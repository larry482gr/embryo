<?php
class ControllerEuropeanCourts extends Controller {
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
			$this->data['europeanCourts'] = $this->language->getLanguage('europeanCourts');
			$this->data['underConstruction'] = $this->language->getLanguage('underConstruction');
			
			// For use in under construction page.
			$this->data['pageTitle'] = $this->data['europeanCourts']['pageTitle'];
	
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
	
	/*
	public function getLinks($cat_id) {
		$this->load->model('link');
		
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['links'] = $this->language->getLanguage('links');
		$pageSubtitle = $this->model_link->findCategory($cat_id);
		$this->data['links']['pageSubtitle'] = $pageSubtitle['label'];
			
		$this->data['links_array'] = $this->model_link->findLinks($cat_id);
		$this->data['categories'] = false;
	
		$this->document->addStyle('links');
		$this->document->addScript('links');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'links/index.tpl';
		$this->response->setOutput($this->render());
	}
	*/
}
?>