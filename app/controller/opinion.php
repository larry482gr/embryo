<?php
class ControllerOpinion extends Controller {
	private $invalid_error = '';
	private $successMessage = '';
	
	public function index() {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['opinion'] = $this->language->getLanguage('opinion');
		$this->data['form'] = $this->language->getLanguage('form');
		
		$this->load->model('survey');
		$this->data['opinionSurvey'] = $this->model_survey->findPageSurvey($lang_id, 'opinion');
		
		if(isset($this->session->data['permissionDenied'])) {
			$this->data['invalidError'] = $this->session->data['permissionDenied'];
			unset($this->session->data['permissionDenied']);
		}
		else if(isset($this->session->data['surveyAlreadyCompleted'])) {
			$this->data['invalidError'] = $this->session->data['surveyAlreadyCompleted'];
			unset($this->session->data['surveyAlreadyCompleted']);
		}
		else if(isset($this->session->data['surveySubmitError'])) {
			$this->data['invalidError'] = $this->session->data['surveySubmitError'];
			unset($this->session->data['surveySubmitError']);
		}
		else if(isset($this->session->data['surveyCompleted'])) {
			$this->data['successMessage'] = $this->session->data['surveyCompleted'];
			unset($this->session->data['surveyCompleted']);
		}
		else {
			$this->data['invalidError'] = $this->invalid_error;
			$this->data['successMessage'] = $this->successMessage;
		}
	
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