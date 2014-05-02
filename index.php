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
	$locale = strtolower(@substr($request->request['route'], 0, 2));
	if($locale == 'en' || $locale == 'gr') {
		$lang = $locale;
		$request->request['route'] = substr($request->request['route'], 3);
	}
	else
		$lang = 'en';
	
	$language = new Language($lang);
	$language->load($lang);
	$registry->set('language', $language);
	
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
	if(isset($request->request['route']) && $request->request['route'] == 'admin' || $request->request['route'] == 'admin/')
		$action = new Action('admin/home');
	else
		$action = isset($request->request['route']) && $request->request['route'] ? new Action($request->request['route']) : new Action('home/');
	
	$controller->dispatch($action, new Action('error/not_found'));
	
	$response->output();
?>
