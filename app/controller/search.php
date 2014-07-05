<?php
class ControllerSearch extends Controller {
	public function index() {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['search'] = $this->language->getLanguage('search');
		// $this->data['underConstruction'] = $this->language->getLanguage('underConstruction');
			
		// For use in under construction page.
		$this->data['pageTitle'] = $this->data['search']['pageTitle'];
		
		$search_text = $this->request->get['q'];
		
		$this->load->model('article');
		$this->load->model('link');
		$this->load->model('member');
		
		$this->data['news'] = $this->model_article->searchArticles($lang_id, $search_text);
		$this->data['links'] = $this->model_link->searchLinks($lang_id, $search_text);
		$this->data['members'] = $this->model_member->searchMembers($lang_id, $search_text);
		
		$this->data['totalNews'] = $this->data['news'] != false ? count($this->data['news']) : 0;
		$this->data['totalLinks'] = $this->data['links'] != false ? count($this->data['links']) : 0;
		$this->data['totalMembers'] = $this->data['members'] != false ? count($this->data['members']) : 0;
		
		$this->data['totalResults'] = $this->data['totalNews'] + $this->data['totalLinks'] + $this->data['totalMembers'];
		
		$this->data['search_text'] = $search_text;
	
		$this->document->addStyle('left_part');
		// $this->document->addStyle('under_construction');
		// $this->document->addScript('under_construction');
			
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
			
		// Assign at template object the tpl
		$this->template = 'search_results.tpl';
		$this->response->setOutput($this->render());
	}
}
?>