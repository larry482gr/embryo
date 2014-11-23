<?php
class ControllerSurvey extends Controller {
	public function index($survey_id = false) {
		$lang = $this->language->getCurrentLanguage();
		if(!$survey_id) {
			return $this->response->redirect('/'.$lang);
		}
		
		if(isset($this->request->post['user']) && isset($this->request->post['question'])) {
			return $this->submitSurvey($this->request->post['user'], $this->request->post['question']);
			/*
			header("Content-type: text/plain; charset=utf-8");
			var_dump($this->request->post);
			die();
			*/
		}
		
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang_id'] = $lang_id;
		$this->data['lang'] = $lang;
		$this->data['showSurveyLang'] = $this->language->getLanguage('showSurveyLang');
		$this->data['pagingLang'] = $this->language->getLanguage('paging');
		$this->data['userLang'] = $this->language->getLanguage('userLang');
		
		$this->load->model('survey');
		$this->data['survey'] = $this->model_survey->findPublicSurvey($survey_id);
		if(!$this->data['survey']) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/opinion');
		}
		
		$this->data['survey_categories'] = $this->model_survey->findSurveyCategories($survey_id);
		$this->data['total_categories'] = count($this->data['survey_categories']);
		$this->data['active_category'] = $this->data['survey_categories'][0]['id'];
		$this->data['survey_subcategories'] = array();
		foreach($this->data['survey_categories'] as $category) {
			$this->data['survey_subcategories'][$category['id']] = $this->model_survey->findSurveySubcategories($category['id']);
		}
		$this->data['survey_questions'] = array();
		foreach($this->data['survey_subcategories'] as $subcategories) {
			foreach($subcategories as $subcategory)
				$this->data['survey_questions'][$subcategory['id']] = $this->model_survey->findSurveyQuestions($subcategory['id']);
		}
		
		if(isset($this->session->data['user']['id'])) {
			$this->load->model('user');
			$this->data['user'] = $this->model_user->findUser($this->session->data['user']['id']);
		}

