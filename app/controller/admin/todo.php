<?php
class ControllerAdminTodo extends Controller {
	public function index($args = false) {
		$this->data['form'] = $this->language->getLanguage('form');
		$lang_id = $this->language->getCurrentLanguageId();
		
		$this->load->model('link');
		$this->data['link_cats'] = $this->model_link->findAllLinkCategories($lang_id, 'ORDER BY is_active DESC, position, id');
		$max_position = $this->model_link->getMaxTabPosition($lang_id);
		$this->data['max_position'] = $max_position['max_link_cat'];

		$this->document->addStyle('admin/links');
		$this->document->addScript('admin/links');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/links.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function createCategory() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$link_cat = array('label' => '', 'lang_id' => 2, 'position' => null, 'is_active' => 1);
		$link_cat['label'] = $this->db->escape($this->request->post['link_cat']['label']);
		$link_cat['lang_id'] = $this->db->escape($this->request->post['link_cat']['lang_id']);
		$link_cat['position'] = empty($this->request->post['link_cat']['position']) ? null : $this->db->escape($this->request->post['link_cat']['position']);
		$link_cat['is_active'] = $this->db->escape($this->request->post['link_cat']['is_active']) == 'on' ? 1 : 0;
		
		$this->load->model('link');
		$lastId = $this->model_link->createLinkCategory($link_cat);
		
		if(is_numeric($lastId))
			return $this->response->redirect('/admin/links');
	}
	
	public function createLink() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$link = array('cat_id' => '', 'header' => '', 'prepend_text' => '', 'link_url' => '', 'link_label' => '', 'append_text' => '', 'is_group' => '');
		$link['cat_id'] = $this->db->escape($this->request->post['link']['cat_id']);
		$link['header'] = $this->db->escape($this->request->post['link']['header']);
		$link['prepend_text'] = $this->db->escape($this->request->post['link']['prepend_text']);
		$link['link_url'] = $this->db->escape($this->request->post['link']['link_url']);
		$link['link_label'] = $this->db->escape($this->request->post['link']['link_label']);
		$link['append_text'] = $this->db->escape($this->request->post['link']['append_text']);
		$link['is_group'] = isset($this->request->post['link']['is_group']) && $this->db->escape($this->request->post['link']['is_group']) == 'on' ? 1 : 0;
		
		$this->load->model('link');
		$lastId = $this->model_link->createLink($link);
		
		if(is_numeric($lastId))
			return $this->response->redirect('/admin/links');
	}
}
?>