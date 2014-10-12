<?php
class ControllerEvents extends Controller {
	public function index($args = false) {
		if($args) {
			return $this->getEvent($args);
		}
		else {
			$lang_id = $this->language->getCurrentLanguageId();
			$this->data['lang'] = $this->language->getCurrentLanguage();
			$this->data['eventLang'] = $this->language->getLanguage('events');
			
			$this->load->model('event');
			$this->data['events'] = $this->model_event->findAllEvents(1, $lang_id);
			
			$this->document->addStyle('events');
			// $this->document->addScript('events');
			$this->document->addStyle('left_part');
			
			// Assign header/footer to children object
			$this->children = array('header', 'footer', 'left_part');
			
			// Assign at template object the tpl
			$this->template = 'events/index.tpl';
			$this->response->setOutput($this->render());
		}
	}
	
	private function getEvent($event_id) {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['home'] = $this->language->getLanguage('home');
		$this->data['eventLang'] = $this->language->getLanguage('events');
		
		$this->load->model('event');
		$this->data['event'] = $this->model_event->findEvent($event_id, $lang_id);
		
		if(!$this->data['event'])
			return $this->response->redirect('/'.$this->data['lang'].'/events');
	
		$this->document->addStyle('events');
		// $this->document->addScript('events');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'events/show.tpl';
		$this->response->setOutput($this->render());
	}
}
?>