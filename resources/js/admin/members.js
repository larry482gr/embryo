$(document).ready(function(){
	$('.container').on('click', '#add-new-group', function(){
		if(!$(this).hasClass('add-form-open')) {
			$(this).addClass('add-form-open');
			$(this).text('Close Form');
			$('#create-new-group').slideDown('fast');
			$('#add-new-member').attr('disabled', true);
		}
		else {
			$(this).removeClass('add-form-open');
			$(this).text('Add New Group');
			$('#create-new-group').slideUp('fast');
			$('#add-new-member').attr('disabled', false);
		}
	});
	
	$('.container').on('click', '#add-new-member', function(){
		if(!$(this).hasClass('add-form-open')) {
			$(this).addClass('add-form-open');
			$(this).text('Close Form');
			$('#create-new-member').slideDown('fast');
			$('#add-new-group').attr('disabled', true);
		}
		else {
			$(this).removeClass('add-form-open');
			$(this).text('Add New Member');
			$('#create-new-member').slideUp('fast');
			$('#add-new-group').attr('disabled', false);
		}
	});
	
	$('.container').on('click', 'tr.group-row', function() {
		group_id = $(this).attr('rel');
		$('div.members').removeClass('visible');
		$('div#members'+group_id).addClass('visible');
	});
	
	$('.container').on('click', 'a.thumbnail', function(e) {
		e.preventDefault();
	});
});

function showCV(id) {
	if($('div #cv'+id).hasClass('cv-open')) {
		$('div #cv'+id).removeClass('cv-open');
		$('div #cv'+id).slideUp('fast');
	}
	else {
		$('.member-cv').removeClass('cv-open');
		$('.member-cv').slideUp('fast');
		$('.member-pubs').removeClass('pubs-open');
		$('.member-pubs').slideUp('fast');
		$('div #cv'+id).slideDown('fast');
		$('div #cv'+id).addClass('cv-open');
	}
}