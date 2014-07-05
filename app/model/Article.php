<?php 
	class ModelArticle extends Model {
		public function findAll($order = '', $limit = '') {
			$query = "SELECT * FROM articles";
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findPublished($lang_id, $order = '', $limit = '') {
			$query = "SELECT id, title, short_desc, long_desc, picture, published_at FROM articles WHERE lang_id = ".$lang_id." AND is_published = 1 ".$order." ".$limit;
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function find($id) {
			$query = "SELECT * FROM articles WHERE id = ".$id;
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function findCarouselArticles($lang_id) {
			$query = "SELECT id, title, short_desc, picture FROM articles WHERE lang_id = ".$lang_id." AND is_published = 1 AND carousel = 1 ORDER BY published_at DESC";
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
	}
?>