<?php
	header("Content-type: application/json; charset=UTF-8");
	
	require_once('../allConfig.php');
	
	require_once(_DOCUMENT_ROOT_ . CORE_D . 'library/db.php');
	$db = new DB(DB_DRIVER, DB_SERVER, DB_USER, DB_PASS, DB_EMBRYO);
	
	require_once(_DOCUMENT_ROOT_ . '/api/model/Article.php');
	
	$news = new Article($db);
	
	$action = $_POST['action'];
	$action = urldecode($action);
	
	if($action == 'all') {
		$all_news = $news->findAll('ORDER BY published_at DESC');
		echo json_encode($all_news);
	}
?>