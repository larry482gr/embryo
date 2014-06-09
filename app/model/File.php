<?php 
	class ModelFile extends Model {
		public function findAllActiveFileCategories($lang_id, $order = '', $limit = '') {
			$query = "SELECT * FROM file_categories WHERE lang_id = ".$lang_id." AND category_state < 5".$order." ".$limit;
			$result = $this->db_files->query($query);
			return $result->rows;
		}
		
		public function findCategory($id) {
			$query = "SELECT * FROM file_categories WHERE id = ".$id;
			$result = $this->db_files->query($query);
			return $result->row;
		}
		
		public function findCategoryHistory($categoryId, $limit = '') {
			$query = "SELECT * FROM file_category_history WHERE category_id = ".$categoryId." ORDER BY timedate DESC ".$limit;
			$result = $this->db_files->query($query);
			return empty($limit) ? $result->rows : $result->row;
		}
		
		public function findCategoryFilesInfo($categoryId) {
			$query = "SELECT COUNT(*) AS totalFiles, SUM(filesize) AS totalFileSize FROM files WHERE category_id = ".$categoryId;
			$result = $this->db_files->query($query);
			return $result->row;
		}
		
		public function findDeletedCategories() {
			$query = "SELECT * FROM file_categories WHERE category_state = 5";
			$result = $this->db_files->query($query);
			return isset($result->rows) ? $result->rows : false ;
		}
		
		public function findDeletedFiles() {
			$query = "SELECT * FROM files WHERE file_state = 5";
			$result = $this->db_files->query($query);
			return isset($result->rows) ? $result->rows : false ;
		}
		
		public function createCategory($lang_id, $label) {
			$query = "INSERT INTO file_categories (label, lang_id, category_state, created_at)
					  VALUES ('".$label."', ".$lang_id.", 1, ".time().")";
			$this->db_files->query($query);
			$lastId = $this->db_files->getLastId();
			
			if($lastId > 0) {
				$userId = $this->session->data['user']['id'];
				$this->setCategoryHistory($lastId, $userId, 'NULL', 1, time());
			}
			
			return $lastId;
		}
		
		public function updateCategory($id, $label, $toState) {
			$query = "UPDATE file_categories SET 
					  label = '".$label."', 
					  category_state = ".$toState." 
					  WHERE id = ".$id;
			$this->db_files->query($query);
			$affectedRows = $this->db_files->countAffected();
			
			$catHistory = $this->findCategoryHistory($id, 'LIMIT 1');
			$fromState = $catHistory['to_state'];
			
			if($affectedRows > 0) {
				$userId = $this->session->data['user']['id'];
				$this->setCategoryHistory($id, $userId, $fromState, $toState, time());
			}
			
			return $affectedRows;
		}
		
		private function setCategoryHistory($fileId, $userId, $fromState, $toState, $timestamp) {
			$query = "INSERT INTO file_category_history VALUES (".$fileId.", ".$userId.", ".$fromState.", ".$toState.", ".$timestamp.")";
			$this->db_files->query($query);
		}
	}
?>