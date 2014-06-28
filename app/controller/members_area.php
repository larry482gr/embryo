<?php
class ControllerMembersArea extends Controller {
	public function index($args = false) {
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['membersArea'] = $this->language->getLanguage('membersArea');
		
		// For use in under construction page.
		$this->data['pageTitle'] = $this->data['membersArea']['pageTitle'];
		// $this->data['underMaintenance'] = $this->language->getLanguage('underMaintenance');
		
		$this->load->model('file');
		$this->data['categories'] = $this->model_file->findAllActiveFileCategories($lang_id, 'ORDER BY label');
		
		$this->session->data['loadMembersArea'] = true;

		$this->document->addStyle('left_part');
		$this->document->addStyle('members_area');
		$this->document->addScript('webtop/functions');
		$this->document->addScript('webtop/context_menus');
		$this->document->addScript('webtop/members_area');

		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'members/webtop.tpl';
		// $this->template = 'under_maintenance.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function getDeletedItems() {
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$catDeleted = $this->db->escape($this->request->post['catDeleted']);
		$items = array('categories' => false, 'files' => false);
		
		$this->load->model('file');
		
		if($catDeleted == -1) {
			$deletedCategories = $this->model_file->findDeletedCategories();
			if($deletedCategories) {
				foreach($deletedCategories as $category) {
					$category['labelHtml'] = str_replace(" ", "<br/>", $category['label']);
					$items['categories'][] = $category;
				}
			}
		}
		
		$deletedFiles = $catDeleted == -1 ? $this->model_file->findDeletedFiles($items['categories']) : $this->model_file->findDeletedFiles($catDeleted);
		if($deletedFiles) {
			foreach($deletedFiles as $file) {
				$file['labelHtml'] = str_replace(" ", "<br/>", $file['label']);
				$items['files'][] = $file;
			}
		}
		
		echo json_encode($items);
		die();
	}
	
	public function getCategoryFiles() {
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$categoryId = $this->request->post['categoryId'];
		$items = array('files' => false);
		
		$this->load->model('file');
		
		$files = $this->model_file->findAllActiveFiles($categoryId, 'ORDER BY label');
		if($files) {
			foreach($files as $file) {
				$file['labelHtml'] = str_replace(" ", "<br/>", $file['label']);
				$items['files'][] = $file;
			}
		}
		
		echo json_encode($items);
		die();
	}
	
	public function createCategory() {
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$lang_id = $this->language->getCurrentLanguageId();
		$label = $this->db_files->escape($this->request->post['label']);
		
		$this->load->model('file');
		$lastId = $this->model_file->createCategory($lang_id, $label);
		
		$category = $this->model_file->findCategory($lastId);
		$category['labelHtml'] = str_replace(" ", "<br/>", $category['label']);
		
		echo json_encode($category);
		die();
	}
	
