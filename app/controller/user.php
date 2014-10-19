<?php
class ControllerUser extends Controller {
	private $invalid_error = '';
	
	public function index($args = false) {
		if($args)
			return $this->getInfo($args);
		// else if($this->right->isAdministrator())
		// 	$this->response->redirect('contact_us');
		else {
			$this->session->data['userPermissionDenied'] = $this->language->getPermissionDeniedMessage('userDenied');
			$this->response->redirect('/');
		}
	}
	
	// Subaction argument defines whether user is in normal login, just registered or activation state.
	public function login($subaction = 0, $membersLogin = false) {
		if(isset($this->session->data['user']['id'])) {
			$referer = $this->session->data['loginReferer'];
			unset($this->session->data['loginReferer']);
			return $this->response->redirect($referer);
		}
	
		if ($subaction == 0) {
			$lang_id = $this->language->getCurrentLanguageId();
			$this->data['lang'] = $this->language->getCurrentLanguage();
			$this->data['form'] = $this->language->getLanguage('form');
			$username = isset($this->request->post['user']['uname']) ? $this->request->post['user']['uname'] : '';
			if (!empty($username) && isset($this->request->post['user']['pass'])) {
				$password = $this->request->post['user']['pass'];
				$this->check_login($username, $password, $this->data['form']['loginError'], $this->data['form']['notActive']);
			}
			
			$this->data['username'] = $username;
			if(isset($this->session->data['permissionDenied'])) {
				$this->data['invalidError'] = $this->session->data['permissionDenied'];
				unset($this->session->data['permissionDenied']);
			}
			else {
				$this->data['invalidError'] = $this->invalid_error;
			}
		}
		
		if(!isset($this->session->data['loginReferer']))
			$this->session->data['loginReferer'] = $this->request->server['HTTP_REFERER'];
				
		$this->data['membersLogin'] = $membersLogin;
		
		$this->document->addStyle('user');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'user/login.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function membersLogin() {
		return $this->login(0, true);
	}
	
	private function check_login($username, $password, $inv_error = '', $activation_error = '') {
		$this->load->model('user');
		
		$user = $this->model_user->validateUser($username, $password);
		
		// Invalid user
		if (!$user) {
			$this->invalid_error = $inv_error;
			return;
		}
		// Valid BUT not activated user.
		else if (!$user['activated']) {
			$this->invalid_error = $activation_error;
			return;
		}
		// Valid user. Proceed to dashboard.
		else {
			$this->session->data['user']['id'] = $user['id'];
			$this->session->data['user']['name'] = $user['username'];
			$this->session->data['user']['email'] = $user['email'];
			$this->session->data['user']['profile'] = $user['profile_id'];
			
			$referer = $this->session->data['loginReferer'];
			unset($this->session->data['loginReferer']);
			return $this->response->redirect($referer);
		}
	}
	
	public function logout() {
		unset($this->session->data['user']['id']);
		unset($this->session->data['user']['name']);
		unset($this->session->data['user']['email']);
		unset($this->session->data['user']['profile']);
		
		$lang = $this->language->getCurrentLanguage();
		return $this->response->redirect('/'.$lang);
	}
	
	public function getInfo($id, $edit = false) {
		if(!isset($this->session->data['user']['id']) || ($id != $this->session->data['user']['id'] && !$this->right->isAdministrator())) {
			$this->session->data['userPermissionDenied'] = $this->language->getPermissionDeniedMessage('userDenied');
			return $this->response->redirect('/');
		}
		
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['userLang'] = $this->language->getLanguage('userLang');
		$this->data['form'] = $this->language->getLanguage('form');
		
		$userId = $this->db->escape($id);
		
		$this->load->model('user');
		$userInfo = $this->model_user->getUserInfo($userId);
		
		$this->data['user'] = array('id' => $id, 'firstName' => $userInfo['first_name'], 'lastName' => $userInfo['last_name'], 'email' => $userInfo['email']);
		$this->data['referer'] = $this->request->server['HTTP_REFERER'];
		$this->data['edit'] = $edit;
	
		$this->document->addStyle('user');
		$this->document->addScript('user');
		$this->document->addStyle('left_part');
		
		$this->children = array('header', 'footer', 'left_part');
		
		$this->template = 'user/info.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function edit($id) {
		if(!isset($this->session->data['user']['id']) || ($id != $this->session->data['user']['id'] && !$this->right->isAdministrator())) {
			$this->session->data['userPermissionDenied'] = $this->language->getPermissionDeniedMessage('userDenied');
			return $this->response->redirect('/'); 
		}
		
		if(empty($this->request->post))
			return $this->getInfo($id, true);
		
		$user = array('id' => $id, 'firstName' => $this->request->post['user']['firstName'], 'lastName' => $this->request->post['user']['lastName'], 'email' => $this->request->post['user']['email']);
		
		$this->load->model('user');
		$this->model_user->updateUserInfo($user);
		
		return $this->getInfo($id, false);
	}
	
