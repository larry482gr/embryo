<?php
class ControllerAdminHome extends Controller {
	// Subaction argument defines whether user is in normal login, just registered or activation state.
	public function index() {
		$this->data['home'] = $this->language->getLanguage('home');
		
		$this->load->model('article');
		$this->data['articles'] = $this->model_article->findLatest($this->language->getCurrentLanguageId());
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/index.tpl';
		$this->response->setOutput($this->render());
	}
}
?>