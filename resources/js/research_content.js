$(document).ready(function(){
	var in_prep = $('#lang').val() == 'en' ? 'In preparation' : 'Υπό διαμόρφωση';
	$('ol.loose-ol li a[href="#"]').after('<span> ('+in_prep+')</span>');
	$('ol.loose-ol li a[href="#"]').on('click', function(e){
		e.preventDefault();
	});
});