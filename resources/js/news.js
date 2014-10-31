$(document).ready(function() {
	$('.panel').slideDown();
	
	firstYear = $('.container .year:first-child');
	firstYear.find('span.glyphicon').removeClass('glyphicon-folder-close').addClass('glyphicon-folder-open');
	firstMonthList = firstYear.next().find('.months');
	firstMonthList.show();
	firstMonthList.find('.month:last-child span.glyphicon').removeClass('glyphicon-folder-close').addClass('glyphicon-folder-open');
	
	$('.container').on('click', '.year span', function() {
		folder = $(this).find('span.glyphicon');
		if(folder.hasClass('glyphicon-folder-close')) {
			folder.removeClass('glyphicon-folder-close');
			folder.addClass('glyphicon-folder-open');
		}
		else {
			folder.removeClass('glyphicon-folder-open');
			folder.addClass('glyphicon-folder-close');
			// $(this).parent().next().find('span.glyphicon').removeClass('glyphicon-folder-open').addClass('glyphicon-folder-close');
		}
		
		monthsList = $(this).parent().next().find('.months');
		monthsList.slideToggle('fast');
	});
	
	$('.container').on('click', '.month span', function() {
		folder = $(this).find('span.glyphicon');
		if(folder.hasClass('glyphicon-folder-close')) {
			$('.month span span.glyphicon').removeClass('glyphicon-folder-open').addClass('glyphicon-folder-close');
			folder.removeClass('glyphicon-folder-close');
			folder.addClass('glyphicon-folder-open');
			// $('span.glyphicon-arrow-right').remove();
			// $(this).append('<span class="glyphicon glyphicon-arrow-right"></span>');
			panelTitle = $(this).attr('rel');
			$('.panel-title').animate({ width: 0 }, 400, function() {
				$('.panel-title').text(panelTitle);
				$('.panel-title').animate({ width: 300 }, 400);
			});
			dlClass = $(this).attr('class');
			$('.news-panel').animate({ opacity: 0 }, 400, function() {
				$('dl.shown').removeClass('shown').addClass('hidden');
				$('dl.'+dlClass).removeClass('hidden').addClass('shown');
				$('.news-panel').animate({ opacity: 1 }, 400);
			});
		}
	});
	
	$('#conf-appl').on('click', function() {
		var lang = $(this).attr('rel');
		window.location.href = '/'+lang+'/news/conference_application';
	});
});