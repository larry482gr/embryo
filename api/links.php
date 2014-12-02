<?php
	header("Content-type: application/json; charset=utf-8");

	require_once('../allConfig.php');
	require_once(_DOCUMENT_ROOT_ . CORE_D . 'library/db.php');
	$db = new DB(DB_DRIVER, DB_SERVER, DB_USER, DB_PASS, DB_EMBRYO);
	require_once(_DOCUMENT_ROOT_ . '/api/model/Link.php');
	
	$link = new Link($db);
	$action = $_POST['action'];
	$action = $action;
	
	if($action == 'all') {
		$categoriesLastId = $_POST['categories_last_id'];
		$linksLastId = $_POST['links_last_id'];
		
		$output = array('categories' => array(), 'links' => array());
		$categories = array();
		$groupIds = array();
		$members = array();
		
		$groups = $member->findAllGroups($groupsLastId);
		
		if($groups) {
			foreach($groups as $group) {
				$groupIds[] = $group['id'];
				$group['label'] = html_entity_decode($group['label']);
				$output['groups'][] = $group;
			}
			
			$members = $member->findAllMembers($groupIds, $membersLastId);
			
			foreach($members as $memb) {
				$memb['cv'] = html_entity_decode($memb['cv']);
				$output['members'][] = $memb;
			}
		}
		
		echo json_encode($output);
	}
?>