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
		$name = $this->request->post['name'];
		$email = $this->request->post['email'];
		$subject = 'repro.law.auth.gr - '.$this->request->post['subject'];
		$message = nl2br($this->request->post['message']);
		$is_opinion_form = $this->request->post['opinion_form'] == 1 ? true : false;
		
		if(empty($name) || empty($email) || empty($subject) || empty($message))
			die('fill_all');
		else {
			if(!$is_opinion_form) {
				$to      = 'bioithiki@gmail.com';
				$message = '<h3>Μήνυμα από "'.$name.'" μέσω της Φόρμας Επικοινωνίας</h3><div>'.$message.'</div>';
				// To send HTML mail, the Content-type header must be set
				$headers  = 'MIME-Version: 1.0' . "\r\n";
				$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
				
				// Additional headers
				$headers .= 'From: '.$name.' <'.$email.'>' . "\r\n";
				$headers .= 'Reply-To: ' . $email . "\r\n";
				// $headers .= 'X-Mailer: PHP/' . phpversion();
			}
			else {
				$to      = 'mimmaki@gmail.com';
				$message = '<h3>Μήνυμα από "'.$name.'" μέσω της Φόρμας αποστολής σκέψης/ζητήματος</h3><div>'.$message.'</div>';
				// To send HTML mail, the Content-type header must be set
				$headers  = 'MIME-Version: 1.0' . "\r\n";
				$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
				
				// Additional headers
				$headers .= 'From: '.$name.' <'.$email.'>' . "\r\n";
				$headers .= 'Reply-To: ' . $email . "\r\n";
				$headers .= 'Cc: kastan@law.auth.gr' . "\r\n";
				// $headers .= 'X-Mailer: PHP/' . phpversion();
			}
			
			if(mail($to, $subject, $message, $headers))
				die('success');
		}
		
		die('error');
	}
}
?>