<?php
class ControllerAdminMembers extends Controller {
	public function index($args = false) {
		$this->data['form'] = $this->language->getLanguage('form');
		$this->data['membersLinks'] = $this->language->getLanguage('membersLinks');
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang_id'] = $lang_id;
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['languages'] = $this->language->getAvailableLanguages();
		
		$this->load->model('member');
		$this->data['member_groups'] = $this->model_member->findAllGroups($lang_id);
		$groups = array();
		foreach($this->data['member_groups'] as $group) {
			$groups[] = $group['id'];
		}
		if(!empty($groups))
			$this->data['members'] = $this->model_member->findAllMembers($groups);
		
		$this->document->addStyle('admin/members');
		$this->document->addScript('admin/members');
		
		// Assign header/footer to children object
		$this->children = array('admin/dashboard', 'admin/footer');
		
		// Assign at template object the tpl
		$this->template = 'admin/members.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function createGroup() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$group = array('label' => '', 'lang_id' => 2);
		$group['label'] = $this->db->escape($this->request->post['group']['label']);
		$group['lang_id'] = $this->db->escape($this->request->post['group']['lang_id']);
		
		$this->load->model('member');
		$lastId = $this->model_member->createGroup($group);
		
		if(is_numeric($lastId))
			return $this->response->redirect('/admin/members');
	}
	
	public function createMember() {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$member = array('group_id' => '', 'name' => '', 'email' => '', 'picture' => '', 'cv' => '', 'pubs' => '');
		$member['group_id'] = $this->db->escape($this->request->post['member']['group_id']);
		$member['name'] = $this->db->escape($this->request->post['member']['name']);
		$member['email'] = $this->db->escape($this->request->post['member']['email']);
		$member['cv'] = $this->db->escape($this->request->post['member']['cv']);
		$member['pubs'] = $this->db->escape($this->request->post['member']['pubs']);
		$edit = $this->db->escape($this->request->post['edit']) == 0 ? false : true;
		
		if(empty($this->request->files["member_picture"]["name"]) && empty($this->request->files["member_picture"]["type"])) {
			$member['picture'] = null;
		}
		else {
			$allowedExts = array("png", "jpeg", "jpg");
			$extension = end(explode(".", $this->request->files["member_picture"]["name"]));
			
			$path = _DOCUMENT_ROOT_."/resources/images/members";
			$filepath = $path."/".$this->request->files["member_picture"]["name"];
			
			if ((($this->request->files["member_picture"]["type"] == "image/jpeg")
				|| ($this->request->files["member_picture"]["type"] == "image/jpg")
				|| ($this->request->files["member_picture"]["type"] == "image/png"))
				&& ($this->request->files["member_picture"]["size"] < 2000000)
				&& in_array($extension, $allowedExts)) {
				   
				if ($this->request->files["member_picture"]["error"] > 0) {
					var_dump($this->request->files["member_picture"]["error"]);
					exit();
				}
				else {
					if (!file_exists($path."/")) {
				        mkdir($path);
				        chmod($path, 0757);  // octal; correct value of mode
				    }
				    else {
				    	@move_uploaded_file($this->request->files["member_picture"]["tmp_name"], $filepath);
				    	$member['picture'] = $this->request->files["member_picture"]["name"];
				    }
				}
			}
			else {
				// Refactor it to send a message to the user.
				var_dump("Wrong file type");
				exit();
			}
		}
		
		$this->load->model('member');
		
		if(!$edit) {
			$lastId = $this->model_member->createMember($member);
			if(is_numeric($lastId))
				return $this->response->redirect('/admin/members');
		}
		else {
			$member['id'] = $this->db->escape($this->request->post['member_id']);
			$affectedRows = $this->model_member->editMember($member);
			if($affectedRows > 0) {
				// echo a message.
			}
			else {
				// echo a message to notify that no change has been made.
			}
				
			return $this->response->redirect('/admin/members');
		}
		
	}
	
	public function show($id) {
		if(!$this->right->canViewAdminPanel()) {
			$this->session->data['permissionDenied'] = $this->language->getPermissionDeniedMessage('adminPanelDenied');
			return $this->response->redirect('/admin');
		}
		
		$this->load->model('member');
		$member		= $this->model_member->findMember($id);
		$memberInfo	= $this->model_member->findMemberInfo($id);
		
		$memberInfo['cv'] = html_entity_decode($memberInfo['cv']);
		$memberInfo['pubs'] = html_entity_decode($memberInfo['pubs']);
		
		echo json_encode(array("member" => $member, "memberInfo" => $memberInfo));
	}
}
?>