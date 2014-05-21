<?php
class ControllerAdminHome extends Controller {
	private $invalid_error = '';
	// Subaction argument defines whether user is in normal login, just registered or activation state.
	public function index($subaction = 0) {
		if($this->right->canViewAdminPanel())
			return $this->response->redirect('/admin/dashboard');
	
		if ($subaction == 0) {
			$this->data['form'] = $this->language->getLanguage('form');
			$username = isset($this->request->post['admin']['uname']) ? $this->request->post['admin']['uname'] : '';
			if (!empty($username) && isset($this->request->post['admin']['pass'])) {
				$password = $this->request->post['admin']['pass'];
				$this->check_login($username, $password, $this->data['form']['loginError']);
			}
			
			$this->data['username'] = $username;
			if(isset($this->session->data['permissionDenied'])) {
				$this->data['invalidError'] = $this->session->data['permissionDenied'];
				unset($this->session->data['permissionDenied']);
			}
			else
				$this->data['invalidError'] = $this->invalid_error;
		}
		
		// Assign header/footer to children object
		$this->children = array('admin/header');
		
		// Assign at template object the tpl
		$this->template = 'admin/index.tpl';
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
		/*
		// Valid BUT not activated user.
		else if ($user['isactive'] == 0) {
			return $this->response->redirect($this->url->link('user/activate&user='.$user['username']));
		}
		*/
		// Valid user. Proceed to dashboard.
		else {
			$this->session->data['user']['id'] = $user['id'];
			$this->session->data['user']['name'] = $user['username'];
			$this->session->data['user']['profile'] = $user['profile_id'];
			
			return $this->response->redirect('/admin/dashboard');
		}
	}
	
	public function logout() {
		unset($this->session->data['user']['id']);
		unset($this->session->data['user']['name']);
		unset($this->session->data['user']['profile']);

		return $this->response->redirect('home');
	}
	
	private function createToken($bits) {
		$chars = "0123456789abcdefghijkmnopqrstuvwxyz";
		srand((double)microtime()*1000000);
		$i = 0;
		$pass = '' ;
		while ($i < $bits) {
			$num = rand() % 33;
			$tmp = substr($chars, $num, 1);
			$pass = $pass . $tmp;
			$i++;
		}
		return $pass;
	}
}
?>