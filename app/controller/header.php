<?php
class ControllerHeader extends Controller {
	protected function index() {
		$this->data['header'] = $this->language->getLanguage('header');
		
		$this->document->addStyle("libraries/bootstrap.min");
		$this->document->addStyle("header");
		$this->document->addScript("header");
		
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['description'] = $this->document->getDescription();
		$this->data['title'] = $this->document->getTitle();
		$this->data['styles'] = $this->document->getStyles();
		
		if (isset($this->request->request['route']) && $this->request->request['route'] != 'dashboard') {
			$tab = explode('/', $this->request->request['route']);
		}
		// $this->data['activated_tab'] = isset($tab) ? $tab[0] : 'dashboard';
		// $this->data['activated_subtab'] = isset($tab) ? $tab[1] : 'dashboard';
		
		$this->data['title'] = 'Embryo';
		
		$this->template = 'header.tpl';
    	$this->render();
	}
}
?>