<?php
class ControllerNationalCourts extends Controller {
	public function index($args = false) {
		if(!isset($this->session->data['user']['id'])) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('userDenied');
			return $this->response->redirect('/user/login');
		}
		
		$lang_id = $this->language->getCurrentLanguageId();
		
		// Until they tell me to set some subcategories go get cat_id = 10 files
		if($lang_id == 2)
			return $this->getCategory(10);
		else if($lang_id == 1)
			return $this->getCategory(22);
		
		/* Until they tell me to set some subcategories go get cat_id = 10 files
		//if($args) {
			return $this->getCategory($args);
		//}
		/* Until they tell me to set some subcategories go get cat_id = 10 files
		else {
			$lang_id = $this->language->getCurrentLanguageId();
			$this->data['lang'] = $this->language->getCurrentLanguage();
			$this->data['nationalCourts'] = $this->language->getLanguage('nationalCourts');
			$this->data['information'] = $this->language->getLanguage('information');
			
			$this->data['infoPage'] = 'nationalCourts';
				
			// For use in under construction page.
			$this->data['pageTitle'] = $this->data['nationalCourts']['pageTitle'];
			
			$this->load->model('tab');
			$this->load->model('info');
			
			$tabRow = $this->model_tab->findSubTabIdByLink('nationalCourts');
			$tabId = $tabRow['id'];
			$this->data['categories'] = $this->model_info->findCategories($tabId, $lang_id);
		
			$this->document->addStyle('left_part');
			$this->document->addStyle('info');
			$this->document->addScript('info');
				
			// Assign header/footer to children object
			$this->children = array('header', 'footer', 'left_part');
				
			// Assign at template object the tpl
			$this->template = 'information/index.tpl';
			$this->response->setOutput($this->render());
		}
		*/
		// Until they tell me to set some subcategories go get cat_id = 10 files
	}
	
	public function getCategory($catId) {
		if(!isset($this->session->data['user']['id'])) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('userDenied');
			return $this->response->redirect('/user/login');
		}
		
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['nationalCourts'] = $this->language->getLanguage('nationalCourts');
		$this->data['information'] = $this->language->getLanguage('information');
		
		$this->data['infoPage'] = 'nationalCourts';
				
		// For use in under construction page.
		$this->data['pageTitle'] = $this->data['nationalCourts']['pageTitle'];
		
		$this->load->model('info');
		$category = $this->model_info->findCategory($catId);
		
		if(null != $category['parent_id']) {
			// Find parent category, make a select box etc.
		}
		else if(null != $category['label']) {
			$this->data['pageTitle'] .= " / " . $category['label'];
		}
		
		$this->data['subcategories'] = $this->model_info->findSubcategories($category['id']);
		$this->data['hasSubcategories'] = $this->data['subcategories'] == false ? false : true;
		
		if(!$this->data['subcategories']) {
			$this->data['files'] = array();
			$files = $this->model_info->findFiles($category['id']);
			foreach($files as $file) {
				$file['size'] = $this->getProperFileSize($file['size']);
				$file['created_at'] = date('d/m/Y', strtotime($file['created_at']));
				$this->data['files'][] = $file;
			}
		}
		
		$this->document->addStyle('left_part');
		$this->document->addStyle('info');
		$this->document->addScript('info');
				
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
				
		// Assign at template object the tpl
		$this->template = 'information/index.tpl';
		$this->response->setOutput($this->render());
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
}
?>