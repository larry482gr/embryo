<?php 
	class ModelArticle extends Model {
		public function findAll($order = '', $limit = '') {
			$query = "SELECT * FROM articles";
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function find($id) {
			 
		}
		
		public function findLatest($lang_id) {
			$query = "SELECT id, title, short_desc, published_at FROM articles WHERE lang_id = ".$lang_id." AND is_published = 1 ORDER BY published_at DESC LIMIT 0, 10";
			$result = $this->db->query($query);
			return $result->rows;
		}
	}
?>