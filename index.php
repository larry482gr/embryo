<?php
	// error_reporting(E_ALL);
	// ini_set('display_errors', 1);

	require_once('allConfig.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'loadEngine.php');
		
	$registry = new Registry();

	$loader = new Loader($registry);
	$registry->set('load', $loader);
	
	$document = new Document();
	$registry->set('document', $document);
	$document->setTitle('Embryo');
	

	// Initialize DB connection registries
	$db = new DB(DB_DRIVER, DB_SERVER, DB_USER, DB_PASS, DB_EMBRYO);
	$registry->set('db', $db);
	
	$url = new Url('/');
	$registry->set('url', $url);
	
	// Initialize Mail class
	$mail = new Mail();
	$registry->set('mail', $mail);
	
	$request = new Request();
	$registry->set('request', $request);

	$response = new Response();
	$response->addHeader('Content-Type: text/html; charset=utf-8');
	$registry->set('response', $response); 

	// Session
	$session = new Session();
	$registry->set('session', $session);
			
	$controller = new Front($registry);
	
	$args = array();
	$remove_pieces = array();
	$route_pieces = explode("/", @$request->request['route']);
	for($i = 0; $i < sizeof($route_pieces); $i++) {
		if(is_numeric($route_pieces[$i])) {
			$args[] = $route_pieces[$i];
			$remove_pieces[] = $i;
		}
	}
	foreach($remove_pieces as $remove) {
		unset($route_pieces[$remove]);
	}
	@$request->request['route'] = implode('/', $route_pieces);
	
	// Language	
	$locale = strtolower(@substr($request->request['route'], 0, 2));
	if($locale == 'en' || $locale == 'gr') {
		$lang = $locale;
		$request->request['route'] = substr($request->request['route'], 3);
	}
	else
		$lang = 'gr';
	
	$language = new Language($lang);
	$language->load($lang);
	$registry->set('language', $language);
	
	$profile = isset($session->data['user']['id']) ? $session->data['user']['profile'] : 4;
	$right = new Right($profile);
	$registry->set('right', $right);
	
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
	// if(isset($request->request['route']) && strstr(@$request->request['route'], 'admin')) {
	if(isset($request->request['route']) && @$request->request['route'] == 'admin' || @$request->request['route'] == 'admin/') {
		// Development
		$action = new Action('admin/home', $args);
		// Production
		// $action = new Action('error/not_found');
	}
	else if(isset($request->request['route']) && @$request->request['route'] == 'admin/logout')
		$action = new Action('admin/home/logout', $args);
	else
		$action = isset($request->request['route']) && $request->request['route'] ? new Action($request->request['route'], $args) : new Action('home/', $args);
	
	$controller->dispatch($action, new Action('error/not_found', $args));
	
	$response->output();
?>
