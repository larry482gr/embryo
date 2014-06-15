$(document).ready(function(){
	$('#change-pass').on('click', function() {
		$('#change-pass-form').slideToggle();
	});
	
	$('#change-pass-form, #register-form .form-control').on('focus', function() {
		$('#change-pass-form, #register-form .alert').parent().fadeOut();
	});
	
	$('#username').on('blur', function(){
		$.post('/'+$('#lang').val()+'/user/check_username',
		  { username: $(this).val() })
		.done(function(result){
			$('#username-availability span').hide();
			if(result == "available") {
				$('#username-availability span:first-child').show();
				$('#username-availability span').css('color', '#00AA00');
			}
			else {
				$('#username-availability span:last-child').show();
				$('#username-availability span').css('color', '#AA0000');
			}
		})
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
	
	$('#register-btn').on('click', function() {
		var error = false;
		// if($('#username').val().length == 0 || $('#email').val().length == 0 || $('#pass').val().length == 0 || $('#confirm-pass').val().length == 0) {
		if($('#username').val().length == 0 || $('#email').val().length == 0) {
			$('#fill-all-error').fadeIn();
			error = true;
		}
		/*
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
		*/
		
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
		
		if(!error)
			$('#register-form').submit();
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