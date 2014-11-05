$(document).ready(function() {
	$('#conf-appl').on('click', function() {
		var lang = $(this).attr('rel');
		window.location.href = '/'+lang+'/news/conference_application';
	});
});