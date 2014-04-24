<?php 
	// Register Globals
	if (ini_get('register_globals')) {
		ini_set('session.use_cookies', 'On');
		ini_set('session.use_trans_sid', 'Off');
			
		session_set_cookie_params(0, '/');
		session_start();
		
		$globals = array($_REQUEST, $_SESSION, $_SERVER, $_FILES);

		foreach ($globals as $global) {
			foreach(array_keys($global) as $key) {
				unset(${$key}); 
			}
		}
	}

	// Magic Quotes Fix
	if (ini_get('magic_quotes_gpc')) {
		function clean($data) {
			if (is_array($data)) {
				foreach ($data as $key => $value) {
					$data[clean($key)] = clean($value);
				}
			} else {
				$data = stripslashes($data);
			}
		
			return $data;
		}			
		
		$_GET = clean($_GET);
		$_POST = clean($_POST);
		$_REQUEST = clean($_REQUEST);
		$_COOKIE = clean($_COOKIE);
	}

	if (!ini_get('date.timezone')) {
		date_default_timezone_set('UTC');
	}

	// Windows IIS Compatibility  
	if (!isset($_SERVER['DOCUMENT_ROOT'])) { 
		if (isset($_SERVER['SCRIPT_FILENAME'])) {
			$_SERVER['DOCUMENT_ROOT'] = str_replace('\\', '/', substr($_SERVER['SCRIPT_FILENAME'], 0, 0 - strlen($_SERVER['PHP_SELF'])));
		}
	}

	if (!isset($_SERVER['DOCUMENT_ROOT'])) {
		if (isset($_SERVER['PATH_TRANSLATED'])) {
			$_SERVER['DOCUMENT_ROOT'] = str_replace('\\', '/', substr(str_replace('\\\\', '\\', $_SERVER['PATH_TRANSLATED']), 0, 0 - strlen($_SERVER['PHP_SELF'])));
		}
	}

	if (!isset($_SERVER['REQUEST_URI'])) { 
		$_SERVER['REQUEST_URI'] = substr($_SERVER['PHP_SELF'], 1); 
		
		if (isset($_SERVER['QUERY_STRING'])) { 
			$_SERVER['REQUEST_URI'] .= '?' . $_SERVER['QUERY_STRING']; 
		}
	}
	
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'machine/action.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'machine/controller.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'machine/front.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'machine/loader.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'machine/model.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'machine/registry.php');
	
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'library/request.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'library/response.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'library/db.php');
	
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'library/document.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'library/language.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'library/url.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'library/mail.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'library/session.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'library/cookies.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'library/cookies.php');
	require_once($_SERVER['DOCUMENT_ROOT'] . CORE_D . 'additional/rights.php');
?>
