<?php
class ControllerFooter extends Controller {
	protected function index() {
		$this->data['header'] = $this->language->getLanguage('header');
		$this->data['scripts'] = $this->document->getScripts();
		$this->template = 'footer.tpl';
    	$this->render();
	}
}
?>