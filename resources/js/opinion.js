$(document).ready(function(){
	
});

function showHideForm() {
	if($('#contact-form').is(':hidden'))
		$('#contact-form').slideDown();
	else
		$('#contact-form').slideUp();
}