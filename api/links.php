<?php
	header("Content-type: application/json; charset=utf-8");

	require_once('../allConfig.php');
	require_once(_DOCUMENT_ROOT_ . CORE_D . 'library/db.php');
	$db = new DB(DB_DRIVER, DB_SERVER, DB_USER, DB_PASS, DB_EMBRYO);
	require_once(_DOCUMENT_ROOT_ . '/api/model/Link.php');
	
	$link = new Link($db);
	$action = $_POST['action'];
	
	if($action == 'all') {
		$categoriesLastId = $_POST['categories_last_id'];
		$linksLastId = $_POST['links_last_id'];
		
		$output = array('categories' => array(), 'links' => array());
		$categories = array();
		$categoryIds = array();
		$links = array();
		
		$categories = $link->findAllLinkCategories($categoriesLastId);
		
		if($categories) {
			foreach($categories as $category) {
				$categoryIds[] = $category['id'];
				$output['categories'][] = $category;
			}
			
			$links = $link->findAllLinks($categoryIds, $linksLastId);
			
			foreach($links as $li) {
				$li['header'] = !empty($li['header']) ? html_entity_decode($li['header']) : '';
				$li['label'] = !empty($li['label']) ? html_entity_decode($li['label']) : '';
				$li['prepend_text'] = !empty($li['prepend_text']) ? html_entity_decode($li['prepend_text']) : '';
				$li['append_text'] = !empty($li['append_text']) ? html_entity_decode($li['append_text']) : '';
				$output['links'][] = $li;
			}
		}
		
		echo json_encode($output);
	}
?>