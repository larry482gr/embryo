<?php
	error_reporting(E_ALL);
	ini_set('display_errors', 1);

	require_once('allConfig.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'loadEngine.php');
		
	$registry = new Registry();

	$loader = new Loader($registry);
	$registry->set('load', $loader);
	
	$registry->set('document', new Document());

	// Initialize DB connection registries
	$db = new DB(DB_DRIVER, DB_SERVER, DB_USER, DB_PASS, DB_EMBRYO);
	$registry->set('db', $db);
	
	$url = new Url('/');
	$registry->set('url', $url);
	
	$request = new Request();
	$registry->set('request', $request);

	$response = new Response();
	$response->addHeader('Content-Type: text/html; charset=utf-8');
	$registry->set('response', $response); 

	// Session
	$session = new Session();
	$registry->set('session', $session);
			
	$controller = new Front($registry);
	
	// Language	
	// TO BE Implemented --> How to take language parameter dynamically (by cookie). 
	// if (isset($request->request['lang']))
	// 	$lang = $request->request['lang'];
	// This will be commented-out when full language support will be implemented.
	// else if (isset($session->data['usersLanguage']))
	//	$lang = $session->data['usersLanguage'];
	// else
	//	$lang = 'eng';
	
	// $language = new Language($lang);
	// $language->load($lang);
	// $registry->set('language', $language);
	
	// Router
	// TO BE Modified or added as PreAction	
	// TO Implement permissions set an array variable $permissions and appropriately add them from the DB
	// Permissions are currently (development phase) defined in core/additional/rights.php
	/*if (!isset($session->data['userID'])) {
		if (isset($request->request['route']) &&
				 ($request->request['route'] == 'user/pass_recover_form' ||
				  $request->request['route'] == 'user/register_form' ||
				  $request->request['route'] == 'user/activate'))
			 $action = new Action($request->request['route']);
		else
			$action = new Action('user/');
	}
	else {
		$action = isset($request->request['route']) ? new Action($request->request['route']) : new Action('dashboard');
		// Initiate Right class to define user 's permissions
		$rights = new Right();
		$registry->set('rights', $rights);
	}
	*/
	$action = isset($request->request['route']) ? new Action($request->request['route']) : new Action('initial/');
	
	$controller->dispatch($action, new Action('error/not_found'));
	
	$response->output();
?>