		$this->document->addStyle('survey/show');
		$this->document->addScript('survey/show');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'survey/show.tpl';
		$this->response->setOutput($this->render());
	}
	
	private function submitSurvey($user, $user_answers) {
		$lang = $this->language->getCurrentLanguage();
		
		$this->load->model('survey');
		$quest_id = key($user_answers);
		$survey = $this->model_survey->findSurveyByQuestionId($quest_id);
		$tmp_email = trim($user['email']);
		$email = $this->db_survey->escape($tmp_email);
		if($this->alreadyCompletedSurvey($survey['title'], $email)) {
			$map_entry = $this->model_survey->findSubmittedDateTime($survey['id'], $email);
			$date_time = date('j/n/Y H:i:s', strtotime($map_entry['date_time']));
			$failure_message = str_replace('%timestamp%', $date_time, $this->language->getFailureMessage('surveyAlreadyCompleted'));
			$this->session->data['surveyAlreadyCompleted'] =  $failure_message;
			return $this->response->redirect('/'.$lang.'/opinion');
		}
		
		// Create new user and set a new entry at the survey_user_map table.
		$user_id = $this->createUser($user);
		if(!is_numeric($user_id)) {
			return $this->surveySubmitError($lang);
		}
		$map_entry = $this->model_survey->createSurveyUserMap($survey['id'], $user_id);
		if(!is_numeric($map_entry) && $map_entry < 1) {
			return $this->surveySubmitError($lang);
		}
		
		// Import user's answers.
		$all_questions = $this->model_survey->findSurveyQuestionsBySurveyId($survey['id']);
		// header("Content-type: text/plain; charset=utf-8");
		// var_dump($all_questions);
		// die();
		$questions = array();
		foreach($all_questions as $question) {
			$questions[$question['id']] = $question['answer_options'];
		}
		
		foreach($questions as $key => $value) {
			$question_entry = -1;
			if(array_key_exists($key, $user_answers)) {
				$question_entry = $this->createSurveyAnswer($user_id, $key, $user_answers[$key]);
			}
			else {
				$question_entry = $this->model_survey->createSurveyAnswer($user_id, $key);
			}
			
			if(!is_numeric($question_entry) && $question_entry < 1)
					return $this->surveySubmitError($lang);
					
			// var_dump($key);
			// var_dump($array_val);
		}
		// die();
		
		$this->session->data['surveyCompleted'] = $this->language->getSuccessMessage('surveyCompleted');
		$this->response->redirect('/'.$lang.'/opinion');
	}
	
	private function createUser($user) {
		$tmp_fname = trim($user['fname']);
		$fname = $this->db_survey->escape($tmp_fname);
		$tmp_lname = trim($user['lname']);
		$lname = $this->db_survey->escape($tmp_lname);
		$tmp_email = trim($user['email']);
		$email = $this->db_survey->escape($tmp_email);
		
		return $this->model_survey->createUser($fname, $lname, $email);
	}
	
	private function createSurveyAnswer($user_id, $question_id, $array_val) {
		$answer = "NULL";
		$other = "NULL";
		$comment = "NULL";
		
		if(array_key_exists('answer', $array_val))
			$answer = $this->getProperAnswer($question_id, $array_val['answer']);
		if(array_key_exists('other', $array_val))
			$other = $this->getProperOther($array_val['other']);
		if(array_key_exists('comment', $array_val))
			$comment = $this->getProperComment($array_val['comment']);
			
		$affected_rows = $this->model_survey->createSurveyAnswer($user_id, $question_id, $answer, $other, $comment);
		
		return $affected_rows;
	}
	
	private function getProperAnswer($question_id, $user_answer) {
		$answer = '';
		if(!is_array($user_answer)) {
			$tmp_answer = trim($user_answer);
			$tmp_answer = $this->db_survey->escape($tmp_answer);
			$answer = !empty($tmp_answer) ? $tmp_answer : NULL;
		}
		else {
			$question = $this->model_survey->findSurveyQuestion($question_id);
			if(!$question)
				return $this->surveySubmitError($lang);
			else {
				$answer_options = explode('-,-', $question['answer_options']);
				$total_options = count($answer_options);
				for($i = 0; $i < $total_options; $i++) {
					if(array_key_exists($i+1, $user_answer)) {
						$tmp_answer = trim($user_answer[$i+1]);
						$tmp_answer = $this->db_survey->escape($tmp_answer);
						if(!empty($tmp_answer))
							$answer .= $tmp_answer.'-,-';
						else
							$answer .= '::empty::'.'-,-';
					}
					else {
						$answer .= '::empty::'.'-,-';
					}
				}
				
				$answer = substr($answer, 0, -3);
			}
		}
		
		return $answer != NULL ? "'".$answer."'" : "NULL";
	}
	
	private function getProperOther($user_other) {
		$tmp_other = trim($user_other);
		$tmp_other = $this->db_survey->escape($tmp_other);
		$other = !empty($tmp_other) ? "'".$tmp_other."'" : "NULL";
		
		return $other;
	}
	
	private function getProperComment($user_comment) {
		$tmp_comment = trim($user_comment);
		$tmp_comment = $this->db_survey->escape($tmp_comment);
		$comment = !empty($tmp_comment) ? "'".$tmp_comment."'" : "NULL";
		
		return $comment;
	}
	
	private function surveySubmitError($lang) {
		$this->session->data['surveySubmitError'] = $this->language->getFailureMessage('surveySubmitError');
		return $this->response->redirect('/'.$lang.'/opinion');
	}
	
	public function alreadyCompletedSurvey($survey_title = false, $user_email = false) {
		$title = $survey_title ? $survey_title : $this->db_survey->escape($this->request->post['survey_title']);
		$email = $user_email ? $user_email : $this->db_survey->escape($this->request->post['user_email']);
		$this->load->model('survey');
		$alreadyCompleted = $this->model_survey->alreadyCompleted($title, $email);
		
		if(!$survey_title && !$user_email) {
			echo $alreadyCompleted;
			die();
		}
		else {
			return $alreadyCompleted;
		}
	}
}
?>