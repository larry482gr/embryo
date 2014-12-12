<?php
	header("Content-type: application/json; charset=utf-8");

	require_once('../allConfig.php');
	require_once(_DOCUMENT_ROOT_ . CORE_D . 'library/db.php');
	$db = new DB(DB_DRIVER, DB_SERVER, DB_USER, DB_PASS, DB_EMBRYO);
	require_once(_DOCUMENT_ROOT_ . '/api/model/Member.php');
	
	$member = new Member($db);
	$action = $_POST['action'];
	
	if($action == 'all') {
		$groupsLastId = $_POST['groups_last_id'];
		$membersLastId = $_POST['members_last_id'];
		
		$output = array('groups' => array(), 'members' => array());
		$groups = array();
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