<?php
class ControllerHeader extends Controller {
	protected function index() {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['header'] = $this->language->getLanguage('header');
		$this->data['userLang'] = $this->language->getLanguage('userLang');
		
		$this->load->model('tab');
		$this->data['tabs'] = $this->model_tab->findActiveTabs($lang_id);
		
		$tab_ids_array = array();
		foreach($this->data['tabs'] as $tab) {
			if($tab['has_submenu'])
				$tab_ids_array[] = $tab['id'];
		}
		
		$tab_ids = '('.implode(',', $tab_ids_array).')';
		$this->data['subtabs'] = $tab_ids != '()' ? $this->model_tab->findActiveSubTabs($tab_ids) : array();
		
		$this->data['activated_tab'] = 'non-active';
		if (!empty($this->request->request['route']) && strpos($this->request->request['route'], 'admin') === false) {
			$tab = explode('/', $this->request->request['route']);
			$this->data['activated_tab'] = $tab[0];
		}
		
		$this->data['userid'] = isset($this->session->data['user']['id']) ? $this->session->data['user']['id'] : '';
		$this->data['username'] = isset($this->session->data['user']['name']) ? $this->session->data['user']['name'] : '';
		$this->data['canViewMembersArea'] = $this->right->canViewMembersArea() ? true : false;
		// $this->data['canCreateUser'] = $this->right->isAdministrator() ? true : false;
		
		if(isset($this->session->data['userPermissionDenied'])) {
			$this->data['invalidError'] = $this->session->data['userPermissionDenied'];
			unset($this->session->data['userPermissionDenied']);
		}
		if(isset($this->session->data['userRightsDenied'])){
			$this->data['invalidError'] = $this->session->data['userRightsDenied'];
			unset($this->session->data['userRightsDenied']);
		}
		
		if(isset($this->session->data['loadMembersArea'])) {
			$this->data['loadMembersArea'] = true;
			unset($this->session->data['loadMembersArea']);
		}
		
		if(isset($this->session->data['activationError'])) {
			$this->data['invalidError'] = $this->session->data['activationError'];
			unset($this->session->data['activationError']);
		}
		
		$this->document->addStyle("libraries/bootstrap.min");
		$this->document->addStyle("libraries/jquery-ui-1.10.4.custom.min");
		$this->document->addStyle("header");
		$this->document->addScript("header");
		
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['description'] = $this->document->getDescription();
		$this->data['title'] = $this->document->getTitle();
		$this->data['styles'] = $this->document->getStyles();
		
		$this->template = 'header.tpl';
    	$this->render();
	}
}
?>