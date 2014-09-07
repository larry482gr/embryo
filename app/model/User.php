<?php 
	class ModelUser extends Model {
		public function findUser($id) {
			$query = "SELECT user.*, info.* FROM users AS user, user_infos AS info WHERE user.id = ".$id." AND user.id = info.user_id";
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function findUserByOrCondition($user) {
			$whereClause = "";
			foreach($user as $key => $value) {
				$whereClause .= $key." = '".$value."' OR ";
			}
			$whereClause = substr($whereClause, 0, -3);
			$query = "SELECT user.*, info.* FROM users AS user, user_infos AS info WHERE (".$whereClause.") AND user.id = info.user_id";
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function registerUser($user) {
			$username = $this->db->escape($user['uname']);
			$email = $this->db->escape($user['email']);
			$pass = $this->db->escape($user['pass']);
			$profile = isset($user['profile']) ? $this->db->escape($user['profile']) : 4;
			
			$query = "INSERT INTO users (username, password, email, profile_id, created_at, updated_at) VALUES ('".$username."', '".sha1($pass)."', '".$email."', ".$profile.", NOW(), NOW())";
			$this->db->query($query);
			return $this->db->getLastId();
		}
		
		public function setUserInfo($id, $token, $user = array()) {
			if(empty($user))
				$query = "INSERT INTO user_infos (user_id, token) VALUES (".$id.", '".$token."')";
			else {
				$firstName = $this->db->escape($user['firstName']);
				$lastName = $this->db->escape($user['lastName']);
				$faculty = $this->db->escape($user['faculty']);
				$postalAddress = $this->db->escape($user['postalAddress']);
				$phoneNumber = $this->db->escape($user['phoneNumber']);
				$query = "INSERT INTO user_infos (user_id, first_name, last_name, faculty, postal_address, phone_number, token) 
						  VALUES (".$id.", '".$firstName."', '".$lastName."', '".$faculty."', '".$postalAddress."', '".$phoneNumber."', '".$token."')";
			}
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
		
		public function activateMember($id, $password, $token) {
			$query = "SELECT user.id FROM users AS user, user_infos AS info WHERE user.id = ".$id." AND user.password = '".sha1($password)."' AND user.id = info.user_id AND info.activated = 0 AND info.token = '".$token."'";
			$result = $this->db->query($query);
			if(!empty($result->row)) {
				$query2 = "UPDATE user_infos SET activated = 1, token = NULL WHERE user_id = ".$id;
				$this->db->query($query2);
			}
			return $this->db->countAffected();
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
		
		public function emailExists($email) {
			$email = $this->db->escape($email);
			$query = "SELECT id FROM users WHERE email = '".$email."'";
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
		
		public function resetPass($user) {
			$username = $this->db->escape($user['uname']);
			$email = $this->db->escape($user['email']);
			$query = "UPDATE users SET password = '".sha1($user['pass'])."' WHERE username = '".$username."' OR email = '".$email."'";
			$this->db->query($query);
			return $this->db->countAffected();
		}
	}
?>