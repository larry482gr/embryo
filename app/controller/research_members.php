<?php
class ControllerResearchMembers extends Controller {
	public function index($args = false) {
		$this->data['membersLinks'] = $this->language->getLanguage('membersLinks');
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$lang_id = $this->language->getCurrentLanguageId();
		
		$this->load->model('member');
		
		$this->data['member_groups'] = $this->model_member->findAllGroups($lang_id);
		$groups = array();
		foreach($this->data['member_groups'] as $group) {
			$groups[] = $group['id'];
		}
		$this->data['members'] = $this->model_member->findAllMembers($groups);
		
		$this->document->addStyle('members');
		$this->document->addScript('members');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'members/index.tpl';
		$this->response->setOutput($this->render());
	}
}
?>