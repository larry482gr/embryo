<?php 
	class ModelProfile extends Model {
		public function getIdByLabel($label) {
			$query = "SELECT id FROM profiles WHERE label = '".$label."'";
			$result = $this->db->query($query);
			return $result->row;
		}
	}
?>