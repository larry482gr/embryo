<?php
class Language {
	private $default = 'eng';
	private $language;
	private $data = array();
 
	public function __construct($language) {
		$this->language = $language;
	}
	
	public function getUsersLanguage() {
   		return $this->language;
  	}
	
	public function getLanguage($key = false) {
   		return $key ? $this->data['language'][$key] : $this->data['language'];
  	}
	
	public function getTracking($key = false) {
   		return $key ? $this->data['tracking'][$key] : $this->data['tracking'];
  	}
	
	public function getGadgets($key = false) {
   		return $key ? $this->data['gadgets'][$key] : $this->data['gadgets'];
  	}
	
	public function getStatus($key = false) {
   		return $key ? $this->data['status'][$key] : $this->data['status'];
  	}
	
	public function getHLRStatus($key = false) {
   		return $key ? $this->data['hlrStatus'][$key] : $this->data['hlrStatus'];
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
			$tracking = array();
			$gadgets = array();
			$status = array();
			$hlr_status = array();
			$information = array();
			$dayArray = array();
			$monthArry = array();
	  		
			require($file);
		
			$this->data['language'] = ($language);
			$this->data['tracking'] = ($tracking);
			$this->data['gadgets'] = ($gadgets);
			$this->data['status'] = ($status);
			$this->data['hlrStatus'] = ($hlr_status);
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
