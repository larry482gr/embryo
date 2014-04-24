<?php
final class Loader {
	protected $registry;
	
	public function __construct($registry) {
		$this->registry = $registry;
	}
	
	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}
	
	public function library($library) {
		$file = CORE_D . 'library/' . $library . '.php';
		
		if (file_exists($file)) {
			include_once($file);
		} else {
			trigger_error('Error: Could not load library ' . $library . '!');
			exit();					
		}
	}
	
	public function helper($helper) {
		$file = CORE_D . 'additional/' . $helper . '.php';
		if (file_exists($file)) {
			include_once($file);
		} else {
			trigger_error('Error: Could not load helper ' . $helper . '!');
			exit();					
		}
	}
		
	public function model($model) {
		$file = APPLICATION_D . 'model/' .ucfirst($model) . '.php';
		$class = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $model);
		
		if (file_exists($file)) {
			include_once($file);
			
			$this->registry->set('model_' . str_replace('/', '_', $model), new $class($this->registry));
		} else {
			trigger_error('Error: Could not load model ' . $model . '!');
			exit();					
		}
	}
	 
	public function database($driver, $hostname, $username, $password, $database, $prefix = NULL, $charset = 'UTF8') {
		$file  = CORE_D . 'database/' . $driver . '.php';
		$class = 'Database' . preg_replace('/[^a-zA-Z0-9]/', '', $driver);
		
		if (file_exists($file)) {
			include_once($file);
			
			$this->registry->set(str_replace('/', '_', $driver), new $class());
		} else {
			trigger_error('Error: Could not load database ' . $driver . '!');
			exit();				
		}
	}
	
	public function config($config) {
		$this->config->load($config);
	}
	
	public function language($language) {
		$file = APPLICATION_D.'language/'.($language).'.php';
		return include_once($file);
	}
} 
?>
