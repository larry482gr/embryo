<?php 
	class Member {
		private $db;
		
		public function __construct($db) {
			$this->db = $db;
			$this->db->query("SET NAMES utf8");
		}
		
		public function findAllGroups() {
			$query = "SELECT * FROM research_groups ORDER BY id ASC";
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findAllMembers($groups, $order = '', $limit = '') {
			$groups_clause = "(".implode(',', $groups).")";
			$where_clause  = "rm.group_id IN ".$groups_clause;
			$where_clause .= " AND rmi.member_id = rm.id";
			$query = "SELECT rm.*, rmi.* FROM research_members as rm, research_member_info as rmi WHERE ".$where_clause." ".$order." ".$limit;
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function createGroup($group) {
			$query = "INSERT INTO research_groups (label, lang_id)
					  VALUES ('".$group['label']."', ".$group['lang_id'].")";
			$result = $this->db->query($query);
			return $this->db->getLastId();
		}
		
		public function createMember($member) {
			$query1 =  "INSERT INTO research_members (group_id, name, email, picture)
						VALUES (".$member['group_id'].", '".$member['name']."',
					  		   '".$member['email']."', '".$member['picture']."')";
			$result1 = $this->db->query($query1);
			$member_id = $this->db->getLastId();
			
			$query2 =  "INSERT INTO research_member_info (member_id, cv, pubs)
						VALUES (".$member_id.", '".nl2br($member['cv'])."', '".nl2br($member['pubs'])."')";
			$result2 = $this->db->query($query2);
			$member_info_id = $this->db->getLastId();
			
			return $member_info_id;
		}
		
		public function editMember($member) {
			$updatePicture = $member['picture'] != null ? ", picture = '".$member['picture']."'" : "";
			$affectedRows = 0;
			
			$query1 =  "UPDATE research_members SET 
						group_id = ".$member['group_id'].", 
						name = '".$member['name']."', 
						email = '".$member['email']."' 
						".$updatePicture." 
						WHERE id = ".$member['id'];
			
			$this->db->query($query1);
			$affectedRows += $this->db->countAffected();
			
			$query2 =  "UPDATE research_member_info SET 
						cv = '".nl2br($member['cv'])."', 
						pubs = '".$member['pubs']."' 
						WHERE member_id = ".$member['id'];
						
			$this->db->query($query2);
			$affectedRows += $this->db->countAffected();
			
			return $affectedRows;
		}
		
		public function findMember($id) {
			$query = "SELECT * FROM research_members WHERE id = ".$id;
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function findMemberInfo($id) {
			$query = "SELECT * FROM research_member_info WHERE member_id = ".$id;
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function searchMembers($lang_id, $search_text) {
			$query = "SELECT member.id, member.name, member.email
					  FROM research_groups AS member_group, research_members AS member, research_member_info AS member_info
					  WHERE member_group.lang_id = ".$lang_id." AND member.group_id = member_group.id AND member_info.member_id = member.id 
					  AND (member.name LIKE '%".$search_text."%' OR member_info.cv LIKE '%".$search_text."%' OR member_info.pubs LIKE '%".$search_text."%')
					  ORDER BY member.id";
			$result = $this->db->query($query);
			return isset($result->rows) ? $result->rows : false ;
		}
	}
?>