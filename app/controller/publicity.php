<?php
class ControllerPublicity extends Controller {
	public function index($args = false) {
		if($args) {
			return $this->getEvent($args);
		}
		else {
			$lang_id = $this->language->getCurrentLanguageId();
			$this->data['lang'] = $this->language->getCurrentLanguage();
			$this->data['eventLang'] = $this->language->getLanguage('publicity');
			
			$this->load->model('event');
			$this->data['events'] = $this->model_event->findAllEvents(0, $lang_id);
			
			$this->document->addStyle('events');
			$this->document->addScript('events');
			$this->document->addStyle('left_part');
			
			// Assign header/footer to children object
			$this->children = array('header', 'footer', 'left_part');
			
			// Assign at template object the tpl
			$this->template = 'events/index.tpl';
			$this->response->setOutput($this->render());
		}
	}
	
	/*
	public function getEvent($event_id) {
		$this->load->model('events');
		
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