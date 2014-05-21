<?php
class ControllerLeftPart extends Controller {
	// Subaction argument defines whether user is in normal login, just registered or activation state.
	public function index() {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['home'] = $this->language->getLanguage('home');
		
		$this->load->model('article');
		$this->data['carouselArticles'] = $this->model_article->findCarouselArticles($lang_id);
		$this->data['articles'] = $this->model_article->findLatestArticles($lang_id, 3);
		
		// Assign at template object the tpl
		$this->template = 'left_part.tpl';
		$this->response->setOutput($this->render());
	}
}
?>