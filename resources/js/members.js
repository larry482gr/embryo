$(document).ready(function(){
	$('.container').on('click', 'a.thumbnail', function(e) {
		e.preventDefault();
	});
});

function showCV(id) {
	if($('div #cv'+id).hasClass('cv-open')) {
		$('div #cv'+id).removeClass('cv-open');
		$('div #cv'+id).slideUp('fast');
		$('a[rel=cv'+id+']').parent().parent().find('.thumbnail').blur();
	}
	else {
		$('.member-cv').removeClass('cv-open');
		$('.member-cv').slideUp('fast');
		$('.member-pubs').removeClass('pubs-open');
		$('.member-pubs').slideUp('fast');
		$('div #cv'+id).slideDown('fast');
		$('div #cv'+id).addClass('cv-open');
		$('a[rel=cv'+id+']').parent().parent().find('.thumbnail').focus();
	}
}

function showPubs(id) {
	if($('div #pubs'+id).hasClass('pubs-open')) {
		$('div #pubs'+id).removeClass('pubs-open');
		$('div #pubs'+id).slideUp('fast');
	}
	else {
		$('.member-cv').removeClass('cv-open');
		$('.member-cv').hide();
		$('.member-pubs').removeClass('pubs-open');
		$('.member-pubs').hide();
		$('div #pubs'+id).slideDown('fast');
		$('div #pubs'+id).addClass('pubs-open');
	}
}