<?php
class ControllerSurvey extends Controller {
	public function index($survey_id = false) {
		$lang = $this->language->getCurrentLanguage();
		if(!$survey_id) {
			return $this->response->redirect('/'.$lang);
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
			return $this->response->redirect('/');
		}
		
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
}
?>