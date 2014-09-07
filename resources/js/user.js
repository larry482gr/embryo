var username_exists = false;
var email_exists = false;
var username_modify = false;
var email_modify = false;

$(document).ready(function(){
	$('#change-pass').on('click', function() {
		$('#change-pass-form').slideToggle();
	});
	
	$('#change-pass-form, #register-form .form-control').on('focus', function() {
		$('#change-pass-form, #register-form .alert').parent().fadeOut();
	});
	
	$('#username').on('blur', function() {
		checkUsername($(this).val());
		username_modify = true;
	});
	
	$('#username').on('keyup', function() {
		if(username_modify)
			checkUsername($(this).val());
	});
	
	$('#email').on('blur', function() {
		if(typeof $('#pass-one-field-error').val() === "undefined")
			checkEmail($(this).val());
		email_modify = true;
	});
	
	$('#email').on('keyup', function() {
		if(email_modify)
			checkEmail($(this).val());
	});
	
	$('#username, #email').on('focus', function() {
		if(typeof $('#pass-one-field-error').val() !== "undefined") {
			username_modify = false;
			email_modify = false;
			$('#pass-reset-error').hide();
			$('#pass-reset-success').hide();
			$('#pass-reset-fail').hide();
		}
	});
	
	$('#confirm-pass').on('keyup', function() {
		$('#confirm-sign span').hide();
		if($(this).val().length > 0) {
			if($(this).val() != $('#pass').val()) {
				$('#confirm-sign span:last-child').show();
				$('#confirm-sign span').css('color', '#AA0000');
			}
			else {
				$('#confirm-sign span:first-child').show();
				$('#confirm-sign span').css('color', '#00AA00');
			}
		}
	});
	
	$('#register-btn, #member-register-btn').on('click', function() {
		$('#register-error').hide();
		var error = false;
		if(username_exists) {
			$('#username-availability').fadeOut('slow', function(){
				$('#username-availability').fadeIn('slow', function(){
					$('#username-availability').fadeOut('slow', function(){
						$('#username-availability').fadeIn('slow');
					});
				});
			});
			error = true;
		}
		
		if(email_exists) {
			$('#email-availability').fadeOut('slow', function(){
				$('#email-availability').fadeIn('slow', function(){
					$('#email-availability').fadeOut('slow', function(){
						$('#email-availability').fadeIn('slow');
					});
				});
			});
			error = true;
		}
		
		if($('#pass').val().length > 0 && $('#confirm-pass').val().length > 0 && $('#pass').val() != $('#confirm-pass').val()) {
			$('#confirm-sign span:last-child').fadeOut('slow', function(){
				$('#confirm-sign span:last-child').fadeIn('slow', function(){
					$('#confirm-sign span:last-child').fadeOut('slow', function(){
						$('#confirm-sign span:last-child').fadeIn('slow');
					});
				});
			});
			error = true;
		}
		
		if($(this).attr('id') == 'register-btn') {
			if($('#username').val().length == 0 || $('#email').val().length == 0 || $('#pass').val().length == 0 || $('#confirm-pass').val().length == 0) {
				$('#fill-all-error').fadeIn();
				error = true;
			}
		}
		else if($(this).attr('id') == 'member-register-btn') {
			if($('#username').val().length == 0 || $('#email').val().length == 0 || $('#pass').val().length == 0 || $('#confirm-pass').val().length == 0 || 
			   $('#firstName').val().length == 0 || $('#lastName').val().length == 0 || $('#faculty').val().length == 0 || $('#postalAddress').val().length == 0 || 
			   $('#phoneNumber').val().length == 0) {
				$('#fill-all-error').fadeIn();
				error = true;
			}
		}
		
		if(!validateEmail($('#email').val())) {
			$('#email').css('border-color', '#FF0000');
			$('#email-error').slideDown('fast');
			
			$('.container').on('focus', '#email', function() {
				if($('#email-error').is(":visible"))
					$('#email-error').slideUp('fast');
				$(this).css('border-color', '#66afe9');
			});
			
			$('.container').on('focusout', '#email', function() {
				$(this).css('border-color', '#CCCCCC');
			});
			
			error = true;
		}
		
		if(!error) {
			$('#register-form').submit();
		}
	});
	
	$('#change-pass-btn').on('click', function() {
		if($('#old-pass').val().length == 0 || $('#new-pass').val().length == 0 || $('#confirm-pass').val().length == 0) {
			$('#fill-all-error').fadeIn();
			return;
		}
		
		oldPass		= $('#old-pass').val();
		newPass		= $('#new-pass').val();
		confirmPass	= $('#confirm-pass').val();
			
		$.ajax({
			url: '/'+$('#lang').val()+'/user/checkOldPass',
			cache: false,
			type: 'post',
			dataType: 'text',
			data: {
				oldPass: $('#old-pass').val()
			},
			success: function(result) {
				if(result == 'yes')
					sendNewPassword(oldPass, newPass, confirmPass);
				else if(result == 'loged out')
					window.location.href = '/'+$('#lang').val()+'/user/login';
				else {
					$('#change-pass-error .alert').text(result);
					$('#change-pass-error').fadeIn();
				}
			},
			error: function(result) {
				bootbox.alert("Something bad happened!");
			}
			
		});
	});
	
	$('#pass-reset-btn').on('click', function() {
		if($('#username').val().length > 0 && $('#email').val().length > 0) {
			$('#pass-reset-error').html($('#pass-one-field-error').val());
			$('#pass-reset-error').show();
		}
		else {
			checkUsername($('#username').val());
			if($('#email').val().length > 0 && !validateEmail($('#email').val())) {
				$('#email').css('border-color', '#FF0000');
				$('#email-error').slideDown('fast');
				
				$('.container').on('focus', '#email', function() {
					if($('#email-error').is(":visible"))
						$('#email-error').slideUp('fast');
					$(this).css('border-color', '#66afe9');
				});
					
				$('.container').on('focusout', '#email', function() {
					$(this).css('border-color', '#CCCCCC');
				});
			}
			else
				checkEmail($('#email').val());
		}
	});
	
	function checkPassRecover() {
		if(username_exists || email_exists) {
			$('#pass-reset-btn').attr('disabled', true);
			$('#pass-reset-form').submit();
		}
		else {
			if($('#email').val().length > 0) {
				$('#pass-reset-error').html($('#pass-email-not-found-error').val());
				$('#pass-reset-error').show();
			}
			else if($('#username').val().length > 0) {
				$('#pass-reset-error').html($('#pass-username-not-found-error').val());
				$('#pass-reset-error').show();
			}
		}
	}
	
	function checkUsername(username) {
		$.post('/'+$('#lang').val()+'/user/check_username',
		  { username: username })
		.done(function(result) {
			$('#username-availability span').hide();
			if(result == "available") {
				$('#username-availability span:first-child').show();
				$('#username-availability span').css('color', '#00AA00');
				username_exists = false;
			}
			else {
				$('#username-availability span:last-child').show();
				$('#username-availability span').css('color', '#AA0000');
				username_exists = true;
			}
		});
	}
	
	function checkEmail(email) {
		$.post('/'+$('#lang').val()+'/user/check_email',
		  { email: email })
		.done(function(result) {
			$('#email-availability span').hide();
			if(result == "available") {
				$('#email-availability span:first-child').show();
				$('#email-availability span').css('color', '#00AA00');
				email_exists = false;
			}
			else {
				$('#email-availability span:last-child').show();
				$('#email-availability span').css('color', '#AA0000');
				email_exists = true;
			}
			
			if(typeof $('#pass-one-field-error').val() !== "undefined")
				checkPassRecover();
		});
	}
	
	function validateEmail(elementValue) {
		var emailPattern = /^[a-zA-Z0-9\._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
		return emailPattern.test(elementValue);
	}
	
	function sendNewPassword(oldPass, newPass, confirmPass) {
		$.ajax({
			url: '/'+$('#lang').val()+'/user/changePass',
			cache: false,
			type: 'post',
			dataType: 'text',
			data: {
				oldPass: oldPass,
				newPass: newPass,
				confirmPass: confirmPass
			},
			success: function(result) {
				if(result.indexOf("Your password") == 0 || result.indexOf("Ο κώδικος πρόσβασης") == 0) {
					$('#welcome .alert').text(result);
					$('#welcome').fadeIn();
				}
				else {
					$('#change-pass-error .alert').text(result);
					$('#change-pass-error').fadeIn();
				}
			},
			error: function(result) {
				bootbox.alert("Something bad happened!");
			}
		});
	}
});