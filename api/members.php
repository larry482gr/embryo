<?php
	header("Content-type: application/json; charset=utf-8");

	require_once('../allConfig.php');
	require_once(_DOCUMENT_ROOT_ . CORE_D . 'library/db.php');
	$db = new DB(DB_DRIVER, DB_SERVER, DB_USER, DB_PASS, DB_EMBRYO);
	require_once(_DOCUMENT_ROOT_ . '/api/model/Member.php');
	
	$member = new Member($db);
	$action = $_POST['action'];
	$action = $action;
	
	// if($action == 'all') {
		$output = array('groups' => array(), 'members' => array());
		$groups = array();
		$groupIds = array();
		$members = array();
		
		$groups = $member->findAllGroups();
		
		foreach($groups as $group) {
			$groupIds[] = $group['id'];
			$group['label'] = html_entity_decode($group['label']);
			$output['groups'][] = $group;
		}
		
		$members = $member->findAllMembers($groupIds);
		
		foreach($members as $memb) {
			$memb['cv'] = html_entity_decode($memb['cv']);
			$output['members'][] = $memb;
		}
		
		echo json_encode($output);
	// }
?>