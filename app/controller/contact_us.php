<?php
class ControllerContactUs extends Controller {
	public function index($args = false) {
			$lang_id = $this->language->getCurrentLanguageId();
			$this->data['lang'] = $this->language->getCurrentLanguage();
			$this->data['contact'] = $this->language->getLanguage('contact');
			$this->data['form'] = $this->language->getLanguage('form');
	
			$this->document->addStyle('contact_us');
			$this->document->addScript('contact_us');
			$this->document->addStyle('left_part');
			
			// Assign header/footer to children object
			$this->children = array('header', 'footer', 'left_part');
			
			// Assign at template object the tpl
			$this->template = 'contact_us/index.tpl';
			$this->response->setOutput($this->render());
	}
	
	public function processContactForm() {
		$name = $this->db->escape($this->request->post['name']);
		$email = $this->db->escape($this->request->post['email']);
		$subject = $this->db->escape($this->request->post['subject']);
		$message = $this->db->escape($this->request->post['message']);
		
		if(empty($name) || empty($email) || empty($subject) || empty($message))
			die('fill_all');
		else {
			$this->mail->setTo('lakazantzis@gmail.com');
			$this->mail->setSender($name);
			$this->mail->setFrom($email);
			$this->mail->setSubject($subject);
			
			$message = '<h3>Message from '.$name.' via Contact Form</h3><div>'.nl2br($message).'</div>';
			$this->mail->setHtml($message);
			
			if($this->mail->send())
				die('success');	
		}
		
		die('error');
	}
}
?>