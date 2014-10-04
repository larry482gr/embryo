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
		
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang_id'] = $lang_id;
		$this->data['lang'] = $lang;
		$this->data['showSurveyLang'] = $this->language->getLanguage('showSurveyLang');
		$this->data['pagingLang'] = $this->language->getLanguage('paging');
		
		$this->load->model('survey');
		$this->data['survey'] = $this->model_survey->findSurvey($survey_id);
		$this->data['survey_categories'] = $this->model_survey->findSurveyCategories($survey_id);
		$this->data['total_categories'] = count($this->data['survey_categories']);
		$this->data['survey_subcategories'] = array();
		foreach($this->data['survey_categories'] as $category) {
			$this->data['survey_subcategories'][$category['id']] = $this->model_survey->findSurveySubcategories($category['id']);
		}
		$this->data['survey_questions'] = array();
		foreach($this->data['survey_subcategories'] as $subcategories) {
			foreach($subcategories as $subcategory)
				$this->data['survey_questions'][$subcategory['id']] = $this->model_survey->findSurveyQuestions($subcategory['id']);
		}

		$this->document->addStyle('admin/survey/show');
		$this->document->addScript('admin/survey/show');
		
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
			$answer_options = str_replace("<br />", ",", nl2br($question['answer_options']));
		
		return $answer_options;
	}
}
?>