<?php
class Request {
	public $get = array();
	public $post = array();
	public $cookie = array();
	public $files = array();
	public $server = array();
	
  	public function __construct() {
		$_GET = $this->clean($_GET);
		$_POST = $this->clean($_POST);
		$_REQUEST = $this->clean($_REQUEST);
		$_COOKIE = $this->clean($_COOKIE);
		$_FILES = $this->clean($_FILES);
		$_SERVER = $this->clean($_SERVER);
		
		$this->get = $_GET;
		$this->post = $_POST;
		$this->request = $_REQUEST;
		$this->cookie = $_COOKIE;
		$this->files = $_FILES;
		$this->server = $_SERVER;
	}
	
  	public function clean($data) {
    	if (is_array($data)) {
	  		foreach ($data as $key => $value) {
				unset($data[$key]);
				
	    		$data[$this->clean($key)] = $this->clean($value);
	  		}
		} else { 
	  		$data = htmlspecialchars($data, ENT_COMPAT);
		}

		return $data;
	}
	
	public function escapeGet(){
		foreach ($this->get as $key => $value) {
			if(!get_magic_quotes_gpc()){
				if(is_array($value)){
					foreach ($value as $index => $val) {
						$this->get[$key][$index] = addslashes($val);
					}		
				} else
					$this->get[$key] = addslashes($value);	
			}
  		}	
	}
	
	public function escapePost(){
		foreach ($this->post as $key => $value) {
			if(!get_magic_quotes_gpc()){
				if(is_array($value)){
					foreach ($value as $index => $val) {
						$this->post[$key][$index] = addslashes($val);
					}		
				} else
					$this->post[$key] = addslashes($value);	
			}	
  		}	
	}
	
	public function escapeRequest(){
		foreach ($this->request as $key => $value) {
			if(!get_magic_quotes_gpc()){
				if(is_array($value)){
					foreach ($value as $index => $val) {
						$this->request[$key][$index] = addslashes($val);
					}		
				} else
					$this->request[$key] = addslashes($value);	
			}
  		}	
	}
}
?>