	public function checkOldPass() {
		if(!isset($this->session->data['user']['id']))
			die("loged out");
			
		$id = $this->session->data['user']['id'];
		$oldPass = $this->request->post['oldPass'];
		
		$this->load->model('user');
		$passExists = $this->model_user->passExists($id, $oldPass);
		
		echo $passExists ? "yes" : $this->language->getPermissionDeniedMessage('oldPassIncorrect');
		die();
	}
	
	public function changePass() {
		if(!isset($this->session->data['user']['id']) || ($id != $this->session->data['user']['id'] && !$this->right->isAdministrator())) {
			$this->session->data['userPermissionDenied'] = $this->language->getPermissionDeniedMessage('userDenied');
			return $this->response->redirect('/'); 
		}
		
		if(empty($this->request->post))
			return $this->getInfo($id, true);
			
		$oldPass	= $this->request->post['oldPass'];
		$newPass	= $this->request->post['newPass'];
		$confirmPass= $this->request->post['confirmPass'];
		
		if($newPass != $confirmPass)
			die($this->language->getPermissionDeniedMessage('noMatchPass'));
		
		$id = $this->session->data['user']['id'];
		
		$this->load->model('user');
		
		$affectedRows = $this->model_user->changePass($id, $newPass);
		
		if($affectedRows == 1) {
			unset($this->session->data['user']['id']);
			unset($this->session->data['user']['name']);
			unset($this->session->data['user']['email']);
			unset($this->session->data['user']['profile']);
			
			$langForm = $this->language->getLanguage('form');
			die($langForm['passChanged']);
		}
		
		die("error");
	}
	
