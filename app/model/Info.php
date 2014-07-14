<?php 
	class ModelInfo extends Model {
		public function findCategory($id) {
			$query = "SELECT id, label, parent_id FROM info_cat WHERE id = ".$id." AND is_active = 1";
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function findCategories($tabId, $lang_id) {
			$query = "SELECT id, label FROM info_cat WHERE tab_id = ".$tabId." AND lang_id = ".$lang_id." AND parent_id IS NULL AND is_active = 1";
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findSubcategories($catId) {
			$query = "SELECT id, label FROM info_cat WHERE parent_id = ".$catId." AND is_active = 1";
			$result = $this->db->query($query);
			return isset($result->rows) ? $result->rows : false;
		}
		
		public function findFiles($catId) {
			$query = "SELECT label, name, size, created_at FROM info_files WHERE cat_id = ".$catId." ORDER BY created_at";
			$result = $this->db->query($query);
			return isset($result->rows) ? $result->rows : false;
		}
	}
?>