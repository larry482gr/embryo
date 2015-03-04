<?php
class ControllerNews extends Controller {
	public function index($args = false) {
		if($args) {
			return $this->getArticle($args);
		}
		else {
			$lang_id = $this->language->getCurrentLanguageId();
			$this->data['lang'] = $this->language->getCurrentLanguage();
			$this->data['news'] = $this->language->getLanguage('news');
			$this->data['home'] = $this->language->getLanguage('home');
			$this->data['months'] = $this->language->getMonthArray();
			
			$this->load->model('article');
			$this->data['articles'] = $this->model_article->findPublished($lang_id, 'ORDER BY published_at DESC');
	
			$this->document->addStyle('news');
			$this->document->addScript('news');
			
			// Assign header/footer to children object
			$this->children = array('header', 'footer');
			
			// Assign at template object the tpl
			$this->template = 'news/index.tpl';
			$this->response->setOutput($this->render());
		}
	}
	
	public function getArticle($article_id) {
		$this->load->model('article');
		
		$lang_id = $this->language->getCurrentLanguageId();
		$this->data['lang'] = $this->language->getCurrentLanguage();
		$this->data['home'] = $this->language->getLanguage('home');
		$this->data['news'] = $this->language->getLanguage('news');
			
		$this->data['article'] = $this->model_article->find($article_id);
		
		if(!$this->data['article'])
			return $this->response->redirect('error/not_found');
		
		$this->document->addStyle('news');
		$this->document->addScript('news');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'news/show.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function conference_application() {
		$lang = $this->language->getCurrentLanguage();
		
		$this->data['confAppl'] = $this->language->getLanguage('confAppl');
		$this->data['countryList'] = $this->language->getCountryList();
		
		$this->document->addStyle('conf_appl');
		$this->document->addScript('conf_appl');
		$this->document->addStyle('left_part');
		
		// Assign header/footer to children object
		$this->children = array('header', 'footer', 'left_part');
		
		// Assign at template object the tpl
		$this->template = 'news/conf_appl.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function sendApplication() {
		$output = 0;
		
		$appl = array();
		$appl['title'] = $this->db->escape($this->request->post['title']);
		$appl['fname'] = $this->db->escape($this->request->post['fname']);
		$appl['lname'] = $this->db->escape($this->request->post['lname']);
		$appl['faculty'] = $this->db->escape($this->request->post['faculty']);
		$appl['country'] = $this->db->escape($this->request->post['country']);
		$appl['city'] = $this->db->escape($this->request->post['city']);
		$appl['pocode'] = $this->db->escape($this->request->post['pocode']);
		$appl['address'] = $this->db->escape($this->request->post['address']);
		$appl['mcc'] = $this->db->escape($this->request->post['mcc']);
		$appl['mnc'] = $this->db->escape($this->request->post['mnc']);
		$appl['tel'] = $this->db->escape($this->request->post['tel']);
		$appl['fax'] = $this->db->escape($this->request->post['fax']);
		$appl['email'] = $this->db->escape($this->request->post['email']);
		$appl['material'] = $this->db->escape($this->request->post['material']);
		
		if(empty($appl['fname']) || empty($appl['lname']) || empty($appl['faculty']) || empty($appl['country']) || 
		   empty($appl['city']) || empty($appl['pocode']) || empty($appl['address']) || empty($appl['mcc']) || 
		   empty($appl['mnc']) || empty($appl['tel']) || empty($appl['email'])) {
			
			$output += 1;
		}
		
		if(!empty($appl['email']) && !preg_match('/^[a-zA-Z0-9\._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/', $appl['email'])) {
			$output += 2;
		}
		
		if($appl['material'] == 0) {
			$output += 4;
		}
		
		if(!ctype_digit($appl['mcc']) || !ctype_digit($appl['mnc']) || !ctype_digit($appl['tel']) || (!empty($appl['fax']) && !ctype_digit($appl['fax']))) {
			$output = 8;
		}
		
		if($output == 0) {
			$this->load->model('application');
			$appl['fax'] = empty($appl['fax']) ? "NULL" : "'".$appl['fax']."'";
			$appl['email'] = empty($appl['email']) ? "NULL" : "'".$appl['email']."'";
			$lastId = $this->model_application->createApplication($appl);
			
			if(is_numeric($lastId)) {
				$full_name = $appl['fname'].' '.$appl['lname'];
				$email = !empty($appl['email']) ? $appl['email'] : 'online-form@repro.law.auth.gr';
				$subject = 'ONLINE ΔΗΛΩΣΗ ΣΥΜΜΕΤΟΧΗΣ';
				$to      = 'bioithiki@gmail.com';
				$message = $this->buildConferenceApplication($appl);
				// To send HTML mail, the Content-type header must be set
				$headers  = 'MIME-Version: 1.0' . "\r\n";
				$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
				
				// Additional headers
				$headers .= 'From: '.$full_name.' <'.$email.'>' . "\r\n";
				$headers .= 'Reply-To: ' . $email . "\r\n";
				$headers .= 'Cc: mimmaki@gmail.com, roxannefragou@hotmail.com' . "\r\n";
				// $headers .= 'X-Mailer: PHP/' . phpversion();
				
				if(!mail($to, $subject, $message, $headers)) {
					$output = 'id:'.$lastId;
				}
					
			}
		}
		
		echo $output;
		die();
	}
	
