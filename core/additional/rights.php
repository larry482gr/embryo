<?php 
final class Right {
	private $usertype;
	
	public function __construct() {
		$this->usertype = $_SESSION['usertype'];
	}
	
	public function isAdmin() {
		return ($this->usertype == 9);
	}
	
	public function isAccountManager() {
		return ($this->usertype == 8 || $this->usertype == 18);
	}
	
	public function isPlatform() {
		return ($this->usertype == 5);
	}
	
	public function isWeb2smsUser() {
		return ($this->usertype == 6);
	}
	
	public function isSmppUser() {
		return ($this->usertype == 1 || $this->usertype == 2);
	}
	
	public function isApiUser() {
		return ($this->usertype == 20);
	}
	
	// Special Case Usertypes
	public function isRoutingAccount() {
		return ($this->usertype == 10);
	}
	
	public function isUsertype15() {
		return ($this->usertype == 15);
	}
	
	public function isUsertype16() {
		return ($this->usertype == 16);
	}
	// Special Case Usertypes
	
	public function hasWeb2SmsRights() {
		$web2smsUsers = array('9', '8', '18', '7', '6'); 	// Possibly '4','26' ??? --> Additional note: usertype 26 does not exist anymore.
		return (in_array($this->usertype, $web2smsUsers));
	}
	
	public function hasWeb2SmsCampaignsCategoryRights() {
		$campaignsUsers = array('9', '8', '18', '7'); 	// Possibly '4' ???
		return (in_array($this->usertype, $campaignsUsers));
	}
	
	public function hasAdministrationRights() {
		$administrationUsers = array('9', '3');
		return (in_array($this->usertype, $administrationUsers));
	}
	
	public function hasRoutingAdministrationRights() {
		$routingAdministrationUsers = array('9', '3', '10');
		return (in_array($this->usertype, $routingAdministrationUsers));
	}
	
	public function hasMyClientsRights() {
		$myClientsUsers = array('9', '8', '18', '7', '5');	// mass_hlr --> Possibly '4' ???
		return (in_array($this->usertype, $myClientsUsers));
	}
	
	public function hasClientInfoRights() {
		$clientInfoUsers = array('9', '8', '18');
		return (in_array($this->usertype, $clientInfoUsers));
	}
	
	public function hasPricingRights() {
		$pricingUsers = array('9', '8', '18', '5', '10'); // coverage/pricing_administration --> '9','8','18','5','10' ..... Is usertype No. 10 still in use??? I suppose not because... I 'll explain if you ask me (lazaros)!
		return (in_array($this->usertype, $pricingUsers));
	}
	
	public function hasSmppFaqRights() {
		$smppFaqUsers = array('9', '8', '18', '7', '5', '1');
		return (in_array($this->usertype, $smppFaqUsers));
	}
	
	public function hasWeb2smsFaqRights() {
		$web2smsFaqUsers = array('9', '8', '18', '7', '6', '5');  // hlr_tracking --> also '4' ???
		return (in_array($this->usertype, $web2smsFaqUsers));
	}
	
	public function possiblyOldUsertypeUser() {
		$rejectAntispamUsers = array('3', '10');
		return (in_array($this->usertype, $rejectAntispamUsers));
	}
	
	public function hasTrackingUserOptionRights() {
		$trackingUserOptionUsers = array('5', '7', '8', '18'); // also '4' ???
		return (in_array($this->usertype, $trackingUserOptionUsers));
	}
	
	public function hasCampaignsUserOptionRights () {
		$campaignsUserOptionUsers = array('4', '7', '8', '18');
		return (in_array($this->usertype, $campaignsUserOptionUsers));
	}
	
	public function hasStatisticsRights() {
		$statisticsByNumbersUsers = array('3', '4', '6', '10', '15');
		return (in_array($this->usertype, $statisticsByNumbersUsers));
	}
}
?>