<?php
class ControllerAdminHeader extends Controller {
	protected function index() {
		$this->data['adminHeader'] = $this->language->getLanguage('adminHeader');
		$this->data['form'] = $this->language->getLanguage('form');
		
		$this->document->addStyle("libraries/bootstrap.min");
		$this->document->addStyle("admin/header");
		
		$this->data['title'] = $this->document->getTitle();
		$this->data['styles'] = $this->document->getStyles();
		
		if (isset($this->request->request['route']) && $this->request->request['route'] != 'dashboard') {
			$tab = explode('/', $this->request->request['route']);
		}
		// $this->data['activated_tab'] = isset($tab) ? $tab[0] : 'dashboard';
		// $this->data['activated_subtab'] = isset($tab) ? $tab[1] : 'dashboard';
		
		$this->template = 'admin/header.tpl';
    	$this->render();
	}
}
?>