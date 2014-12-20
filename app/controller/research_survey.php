<?php
class ControllerResearchSurvey extends Controller {
	public function showResearchSurvey($survey_id = false) {
		$lang = $this->language->getCurrentLanguage();
		if(!$survey_id) {
			return $this->response->redirect('/'.$lang);
		}
		
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang_id'] = $lang_id;
		$this->data['lang'] = $lang;
		$this->data['showSurveyLang'] = $this->language->getLanguage('showSurveyLang');
		$this->data['pagingLang'] = $this->language->getLanguage('paging');
		$this->data['userLang'] = $this->language->getLanguage('userLang');
		
		$this->load->model('survey');
		$this->data['survey'] = $this->model_survey->findSurvey($survey_id);
		$survey_users = $this->model_survey->findSurveyUsers($survey_id);
		$this->data['user_ids'] = array();
		$this->data['countries'] = array();
		foreach($survey_users as $survey_user) {
			$this->data['user_ids'][] = $survey_user['id'];
			$this->data['countries'][] = ucfirst($survey_user['last_name']);
		}
		
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
		$this->document->addScript('survey/research_answers');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'survey/research_survey.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function getAnswers($question_id = false) {
		$lang = $this->language->getCurrentLanguage();
		if(!$question_id) {
			return $this->response->redirect('/'.$lang);
		}
		
		$questionType = $this->request->post['question_type'];
		
		$this->load->model('survey');
		$surveyAnswers = $this->model_survey->findSurveyAnswers($question_id);
		$properAnswers = array();
		
		foreach($surveyAnswers as $surveyAnswer) {
			$surveyAnswer['answer'] = nl2br($surveyAnswer['answer']);
			$properAnswers[] = $this->getProperAnswers($questionType, $surveyAnswer);
		}
		
		echo json_encode($properAnswers);
	}
	
	private function getProperAnswers($questionType, $surveyAnswers) {
		switch($questionType) {
			case 1:
				$surveyAnswers['answer'] = $this->getProperRadio($surveyAnswers);
				break;
			case 2:
				$surveyAnswers['answer'] = $this->getProperCheckbox($surveyAnswers);
				break;
			case 3:
				$surveyAnswers['answer'] = !empty($surveyAnswers['answer']) ? $surveyAnswers['answer'] : " - ";
				break;
			case 4:
				$surveyAnswers['answer'] = $this->getProperMultipleAnswer($surveyAnswers);
				break;
		}
		
		return $surveyAnswers;
	}
	
	private function getProperRadio($surveyAnswers) {
		$questionOptions = $this->model_survey->findSurveyAnswersOptions($surveyAnswers['question_id']);
		$optionsArray = explode("-,-", $questionOptions['answer_options']);
		
		$properAnswer = !empty($surveyAnswers['answer']) ? $optionsArray[$surveyAnswers['answer']-1] : " - ";
		
		if(!empty($surveyAnswers['other'])) {
			$properAnswer .= "<br/><br/>".$surveyAnswers['other'];
		}
		
		if(!empty($surveyAnswers['comment'])) {
			$showSurveyLang = $this->language->getLanguage('showSurveyLang');
			$properAnswer .= "<br/><br/>".$showSurveyLang['comment']."<br/>".$surveyAnswers['comment'];
		}
		
		return $properAnswer;
		
	}
	
	private function getProperCheckbox($surveyAnswers) {
		$questionOptions = $this->model_survey->findSurveyAnswersOptions($surveyAnswers['question_id']);
		$optionsArray = explode("-,-", $questionOptions['answer_options']);
		$answersArray = explode("-,-", $surveyAnswers['answer']);
		
		$properAnswer = "";
		for($i = 0; $i < sizeof($answersArray); $i++) {
			if($answersArray[$i] == "on") {
				$properAnswer .= $optionsArray[$i]."<br/>";
			}
		}
		
		if(!empty($properAnswer)) {
			$properAnswer = substr($properAnswer, 0, -5);
			
			if(!empty($surveyAnswers['other'])) {
				$properAnswer .= "<br/><br/>".$surveyAnswers['other'];
			}
			
			if(!empty($surveyAnswers['comment'])) {
				$showSurveyLang = $this->language->getLanguage('showSurveyLang');
				$properAnswer .= "<br/><br/>".$showSurveyLang['comment']."<br/>".$surveyAnswers['comment'];
			}
		}
		else {
			$properAnswer = " - ";
		}
		
		return $properAnswer;
	}
	
	private function getProperMultipleAnswer($surveyAnswers) {
		$questionOptions = $this->model_survey->findSurveyAnswersOptions($surveyAnswers['question_id']);
		$optionsArray = explode("-,-", $questionOptions['answer_options']);
		$answersArray = explode("-,-", $surveyAnswers['answer']);
		
		$properAnswer = "";
		for($i = 0; $i < sizeof($answersArray); $i++) {
			$properAnswer .= substr($optionsArray[$i], -1) == ":" ? $optionsArray[$i]." " : $optionsArray[$i].": ";
			$properAnswer .= $answersArray[$i] != "::empty::" ? $answersArray[$i] : " - ";
			$properAnswer .= "<br/>";
		}
		
		if(!empty($properAnswer)) {
			$properAnswer = substr($properAnswer, 0, -5);
			
			if(!empty($surveyAnswers['other'])) {
				$properAnswer .= "<br/><br/>".$surveyAnswers['other'];
			}
			
			if(!empty($surveyAnswers['comment'])) {
				$showSurveyLang = $this->language->getLanguage('showSurveyLang');
				$properAnswer .= "<br/><br/>".$showSurveyLang['comment']."<br/>".$surveyAnswers['comment'];
			}
		}
		else {
			$properAnswer = " - ";
		}
		
		return $properAnswer;
	}
}
?>