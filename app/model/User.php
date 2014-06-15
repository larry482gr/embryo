<?php 
	class ModelUser extends Model {
		public function findUser($id) {
			$query = "SELECT user.*, info.* FROM users AS user, user_infos AS info WHERE user.id = ".$id." AND user.id = info.user_id";
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function registerUser($user) {
			$username = $this->db->escape($user['uname']);
			$email = $this->db->escape($user['email']);
			$pass = $this->db->escape($user['pass']);
			$profile = $this->db->escape($user['profile']);
			
			$query = "INSERT INTO users (username, password, email, profile_id) VALUES ('".$username."', '".sha1($pass)."', '".$email."', ".$profile.")";
			$this->db->query($query);
			return $this->db->getLastId();
		}
		
		public function setUserInfo($id, $token) {
			$query = "INSERT INTO user_infos (user_id, token) VALUES (".$id.", '".$token."')";
			$this->db->query($query);
			return $this->db->countAffected();
		}
		
		public function validateUser($username, $password) {
			$username = $this->db->escape($username);
			$password = $this->db->escape($password);
			
			$query = "SELECT user.*, info.activated FROM users AS user, user_infos AS info WHERE user.username = '".$username."' AND user.password = '".sha1($password)."' AND user.id = info.user_id";
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
		
		public function usernameExists($username) {
			$username = $this->db->escape($username);
			$query = "SELECT id FROM users WHERE username = '".$username."'";
			$result = $this->db->query($query);
			return !empty($result->row);
		}
		
		public function passExists($id, $pass) {
			$id = $this->db->escape($id);
			$pass = $this->db->escape($pass);
			$query = "SELECT password FROM users WHERE id = ".$id." AND password = '".sha1($pass)."'";
			$result = $this->db->query($query);
			return !empty($result->row);
		}
		
		public function changePass($id, $pass) {
			$id = $this->db->escape($id);
			$pass = $this->db->escape($pass);
			$query = "UPDATE users SET password = '".sha1($pass)."' WHERE id = ".$id;
			$this->db->query($query);
			return $this->db->countAffected();
		}
	}
?>