<?php
class ControllerAdminHome extends Controller {
	private $invalid_error = '';
	// Subaction argument defines whether user is in normal login, just registered or activation state.
	public function index($subaction = 0) {
		if ($subaction == 0) {
			$this->data['form'] = $this->language->getLanguage('form');
			$username = isset($this->request->post['admin']['uname']) ? $this->request->post['admin']['uname'] : '';
			if (!empty($username) && isset($this->request->post['admin']['pass'])) {
				$password = $this->request->post['admin']['pass'];
				$this->check_login($username, $password, $this->data['form']['loginError']);
			}
			
			$this->data['username'] = $username;
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
			$this->session->data['userID'] = $user['id'];
			$this->session->data['name'] = $user['username'];
			$this->session->data['userProfile'] = $user['profile_id'];
			$this->invalid_error = 'Successfully logged in!';
			return;
			// return $this->response->redirect('admin/dashboard');
		}
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