	public function updateEmailFail() {
		$id = $this->db->escape($this->request->post['id']);
		$this->load->model('application');
		$affectedRows = $this->model_application->updateEmailFail($id);
		
		echo $affectedRows;
		die();
	}
	
	private function buildConferenceApplication($appl) {
		$confAppl = $this->language->getLanguage('confAppl');
		$appl['fax'] = $appl['fax'] == "NULL" ? '' : $appl['fax'];
		$appl['email'] = $appl['email'] == "NULL" ? '' : $appl['email'];
		$watch = '';
		if($appl['material'] == 1) {
			$watch = $confAppl['watch'];
		}
		else if($appl['material'] == 2) {
			$watch = $confAppl['watchAndGet'];
		}
		else if($appl['material'] == 3) {
			$watch = $confAppl['watch'].'<br/>'.$confAppl['watchAndGet'];
		}
		$message = '<h3>'.$confAppl['onlineAppl'].'</h3>
					<h4>'.$confAppl['personalInfo'].'</h4>
					  <table>
					    <tr>
					      <td>'.$confAppl['title'].'</td>
					      <td style="padding-left: 14px;">'.$appl['title'].'</td>
					    <tr>
					      <td>'.$confAppl['fname'].'</td>
					      <td style="padding-left: 14px;">'.$appl['fname'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['lname'].'</td>
					      <td style="padding-left: 14px;">'.$appl['lname'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['faculty'].'</td>
					      <td style="padding-left: 14px;">'.$appl['faculty'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['country'].'</td>
					      <td style="padding-left: 14px;">'.$appl['country'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['city'].'</td>
					      <td style="padding-left: 14px;">'.$appl['city'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['pocode'].'</td>
					      <td style="padding-left: 14px;">'.$appl['pocode'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['address'].'</td>
					      <td style="padding-left: 14px;">'.$appl['address'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['phoneCountryCode'].'</td>
					      <td style="padding-left: 14px;">'.$appl['mcc'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['phoneCityCode'].'</td>
					      <td style="padding-left: 14px;">'.$appl['mnc'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['phoneNumber'].'</td>
					      <td style="padding-left: 14px;">'.$appl['tel'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['fax'].'</td>
					      <td style="padding-left: 14px;">'.$appl['fax'].'</td>
					    </tr>
					    <tr>
					      <td>'.$confAppl['email'].'</td>
					      <td style="padding-left: 14px;">'.$appl['email'].'</td>
					    </tr>
					  </table>
					  <h4 style="margin-top: 30px; margin-bottom: 4px;">'.$confAppl['interest'].':</h4>
					  <div>'.$watch.'</div>';
      
      return $message;
	}
}
?>