<?php
class ControllerAdminArticles extends Controller {
	public function index() {
		$this->data['form'] = $this->language->getLanguage('form');
		$this->data['news'] = $this->language->getLanguage('news');
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang_id'] = $lang_id;
		$this->data['languages'] = $this->language->getAvailableLanguages();
		
		$this->load->model('article');
		$this->data['articles'] = $this->model_article->findAll('ORDER BY published_at DESC', '', 'lang_id = '.$lang_id.' AND is_published = 1');
		
		$this->document->addStyle('admin/articles');
		$this->document->addScript('admin/articles');
		$this->document->addScript('libraries/jquery.form.min');
		
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
		
		if($affectedRows > 0 && $isPublished == 1) {
			date_default_timezone_set("Europe/Helsinki");
			$result = date('Y-m-d H:i:s');
		}
		else if($affectedRows > 0 && $isPublished == 0)
			$result = 1;
		else
			$result = 0;
			
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
		$articles = $this->model_article->findAll('ORDER BY published_at DESC', '', 'lang_id = '.$lang_id.' AND '.$isPublishedClause);
		
		echo json_encode($articles);
		die();
	}
	
	public function getArticle($id) {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin/dashboard');
		}
		
		$this->load->model('article');
		$article = $this->model_article->findAny($id);
		$article['long_desc'] = html_entity_decode(nl2br($article['long_desc']));
		
		echo json_encode($article);
		die();
	}
	
	public function create() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin/dashboard');
		}
		
		$lang_id = $this->db->escape($this->request->post['lang_id']);
		$article['title'] = $this->db->escape($this->request->post['articleTitle']);
		$article['short_desc'] = $this->db->escape($this->request->post['articleShortDesc']);
		$article['long_desc'] = $this->db->escape($this->request->post['articleLongDesc']);
		$article['source_label'] = $this->db->escape($this->request->post['articleSourceLabel']);
		$article['source_link'] = $this->db->escape($this->request->post['articleSourceLink']);
		$article['carousel_label'] = $this->db->escape($this->request->post['articleCarouselLabel']);
		
		$this->load->model('article');
		$lastId = $this->model_article->create($lang_id, $article);
		
		if(is_numeric($lastId) && $lastId > 0)
			echo $lastId.'*::*'.$article['title'];
		else
			echo 'error';
			
		die();
	}
	
	public function edit() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin/dashboard');
		}
		
		$article['id'] = $this->db->escape($this->request->post['articleId']);
		$article['title'] = $this->db->escape($this->request->post['articleTitle']);
		$article['short_desc'] = $this->db->escape($this->request->post['articleShortDesc']);
		$article['long_desc'] = $this->db->escape($this->request->post['articleLongDesc']);
		$article['source_label'] = $this->db->escape($this->request->post['articleSourceLabel']);
		$article['source_link'] = $this->db->escape($this->request->post['articleSourceLink']);
		$article['carousel_label'] = $this->db->escape($this->request->post['articleCarouselLabel']);
		
		$this->load->model('article');
		$affectedRows = $this->model_article->edit($article);
		
		if($affectedRows > 0)
			echo $article['title'];
		else
			echo 'error';
			
		die();
	}
	
	public function editImage() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin/dashboard');
		}
		
		$article['id'] = $this->db->escape($this->request->post['article']['id']);
		
		if($imageType == 'undefined') {
			echo 1;
			die();
		}
		else if(empty($this->request->files["articleImage"]["name"]) && empty($this->request->files["articleImage"]["type"])) {
			$article['picture'] = null;
		}
		else {
			$allowedExts = array("png", "jpeg", "jpg");
			$extension = end(explode(".", $this->request->files["articleImage"]["name"]));
			
			$path = $this->request->post['isCarousel'] == 1 ? _DOCUMENT_ROOT_."/resources/images/carousel" : _DOCUMENT_ROOT_."/resources/images/news";
			
			$filepath = !empty($path) ? $path."/".$this->request->files["articleImage"]["name"] : null;
			
			if ((($this->request->files["articleImage"]["type"] == "image/jpeg")
				|| ($this->request->files["articleImage"]["type"] == "image/png"))
				&& ($this->request->files["articleImage"]["size"] < 2000000)
				&& in_array($extension, $allowedExts)) {
				   
				if ($this->request->files["articleImage"]["error"] > 0) {
					echo 2;
					die();
				}
				else {
					if (!file_exists($path."/")) {
				        mkdir($path);
				        chmod($path, 0777);  // octal; correct value of mode
				    }
				    else {
				    	@move_uploaded_file($this->request->files["articleImage"]["tmp_name"], $filepath);
				    	$article['picture'] = $this->request->files["articleImage"]["name"];
				    }
				}
			}
			else {
				echo 3;
				die();
			}
		}
		
		$this->load->model('article');
		
		$affectedRows = $this->model_article->editImage($article);
		if($affectedRows > 0) {
			echo 0;
		}
		else {
			echo 0;
		}
		
		die();
	}
}
?>