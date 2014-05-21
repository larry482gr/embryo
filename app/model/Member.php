<?php 
	class ModelMember extends Model {
		public function findAllGroups($lang_id, $order = '', $limit = '') {
			$query = "SELECT * FROM research_groups WHERE lang_id = ".$lang_id." ".$order." ".$limit;
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
	}
?>