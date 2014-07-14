<?php
class ControllerAdminArticles extends Controller {
	public function index() {
		$this->data['form'] = $this->language->getLanguage('form');
		$this->data['news'] = $this->language->getLanguage('news');
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang_id'] = $lang_id;
		$this->data['languages'] = $this->language->getAvailableLanguages();
		
		$this->load->model('article');
		$this->data['articles'] = $this->model_article->findAll('ORDER BY published_at DESC', 'LIMIT 0, 10', 'lang_id = '.$lang_id.' AND is_published = 1');
		
		$this->document->addStyle('admin/articles');
		$this->document->addScript('admin/articles');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/articles.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function updateCarousel() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin/dashboard');
		}
		
		$articleId = $this->db->escape($this->request->post['articleId']);
		$showOnCarousel = $this->db->escape($this->request->post['showOnCarousel']);
		
		$this->load->model('article');
		$affectedRows = $this->model_article->updateCarousel($articleId, $showOnCarousel);
		
		$result = $affectedRows > 0 ? 1 : 0;
		
		echo $result;
		die();
	}
	
	public function updatePublished() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin/dashboard');
		}
		
		$articleId = $this->db->escape($this->request->post['articleId']);
		$isPublished = $this->db->escape($this->request->post['isPublished']);
		
		$this->load->model('article');
		$affectedRows = $this->model_article->updatePublished($articleId, $isPublished);
		
		$result = $affectedRows > 0 ? 1 : 0;
		
		echo $result;
		die();
	}
	
	public function getArticles() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin/dashboard');
		}
		
		$lang_id = $this->db->escape($this->request->post['lang_id']);
		$showUnpublished = $this->db->escape($this->request->post['showUnpublished']);
		$isPublishedClause = !$showUnpublished ? 'is_published = 1' : '1';
		
		$this->load->model('article');
		$articles = $this->model_article->findAll('ORDER BY published_at DESC', 'LIMIT 0, 10', 'lang_id = '.$lang_id.' AND '.$isPublishedClause);
		
		echo json_encode($articles);
		die();
	}
	
	public function getArticle($id) {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin/dashboard');
		}
		
		$this->load->model('article');
		$article = $this->model_article->find($id);
		
		echo json_encode($article);
		die();
	}
}
?>