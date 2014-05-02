<?php 
	class ModelTab extends Model {
		public function findAllTabs($order = '', $limit = '') {
			$query = "SELECT * FROM menu_tabs";
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findAllSubTabs($order = '', $limit = '') {
			$query = "SELECT * FROM menu_subtabs";
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findActiveTabs($lang_id) {
			$query = "SELECT * FROM menu_tabs WHERE lang_id = ".$lang_id." AND is_active = 1 ORDER BY tab_position";
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findActiveSubTabs($tab_ids) {
			$query = "SELECT * FROM menu_subtabs WHERE tab_id IN ".$tab_ids." AND is_active = 1 ORDER BY subtab_position";
			$result = $this->db->query($query);
			return $result->rows;
		}
	}
?>