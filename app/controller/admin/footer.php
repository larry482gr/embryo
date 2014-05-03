<?php
class ControllerAdminFooter extends Controller {
	protected function index() {
		$this->data['scripts'] = $this->document->getScripts();
		$this->template = 'admin/footer.tpl';
    	$this->render();
	}
}
?>