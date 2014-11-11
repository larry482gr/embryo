<?php
	require_once('../allConfig.php');
	
	require_once(_DOCUMENT_ROOT_ . CORE_D . 'library/db.php');
	$db = new DB(DB_DRIVER, DB_SERVER, DB_USER, DB_PASS, DB_EMBRYO);
	
	require_once(_DOCUMENT_ROOT_ . '/api/model/Article.php');
	
	$news = new Article($db);
	
	$action = $_POST['action'];
	
	if($action == 'all') {
		$all_news = $news->findAll();
		echo json_encode($all_news);
	}
?>