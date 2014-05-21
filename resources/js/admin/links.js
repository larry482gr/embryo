$(document).ready(function(){
	$('.container').on('click', '#add-new-category', function(){
		if(!$(this).hasClass('add-form-open')) {
			$(this).addClass('add-form-open');
			$(this).text('Close Form');
			$('#create-new-category').slideDown('fast');
			$('#add-new-link').attr('disabled', true);
		}
		else {
			$(this).removeClass('add-form-open');
			$(this).text('Add New Category');
			$('#create-new-category').slideUp('fast');
			$('#add-new-link').attr('disabled', false);
		}
	});
	
	$('.container').on('click', '#add-new-link', function(){
		if(!$(this).hasClass('add-form-open')) {
			$(this).addClass('add-form-open');
			$(this).text('Close Form');
			$('#create-new-link').slideDown('fast');
			$('#add-new-category').attr('disabled', true);
		}
		else {
			$(this).removeClass('add-form-open');
			$(this).text('Add New Link');
			$('#create-new-link').slideUp('fast');
			$('#add-new-category').attr('disabled', false);
		}
	});
	/*
	$('.container').on('focus', '#link_url', function(){
		if($(this).val().length == 0)
			$(this).val('http://');
	});
	*/
});