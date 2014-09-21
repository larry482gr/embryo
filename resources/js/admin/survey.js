$(document).ready(function(){
	$('#language').val($('#lang_id').val());
	
	$('#language').on('change', function(){
		var lang = $(this).find('option:selected').attr('rel');
		window.location.href = '/' + lang + '/admin/surveys';
	});
});