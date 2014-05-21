<?php
class ControllerResearchContent extends Controller {
	public function index($args = false) {
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$lang_id = $this->language->getCurrentLanguageId();
		
		$this->load->model('content');
		$this->data['content'] = $this->model_content->findContent($this->request->request['route'], $lang_id);
		
		$this->document->addStyle('research_content');
		// $this->document->addScript('research_content');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'research/index.tpl';
		$this->response->setOutput($this->render());
	}
}
?>