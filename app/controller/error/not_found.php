<?php
class ControllerErrorNotFound extends Controller {
	public function index() {
	
		$this->template = 'error/not_found.tpl';
		
		$this->children = array(
			'header',
			'footer'
		);
		
    	$this->response->setOutput($this->render());
	}
}
?>