var active_category = 1;
var total_categories = $('#total-categories').val();

$('.category-div').hide();
$('.category-div:first-child').show();
$('#submit-button').hide();

$(document).ready(function() {
	$('#survey-progress').css('width', (((active_category)/total_categories)*100)+'%');
	$('#survey-progress-span').html((((active_category)/total_categories)*100)+'%');
	
	$('#submit-button').on('click', function() {
		$('#survey-form').submit();
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

function previousPage() {
	if(active_category == 1)
		return;
	
	$('#category'+active_category).fadeOut('fast', function() {
		active_category--;
		$('#category'+active_category).fadeIn('fast', function() {
			$('.next').removeClass('disabled');
	
			if(active_category == 1)
				$('.previous').addClass('disabled', true);
				
			$("html, body").animate({
				scrollTop: 0
			}, 300);
			
			$('#survey-progress').css('width', (((active_category)/total_categories)*100)+'%');
			$('#survey-progress-span').html((((active_category)/total_categories)*100)+'%');
			$('#submit-button').hide();
		});
	});
}

function nextPage() {
	if(active_category == total_categories)
		return;
	
	$('#category'+active_category).fadeOut('fast', function() {
		active_category++;
		$('#category'+active_category).fadeIn('fast', function() {
			$('.previous').removeClass('disabled');
		
			if(active_category == total_categories) {
				$('.next').addClass('disabled', true);
				$('#submit-button').show();
			}
			
				
			$("html, body").animate({
				scrollTop: 0
			}, 300);
			
			$('#survey-progress').css('width', (((active_category)/total_categories)*100)+'%');
			$('#survey-progress-span').html((((active_category)/total_categories)*100)+'%');
		});
	});
}