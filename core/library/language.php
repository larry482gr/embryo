<?php
class Language {
	private $default = 'en';
	private $language;
	private $data = array();
 
	public function __construct($language) {
		$this->language = $language;
	}
	
	public function getCurrentLanguage() {
   		return $this->language;
  	}
	
	public function getCurrentLanguageId() {
		switch($this->language) {
			case 'en':
				return 1;
			case 'gr':
				return 2;
			default:
				return 2;
		}
	}
	
	public function getLanguage($key = false) {
   		return $key ? $this->data['language'][$key] : $this->data['language'];
  	}
  	
  	public function getPermissionDeniedMessage($key = false) {
   		return $key ? $this->data['language']['permission'][$key] : $this->data['language'];
  	}
	
	public function getInformation($key = false) {
   		return $key ? $this->data['information'][$key] : $this->data['information'];
  	}
	
	public function getDayArray($key = false) {
   		return $key ? $this->data['dayArray'][$key] : $this->data['dayArray'];
  	}
	
	public function getMonthArray($key = false) {
   		return $key ? $this->data['monthArray'][$key] : $this->data['monthArray'];
  	}
	
	public function load($filename) {
		$file = LANGUAGE_D . '/' . $filename . '.php';
    	
		if (file_exists($file)) {
			$language = array();
			$information = array();
			$dayArray = array();
			$monthArry = array();
	  		
			require($file);
		
			$this->data['language'] = ($language);
			$this->data['information'] = ($information);
			$this->data['dayArray'] = ($dayArray);
			$this->data['monthArray'] = ($monthArray);
			
			return $this->data;
		}
		
		$file = LANGUAGE_D . '/' . $filename . '.php';
		
		if (file_exists($file)) {
			$_ = array();
	  		
			require($file);
		
			$this->data = array_merge($this->data, $_);
			
			return $this->data;
		} else {
			trigger_error('Error: Could not load language ' . $filename . '!');
		//	exit();
		}
  	}
}
?>
