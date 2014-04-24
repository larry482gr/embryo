<?php 
	class ModelContact extends Model {
		public function getGroups($userID) {
			$userID = $this->db_w2sms->escape($userID);
			$query = "SELECT * FROM groups WHERE ClientID = '".$userID."' ORDER BY Description";
			$result = $this->db_w2sms->query($query);
			return $result->rows;
		}
		
		public function getGroupFieldsByUniqueId($fields, $id) {
			$query = "SELECT ".$fields." FROM groups WHERE UniqueID = ".$id;
			$result = $this->db_w2sms->query($query);
			return $result->row;
		}
		
		public function getGroupFieldsByUniqueIdArray($fields, $idsArray) {
			$query = "SELECT ".$fields." FROM groups WHERE UniqueID IN (".$idsArray.")";
			$result = $this->db_w2sms->query($query);
			return $result->rows;
		}
		
		public function getUndeletedGroups($userID) {
			$userID = $this->db_w2sms->escape($userID);
			$query = "SELECT * FROM groups WHERE ClientID = '".$userID."' AND isDeleted != 1 ORDER BY Description ASC";
			$result = $this->db_w2sms->query($query);
			return $result->rows;
		}
		
		public function totalMassHlrGroups($condition) {
			$query = "SELECT COUNT(*) AS total FROM hlrGroups " . $condition . " ORDER BY date_submitted DESC";
			$result = $this->db_masshlr->query($query);
			return $result->row;
		}
		
		public function getMassHlrGroups($condition, $offset, $rowsPerPage) {
			$offset = $this->db_masshlr->escape($offset);
			$rowsPerPage = $this->db_masshlr->escape($rowsPerPage);
			$query = "SELECT id, user_id, description, paused, completed, date_submitted FROM hlrGroups " . $condition . " ORDER BY date_submitted DESC LIMIT " . $offset . ", " . $rowsPerPage;
			$result = $this->db_masshlr->query($query);
			return $result->rows;
		}
		
		public function getUsersMassHlrGroups($userID) {
			$query = "SELECT id, description FROM hlrGroups WHERE user_id='".$userID."' AND deleted=0 AND completed=0 AND paused=1 ORDER BY description ASC";
			$result = $this->db_masshlr->query($query);
			return $result->rows;
		}
		
		public function getContactsGroupsFieldsByCondition($fields, $condition, $limit = "") {
			$query = "SELECT ".$fields." FROM contactsGroups WHERE ".$condition." ".$limit;
			$result = $this->db_w2sms->query($query);
			return $result;
		}
		
		public function getContactsAddressbookGroups($userID, $contactID) {
			$query = "SELECT isPredefine, isBlacklist, isUnknown FROM addressbook WHERE UniqueID = ".$contactID." AND ClientID = ".$userID;
			$result = $this->db_w2sms->query($query);
			return $result->row;
		}
		
		public function addContactGroup($groupID, $contactID, $userID) {
			$query = "INSERT INTO contactsGroups VALUES (".$groupID.", ".$contactID.", ".$userID.")";
			$this->db_w2sms->query($query);
			return $this->db_w2sms->countAffected();
		}
		
		public function countContactsGroupsByGroupID($group, $userID = '') {
			$query = "SELECT COUNT(GroupID) as total FROM contactsGroups WHERE GroupID = ".$group." ";
			if (!empty($userID))
				$query .= "AND ClientID = ".$userID;
				
			$result = $this->db_w2sms->query($query);
			return $result->row;
		}
		
		public function getSMSRecipients($group) {
			$query = "SELECT ab.Prefix, ab.MobileNo, UniqueID as id FROM addressbook as ab, contactsGroups as cg WHERE cg.GroupID = '".$group."' AND ab.isBlacklist != 1 AND cg.ContactID = ab.UniqueID ";
			$result = $this->db_w2sms->query($query);
			return $result->rows;
		}
		
		public function getPredefinedSMS($userID) {
			$query = "SELECT UniqueID as id, Prefix, MobileNo FROM addressbook WHERE ClientID = '".$userID."' AND isPredefine = '1' ORDER BY UniqueID ASC";
			$result = $this->db_w2sms->query($query);
			return $result;
		}
		
		public function getBlacklistContacts($userID) {
			$query = "SELECT COUNT(*) as total FROM addressbook WHERE isBlacklist = 1 AND ClientID = ".$userID;
			$result = $this->db_w2sms->query($query);
			return $result->row['total'];
		}
		
		public function getPredefineContacts($userID) {
			$query = "SELECT COUNT(*) as total FROM addressbook WHERE isPredefine = 1 AND ClientID = ".$userID;
			$result = $this->db_w2sms->query($query);
			return $result->row['total'];
		}
		
		public function getUnknownContacts($userID) {
			$query = "SELECT COUNT(*) as total FROM addressbook WHERE isUnknown = 1 AND ClientID = ".$userID;
			$result = $this->db_w2sms->query($query);
			return $result->row['total'];
		}
		
		public function getContactsTabContacts($contactGroups, $userID, $mobile_sql, $firstName_sql, $lastName_sql, $group_sql, $offset, $rowsPerPage, $csvRequested = false) {
			$query  = "SELECT *, ab.UniqueID as contactID FROM addressbook as ab ".$contactGroups;
			$query .= " WHERE ab.ClientID='".$userID."' ".$mobile_sql."  ".$firstName_sql."  ".$lastName_sql." ".$group_sql;
			
			if ($csvRequested)
				$query .= "GROUP BY ab.UniqueID ";
			
			$query .= "ORDER BY ab.UniqueID ASC ";
			
			if (!$csvRequested)
				$query .= "LIMIT ".$offset.", ".$rowsPerPage;
			
			$result = $this->db_w2sms->query($query);
			return $result;
		}
		
		public function getExtraFields($userID) {
			$query = "SELECT * FROM extraFields  WHERE ClientID = ".$userID;
			$result = $this->db_w2sms->query($query);
			return $result->rows;
		}
		
		public function getActiveExtraFields($userID) {
			$query = "SELECT * FROM extraFields  WHERE ClientID = '".$userID."' AND Enabled=1 ORDER BY FieldName ASC";
			$result = $this->db_w2sms->query($query);
			return $result;
		}
		
		public function getExtraFieldsByCondition($fields, $condition, $order = "") {
			$query = "SELECT ".$fields." FROM extraFields WHERE ".$condition." ".$order;
			$result = $this->db_w2sms->query($query);
			return $result;
		}
		
		public function addGroup($userID, $groupName) {
			$query = "INSERT INTO groups ( UniqueID, ClientID, Description ) VALUES ('',  '".$userID."', '".$groupName."') ";
			$this->db_w2sms->query($query);
			return $this->db_w2sms->getLastId();
		}
		
		public function editGroup($groupName, $groupID) {
			$query = "UPDATE groups SET Description = '".$groupName."' WHERE UniqueID = ".$groupID." LIMIT 1";
			$this->db_w2sms->query($query);
			return $this->db_w2sms->countAffected();
		}
		
		public function setDeletedGroup($groupID) {
			$query = 'UPDATE groups SET isDeleted = "1" WHERE UniqueID = '.$groupID.' LIMIT 1';
			$this->db_w2sms->query($query);
			return $this->db_w2sms->countAffected();
		}
		
		public function deleteContact($contactID, $userID) {
			$query = "DELETE FROM addressbook WHERE UniqueID = ".$contactID." AND ClientID = ".$userID." LIMIT 1";
			$this->db_w2sms->query($query);
			return $this->db_w2sms->countAffected();
		}
		
		public function deleteContactFromGroup ($contactID, $groupCondition = "") {
			$query = "DELETE FROM contactsGroups WHERE ContactID = ".$contactID." ".$groupCondition;
			$this->db_w2sms->query($query);
			return $this->db_w2sms->countAffected();
		}
		
		public function emptyGroup ($cliendID, $groupID) {
			$query = "DELETE FROM contactsGroups WHERE ClientID = ".$cliendID." AND GroupID = ".$groupID;
			$this->db_w2sms->query($query);
			return $this->db_w2sms->countAffected();
		}
		
		public function removeContactsFromDataExtraFields ($condition) {
			$query = "DELETE FROM dataExtraFields WHERE ContactID IN(".$condition.") ";
			$this->db_w2sms->query($query);
		}
		
		public function removeContactsFromAddressbook ($condition) {
			$query = "DELETE FROM addressbook WHERE UniqueID IN(".$condition.") ";
			$this->db_w2sms->query($query);
		}
		
		public function removeContactsFromContactsGroups ($condition, $userID, $groupID = "") {
			$query = "DELETE FROM contactsGroups WHERE ContactID IN(".$condition.") AND ClientID = ".$userID;
			$this->db_w2sms->query($query);
		}
		
		public function deleteContactFromDataExtra($contactID, $fieldIDCondition = "") {
			$query = "DELETE FROM dataExtraFields WHERE ContactID = ".$contactID." ".$fieldIDCondition;
			$this->db_w2sms->query($query);
		}
		
		public function getMyGroupsContacts($mobile, $prefix, $userID, $groupID) {
			$query = "SELECT * FROM addressbook as ab, contactsGroups as cg	WHERE ab.MobileNo=".$mobile." AND ab.Prefix=".$prefix." AND ab.ClientID=".$userID." AND ab.UniqueID = cg.ContactID AND cg.GroupID = ".$groupID;
			$result = $this->db_w2sms->query($query);
			return $result;
		}
		
		public function getMyContacts($mobile, $prefix, $userID) {
			$query = "SELECT * FROM addressbook	WHERE MobileNo=".$mobile." AND Prefix=".$prefix." AND ClientID=".$userID;
			$result = $this->db_w2sms->query($query);
			return $result;
		}
				
		public function addContact($userID, $firstName, $lastName, $mobile, $prefix, $insertNo) {
			$query = "INSERT INTO addressbook (UniqueID, ClientID, FirstName, LastName, MobileNo, Prefix, InsertNo) VALUES ('',  '".$userID."', '".$firstName."',  '".$lastName."', '".$mobile."', '".$prefix."', '".$insertNo."')";
			$this->db_w2sms->query($query);
			return $this->db_w2sms->getLastId();
		}
		
		public function setUnknownContact($contact_id, $clientCondition = "") {
			$query = "UPDATE addressbook SET isUnknown=1 WHERE UniqueID = ".$contact_id." ".$clientCondition;
			$this->db_w2sms->query($query);
		}
		
		public function setBlacklistedContact($contact_id, $clientCondition = "") {
			$query = "UPDATE addressbook SET isBlacklist=1 WHERE UniqueID = ".$contact_id." ".$clientCondition;
			$this->db_w2sms->query($query);
			return $this->db_w2sms->countAffected();
		}
		
		public function setPredefineContact($contact_id, $clientCondition = "") {
			$query = "UPDATE addressbook SET isPredefine=1 WHERE UniqueID = ".$contact_id." ".$clientCondition;
			$this->db_w2sms->query($query);
			return $this->db_w2sms->countAffected();
		}
		
		public function setContactDataExtraFields($fieldID, $contactID, $description) {
			$query = "INSERT INTO dataExtraFields (FieldID, ContactID, Description) VALUES ('".$fieldID."', '".$contactID."', '".$description."')";
			$this->db_w2sms->query($query);
		}
		
		public function getAddressBookContactID($mobile, $prefix, $userID) {
			$query = "SELECT UniqueID FROM addressbook WHERE MobileNo='".$mobile."' AND Prefix='".$prefix."' AND ClientID='".$userID."' ";
			$result = $this->db_w2sms->query($query);
			return $result->row['UniqueID'];
		}
		
		public function editAddressbookContact($fname, $lname, $prefix, $mobile, $contactID, $userID) {
			$query = "UPDATE addressbook SET FirstName='".$fname."',  LastName='".$lname."', Prefix=".$prefix.", MobileNo=".$mobile.", isBlacklist=0, isPredefine=0 WHERE UniqueID=".$contactID." AND ClientID=".$userID;
			$result = $this->db_w2sms->query($query);
		}
		
		public function editAddressbookContactFieldsByCondition($fields, $condition) {
			$query = "UPDATE addressbook SET ".$fields." WHERE ".$condition;
			$result = $this->db_w2sms->query($query);
		}
		
		public function editDataExtraDescription($description, $contactID, $fieldID) {
			$query = "UPDATE dataExtraFields SET Description='".$description."' WHERE ContactID = ".$contactID." AND FieldID = ".$fieldID;
			$result = $this->db_w2sms->query($query);
			return $this->db_w2sms->countAffected();
		}
		
		public function countImportedContacts($userID, $insertNo) {
			$query = "SELECT COUNT(UniqueID) as total FROM addressbook WHERE ClientID = ".$userID." AND InsertNo = ".$insertNo;
			$result = $this->db_w2sms->query($query);
			return $result->row;
		}
		
		//Mass HLR functions
		public function countMassHlrContacts($condition) {
			$query = "SELECT COUNT(*) AS total FROM hlrContacts WHERE ".$condition;
			$result = $this->db_masshlr->query($query);
			return $result->row;
		}
		
		public function removeHlrGroup($group_id) {
			$query = "UPDATE hlrGroups SET deleted=1 WHERE id='".$group_id."' LIMIT 1";
			$this->db_masshlr->query($query);
			return $this->db_masshlr->countAffected();
		}
		
		public function removeHlrContactsByCondition($condition) {
			$query = "DELETE FROM hlrContacts WHERE ".$condition;
			$this->db_masshlr->query($query);
			return $this->db_masshlr->countAffected();
		}
		
		public function playPauseGroup($group_id, $paused) {
			$query = "UPDATE hlrGroups SET paused=".$paused." WHERE id=".$group_id." LIMIT 1";
			$this->db_masshlr->query($query);
			return $this->db_masshlr->countAffected();
		}
		
		public function addNewGroup($userID, $groupName) {
			$query = "INSERT INTO hlrGroups (user_id, description, date_submitted) VALUES (".$userID.", '".$groupName."', NOW())";
			$this->db_masshlr->query($query);
			return $this->db_masshlr->getLastId();
		}
		
		public function getHlrContactFieldsByCondition($fields, $condition, $order = "", $limit = "") {
			if(is_array($condition))
				$condition = implode(" AND ", $condition);
			$query = "SELECT ".$fields." FROM hlrContacts WHERE ".$condition." ".$order." ".$limit;
			$result = $this->db_masshlr->query($query);
			return $result;
		}
		
		public function addContactToHlrGroup($userID, $group_id, $prefix, $mobile, $current_time) {
			$query = "INSERT INTO hlrContacts (user_id, group_id, prefix, number, insert_time) VALUES ('".$userID."', '".$group_id."', '".$prefix."', '".$mobile."', '".$current_time."')";
			$this->db_masshlr->query($query);
			return $this->db_masshlr->countAffected();
		}
		//Mass HLR functions
	}
?>