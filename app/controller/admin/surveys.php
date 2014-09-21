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
			foreach($survey['category'] as $category) {
				$this->createCategory($surveyId, $category, $survey);
			}
		}
		
		
		$this->response->redirect('/'.$lang.'/admin/surveys'); 
	}
	
	private function createCategory($surveyId, $category, $survey) {
		$categoryLabel = $this->db_survey->escape($category['label']);
		$surveyCatId = $this->model_survey->createSurveyCategory($surveyId, $categoryLabel);
		
		// Check this after the UI (form) implementation.
		if(isset($survey['subcategory'])) {
			foreach($survey['subcagory'] as $subcategory) {
				$this->createSubcategory($surveyCatId, $survey);
			}
		}
	}
	
	/*
	public function createCategory() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$link_cat = array('label' => '', 'lang_id' => 2, 'position' => null, 'is_active' => 1);
		$link_cat['label'] = $this->db->escape($this->request->post['link_cat']['label']);
		$link_cat['lang_id'] = $this->db->escape($this->request->post['link_cat']['lang_id']);
		$link_cat['position'] = empty($this->request->post['link_cat']['position']) ? null : $this->db->escape($this->request->post['link_cat']['position']);
		$link_cat['is_active'] = $this->db->escape($this->request->post['link_cat']['is_active']) == 'on' ? 1 : 0;
		
		$this->load->model('link');
		$lastId = $this->model_link->createLinkCategory($link_cat);
		
		if(is_numeric($lastId))
			return $this->response->redirect('/admin/links');
	}
	
	public function createLink() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$link = array('cat_id' => '', 'header' => '', 'prepend_text' => '', 'link_url' => '', 'link_label' => '', 'append_text' => '', 'is_group' => '');
		$link['cat_id'] = $this->db->escape($this->request->post['link']['cat_id']);
		$link['header'] = $this->db->escape($this->request->post['link']['header']);
		$link['prepend_text'] = $this->db->escape($this->request->post['link']['prepend_text']);
		$link['link_url'] = $this->db->escape($this->request->post['link']['link_url']);
		$link['link_label'] = $this->db->escape($this->request->post['link']['link_label']);
		$link['append_text'] = $this->db->escape($this->request->post['link']['append_text']);
		$link['is_group'] = isset($this->request->post['link']['is_group']) && $this->db->escape($this->request->post['link']['is_group']) == 'on' ? 1 : 0;
		
		$this->load->model('link');
		$lastId = $this->model_link->createLink($link);
		
		if(is_numeric($lastId))
			return $this->response->redirect('/admin/links');
	}
	*/
}
?>