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
	public function login($subaction = 0) {
		if(isset($this->session->data['user']['id'])) {
			$referer = $this->session->data['loginReferer'];
			unset($this->session->data['loginReferer']);
			return $this->response->redirect($referer);
		}
	
		if ($subaction == 0) {
			$this->data['form'] = $this->language->getLanguage('form');
			$username = isset($this->request->post['user']['uname']) ? $this->request->post['user']['uname'] : '';
			if (!empty($username) && isset($this->request->post['user']['pass'])) {
				$password = $this->request->post['user']['pass'];
				$this->check_login($username, $password, $this->data['form']['loginError']);
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
		
		$this->document->addStyle('user');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'user/login.tpl';
		$this->response->setOutput($this->render());
	}
	
	private function check_login($username, $password, $inv_error) {
		$this->load->model('user');
		
		$user = $this->model_user->validateUser($username, $password);
		
		// Invalid user
		if (!$user) {
			$this->invalid_error = $inv_error;
			return;
		}
		// Valid BUT not activated user.
		else if (!$user['activated']) {
			return $this->response->redirect('user/activate&user='.$user['username']);
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

		return $this->response->redirect('/');
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
	
	public function register() {
		if(!isset($this->session->data['user']['id']) && !$this->right->isAdministrator()) {
			$this->session->data['userPermissionDenied'] = $this->language->getPermissionDeniedMessage('userDenied');
			return $this->response->redirect('/'); 
		}
		
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['form'] = $this->language->getLanguage('form');
		$user = isset($this->request->post['user']) ? $this->request->post['user'] : '';
		$affectedRows = 0;
		
		// if(!empty($user['uname']) && !empty($user['email']) && !empty($user['pass']) && !empty($user['confPass']) && !empty($user['profile'])) {
		if(!empty($user['uname']) && !empty($user['email']) && !empty($user['profile'])) {
			$this->load->model('user');
			$this->load->model('profile');
			$profile = $this->model_profile->getIdByLabel($user['profile']);
			$user['profile'] = $profile['id'];
			$lastId = $this->model_user->registerUser($user);
			if($lastId > 0) {
				$token = $this->createToken(64);
				$affectedRows = $this->model_user->setUserInfo($lastId, $token);
				if($affectedRows == 1) {
					$passChanged = $this->model_user->changePass($lastId, substr($token, 0, 10));
					if($passChanged) {
						$to      = $user['email'];
						$message  = '<h3>A new account has been created for you in embryo.web.auth.gr</h3>';
						$message .= '<div>Please follow the link below to activate your account.</div>';
						$message .= '<a href="embryo.web.auth.gr/user/'.$lastId.'/activate/'.$token.'">';
						// To send HTML mail, the Content-type header must be set
						$headers  = 'MIME-Version: 1.0' . "\r\n";
						$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
						
						// Additional headers
						$headers .= 'From: '.$name.' <'.$email.'>' . "\r\n";
						$headers .= 'Reply-To: ' . $email . "\r\n";
						$headers .= 'X-Mailer: PHP/' . phpversion();
						
						if(mail($to, $subject, $message, $headers))
							$this->data['registerSuccess'] = $this->data['form']['registerSuccess'];
						else
							$this->data['registerError'] = $this->data['form']['registerError'];
					}
					else {
						$this->data['registerError'] = $this->data['form']['registerError'];
					}
				}
				else
					$this->data['registerError'] = $this->data['form']['registerError'];
			}
		}
		else {
			$this->data['username'] = !empty($user) ? $user['uname'] : "";
			$this->data['email'] = !empty($user) ? $user['email'] : "";
		}
		
		$this->data['profiles'] = $this->right->getProfiles();
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
	
	public function check_username() {
		$username = $this->request->post['username'];
		$this->load->model('user');
		$usernameExists = $this->model_user->usernameExists($username);
		
		echo $usernameExists ? "not available" : "available" ;
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