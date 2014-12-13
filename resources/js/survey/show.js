var active_category = $('#active-category').val();
var total_categories = $('#total-categories').val();
var first_category = active_category;
var last_category = parseInt(active_category) + parseInt(total_categories) - 1;
var n_category = 0;

$('.category-div').hide();
$('.category-div:first-child').show();
$('#submit-button').hide();
$('#required-fields').hide();
$('#already-completed').hide();

$(document).ready(function() {
	$('#survey-progress').css('width', ((n_category/total_categories)*100)+'%');
	$('#survey-progress').html(parseInt(((n_category/total_categories)*100))+'%');
	
	$('#user-fname').focus();
	
	$('#user-fname, #user-lname, #user-email').on('focus', function() {
		$(this).css('border-color', '#66afe9');
		$('#required-fields').hide();
	});
	
	$('#user-fname, #user-lname, #user-email').on('blur', function() {
		if($.trim($(this).val().length) == 0)
			$(this).css('border-color', '#FF0000');
		
		$('#hidden-'+$(this).attr('id')).val($(this).val());
	});
	
	$('#user-email').on('focus', function() {
		if($('#email-error').is(":visible"))
			$('#email-error').hide('fast');	
		$(this).css('border-color', '#66afe9');
		
		$('#already-completed').hide();
	});
	
	$('#user-email').on('blur', function() {
		var title = $.trim($('#survey-title').text());
		var email = $.trim($(this).val());
		
		if(!validateEmail(email)) {
			$(this).css('border-color', '#FF0000');
			$('#email-error').show('fast');
		}
		else {
			$(this).css('border-color', '#CCCCCC');
			alreadyCompleted(title, email);
		}
	});
	
	$('#submit-button').on('click', function() {
		var title = $.trim($('#survey-title').text());
		var first_name = $.trim($('#hidden-user-fname').val());
		var last_name = $.trim($('#hidden-user-lname').val());
		var email = $.trim($('#hidden-user-email').val());
		var has_errors = false;
		
		if(first_name.length == 0 || last_name.length == 0 || email.length == 0 || !validateEmail(email)) {
			$('#required-fields').show();
			has_errors = true;
		}
		
		if(alreadyCompleted(title, email)) {
			has_errors = true;
		}
			
		if(has_errors) {
			$('#category'+active_category).hide();
			active_category = 2;
			previousPage();
		}
		else {
			$('#survey-form').removeAttr('onsubmit');
			$('#survey-form').submit();
		}
	});
	
	$('.radio label').on('click', function() {
		if($(this).find('input').hasClass('is-other')) {
			rel = $(this).find('input').attr('rel');
			other_id = 'other-' + rel.substring(rel.indexOf('-')+1);
			$('#' + other_id).removeAttr('disabled');
		}
		else {
			rel = $(this).find('input').attr('rel');
			other_id = 'other-' + rel.substring(rel.indexOf('-')+1);
			$('#' + other_id).val('');
			$('#' + other_id).attr('disabled', true);
		}
	});
	
	$('.checkbox label').on('click', function() {
		if($(this).find('input').hasClass('is-other')) {
			rel = $(this).find('input').attr('rel');
			other_id = 'other-' + rel.substring(rel.indexOf('-')+1);
			if($(this).find('input').is(':checked')) {
				$('#' + other_id).removeAttr('disabled');
			}
			else {
				$('#' + other_id).val('');
				$('#' + other_id).attr('disabled', true);
			}
		}
	});
});

function validateEmail(elementValue) {
	var emailPattern = /^[a-zA-Z0-9\._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
	return emailPattern.test(elementValue);
}

function alreadyCompleted(title, email) {
	var already_completed = false;
	
	$.ajax({
		url: "/" + $('#lang').val() + "/survey/alreadyCompletedSurvey",
		cache: false,
		async: false,
		method: 'post',
		dataType: "text",
		data: {
			survey_title: title,
			user_email:	email,
		},
		success: function(result) {
			if(result == 1) {
				$('#already-completed').show();
				already_completed = true;
			}
			else {
				$('#already-completed').hide();
				already_completed = false;
			}
		}
	});
	
	return already_completed;
}

function previousPage() {
	if(active_category == first_category)
		return;
	
	$('#category'+active_category).fadeOut('fast', function() {
		active_category--;
		n_category--;
		$('#category'+active_category).fadeIn('fast', function() {
			$('.next').removeClass('disabled');
	
			if(active_category == first_category) {
				$('.previous').addClass('disabled', true);
				$('#user-form').show();
			}
				
			$("html, body").animate({
				scrollTop: 0
			}, 300);
			
			$('#survey-progress').css('width', (((n_category)/total_categories)*100)+'%');
			$('#survey-progress').html(parseInt(((n_category/total_categories)*100))+'%');
			$('#submit-button').hide();
		});
	});
}

function nextPage() {
	if(active_category == last_category)
		return;
	
	$('#user-form').hide();
	$('#category'+active_category).fadeOut('fast', function() {
		active_category++;
		n_category++;
		$('#category'+active_category).fadeIn('fast', function() {
			$('.previous').removeClass('disabled');
		
			if(active_category == last_category) {
				$('.next').addClass('disabled', true);
				$('#submit-button').show();
			}
			
				
			$("html, body").animate({
				scrollTop: 0
			}, 300);
			
			$('#survey-progress').css('width', (((n_category)/total_categories)*100)+'%');
			$('#survey-progress').html(parseInt(((n_category/total_categories)*100))+'%');
		});
	});
}