	public function register($redirectMessage = '') {
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['form'] = $this->language->getLanguage('form');
		$this->data['userLang'] = $this->language->getLanguage('userLang');
		$user = isset($this->request->post['user']) ? $this->request->post['user'] : '';
		$affectedRows = 0;
		
		if(!empty($redirectMessage)) {
			$this->data['username'] = !empty($user) ? $user['uname'] : "";
			$this->data['email'] = !empty($user) ? $user['email'] : "";
			$this->data['registerError'] = $this->data['form']['memberRegisterError'];
		}
		else if((!empty($user['uname']) && !empty($user['email']) && !empty($user['pass']) && !empty($user['confPass']) && !empty($user['confPass']) && 
				 !empty($user['firstName']) && !empty($user['lastName']) && !empty($user['faculty']) &&
				 !empty($user['postalAddress']) && !empty($user['phoneNumber'])) &&
				 ($user['pass'] == $user['confPass'])) {
			$this->load->model('user');
			
			$lastId = $this->model_user->registerUser($user);
			if($lastId > 0) {
				$token = $this->createToken(64);
				$affectedRows = $this->model_user->setUserInfo($lastId, $token, $user);
				if($affectedRows == 1) {
					$to      = $user['email'];
					$subject = 'Your account for repro.law.auth.gr';
					$message  = '<h3>A new account has been created for you in repro.law.auth.gr</h3>';
					$message .= '<div>Please follow the link below to activate your account.</div>';
					$message .= '<div><a href="http://repro.law.auth.gr/user/'.$lastId.'/activate/'.$token.'">http://repro.law.auth.gr/user/'.$lastId.'/activate/'.$token.'</a></div>';
					// To send HTML mail, the Content-type header must be set
					$headers  = 'MIME-Version: 1.0' . "\r\n";
					$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
						
					// Additional headers
					$headers .= 'From: no-reply@repro.law.auth.gr' . "\r\n";
					$headers .= 'X-Mailer: PHP/' . phpversion();
						
					if(mail($to, $subject, $message, $headers))
						$this->data['registerSuccess'] = $this->data['form']['registerSuccess'];
					else
						$this->data['registerError'] = $this->data['form']['registerError'];
				}
				else
					$this->data['registerError'] = $this->data['form']['registerError'];
			}
		}
		else {
			$this->data['username'] = !empty($user) ? $user['uname'] : "";
			$this->data['email'] = !empty($user) ? $user['email'] : "";
		}
		
		$this->data['referer'] = isset($this->request->post['referer']) ? $this->request->post['referer'] : $this->request->server['HTTP_REFERER'];
		
		$this->document->addStyle('user');
		$this->document->addScript('user');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'user/register.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function member_register() {		
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['form'] = $this->language->getLanguage('form');
		$this->data['userLang'] = $this->language->getLanguage('userLang');
		$user = isset($this->request->post['user']) ? $this->request->post['user'] : '';
		$affectedRows = 0;
		
		if((!empty($user['uname']) && !empty($user['email']) && !empty($user['pass']) && !empty($user['confPass'])) && ($user['pass'] == $user['confPass'])) {
			if($this->right->isMember($user['email'])) {
				$this->load->model('user');
				$user['profile'] = 2;
				$lastId = $this->model_user->registerUser($user);
				if($lastId > 0) {
					$token = $this->createToken(64);
					$affectedRows = $this->model_user->setUserInfo($lastId, $token);
					if($affectedRows == 1) {
						$to      = $user['email'];
						$subject = 'Your account for repro.law.auth.gr';
						$message  = '<h3>A new account has been created for you in repro.law.auth.gr</h3>';
						$message .= '<div>Please follow the link below to activate your account.</div>';
						$message .= '<div><a href="http://repro.law.auth.gr/user/'.$lastId.'/activate/'.$token.'">http://repro.law.auth.gr/user/'.$lastId.'/activate/'.$token.'</a></div>';
						// To send HTML mail, the Content-type header must be set
						$headers  = 'MIME-Version: 1.0' . "\r\n";
						$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
							
						// Additional headers
						$headers .= 'From: no-reply@repro.law.auth.gr' . "\r\n";
						$headers .= 'X-Mailer: PHP/' . phpversion();
							
						if(mail($to, $subject, $message, $headers))
							$this->data['registerSuccess'] = $this->data['form']['registerSuccess'];
						else
							$this->data['registerError'] = $this->data['form']['registerError'];
					}
					else
						$this->data['registerError'] = $this->data['form']['registerError'];
				}
			}
			else {
				return $this->register($this->data['form']['memberRegisterError']);
			}
		}
		else {
			$this->data['username'] = !empty($user) ? $user['uname'] : "";
			$this->data['email'] = !empty($user) ? $user['email'] : "";
		}
		
		$this->data['referer'] = isset($this->request->post['referer']) ? $this->request->post['referer'] : $this->request->server['HTTP_REFERER'];
		
		$this->document->addStyle('user');
		$this->document->addScript('user');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'user/member_register.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function activate($args = array()) {
		if(empty($args)) {
			$this->session->data['activationError'] = $this->language->getPermissionDeniedMessage('activationError');
			return $this->response->redirect('/'); 
		}
		
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['form'] = $this->language->getLanguage('form');

		$userId = $this->db->escape($args);
		$token = $this->db->escape($this->session->data['parts'][0]);
		unset($this->session->data['parts']);
		
		$this->load->model('user');
		$user = $this->model_user->findUser($userId);
		
		if(!isset($this->request->post['user']['pass']) && !isset($this->request->post['user']['token'])) {
			$this->invalid_error = $this->data['form']['activationPrompt'];
		
			$this->data['username'] = $user['username'];
			$this->data['token'] = $user['token'];
			
			$this->document->addStyle('user');
			$this->document->addStyle('left_part');
			
			// Assign header/footer to children object
			$this->children = array('header', 'footer', 'left_part');
			
			// Assign at template object the tpl
			$this->template = 'user/activation.tpl';
			$this->response->setOutput($this->render());
		}
		else {
			$pass = $this->db->escape($this->request->post['user']['pass']);
			$token = $this->db->escape($this->request->post['user']['token']);
			$affectedRows = $this->model_user->activateMember($user['id'], $pass, $token);
			if($affectedRows > 0) {
				$this->session->data['loginReferer'] = '/';
				return $this->check_login($user['username'], $this->request->post['user']['pass']);
			}
			else {
				$this->data['invalidError'] = $this->language->getPermissionDeniedMessage('activationError');
		
				$this->data['username'] = $user['username'];
				$this->data['token'] = $user['token'];
				
				$this->document->addStyle('user');
				$this->document->addStyle('left_part');
				
				// Assign header/footer to children object
				$this->children = array('header', 'footer', 'left_part');
				
				// Assign at template object the tpl
				$this->template = 'user/activation.tpl';
				$this->response->setOutput($this->render());
			}
		}
	}
	
