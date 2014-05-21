<?php
class ControllerHeader extends Controller {
	protected function index() {
		$this->data['header'] = $this->language->getLanguage('header');
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$lang_id = $this->language->getCurrentLanguageId();
		
		$this->load->model('tab');
		$this->data['tabs'] = $this->model_tab->findActiveTabs($lang_id);
		
		$tab_ids_array = array();
		foreach($this->data['tabs'] as $tab) {
			if($tab['has_submenu'])
				$tab_ids_array[] = $tab['id'];
		}
		
		$tab_ids = '('.implode(',', $tab_ids_array).')';
		$this->data['subtabs'] = $tab_ids != '()' ? $this->model_tab->findActiveSubTabs($tab_ids) : array();
		
		$this->document->addStyle("libraries/bootstrap.min");
		$this->document->addStyle("header");
		$this->document->addScript("header");
		
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['description'] = $this->document->getDescription();
		$this->data['title'] = $this->document->getTitle();
		$this->data['styles'] = $this->document->getStyles();
		
		$this->data['activated_tab'] = 'non-active';
		if (!empty($this->request->request['route']) && strpos($this->request->request['route'], 'admin') === false) {
			$tab = explode('/', $this->request->request['route']);
			$this->data['activated_tab'] = $tab[0];
		}
		
		$this->template = 'header.tpl';
    	$this->render();
	}
}
?>