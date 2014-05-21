$(document).ready(function(){
	$('.container').on('click', '#add-new', function(){
		if(!$(this).hasClass('add-form-open')) {
			$(this).addClass('add-form-open');
			$(this).text('Close Form');
			$('#create-new-tab').slideDown('fast');
		}
		else {
			$(this).removeClass('add-form-open');
			$(this).text('Add New Tab');
			$('#create-new-tab').slideUp('fast');
		}
	});
});