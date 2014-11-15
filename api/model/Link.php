<?php 
	class ModelLink extends Model {
		public function findAllLinkCategories($lang_id, $order = '', $limit = '') {
			$query = "SELECT * FROM link_categories WHERE lang_id = ".$lang_id." ".$order." ".$limit;
			$result = $this->db->query($query);
			return $result->rows;
		}
		
		public function findCategory($id, $order = '', $limit = '') {
			$query = "SELECT label FROM link_categories WHERE id = ".$id." ".$order." ".$limit;
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function findLinks($cat_id, $order = '', $limit = '') {
			$query = "SELECT * FROM links WHERE cat_id = ".$cat_id." ".$order." ".$limit;
			$result = $this->db->query($query);
			return $result->rows;
		}
				
		public function createLinkCategory($link_cat) {
			$link_cat_position = $this->getMaxTabPosition($link_cat['lang_id']);
			if(empty($link_cat['position']))
				$link_cat['position'] = $link_cat_position['max_link_cat'] + 1;
			$query = "INSERT INTO link_categories (label, lang_id, position, is_active)
					  VALUES ('".$link_cat['label']."', ".$link_cat['lang_id'].",
					  		   ".$link_cat['position'].", ".$link_cat['is_active'].")";
			$result = $this->db->query($query);
			return $this->db->getLastId();
		}
		
		public function createLink($link) {
			$query = "INSERT INTO links (cat_id, header, prepend_text, link_url, link_label, append_text, is_group)
					  VALUES ('".$link['cat_id']."', '".$link['header']."',
					  		   '".$link['prepend_text']."', '".$link['link_url']."',
					  		   '".$link['link_label']."', '".$link['append_text']."',
					  		   ".$link['is_group'].")";
			$result = $this->db->query($query);
			return $this->db->getLastId();
		}
		
		public function getMaxTabPosition($lang_id) {
			$query = "SELECT MAX(position) AS max_link_cat FROM link_categories WHERE lang_id = ".$lang_id;
			$result = $this->db->query($query);
			return $result->row;
		}
		
		public function searchLinks($lang_id, $search_text) {
			$query = "SELECT category.position, category.label AS link_cat, link.link_label AS link_label, link.link_url AS link_url
					  FROM links AS link, link_categories AS category
					  WHERE category.lang_id = ".$lang_id." AND category.is_active = 1 AND category.id = link.cat_id 
					  AND link.link_label LIKE '%".$search_text."%' 
					  ORDER BY category.position";
			$result = $this->db->query($query);
			return isset($result->rows) ? $result->rows : false;
		}
	}
?>