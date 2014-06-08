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
		
		$this->load->model('file');
		$this->data['categories'] = $this->model_file->findAllActiveFileCategories($lang_id);
		
		$this->session->data['loadMembersArea'] = true;

		$this->document->addStyle('left_part');
		$this->document->addStyle('members_area');
		$this->document->addScript('members_area');

		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'members/webtop.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function getDeletedItems() {
		if(!$this->right->canViewMembersArea()) {
			$this->session->data['userRightsDenied'] = $this->language->getPermissionDeniedMessage('userRightsDenied');
			return $this->response->redirect('/');
		}
		
		$items = array('categories' => false, 'files' => false);
		
		$this->load->model('file');
		
		$deletedCategories = $this->model_file->findDeletedCategories();
		if($deletedCategories)
			$items['categories'] = $deletedCategories;
			
		$deletedFiles = $this->model_file->findDeletedFiles();
		if($deletedFiles)
			$items['files'] = $deletedFiles;
		
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
	
	public function deleteCategory() {
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
		
		echo json_encode($category);
		die();
	}
	
	/*
	public function getLinks($cat_id) {
		$this->load->model('link');
		
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['links'] = $this->language->getLanguage('links');
		$pageSubtitle = $this->model_link->findCategory($cat_id);
		$this->data['links']['pageSubtitle'] = $pageSubtitle['label'];
			
		$this->data['links_array'] = $this->model_link->findLinks($cat_id);
		$this->data['categories'] = false;
	
		$this->document->addStyle('links');
		$this->document->addScript('links');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'links/index.tpl';
		$this->response->setOutput($this->render());
	}
	*/
}
?>