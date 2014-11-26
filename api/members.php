<?php
	header("Content-type: application/json; charset=UTF-8");

	require_once('../allConfig.php');
	require_once(_DOCUMENT_ROOT_ . CORE_D . 'library/db.php');
	require_once(_DOCUMENT_ROOT_ . '/api/model/Member.php');
	
	$db = new DB(DB_DRIVER, DB_SERVER, DB_USER, DB_PASS, DB_EMBRYO);
	$member = new Member($db);
	
	$members = array('groups' => array(), 'members' => array());
	$groups = array();
	
	$members['groups'] = $member->findAllGroups();
	
	foreach($members['groups'] as $group) {
		$groups[] = $group['id'];
	}
	
	$members['members'] = $member->findAllMembers($groups);
	
	echo json_encode($members);
?>