	public function pass_reset() {
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['form'] = $this->language->getLanguage('form');
		$username = isset($this->request->post['user']['uname']) ? $this->request->post['user']['uname'] : '';
		$email = isset($this->request->post['user']['email']) ? $this->request->post['user']['email'] : '';
		
		if (!empty($username) || !empty($email)) {
			$pass = $this->createToken(8);
			$user = array('uname' => $username, 'email' => $email, 'pass' => $pass);
			$this->load->model('user');
			$affectedRows = $this->model_user->resetPass($user);
			
			if($affectedRows > 0) {
				// $this->data['recoverResult'] = 1;
				$user = $this->model_user->findUserByOrCondition(array('username' => $username, 'email' => $email));
				$to      = $user['email'];
				$subject = 'Password reset notification.';
				$message  = '<h3>Your account\'s password at <a href="http://repro.law.auth.gr">repro.law.auth.gr</a> has been reset.</h3>';
				$message .= '<div>Your username is: <b>'.$user['username'].'</b></div>';
				$message .= '<div>Your new password is: <b>'.$pass.'</b></div>';
				$message .= '<div style="margin-top: 12px;">For security reasons it is recommended to login and change this password through your profile page.</div>';
				// To send HTML mail, the Content-type header must be set
				$headers  = 'MIME-Version: 1.0' . "\r\n";
				$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
							
				// Additional headers
				$headers .= 'From: no-reply@repro.law.auth.gr' . "\r\n";
				$headers .= 'X-Mailer: PHP/' . phpversion();
							
				if(mail($to, $subject, $message, $headers))
					$this->data['recoverResult'] = 1;
				else
					$this->data['recoverResult'] = 0;
			}
			else
				$this->data['recoverResult'] = 0;
		}
				
		$this->document->addStyle('user');
		$this->document->addScript('user');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'user/pass_reset.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function check_username() {
		$username = $this->request->post['username'];
		$this->load->model('user');
		$usernameExists = $this->model_user->usernameExists($username);
		
		echo $usernameExists ? "not available" : "available" ;
		die();
	}
	
	public function check_email() {
		$email = $this->request->post['email'];
		$this->load->model('user');
		$emailExists = $this->model_user->emailExists($email);
		
		echo $emailExists ? "not available" : "available" ;
		die();
	}
	
	private function createToken($bits) {
		$chars = "0123456789abcdefghijkmnopqrstuvwxyz";
		srand((double)microtime()*1000000);
		$i = 0;
		$pass = '' ;
		while ($i < $bits) {
			$num = rand() % 33;
			$tmp = substr($chars, $num, 1);
			$pass .= $tmp;
			$i++;
		}
		return $pass;
	}
}
?>