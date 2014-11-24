<?php
	$name = $_POST['name'];
	$email = $_POST['email'];
	$subject = 'repro.law.auth.gr - '.$_POST['subject'];
	$message = nl2br($_POST['message']);
	$is_opinion_form = $_POST['opinion_form'] == 1 ? true : false;
	
	if(empty($name) || empty($email) || empty($subject) || empty($message))
		die('fill_all');
	else {
		if(!$is_opinion_form) {
			// $to      = 'bioithiki@gmail.com';
			$to      = 'lakazantzis@gmail.com';
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
			// $to      = 'mimmaki@gmail.com';
			$to      = 'lakazantzis@gmail.com';
			$message = '<h3>Μήνυμα από "'.$name.'" μέσω της Φόρμας αποστολής σκέψης/ζητήματος</h3><div>'.$message.'</div>';
			// To send HTML mail, the Content-type header must be set
			$headers  = 'MIME-Version: 1.0' . "\r\n";
			$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
			
			// Additional headers
			$headers .= 'From: '.$name.' <'.$email.'>' . "\r\n";
			$headers .= 'Reply-To: ' . $email . "\r\n";
			// $headers .= 'Cc: kastan@law.auth.gr' . "\r\n";
			// $headers .= 'X-Mailer: PHP/' . phpversion();
		}
		
		if(mail($to, $subject, $message, $headers))
			die('success');
	}
?>