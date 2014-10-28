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
			$query = "SELECT label, name, size, created_at FROM info_files WHERE cat_id = ".$catId." ORDER BY weight, label";
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
		
		// =========================================================================================================================================
	}
?>