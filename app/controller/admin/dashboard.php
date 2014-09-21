<?php
class ControllerAdminDashboard extends Controller {
	public function index() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['user']['id'] = $this->session->data['user']['id'];
		$this->data['user']['name'] = $this->session->data['user']['name'];
		
		$this->document->addStyle("admin/dashboard");
		
		// Assign header/footer to children object
		$this->children = array('admin/header');
		
		// Assign at template object the tpl
		$this->template = 'admin/dashboard.tpl';
		$this->response->setOutput($this->render());
	}
}
?>