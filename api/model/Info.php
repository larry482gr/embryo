<?php 
	class ModelInfo extends Model {
		public function findCategory($id) {
			$query = "SELECT * FROM info_cat WHERE id = ".$id." AND is_active = 1";
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
			$query = "SELECT id, label, name, size, created_at FROM info_files WHERE cat_id = ".$catId." ORDER BY weight, label";
			$result = $this->db->query($query);
			return isset($result->rows) ? $result->rows : false;
		}
		
		// =========================================================================================================================================
		// Admin Panel
		
		public function findAllInfoSubtabs($lang_id) {
			$query	= "SELECT menu_subtab.id, menu_subtab.label, menu_subtab.is_divided, menu_subtab.subtab_position ";
			$query .= "FROM menu_subtabs AS menu_subtab, menu_tabs AS menu_tab ";
			$query .= "WHERE menu_tab.lang_id = ".$lang_id." AND (menu_tab.id = 6 OR menu_tab.id = 15) AND menu_tab.id = menu_subtab.tab_id ";
			$query .= "ORDER BY menu_subtab.subtab_position, menu_subtab.is_divided DESC";
			$result = $this->db->query($query);
			return isset($result->rows) ? $result->rows : false;
		}
		
		public function findInfoCats($tab_ids, $parent_id = 'NULL') {
			$query = "SELECT * FROM info_cat WHERE tab_id IN (".$tab_ids.") AND parent_id IS ".$parent_id;
			$result = $this->db->query($query);
			return isset($result->rows) ? $result->rows : false;
		}
		
		public function findInfoCategory($id) {
			$query = "SELECT * FROM info_cat WHERE id = ".$id;
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function createInfoCategory($info) {
			$query	= "INSERT INTO info_cat (tab_id, lang_id, label, parent_id, is_active) ";
			$query .= "VALUES (".$info['tab_id'].", ".$info['lang_id'].", ".$info['label'].", ".$info['parent_id'].", ".$info['is_active'].")";
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function updateInfoCategory($info) {
			$query	= "UPDATE info_cat SET ";
			$query .= "tab_id = ".$info['tab_id'].", ";
			$query .= "lang_id = ".$info['lang_id'].", ";
			$query .= "label = ".$info['label'].", ";
			$query .= "parent_id = ".$info['parent_id'].", ";
			$query .= "is_active = ".$info['is_active']." ";
			$query .= "WHERE id = ".$info['edit'];
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function createInfoFile($info) {
			$query	= "INSERT INTO info_files (cat_id, label, name, size, weight) ";
			$query .= "VALUES (".$info['cat_id'].", '".$info['label']."', '".$info['name']."', ".$info['size'].", ".$info['weight'].")";
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function updateInfoFileName($id, $label) {
			$query = "UPDATE info_files SET label = '".$label."' WHERE id = ".$id;
			$this->db->query($query);
			return $this->db->countAffected();
		}
		// =========================================================================================================================================
	}
?>