<?php 
	class ModelContent extends Model {
		public function findContent($alias, $lang_id, $order = '', $limit = '') {
			$query = "SELECT * FROM static_content WHERE alias = '".$alias."' AND lang_id = ".$lang_id." ".$order." ".$limit;
			$result = $this->db->query($query);
			return $result->row;
		}
	}
?>