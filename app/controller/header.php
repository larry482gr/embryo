<?php
class ControllerHeader extends Controller {
	protected function index() {
		// $userID = $this->session->data['userID'];
		// $username = $this->session->data['name'];
		// $usertype = $this->session->data['usertype'];

		// $language = $this->language->getLanguage();
				
		// $this->load->model('user');
		
		// $this->data["username"] = $username;
		
		$this->document->addStyle("libraries/bootstrap.min");
		$this->document->addStyle("header");
		$this->document->addScript("header");
		
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['description'] = $this->document->getDescription();
		$this->data['title'] = $this->document->getTitle();
		$this->data['styles'] = $this->document->getStyles();
		
		/*
		$this->data['menu'] = array();
		// Homepage
		$this->data['menu']['homepage']['headTab'] = array('link' => $this->url->link('#dashboard'), 'text' => $language['Menu']['Homepage']);
		
		// Statistics
		$this->data['menu']['statistics'] = array();
		$this->data['menu']['statistics']['headTab'] = array('link' => $this->url->link('#statistics'), 'text' => $language['Menu']['Statistics']['headTab']);
		$this->data['menu']['statistics']['worldMap'] = array('link' => $this->url->link('statistics/world_map'), 'text' => $language['Menu']['Statistics']['worldMap']);
		$this->data['menu']['statistics']['byNumbers'] = array('link' => $this->url->link('statistics/by_numbers'), 'text' => $language['Menu']['Statistics']['byNumbers']);
		if ($this->rights->isAdmin())
			$this->data['menu']['statistics']['bySmsc'] = array('link' => $this->url->link('statistics/by_smsc'), 'text' => $language['Menu']['Statistics']['bySmsc']);
		
		// Tracking
		$this->data['menu']['tracking'] = array();
		$this->data['menu']['tracking']['headTab'] = array('link' => $this->url->link('#tracking'), 'text' => $language['Menu']['Tracking']['headTab']);
		$this->data['menu']['tracking']['smsTracking'] = array('link' => $this->url->link('tracking/sms_tracking'), 'text' => $language['Menu']['Tracking']['smsTracking']);
		$this->data['menu']['tracking']['hlrTracking'] = array('link' => $this->url->link('tracking/hlr_tracking'), 'text' => $language['Menu']['Tracking']['hlrTracking']);
		
		// Web 2 Sms
		if ($this->rights->hasWeb2SmsRights()) {
			$this->data['menu']['web2sms'] = array();
			$this->data['menu']['web2sms']['headTab'] = array('link' => $this->url->link('#web2sms'), 'text' => $language['Menu']['WEB2SMS']['headTab']);
			$this->data['menu']['web2sms']['wizard'] = array('link' => $this->url->link('web2sms/wizard'), 'text' => $language['Menu']['WEB2SMS']['wizard']);
			$this->data['menu']['web2sms']['myContacts'] = array('link' => $this->url->link('web2sms/my_contacts'), 'text' => $language['Menu']['WEB2SMS']['myContacts']);
			$this->data['menu']['web2sms']['sendSms'] = array('link' => $this->url->link('web2sms/send_sms'), 'text' => $language['Menu']['WEB2SMS']['sendSms']);
			$this->data['menu']['web2sms']['campaigns'] = array('link' => $this->url->link('web2sms/campaigns'), 'text' => $language['Menu']['WEB2SMS']['campaigns']);
			$this->data['menu']['web2sms']['mytemplates'] = array('link' => $this->url->link('web2sms/my_templates'), 'text' => $language['Menu']['WEB2SMS']['myTemplates']);
		}
		
		// Administration
		if ($this->rights->hasAdministrationRights()) {
			$this->data['menu']['administration'] = array();
			$this->data['menu']['administration']['headTab'] = array('link' => $this->url->link('#administration'), 'text' => $language['Menu']['Administration']['headTab']);
			$this->data['menu']['administration']['senderIdAdmin'] = array('link' => $this->url->link('administration/sender_id'), 'text' => $language['Menu']['Administration']['senderIdAdmin']);
			$this->data['menu']['administration']['smscIdAdmin'] = array('link' => $this->url->link('administration/smsc_id'), 'text' => $language['Menu']['Administration']['smscIdAdmin']);
			$this->data['menu']['administration']['antiFlooding'] = array('link' => $this->url->link('administration/anti_flooding'), 'text' => $language['Menu']['Administration']['antiFlooding']);
			$this->data['menu']['administration']['antiVirus'] = array('link' => $this->url->link('administration/anti_virus'), 'text' => $language['Menu']['Administration']['smsAntiVirus']);
		}
		
		// My Account
		$this->data['menu']['my_account'] = array();
		$this->data['menu']['my_account']['headTab'] = array('link' => $this->url->link('#my_account'), 'text' => $language['Menu']['MyAccount']['headTab']);
		if ($this->rights->hasMyClientsRights()) {
			$this->data['menu']['my_account']['myClients'] = array('link' => $this->url->link('my_account/my_clients'), 'text' => $language['Menu']['MyAccount']['myClients']);
		}
		$this->data['menu']['my_account']['accountSettings'] = array('link' => $this->url->link('my_account/account_settings'), 'text' => $language['Menu']['MyAccount']['accountSettings']);
		$this->data['menu']['my_account']['balance'] = array('link' => $this->url->link('my_account/balance'), 'text' => $language['Menu']['MyAccount']['balance']);
		if ($this->rights->isAdmin()) {
			$this->data['menu']['my_account']['custCredits'] = array('link' => $this->url->link('my_account/customer_credits'), 'text' => $language['Menu']['MyAccount']['custCredits']);
		}
		if ($this->rights->hasClientInfoRights()) {
			$this->data['menu']['my_account']['tasks'] = array('link' => $this->url->link('my_account/tasks'), 'text' => $language['Menu']['MyAccount']['tasks']);
		}
		
		// Coverage
		$this->data['menu']['coverage'] = array();
		$this->data['menu']['coverage']['headTab'] = array('link' => $this->url->link('#coverage'), 'text' => $language['Menu']['Coverage']['headTab']);
		if ($this->rights->hasPricingRights()) {
			$this->data['menu']['coverage']['pricingAdmin'] = array('link' => $this->url->link('coverage/pricing_administration'), 'text' => $language['Menu']['Coverage']['pricingAdmin']);
		}
		$this->data['menu']['coverage']['coverPrice'] = array('link' => $this->url->link('coverage/coverage_pricing'), 'text' => $language['Menu']['Coverage']['coverPrice']);
		$this->data['menu']['coverage']['numberRanges'] = array('link' => $this->url->link('coverage/numbering_ranges'), 'text' => $language['Menu']['Coverage']['numberRanges']);
		$this->data['menu']['coverage']['massHlr'] = array('link' => $this->url->link('coverage/mass_hlr'), 'text' => $language['Menu']['Coverage']['massHlr']);
		if ($this->rights->hasPricingRights()) {
			$this->data['menu']['coverage']['pricingHist'] = array('link' => $this->url->link('coverage/pricing_history'), 'text' => $language['Menu']['Coverage']['pricingHist']);
		}
		
		// Routing
		if ($this->rights->hasAdministrationRights()) {
			$this->data['menu']['routing'] = array();
			$this->data['menu']['routing']['headTab'] = array('link' => $this->url->link('#routing'), 'text' => $language['Menu']['Routing']['headTab']);
			$this->data['menu']['routing']['smscAdmin'] = array('link' => $this->url->link('routing/smsc_admin'), 'text' => $language['Menu']['Routing']['smscAdmin']);
			$this->data['menu']['routing']['routingAdmin'] = array('link' => $this->url->link('routing/routing_administration'), 'text' => $language['Menu']['Routing']['routingAdmin']);
			$this->data['menu']['routing']['routing'] = array('link' => $this->url->link('routing/routing'), 'text' => $language['Menu']['Routing']['routing']);
			$this->data['menu']['routing']['prefixes'] = array('link' => $this->url->link('routing/prefixes'), 'text' => $language['Menu']['Routing']['prefixes']);
		}
		
		// Help
		$this->data['menu']['help'] = array();
		$this->data['menu']['help']['headTab'] = array('link' => $this->url->link('#help'), 'text' => $language['Menu']['Help']['headTab']);
		$this->data['menu']['help']['smppConn'] = array('link' => $this->url->link('help/smpp_connection'), 'text' => $language['Menu']['Help']['smppConn']);
		$this->data['menu']['help']['apiDoc'] = array('link' => $this->url->link('help/api_doc'), 'text' => $language['Menu']['Help']['apiDoc']);
		$this->data['menu']['help']['errorCodes'] = array('link' => $this->url->link('help/error_codes'), 'text' => $language['Menu']['Help']['errorCodes']);
		$this->data['menu']['help']['apiFaq'] = array('link' => $this->url->link('help/api_faq'), 'text' => $language['Menu']['Help']['apiFaq']);
		if ($this->rights->hasSmppFaqRights()) {
			$this->data['menu']['help']['smppFaq'] = array('link' => $this->url->link('help/smpp_faq'), 'text' => $language['Menu']['Help']['smppFaq']);
		}
		if ($this->rights->hasWeb2smsFaqRights()) {
			$this->data['menu']['help']['web2smsFaq'] = array('link' => $this->url->link('help/web2sms_faq'), 'text' => $language['Menu']['Help']['web2smsFaq']);
		}
		$this->data['menu']['help']['support'] = array('link' => $this->url->link('help/support'), 'text' => $language['Menu']['Help']['support']);
		
		// Support
		if ($this->rights->isAdmin()) {
			$this->data['menu']['support'] = array();
			$this->data['menu']['support']['headTab'] = array('link' => $this->url->link('#support'), 'text' => $language['Menu']['Support']['headTab']);
			$this->data['menu']['support']['notif'] = array('link' => $this->url->link('support/notifications'), 'text' => $language['Menu']['Support']['notif']);
			$this->data['menu']['support']['kannel'] = array('link' => $this->url->link('support/kannel'), 'text' => $language['Menu']['Support']['kannel']);
			$this->data['menu']['support']['sysMonitoring'] = array('link' => $this->url->link('support/system_monitoring'), 'text' => $language['Menu']['Support']['sysMonitoring']);
		}
		*/
		if (isset($this->request->request['route']) && $this->request->request['route'] != 'dashboard') {
			$tab = explode('/', $this->request->request['route']);
		}
		$this->data['activated_tab'] = isset($tab) ? $tab[0] : 'dashboard';
		$this->data['activated_subtab'] = isset($tab) ? $tab[1] : 'dashboard';
		
		$this->data['title'] = 'Embryo';
		
		$this->template = 'header.tpl';
    	$this->render();
	}
}
?>