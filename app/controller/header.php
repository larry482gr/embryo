<?php
class ControllerHeader extends Controller {
	protected function index() {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['header'] = $this->language->getLanguage('header');
		$this->data['userLang'] = $this->language->getLanguage('userLang');
		$this->data['search_text'] = isset($this->request->get['q']) ? $this->request->get['q'] : '';
		
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
		
		$page_title = $this->data['header']['siteName'];
		foreach($this->data['tabs'] as $current_tab) {
			if($current_tab['link'] == $this->data['activated_tab']) {
				$page_title .= ' - '.$current_tab['label'];
				break;
			}	
		}
		foreach($this->data['subtabs'] as $current_subtab) {
			if($current_subtab['link'] == $this->data['activated_tab']) {
				$page_title .= ' - '.$current_subtab['label'];
				break;
			}
		}
		
		$this->document->setTitle($page_title);
		
		$this->data['userid'] = isset($this->session->data['user']['id']) ? $this->session->data['user']['id'] : '';
		$this->data['username'] = isset($this->session->data['user']['name']) ? $this->session->data['user']['name'] : '';
		$this->data['canViewMembersArea'] = $this->right->canViewMembersArea() ? true : false;
		// $this->data['canCreateUser'] = $this->right->isAdministrator() ? true : false;
		
		$request_uri_array = explode('/', $this->request->server['REQUEST_URI']);
		$last_uri_element = end($request_uri_array);
		$end = '';
		if(ctype_digit($last_uri_element) && strpos($this->request->server['REQUEST_URI'], 'showResearchSurvey') === false) {
			$end = sizeof($last_uri_element)+1;
		}
		$this->data['gr_href'] = empty($end) ? '/gr/'.substr($this->request->server['REQUEST_URI'], 4) : '/gr/'.substr($this->request->server['REQUEST_URI'], 4, -$end);
		$this->data['en_href'] = empty($end) ? '/en/'.substr($this->request->server['REQUEST_URI'], 4) : '/en/'.substr($this->request->server['REQUEST_URI'], 4, -$end);
		
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
		// $this->document->addStyle("libraries/metronic");
		$this->document->addStyle("header");
		$this->document->addScript("header");
		
		// Set Description, Keywords, Site title, and main stylesheets.
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['description'] = $this->document->getDescription();
		$this->data['title'] = $this->document->getTitle();
		$this->data['styles'] = $this->document->getStyles();
		
		$this->template = 'header.tpl';
    	$this->render();
	}
}
?>