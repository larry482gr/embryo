<?php
class ControllerAdminMenuTabs extends Controller {
	public function index() {
		$this->data['form'] = $this->language->getLanguage('form');
		$lang_id = $this->language->getCurrentLanguageId();
		
		$this->load->model('tab');
		$this->data['tabs'] = $this->model_tab->findAllTabs($lang_id, 'ORDER BY is_active DESC, tab_position');
		
		$this->document->addStyle('admin/menu_tabs');
		$this->document->addScript('admin/menu_tabs');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/menu_tabs.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function create() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$tab = array('label' => '', 'description' => '', 'link' => '', 'lang_id' => '', 'has_submenu' => 0, 'is_active' => '', 'tab_position' => '');
		$tab['label'] = $this->db->escape($this->request->post['tab']['label']);
		$tab['description'] = $this->db->escape($this->request->post['tab']['description']);
		$tab['link'] = $this->db->escape($this->request->post['tab']['link']);
		$tab['lang_id'] = $this->db->escape($this->request->post['tab']['lang_id']);
		// $tab['has_submenu'] = $this->db->escape($this->request->post['tab']['has_submenu']);
		$tab['is_active'] = $this->db->escape($this->request->post['tab']['is_active']) == 'on' ? 1 : 0;
		
		$this->load->model('tab');
		$lastId = $this->model_tab->create($tab);
		
		if(is_numeric($lastId))
		return $this->index();
	}
}
?>