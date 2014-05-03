<?php
class ControllerAdminArticles extends Controller {
	public function index() {
		// Assign header/footer to children object
		$this->children = array('admin/dashboard');
		
		// Assign at template object the tpl
		$this->template = 'admin/articles.tpl';
		$this->response->setOutput($this->render());
	}
}
?>