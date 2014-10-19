<?php
class ControllerAdminInfo extends Controller {
	public function index($args = false) {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang_id'] = $lang_id;
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['languages'] = $this->language->getAvailableLanguages();
		$this->data['form'] = $this->language->getLanguage('form');
		$this->data['information'] = $this->language->getLanguage('information');
		
		$this->load->model('info');
		$this->data['info_subtabs'] = $this->model_info->findAllInfoSubtabs($lang_id);
		// Get info tab's ids
		$tab_ids = array();
		foreach($this->data['info_subtabs'] as $subtab) {
			$tab_ids[] = $subtab['id'];
		}
		$tab_ids = implode(',', $tab_ids);
		$this->data['info_main'] = $this->model_info->findInfoCats($tab_ids);
		$this->data['info_sub'] = $this->model_info->findInfoCats($tab_ids, 'NOT NULL');

		$this->document->addStyle('admin/info');
		$this->document->addScript('admin/info');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/info/index.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function getCategoryFiles($cat_id) {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$cat_id = $this->db->escape($cat_id);
		$items = array();
		
		$this->load->model('info');
		$files = $this->model_info->findFiles($cat_id);
		
		foreach($files as $file) {
			$file['size'] = $this->getProperFileSize($file['size']);
			$file['created_at'] = date('d/m/Y', strtotime($file['created_at']));
			$items[] = $file;
		}
		
		echo json_encode($items);
		die();
	}
	
	private function getProperFileSize($fileSize) {
		if(($fileSize/(1024*1024)) > 1)
			$fileSize = number_format($fileSize/(1024*1024), 2) . " MB";
		else if(($fileSize/1024) > 1)
			$fileSize = number_format($fileSize/1024, 2) . " KB";
		else
			$fileSize = $fileSize . " bytes";
			
		return $fileSize;
	}
	
	/*
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
	*/
}
?>