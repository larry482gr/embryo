<?php

class Cookies{
	
	public	$period = '';
	private $cookie_name= '';
	private $path= '';

public function Cookies($period=0, $cookie_name, $path='/'){
	$this->period=$period;
	$this->cookie_name=$cookie_name; 
	$this->path=$path; 
}
	
public function create_cookie($data, $path=''){ 
	if($path==''){$path=$this->path;}
 	setcookie( $this->cookie_name, $data, $this->period , $path); 
}	
	
public function del_cookie($redirect=''){ 
 	setcookie ("auth_AmdTelecom", "0", time()-"$period" , "/"); // delete cookie
	if ($redirect != ''){
		header('Location: http://'.$_SERVER['HTTP_HOST']."/$redirect");
 		exit; 
	}
}

public function logout($customerID, $db, $redirect=''){ 
	$del_coookie=$this->del_cookie($redirect);
}


}//class

?>
