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

		$this->document->addStyle('admin/survey');
		$this->document->addScript('admin/survey');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/survey/index.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function newSurvey() {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang_id'] = $lang_id;
		$this->data['lang'] = $this->language->getCurrentLanguage();
		
		if(isset($this->request->post['survey']))
			return $this->createSurvey($this->data['lang'], $lang_id, $this->request->post['survey']);
		
		$this->data['form'] = $this->language->getLanguage('form');
		$this->data['surveyLang'] = $this->language->getLanguage('surveyLang');
		$this->data['languages'] = $this->language->getAvailableLanguages();

		$this->document->addStyle('admin/survey');
		$this->document->addScript('admin/survey');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/survey/create.tpl';
		$this->response->setOutput($this->render());
	}
	
	private function createSurvey($lang, $lang_id, $survey) {
		$this->load->model('survey');
		
		// Create Survey and redirect to Survey index.
		$surveyTitle = $this->db_survey->escape($survey['title']);
		$surveyAlias = $this->db_survey->escape($survey['alias']);
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
		$categoryLabel = $this->db_survey->escape($cat_value);
		$surveyCatId = $this->model_survey->createSurveyCategory($surveyId, $categoryLabel);
		
		// Check this after the UI (form) implementation.
		if(isset($survey['subcategory'][$cat_id])) {
			foreach($survey['subcategory'][$cat_id] as $sub_id => $sub_value) {
				$this->createSubcategory($surveyCatId, $cat_id, $sub_id, $sub_value, $survey);
			}
		}
	}
	
	private function createSubcategory($surveyCatId, $cat_id, $sub_id, $sub_value, $survey) {
		$subcategoryHeader = $this->db_survey->escape($sub_value['header']);
		$subcategoryLabel = $this->db_survey->escape($sub_value['label']);
		$surveySubcatId = $this->model_survey->createSurveySubcategory($surveyCatId, $subcategoryHeader, $subcategoryLabel);
		
		// Check this after the UI (form) implementation.
		if(isset($survey['question'][$cat_id][$sub_id])) {
			foreach($survey['question'][$cat_id][$sub_id] as $quest_id => $quest_value) {
				$this->createQuestion($surveySubcatId, $quest_id, $quest_value, $survey);
			}
		}
	}
}
?>