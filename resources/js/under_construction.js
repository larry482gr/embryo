$(document).ready(function(){
	setInterval(function(){
		$('.under-construction').animate({opacity: 0}, 600, function(){
			$('.under-construction').animate({opacity: 1}, 600);
		});
	}, 1200);
});