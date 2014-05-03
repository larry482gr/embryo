<?php
class ControllerAdminDashboard extends Controller {
	public function index() {
		$this->document->addStyle("admin/dashboard");
		
		// Assign header/footer to children object
		$this->children = array('admin/header');
		
		// Assign at template object the tpl
		$this->template = 'admin/dashboard.tpl';
		$this->response->setOutput($this->render());
	}
}
?>