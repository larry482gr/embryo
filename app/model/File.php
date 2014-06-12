<?php 
	class ModelFile extends Model {
		public function findAllActiveFileCategories($lang_id, $order = '', $limit = '') {
			$query = "SELECT * FROM file_categories WHERE lang_id = ".$lang_id." AND category_state < 5 ".$order." ".$limit;
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
			$timestamp = time();
			$query = "INSERT INTO file_categories (label, lang_id, category_state, created_at)
					  VALUES ('".$label."', ".$lang_id.", 1, ".$timestamp.")";
			$this->db_files->query($query);
			$lastId = $this->db_files->getLastId();
			
			if($lastId > 0) {
				$userId = $this->session->data['user']['id'];
				$this->setCategoryHistory($lastId, $userId, 'NULL', 1, $timestamp);
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
		
		private function setCategoryHistory($categoryId, $userId, $fromState, $toState, $timestamp) {
			$query = "INSERT INTO file_category_history VALUES (".$categoryId.", ".$userId.", ".$fromState.", ".$toState.", ".$timestamp.")";
			$this->db_files->query($query);
		}
		
		public function findAllActiveFiles($categoryId) {
			$query = "SELECT * FROM files WHERE category_id = ".$categoryId." AND file_state < 5 ".$order." ".$limit;
			$result = $this->db_files->query($query);
			return isset($result->rows) ? $result->rows : false;
		}
		
		public function findFile($id) {
			$query = "SELECT * FROM files WHERE id = ".$id;
			$result = $this->db_files->query($query);
			return $result->row;
		}
		
		public function findFileHistory($fileId, $limit = '') {
			$query = "SELECT * FROM file_history WHERE file_id = ".$fileId." ORDER BY timedate DESC ".$limit;
			$result = $this->db_files->query($query);
			return empty($limit) ? $result->rows : $result->row;
		}
		
		public function createFile($fileLabel, $fileSize, $fileCategory) {
			$timestamp = time();
			$query = "INSERT INTO files (label, filesize, category_id, file_state, created_at)
					  VALUES ('".$fileLabel."', ".$fileSize.", ".$fileCategory.", 1, ".$timestamp.")";
			$this->db_files->query($query);
			$lastId = $this->db_files->getLastId();
			
			if($lastId > 0) {
				$userId = $this->session->data['user']['id'];
				$this->setFileHistory($lastId, $userId, 'NULL', 1, $timestamp);
			}
			
			return $lastId;
		}
		
		public function updateFile($id, $label, $toState) {
			$query = "UPDATE files SET 
					  label = '".$label."', 
					  file_state = ".$toState." 
					  WHERE id = ".$id;
			$this->db_files->query($query);
			$affectedRows = $this->db_files->countAffected();
			
			$fileHistory = $this->findFileHistory($id, 'LIMIT 1');
			$fromState = $fileHistory['to_state'];
			
			if($affectedRows > 0) {
				$userId = $this->session->data['user']['id'];
				$this->setFileHistory($id, $userId, $fromState, $toState, time());
			}
			
			return $affectedRows;
		}
		
		private function setFileHistory($fileId, $userId, $fromState, $toState, $timestamp) {
			$query = "INSERT INTO file_history VALUES (".$fileId.", ".$userId.", ".$fromState.", ".$toState.", ".$timestamp.")";
			$this->db_files->query($query);
		}
	}
?>