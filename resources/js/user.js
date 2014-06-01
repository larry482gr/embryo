$(document).ready(function(){
	$('#change-pass').on('click', function(){
		$('#change-pass-form').slideToggle();
	});
	
	$('#change-pass-form .form-control').on('focus', function(){
		$('#change-pass-form .alert').parent().fadeOut();
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