<?php 
	class ModelUser extends Model {
		public function validateUser($username, $password) {
			$query = "SELECT * FROM users WHERE username = '".$username."' AND password = '".sha1($password)."'";
			$result = $this->db->query($query);
			return $result->row;
		}
	}
?>