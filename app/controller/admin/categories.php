<?php
class ControllerAdminCategories extends Controller {
	public function index() {
		$this->data['form'] = $this->language->getLanguage('form');
		$lang_id = isset($this->request->post['lang_id']) ? $this->request->post['lang_id'] : 1;
		
		$this->load->model('tab');
		$this->data['tabs'] = $this->model_tab->findAllTabs($lang_id, 'ORDER BY is_active DESC, tab_position');
		// Assign header/footer to children object
		$this->children = array('admin/dashboard');
		
		// Assign at template object the tpl
		$this->template = 'admin/categories.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function create() {
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