	public function createFile() {
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$fileName = $this->request->files['new_file']['name'];
		$fileSize = $this->request->files['new_file']['size'];
		$fileCategory = $this->request->post['file_cat'];
		$newFile = array();
		
		$fileElements = explode(".", $fileName);
		$extension = array_pop($fileElements);
		$fileLabel = implode(".", $fileElements);
		
		$allowedExts = array("doc", "docx", "pdf");
			
		$path = _DOCUMENT_ROOT_."/resources/files/members_area/".$fileCategory;
		$filepath = $path."/".$fileLabel.".".$extension;

		if ((($this->request->files["new_file"]["type"] == "application/pdf")
			|| ($this->request->files["new_file"]["type"] == "application/msword")
			|| ($this->request->files["new_file"]["type"] == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"))
			&& ($this->request->files["new_file"]["size"] < (20*1024*1024))
			&& in_array($extension, $allowedExts)) {
				   
			if ($this->request->files["new_file"]["error"] > 0) {
				var_dump($this->request->files["new_file"]["error"]);
				exit();
			}
			else {
				if (!file_exists($path."/")) {
			        mkdir($path, 0777, true);
			        chmod($path, 0777);  // octal; correct value of mode
			    }

			    if(file_exists($filepath)) {
			    	$i = 1;
			    	do {
			    		$fileLabel = $fileLabel . " (" . $i . ")";
			    		$filepath = $path . "/" . $fileLabel . "." . $extension;
				    	$i++;
			    	} while(file_exists($filepath));
		    	}
		    	move_uploaded_file($this->request->files["new_file"]["tmp_name"], $filepath);
		    	$this->load->model('file');
		    	$lastId = $this->model_file->createFile($fileLabel, ".".$extension, $fileSize, $fileCategory);
			    	
		    	$newFile = $this->model_file->findFile($lastId);
				$newFile['labelHtml'] = str_replace(" ", "<br>", $newFile['label']);
		    }
		}
		else {
			// Refactor it to send a message to the user.
			var_dump("Wrong file type");
			exit();
		}
		
		echo json_encode($newFile);
		die();
	}
	
	public function updateCategory() {
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$id = $this->db_files->escape($this->request->post['id']);
		$label = $this->db_files->escape($this->request->post['label']);
		$toState = $this->db_files->escape($this->request->post['toState']);
		
		$this->load->model('file');
		$affectedRows = $this->model_file->updateCategory($id, $label, $toState);
		
		if($affectedRows > 0)
			$category = $this->model_file->findCategory($id);
		$category['labelHtml'] = str_replace(" ", "<br/>", $category['label']);
		
		echo json_encode($category);
		die();
	}
	
	public function updateFile() {
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$id = $this->db_files->escape($this->request->post['id']);
		$label = $this->db_files->escape($this->request->post['label']);
		$toState = $this->db_files->escape($this->request->post['toState']);
		
		$this->load->model('file');
		$oldFile = $this->model_file->findFile($id);
		
		$affectedRows = $this->model_file->updateFile($id, $label, $toState);
		
		if($affectedRows > 0) {
			$newFile = $this->model_file->findFile($id);
			$newFile['labelHtml'] = str_replace(" ", "<br/>", $newFile['label']);
			
			if($toState == 3) {
				// Rename the file
				rename(_DOCUMENT_ROOT_."/resources/files/members_area/".$oldFile['category_id']."/".$oldFile['label'].$oldFile['extention'], _DOCUMENT_ROOT_."/resources/files/members_area/".$newFile['category_id']."/".$newFile['label'].$newFile['extention']);
			}
			else if($toState == 4) {
				$path = _DOCUMENT_ROOT_."/resources/files/members_area/".$newFile['category_id'];
				$filepath = $path."/".$newFile['label'].$newFile['extention'];
				if(file_exists($filepath)) {
			   		$i = 0;
			    	do {
			    		$i++;
			    		$newFile['label'] = $newFile['label'] . "_restored" . $i;
			    		$filepath = $path . "/" . $newFile['label'] . $newFile['extention'];
			    	} while(file_exists($filepath));
			    	// Update the file but not its history, as its already been updated for this action.
					$affectedRows = $this->model_file->updateFile($id, $newFile['label'], $toState, false);
			    }
			    rename(_DOCUMENT_ROOT_."/resources/files/members_area/".$oldFile['category_id']."/".$oldFile['label']."_deleted".$oldFile['extention'], $filepath);
			}
			else if($toState == 5) {
				rename(_DOCUMENT_ROOT_."/resources/files/members_area/".$oldFile['category_id']."/".$oldFile['label'].$oldFile['extention'], _DOCUMENT_ROOT_."/resources/files/members_area/".$newFile['category_id']."/".$newFile['label']."_deleted".$newFile['extention']);
			}
			else if($toState == 6) {
				rename(_DOCUMENT_ROOT_."/resources/files/members_area/".$oldFile['category_id']."/".$oldFile['label']."_deleted".$oldFile['extention'], _DOCUMENT_ROOT_."/resources/files/members_area/".$newFile['category_id']."/".$newFile['label']."_purged".$newFile['extention']);
			}
		}
		
		echo json_encode($newFile);
		die();
	}
	
	public function getCategoryInfo() {
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$id = $this->db_files->escape($this->request->post['id']);
		$categoryInfo = array('created' => '', 'updated' => '', 'totalFiles' => 0, 'totalFileSize' => 0);
		
		$this->load->model('file');
		$catHistory = $this->model_file->findCategoryHistory($id);
		$totals = $this->model_file->findCategoryFilesInfo($id);
		$categoryInfo['totalFiles'] = '<b>Total files:</b> '.$totals['totalFiles'].'<br/>';
		$categoryInfo['totalFileSize'] = !empty($totals['totalFiles']) ? '<b>Total files\' size:</b> '.$totals['totalFileSize'] : '<b>Total files\' size:</b> 0 KB';
		
		$this->load->model('user');
		$firstUser = $this->model_user->findUser($catHistory[count($catHistory)-1]['user_id']);
		$lastUser = $this->model_user->findUser($catHistory[0]['user_id']);
		
		$userCreated = (!empty($firstUser['first_name']) || !empty($firstUser['last_name'])) ? $firstUser['first_name'].' '.$firstUser['last_name'] : $firstUser['username'];
		$userUpdated = (!empty($lastUser['first_name']) || !empty($lastUser['last_name'])) ? $lastUser['first_name'].' '.$lastUser['last_name'] : $lasttUser['username'];
		$categoryInfo['created'] = '<b>Created by:</b> '.$userCreated.' on '.date('l jS F Y', $catHistory[count($catHistory)-1]['timedate']).'<br/>';
		$categoryInfo['updated'] = count($catHistory) > 1 ? '<b>'.$this->getStateById($catHistory[0]['to_state']).' by:</b> '.$userUpdated.' on '.date('l jS F Y', $catHistory[0]['timedate']).'<br/>' : '';
		
		echo json_encode($categoryInfo);
		die();
	}
	
	public function getFileInfo() {
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$id = $this->db_files->escape($this->request->post['id']);
		$fileInfo = array('created' => '', 'updated' => '', 'filesize' => 0);
		
		$this->load->model('file');
		$file = $this->model_file->findFile($id);
		$fileHistory = $this->model_file->findFileHistory($id);
		
		$fileInfo['filesize'] = '<b>Size:</b> '.$file['filesize'].'<br/>';
		
		$this->load->model('user');
		$firstUser = $this->model_user->findUser($fileHistory[count($fileHistory)-1]['user_id']);
		$lastUser = $this->model_user->findUser($fileHistory[0]['user_id']);
		
		$userCreated = (!empty($firstUser['first_name']) || !empty($firstUser['last_name'])) ? $firstUser['first_name'].' '.$firstUser['last_name'] : $firstUser['username'];
		$userUpdated = (!empty($lastUser['first_name']) || !empty($lastUser['last_name'])) ? $lastUser['first_name'].' '.$lastUser['last_name'] : $lasttUser['username'];
		
		$fileInfo['created'] = '<b>Created by:</b> '.$userCreated.' on '.date('l jS F Y', $fileHistory[count($fileHistory)-1]['timedate']).'<br/>';
		$fileInfo['updated'] = count($fileHistory) > 1 ? '<b>'.$this->getStateById($fileHistory[0]['to_state']).' by:</b> '.$userUpdated.' on '.date('l jS F Y', $fileHistory[0]['timedate']).'<br/>' : '';
		
		echo json_encode($fileInfo);
		die();
	}
	
	private function getStateById($id) {
		$state = '';
		switch($id) {
			case 1:
				$state = 'Created';
				break;
			case 2:
				$state = 'Updated';
				break;
			case 3:
				$state = 'Renamed';
				break;
			case 4:
				$state = 'Restored from Trash';
				break;
			case 5:
				$state = 'Moved to Trash';
				break;
			case 6:
				$state = 'Permanently deleted';
				break;
			default:
				$state = 'Uknown state. Please contact the web administrator!';
		}
		
		return $state;
	}
}
?>