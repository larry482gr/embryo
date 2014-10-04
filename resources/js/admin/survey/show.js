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
			$('#submit-button').show();
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