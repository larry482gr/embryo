<?php
	define('_HTTP_SERVER_', $_SERVER['SERVER_NAME']);
	define('_BASE_ROOT_', $_SERVER['HTTP_HOST']);
	define('_DOCUMENT_ROOT_', $_SERVER['DOCUMENT_ROOT']);
	
	define('CORE_D', '/core/');
	define('APPLICATION_D', 'app/');
	define('MODEL_D', 'app/model/');
	define('TEMPLATE_D', 'app/template/');
	define('FILES_D', 'files/');
	define('LANGUAGE_D', 'app/language/');
	define('DATABASE_D', 'core/database/');
	
	define('_CSS_DIR_', '/resources/css/');
	define('_JS_DIR_', '/resources/js/');
	define('_IMAGE_DIR_', '/resources/images/');
	define('CACHE_D', 'pool/cache/');
	define('LOGS_D', 'pool/log/');
	define('TEMP_D', 'pool/tmp/');
	
	define('DB_DRIVER','mysql');
	
	// DB Hosts
    define('DB_SERVER', "localhost");
	// define('DB_SERVER', "hosted4db.ccf.auth.gr");
	
	//database login name and pass
	// Development
	define('DB_USER', "l3mbrRY");
	define('DB_PASS', "laRry482grEmbry0");
	// Production
	// define('DB_USER', "larl3mbrRy");
	// define('DB_PASS', "p@ok@rA1926");
	
	define('DB_EMBRYO', "embryo-admin_db");
?>
