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
	
	public function getCategory() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$id = $this->db->escape($this->request->post['id']);
		
		$this->load->model('info');
		$info_cat = $this->model_info->findInfoCategory($id);
		
		echo json_encode($info_cat);
		die();
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
	
	public function createCategory() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$lang = $this->language->getCurrentLanguage();
		
		$info = array();
		foreach($this->request->post['info'] as $key => $value) {
			$info[$key] = $this->db->escape($value);
		}
		
		$info['label'] = !empty($info['label']) ? "'".$info['label']."'" : "NULL";
		$info['parent_id'] = ($info['parent_id'] != -1) ? $info['parent_id'] : "NULL";
		$info['is_active'] = isset($info['is_active']) ? 1 : 0;
		
		$this->load->model('info');
		
		if($info['edit'] == -1)
			$affectedRows = $this->model_info->createInfoCategory($info);
		else
			$affectedRows = $this->model_info->updateInfoCategory($info);
		
		$this->response->redirect('/'.$lang.'/admin/info');
	}
	
	public function createFile() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$lang = $this->language->getCurrentLanguage();
		
		$info['cat_id'] = $this->db->escape($this->request->post['info']['cat_id']);
		$info['label'] = $this->db->escape($this->request->post['info']['label']);
		$info['weight'] = $this->db->escape($this->request->post['info']['weight']);
		
		if(empty($this->request->files['info_file']['name']) && empty($this->request->files['info_file']['type'])) {
			// ==========================
			// error no file!!!
			// ==========================
			
			// $member['picture'] = null;
		}
		else {
			$allowedExts = array("doc", "docx", "pdf");
			$extension = end(explode(".", $this->request->files['info_file']['name']));
			
			$path = _DOCUMENT_ROOT_."/resources/files/information";
			$filepath = $path."/".$this->request->files['info_file']['name'];
			
			if ((($this->request->files['info_file']['type'] == 'application/msword')
				|| ($this->request->files['info_file']['type'] == 'application/pdf')
				|| ($this->request->files['info_file']['type'] == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'))
				&& in_array($extension, $allowedExts)) {
				   
				if ($this->request->files['info_file']['error'] > 0) {
					var_dump($this->request->files['info_file']['error']);
					exit();
				}
				else {
					if (!file_exists($path."/")) {
				        mkdir($path);
				        chmod($path, 0757);  // octal; correct value of mode
				    }
				    else {
				    	@move_uploaded_file($this->request->files['info_file']['tmp_name'], $filepath);
				    	$info['name'] = $this->request->files['info_file']['name'];
				    }
				}
			}
			else {
				// Refactor it to send a message to the user.
				var_dump("Wrong file type");
				exit();
			}
		}
		
		$info['size'] = $this->request->files['info_file']['size'];
		
		$this->load->model('info');
		$affectedRows = $this->model_info->createInfoFile($info);
		
		if($affectedRows > 0)
			return $this->response->redirect('/'.$lang.'/admin/info');
	}
	
	public function updateFileName() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$id = $this->db->escape($this->request->post['id']);
		$label = $this->db->escape($this->request->post['label']);
		
		$this->load->model('info');
		$affectedRows = $this->model_info->updateInfoFileName($id, $label);
		
		echo $affectedRows;
		die();
	}
	
	private function getProperFileSize($fileSize) {
		if(($fileSize/(1024*1024*1024)) > 1)
			$fileSize = number_format($fileSize/(1024*1024*1024), 2) . " GB";
		else if(($fileSize/(1024*1024)) > 1)
			$fileSize = number_format($fileSize/(1024*1024), 2) . " MB";
		else if(($fileSize/1024) > 1)
			$fileSize = number_format($fileSize/1024, 2) . " KB";
		else
			$fileSize = $fileSize . " bytes";
			
		return $fileSize;
	}
}
?>