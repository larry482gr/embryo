$(document).ready(function() {
	var appl_title;
	var appl_fname;
	var appl_lname;
	var appl_faculty;
	var appl_country;
	var appl_city;
	var appl_pocode;
	var appl_address;
	var appl_mcc;
	var appl_mnc;
	var appl_tel;
	var appl_fax;
	var appl_email;
	var appl_material;
		
	$('#appl-submit').on('click', function() {
		var error = 0;
		
		appl_title		= $.trim($('#appl-title').val());
		appl_fname		= $.trim($('#appl-fname').val());
		appl_lname		= $.trim($('#appl-lname').val());
		appl_faculty	= $.trim($('#appl-faculty').val());
		appl_country	= $.trim($('#appl-country').val());
		appl_city		= $.trim($('#appl-city').val());
		appl_pocode		= $.trim($('#appl-pocode').val());
		appl_address	= $.trim($('#appl-address').val());
		appl_mcc		= $.trim($('#appl-mcc').val());
		appl_mnc		= $.trim($('#appl-mnc').val());
		appl_tel		= $.trim($('#appl-tel').val());
		appl_fax		= $.trim($('#appl-fax').val());
		appl_email		= $.trim($('#appl-email').val());
		appl_material	= $.trim($('input[name=material]:checked').val());
		
		if(appl_fname.length == 0 || appl_lname.length == 0 || appl_faculty.length == 0 || appl_country.length == 0 || 
		   appl_city.length == 0 || appl_pocode.length == 0 || appl_address.length == 0 || appl_mcc.length == 0 || 
		   appl_mnc.length == 0 || appl_tel.length == 0) {
			
			error += 1;
		}
		
		if(appl_email.length > 0 && !validateEmail(appl_email)) {
			error += 2;
		}
		
		if(appl_material == 0) {
			error += 4;
		}
		
		if(error == 0) {
			sendApplication();
		}
		else {
			showErrorMessage(error);
		}
	});

	function validateEmail(email) {
		var emailPattern = /^[a-zA-Z0-9\._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
		return emailPattern.test(email);
	}
	
	function showErrorMessage(error) {
		switch(error) {
			case 1:
				bootbox.alert(required_fields);
				break;
			case 2:
				bootbox.alert(invalid_email);
				break;
			case 3:
				bootbox.alert(required_fields + '<br/>' + invalid_email);
				break;
			case 4:
				bootbox.alert(at_least_one);
				break;
			case 5:
				bootbox.alert(required_fields + '<br/>' + at_least_one);
				break;
			case 6:
				bootbox.alert(invalid_email + '<br/>' + at_least_one);
				break;
			case 7:
				bootbox.alert(required_fields + '<br/>' + invalid_email + '<br/>' + at_least_one);
				break;
			case 8:
				bootbox.alert(only_digits);
				break;
		}
	}
	
	function sendApplication() {
		$.ajax({
			url: "/news/sendApplication",
			cache: false,
			method: 'post',
			dataType: "text",
			data: {
				title:		appl_title,
				fname:		appl_fname,
				lname:		appl_lname,
				faculty:	appl_faculty,
				country:	appl_country,
				city:		appl_city,
				pocode:		appl_pocode,
				address:	appl_address,
				mcc:		appl_mcc,
				mnc:		appl_mnc,
				tel:		appl_tel,
				fax:		appl_fax,
				email:		appl_email,
				material:	appl_material,
			},
			beforeSend : function() {
				$('#appl-submit').append('...');
				$('#appl-submit').attr('disabled', true);
			},
			success: function(result) {
				if(result.substring(0, 3) == 'id:') {
					updateEmailFail(result.substring(3));
				}
				else if(result == '0') {
					bootbox.alert(success);
				}
				else {
					showErrorMessage(parseInt(result));
					$('#appl-submit').html($('#appl-submit').html().substring(0, $('#appl-submit').html().length-3));
					$('#appl-submit').removeAttr('disabled');
				}
			},
			error: function(result) {
				bootbox.alert('Αποτυχία.');
				$('#appl-submit').html($('#appl-submit').html().substring(0, $('#appl-submit').html().length-3));
				$('#appl-submit').removeAttr('disabled');
			}
		});
	}
	
	function updateEmailFail(id) {
		$.ajax({
			url: "/news/updateEmailFail",
			cache: false,
			method: 'post',
			dataType: "text",
			data: {
				id: id,
			},
			success: function(result) {
				return;
			}
		});
	}
});