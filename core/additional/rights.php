<?php 
final class Right {
	private $profile;
	
	public function __construct($profile) {
		$this->profile = $profile;
	}
	
	public function isAdministrator() {
		return ($this->profile == 1);
	}
	
	public function isContributor() {
		return ($this->profile == 2);
	}
	
	public function isModerator() {
		return ($this->profile == 3);
	}
	
	public function isUser() {
		return ($this->profile == 4);
	}
	
	// Special Case Usertypes
	
	public function canViewAdminPanel() {
		$adminPanelUsers = array('1', '2');
		return (in_array($this->profile, $adminPanelUsers));
	}
	
	public function canViewMembersArea() {
		$membersAreaUsers = array('1', '2');
		return (in_array($this->profile, $membersAreaUsers));
	}
}
?>