<?php 
	class ModelApplication extends Model {
		public function createApplication($appl) {
			$query	= "INSERT INTO conf_appl (title, fname, lname, faculty, country, city, pocode, address, mcc, mnc, tel, fax, email, material) ";
			$query .= "VALUES ('".$appl['title']."', '".$appl['fname']."', '".$appl['lname']."', '".$appl['faculty']."', '".$appl['country']."', ";
			$query .= "'".$appl['city']."', '".$appl['pocode']."', '".$appl['address']."', ".$appl['mcc'].", ".$appl['mnc'].", ".$appl['tel'].", ";
			$query .= $appl['fax'].", ".$appl['email'].", ".$appl['material'].")";
			$this->db->query($query);
			return $this->db->getLastId();
		}
		
		public function updateEmailFail($id) {
			$query = "UPDATE conf_appl SET email_sent = 0 WHERE id = ".$id;
			$this->db->query($query);
			return $this->db->countAffected();
		}
	}
?>