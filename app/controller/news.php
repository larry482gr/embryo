<?php
class ControllerNews extends Controller {
	public function index($args = false) {
		if($args) {
			return $this->getArticle($args);
		}
		else {
			$lang_id = $this->language->getCurrentLanguageId();
			$this->data['lang'] = $this->language->getCurrentLanguage();
			$this->data['news'] = $this->language->getLanguage('news');
			$this->data['home'] = $this->language->getLanguage('home');
			$this->data['months'] = $this->language->getMonthArray();
			
			$this->load->model('article');
			$this->data['articles'] = $this->model_article->findPublished($lang_id, 'ORDER BY published_at DESC');
	
			$this->document->addStyle('news');
			$this->document->addScript('news');
			
			// Assign header/footer to children object
			$this->children = array('header', 'footer');
			
			// Assign at template object the tpl
			$this->template = 'news/index.tpl';
			$this->response->setOutput($this->render());
		}
	}
	
	public function getArticle($article_id) {
		$this->load->model('article');
		
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['home'] = $this->language->getLanguage('home');
		$this->data['news'] = $this->language->getLanguage('news');
			
		$this->data['article'] = $this->model_article->find($article_id);
		
		$this->document->addStyle('news');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'news/show.tpl';
		$this->response->setOutput($this->render());
	}
}
?>