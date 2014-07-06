<?php
class ControllerInformation extends Controller {
	public function getSubcategoryFiles() {
		if(!isset($this->session->data['user']['id'])) {
			die($this->language->getPermissionDeniedMessage('userDenied'));
		}
		
		$catId = $this->db->escape($this->request->post['catId']);
		$items = array();
		
		$this->load->model('info');
		$files = $this->model_info->findFiles($catId);
		
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
}
?>