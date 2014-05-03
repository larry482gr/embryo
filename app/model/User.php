<?php 
	class ModelUser extends Model {
		public function validateUser($username, $password) {
			$query = "SELECT * FROM users WHERE username = '".$username."' AND password = '".$password."'";
			$result = $this->db->query($query);
			return $result->row;
		}
	}
?>