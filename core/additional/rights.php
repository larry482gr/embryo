<?php 
final class Right {
	private $profile;
	
	public function __construct() {
		$this->profile = isset($this->session->data['userProfile']) ? $this->session->data['userProfile'] : 3;
	}
	
	
	public function isAdministrator() {
		return ($this->profile == 1);
	}
	
	public function isModerator() {
		return ($this->profile == 2);
	}
	
	public function isUser() {
		return ($this->profile == 3);
	}
	
	// Special Case Usertypes
	
	public function canViewAdminPanel() {
		$adminPanelUsers = array('1', '2');
		return (in_array($this->profile, $adminPanelUsers));
	}
	
	public function hasWeb2SmsRights() {
		$web2smsUsers = array('9', '8', '18', '7', '6'); 	// Possibly '4','26' ??? --> Additional note: usertype 26 does not exist anymore.
		return (in_array($this->usertype, $web2smsUsers));
	}
}
?>