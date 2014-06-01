<?php 
	class ModelUser extends Model {
		public function validateUser($username, $password) {
			$query = "SELECT * FROM users WHERE username = '".$username."' AND password = '".sha1($password)."'";
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function getUserInfo($id) {
			$query = "SELECT info.*, user.email AS email FROM user_infos AS info, users AS user WHERE user.id = ".$id." AND info.user_id = user.id";
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function updateUserInfo($user) {
			$firstName = $this->db->escape($user['firstName']);
			$lastName = $this->db->escape($user['lastName']);
			$email = $this->db->escape($user['email']);
			
			$query = "UPDATE user_infos SET first_name = '".$firstName."', last_name = '".$lastName."' WHERE user_id = ".$user['id'];
			$this->db->query($query);
			
			$query = "UPDATE users SET email = '".$email."' WHERE id = ".$user['id'];
			$this->db->query($query);
		}
		
		public function passExists($id, $pass) {
			$query = "SELECT password FROM users WHERE id = ".$id." AND password = '".sha1($pass)."'";
			$result = $this->db->query($query);
			return !empty($result->row);
		}
		
		public function changePass($id, $pass) {
			$query = "UPDATE users SET password = '".sha1($pass)."' WHERE id = ".$id;
			$this->db->query($query);
			return $this->db->countAffected();
		}
	}
?>