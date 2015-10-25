$(document).ready(function(){
	$('ol.loose-ol li a[href="#"]').after('<span> (Υπό διαμόρφωση)</span>');
	$('ol.loose-ol li a[href="#"]').on('click', function(e){
		e.preventDefault();
	});
});