<?php
class ControllerLinks extends Controller {
	public function index($args = false) {
		if($args) {
			return $this->getLinks($args);
		}
		else {
			$lang_id = $this->language->getCurrentLanguageId();
			$this->data['lang'] = $this->language->getCurrentLanguage();
			$this->data['links'] = $this->language->getLanguage('links');
			
			$this->load->model('link');
			$this->data['link_cats'] = $this->model_link->findAllLinkCategories($lang_id, 'ORDER BY is_active DESC, position, id');
			$this->data['categories'] = true;
	
			$this->document->addStyle('links');
			$this->document->addScript('links');
			$this->document->addStyle('left_part');
			
			// Assign header/footer to children object
			$this->children = array('header', 'footer', 'left_part');
			
			// Assign at template object the tpl
			$this->template = 'links/index.tpl';
			$this->response->setOutput($this->render());
		}
	}
	
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
}
?>