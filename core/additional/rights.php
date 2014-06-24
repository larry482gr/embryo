<?php 
final class Right {
	private $profile;
	private $profiles = array('admin' => 'Administrator', 'contr' => 'Contributor', 'moder' => 'Moderator', 'user' => 'User');
	private $memberEmails = array('eftihia@law.auth.gr', 'kastan@law.auth.gr', 'tarlatzis@gmail.com', 'erethemn@law.uoa.gr', 'nikos_koumoutzis@hotmail.com', 'konstantinoscha@law.auth.gr', 'kalliopi.kipouridou@gmail.com', 'mimmaki@gmail.com', 'roxannefragou@hotmail.com', 'marva84@gmail.com', 'sachinidouchristina@hotmail.com');
	
	public function __construct($profile) {
		$this->profile = $profile;
	}
	
	public function getProfiles() {
		return $this->profiles;
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
	
	public function isMember($email) {
		return (in_array($email, $this->memberEmails));
	}
	
	public function canViewAdminPanel() {
		$adminPanelUsers = array('1');
		return (in_array($this->profile, $adminPanelUsers));
	}
	
	public function canViewMembersArea() {
		$membersAreaUsers = array('1', '2');
		return (in_array($this->profile, $membersAreaUsers));
	}
}
?>