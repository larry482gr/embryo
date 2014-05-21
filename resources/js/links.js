$(document).ready(function(){
	$('.container').on('click', '.link-category', function(){
		link = '/'+$('#lang').val()+'/links/'+$(this).attr('rel');
		window.location.href = link;
	});
});