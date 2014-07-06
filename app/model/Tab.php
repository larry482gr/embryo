<?php 
	class ModelTab extends Model {
		public function findAllTabs($lang_id, $order = '', $limit = '') {
			$query = "SELECT * FROM menu_tabs WHERE lang_id = ".$lang_id." ".$order." ".$limit;
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findAllSubTabs($order = '', $limit = '') {
			$query = "SELECT * FROM menu_subtabs";
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findSubTabIdByLink($link) {
			$query = "SELECT id FROM menu_subtabs WHERE link = '".$link."'";
			$result = $this->db->query($query);
			return $result->row;
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
		
		public function create($tab) {
			$tab_position = $this->getMaxTabPosition($tab['lang_id']);
			$tab['tab_position'] = $tab_position['max_tab'] + 1;
			$query = "INSERT INTO menu_tabs (label, description, link, lang_id, has_submenu, is_active, tab_position)
					  VALUES ('".$tab['label']."', '".$tab['description']."', '".$tab['link']."', ".$tab['lang_id'].",
					  		   ".$tab['has_submenu'].", ".$tab['is_active'].", ".$tab['tab_position'].")";
			$result = $this->db->query($query);
			return $this->db->getLastId();
		}
		
		private function getMaxTabPosition($lang_id) {
			$query = "SELECT MAX(tab_position) AS max_tab FROM menu_tabs WHERE lang_id = ".$lang_id;
			$result = $this->db->query($query);
			return $result->row;
		}
	}
?>