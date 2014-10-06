<?php
class ControllerOpinion extends Controller {
	public function index() {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['opinion'] = $this->language->getLanguage('opinion');
		$this->data['form'] = $this->language->getLanguage('form');
		
		$this->load->model('survey');
		$this->data['opinionSurvey'] = $this->model_survey->findPageSurvey('opinion');
	
		$this->document->addStyle('left_part');
		$this->document->addStyle('opinion');
		$this->document->addScript('opinion');
		$this->document->addStyle('contact_us');
		$this->document->addScript('contact_us');
			
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
			
		// Assign at template object the tpl
		$this->template = 'opinion/index.tpl';
		$this->response->setOutput($this->render());
	}
}
?>