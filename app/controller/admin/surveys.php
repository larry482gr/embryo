<?php
class ControllerAdminSurveys extends Controller {
	public function index() {
		$this->data['form'] = $this->language->getLanguage('form');
		$this->data['surveyLang'] = $this->language->getLanguage('surveyLang');
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang_id'] = $lang_id;
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['languages'] = $this->language->getAvailableLanguages();
		
		$this->load->model('survey');
		$this->data['surveys'] = $this->model_survey->findAll($lang_id);

		$this->document->addStyle('admin/survey/create');
		$this->document->addScript('admin/survey/create');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/survey/index.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function show($survey_id = false) {
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
		$this->data['survey'] = $this->model_survey->findSurvey($survey_id);
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
		
		// ====================================
		
		if(isset($this->session->data['user']['id'])) {
			$this->load->model('user');
			$this->data['user'] = $this->model_user->findUser($this->session->data['user']['id']);
		}
		
		// ====================================

		$this->document->addStyle('survey/show');
		$this->document->addScript('survey/show');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/survey/show.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function newSurvey() {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang_id'] = $lang_id;
		$this->data['lang'] = $this->language->getCurrentLanguage();
		
		if(isset($this->request->post['survey'])) {
			/*
				header("Content-type: text/plain");
				var_dump($this->request->post['survey']['question']);
				die();
			*/
			return $this->createSurvey($this->data['lang'], $lang_id, $this->request->post['survey']);
		}
		
		$this->data['form'] = $this->language->getLanguage('form');
		$this->data['surveyLang'] = $this->language->getLanguage('surveyLang');
		$this->data['languages'] = $this->language->getAvailableLanguages();
		
		$this->load->model('survey');
		$question_types = $this->model_survey->findQuestionTypes();
		for($i = 0; $i < sizeof($question_types); $i++) {
			$question_types[$i]['description'] = $this->data['surveyLang'][$question_types[$i]['codename']];
		}
		
		$this->data['question_types'] = json_encode($question_types);

		$this->document->addStyle('admin/survey/create');
		$this->document->addScript('admin/survey/create');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/survey/create.tpl';
		$this->response->setOutput($this->render());
	}
	
	private function createSurvey($lang, $lang_id, $survey) {
		$this->load->model('survey');
		
		// Create Survey and redirect to Survey index.
		$surveyTitle = $this->db_survey->escape(trim($survey['title']));
		$surveyAlias = $this->db_survey->escape(trim($survey['alias']));
		$surveyIsPublic = $this->db_survey->escape($survey['surveyType']);
		$surveyId = $this->model_survey->createSurvey($lang_id, $surveyTitle, $surveyAlias, $surveyIsPublic);
		
		// If statement should not be here after the full implementation.
		if(isset($survey['category'])) {
			foreach($survey['category'] as $cat_id => $cat_value) {
				$this->createCategory($surveyId, $cat_id, $cat_value, $survey);
			}
		}
		
		$this->response->redirect('/'.$lang.'/admin/surveys'); 
	}
	
	private function createCategory($surveyId, $cat_id, $cat_value, $survey) {
		$categoryLabel = $this->db_survey->escape(trim($cat_value));
		$surveyCatId = $this->model_survey->createSurveyCategory($surveyId, $categoryLabel);
		
		// Check this after the UI (form) implementation.
		if(isset($survey['subcategory'][$cat_id])) {
			foreach($survey['subcategory'][$cat_id] as $sub_id => $sub_value) {
				$this->createSubcategory($surveyCatId, $cat_id, $sub_id, $sub_value, $survey);
			}
		}
	}
	
	private function createSubcategory($surveyCatId, $cat_id, $sub_id, $sub_value, $survey) {
		$subcategoryHeader = $this->db_survey->escape(trim($sub_value['header']));
		$subcategoryLabel = $this->db_survey->escape(trim($sub_value['label']));
		$surveySubcatId = $this->model_survey->createSurveySubcategory($surveyCatId, $subcategoryHeader, $subcategoryLabel);
		
		// Check this after the UI (form) implementation.
		if(isset($survey['question'][$cat_id][$sub_id])) {
			foreach($survey['question'][$cat_id][$sub_id] as $question) {
				$this->createQuestion($surveySubcatId, $question);
			}
		}
	}
	
	private function createQuestion($surveySubcatId, $question) {
		$question['text'] = "'".nl2br($this->db_survey->escape(trim($question['text'])))."'";
		$help = trim($question['help']);
		$question['help'] = empty($help) ? "NULL" : "'".nl2br($this->db_survey->escape($help))."'";
		$question['type'] = $this->db_survey->escape($question['type']);
		$answer_options = $this->db_survey->escape($this->getProperAnswerOptions($question));
		$question['answer_options'] = empty($answer_options) ? "NULL" : "'".$answer_options."'";
		$question['has_other'] = !isset($question['has_other']) ? 0 : 1;
		$question['has_comment'] = !isset($question['has_comment']) ? 0 : 1;
		
		$this->model_survey->createSurveyQuestion($surveySubcatId, $question);
	}
	
	private function getProperAnswerOptions($question) {
		$answer_options = '';
		if($question['type'] != 3)
			$answer_options = str_replace("<br />", "-,-", nl2br($question['answer_options']));
		
		return $answer_options;
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