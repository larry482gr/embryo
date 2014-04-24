<?php
class ControllerInitial extends Controller {
	// Subaction argument defines whether user is in normal login, just registered or activation state.
	public function index() {
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer');
		
		// Assign at template object the tpl
		$this->template = 'index.tpl';
		$this->response->setOutput($this->render());
	}
}
?>