<?php
class ControllerAdminTodo extends Controller {
	public function index($args = false) {
		$this->load->model('todo');
		
		$this->document->addStyle('admin/todo');
		$this->document->addScript('admin/todo');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/todo/index.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function newIssue() {
		$this->load->model('user');
		$this->load->model('tab');
		
		$this->data['users'] = $this->model_user->findUsers('user.profile_id = 1');
		$tabs_gr = $this->model_tab->findActiveTabs('2');
		$tabs_en = $this->model_tab->findActiveTabs('1');
		$this->data['tabs'] = array_merge($tabs_gr, $tabs_en);
		$this->data['subtabs'] = $this->model_tab->findAllSubTabs();
	
		$this->document->addStyle('admin/todo');
		$this->document->addScript('admin/todo');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/todo/new.tpl';
		$this->response->setOutput($this->render());
	}
}
?>