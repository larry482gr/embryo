<?php
class ControllerLegislation extends Controller {
	public function index($args = false) {
		if(!isset($this->session->data['user']['id'])) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('userDenied');
			return $this->response->redirect('user/login');
		}
		
		if($args) {
			return $this->getEvent($args);
		}
		else {
			$lang_id = $this->language->getCurrentLanguageId();
			$this->data['lang'] = $this->language->getCurrentLanguage();
			$this->data['legislation'] = $this->language->getLanguage('legislation');
			$this->data['underConstruction'] = $this->language->getLanguage('underConstruction');
			
			// For use in under construction page.
			$this->data['pageTitle'] = $this->data['legislation']['pageTitle'];
	
			$this->document->addStyle('left_part');
			$this->document->addStyle('under_construction');
			$this->document->addScript('under_construction');
			
			// Assign header/footer to children object
			$this->children = array('header', 'footer', 'left_part');
			
			// Assign at template object the tpl
			$this->template = 'under_construction.tpl';
			$this->response->setOutput($this->render());
		}
	}
	
}
?>