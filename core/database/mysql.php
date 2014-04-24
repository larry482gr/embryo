<?php
class MySQL {
	private $link;
	
	// Opens a connection to the DB.
	// Arguments: DB connection credentials (4 strings)
	public function __construct($hostname, $username, $password, $database) {
		if (!$this->link = mysql_connect($hostname, $username, $password, true)) {
      		trigger_error('Error: Could not make a database link using ' . $username . '@' . $hostname);
    	}

    	if (!mysql_select_db($database, $this->link)) {
      		trigger_error('Error: Could not connect to database ' . $database);
    	}
		
		mysql_query("SET NAMES 'utf8'", $this->link);
		mysql_query("SET CHARACTER SET utf8", $this->link);
		mysql_query("SET CHARACTER_SET_CONNECTION=utf8", $this->link);
		mysql_query("SET SQL_MODE = ''", $this->link);
  	}
		
	// Executes an SQL query. Receives an SLQ Query (string)
	// and returns an array of results OR error if no result is found.
  	public function query($sql) {
		$resource = mysql_query($sql, $this->link);
		
		if ($resource) {
			if (is_resource($resource)) {
				$i = 0;
    	
				$data = array();
		
				while ($result = mysql_fetch_assoc($resource)) {
					$data[$i] = $result;
    	
					$i++;
				}
				
				mysql_free_result($resource);
				
				$query = new stdClass();
				$query->row = isset($data[0]) ? $data[0] : array();
				$query->rows = $data;
				$query->num_rows = $i;
				
				unset($data);
				
				return $query;
    		} else {
				return true;
			}
		} else {
			// do not exit the script. Instead send the error to controller and show appropriate message!
			trigger_error('Error: ' . mysql_error($this->link) . '<br />Error No: ' . mysql_errno($this->link) . '<br />' . $sql);
			exit();
			// return mysql_errno($this->link);
    	}
  	}
	
	// Self-explanatory
	public function escape($value) {
		return mysql_real_escape_string($value, $this->link);
	}
	
	// Self-explanatory
  	public function countAffected() {
    	return mysql_affected_rows($this->link);
  	}

	// Self-explanatory
  	public function getLastId() {
    	return mysql_insert_id($this->link);
  	}
	
	// Self-explanatory
	public function __destruct() {
		mysql_close($this->link);
	}
}
?>
