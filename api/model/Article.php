<?php 
	class Article {
		private $db;
		
		public function __construct($db) {
			$this->db = $db;
		}
		
		public function findAll($order = '', $limit = '', $additionalQuery = 1) {
			$query = "SELECT * FROM articles WHERE ".$additionalQuery." ".$order." ".$limit;
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findPublished($lang_id, $order = '', $limit = '') {
			$query = "SELECT id, title, short_desc, long_desc, picture, published_at FROM articles WHERE lang_id = ".$lang_id." AND is_published = 1 ".$order." ".$limit;
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function find($id) {
			$query = "SELECT * FROM articles WHERE id = ".$id." AND is_published = 1";
			$result = $this->db->query($query);
			return isset($result->row) ? $result->row : false;
		}
		
		public function findAny($id) {
			$query = "SELECT * FROM articles WHERE id = ".$id;
			$result = $this->db->query($query);
			return isset($result->row) ? $result->row : false;
		}
		
		public function findCarouselArticles($lang_id) {
			$query = "SELECT id, title, picture, carousel_label, carousel_position FROM articles WHERE lang_id = ".$lang_id." AND is_published = 1 AND carousel = 1 ORDER BY carousel_position, published_at DESC";
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findLatestArticles($lang_id, $arts_number = 10) {
			$query = "SELECT id, title, short_desc, picture, published_at FROM articles WHERE lang_id = ".$lang_id." AND is_published = 1 AND carousel = 0 ORDER BY published_at DESC LIMIT 0, ".$arts_number;
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function searchArticles($lang_id, $search_text) {
			$query = "SELECT id, title, published_at 
					  FROM articles 
					  WHERE lang_id = ".$lang_id." AND is_published = 1 AND published_at <= NOW() 
					  AND (title LIKE '%".$search_text."%' OR short_desc LIKE '%".$search_text."%' OR long_desc LIKE '%".$search_text."%')";
			$result = $this->db->query($query);
			return isset($result->rows) ? $result->rows : false ;
		}
		
		public function updateCarousel($id, $carousel) {
			$carousel_position = $carousel == 1 ? 1 : 'NULL';
			$query = "UPDATE articles SET carousel = ".$carousel.", carousel_position = ".$carousel_position." WHERE id = ".$id;
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function removeLastFromCarousel($lang_id, $carousel_max) {
			$query = "UPDATE articles SET carousel = 0, carousel_position = NULL WHERE lang_id = ".$lang_id." AND carousel_position = ".$carousel_max;
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function updateCarouselPosition($id, $new_position) {
			$query = "UPDATE articles SET carousel_position = ".$new_position." WHERE id = ".$id;
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function increaseArticlesPositions($id, $lang_id, $new_position, $old_potition) {
			$query = "UPDATE articles SET carousel_position = carousel_position + 1 WHERE id != ".$id." AND lang_id = ".$lang_id." AND carousel_position >= ".$new_position." AND carousel_position < ".$old_potition;
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function decreaseArticlesPositions($id, $lang_id, $new_position, $old_potition) {
			$query = "UPDATE articles SET carousel_position = carousel_position - 1 WHERE id != ".$id." AND lang_id = ".$lang_id." AND carousel_position > ".$old_potition." AND carousel_position <= ".$new_position;
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function updatePublished($id, $isPublished) {
			$updatePublishedAt = $isPublished == 1 ? ', published_at = NOW()' : '';
			$query = "UPDATE articles SET is_published = ".$isPublished.$updatePublishedAt." WHERE id = ".$id;
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function create($lang_id, $article) {
			$query = "INSERT INTO articles (title, short_desc, long_desc, source_label, source_link, lang_id, carousel_label, created_at)
					  VALUES ('".$article['title']."', '".$article['short_desc']."', '".$article['long_desc']."', 
					  		  '".$article['source_label']."', '".$article['source_link']."', ".$lang_id.", 
					  		  '".$article['carousel_label']."', NOW())";
			$this->db->query($query);
			return $this->db->getLastId();
		}
		
		public function edit($article) {
			$query = "UPDATE articles 
					  SET title = '".$article['title']."', 
					  	  short_desc = '".$article['short_desc']."',
					  	  long_desc = '".$article['long_desc']."',
					  	  source_label = '".$article['source_label']."',
					  	  source_link = '".$article['source_link']."',
					  	  carousel_label = '".$article['carousel_label']."'
					  WHERE id = ".$article['id'];
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function editImage($article) {
			$query = "UPDATE articles SET picture = '".$article['picture']."' WHERE id = ".$article['id'];
			$this->db->query($query);
			return $this->db->countAffected();
		}
	}
?>