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
		$last_id = $_POST['last_id'];
		$all_news = $news->findAll('ORDER BY published_at DESC', '', 'is_published = 1 AND id > '.$last_id);
		$proper_news = array();
		foreach($all_news as $new) {
			$new['long_desc'] = html_entity_decode($new['long_desc']);
			$proper_news[] = $new;
		}
		echo json_encode($proper_news);
	}
?>