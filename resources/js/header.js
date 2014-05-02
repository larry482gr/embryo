var windowWidth = $(window).width();

$(document).ready(function(){
	$('.navbar-nav').on('click', 'li', function(){
		if(!$(this).hasClass('dropdown')) {
			$('.navbar-nav li').removeClass('active');
			$(this).addClass('active');
		}
	});
	
	$(window).resize(function(){
		windowWidth = $(window).width();
		if(windowWidth < 768)
			$('.dropdown-toggle').attr('data-toggle', 'dropdown');
	});
	
	if (!navigator.userAgent.match(/Android|BlackBerry|iPhone|iPad|iPod|Opera Mini|IEMobile/i)){
		$('.container').on('mouseover', '.dropdown', function() {
			if(windowWidth >768)
		   		$(this).addClass('open');
		});
		    
		$('.container').on('mouseout', '.dropdown', function() {
			if(windowWidth >768)
				$(this).removeClass('open');
		});
	}
	else {
		$('.dropdown-toggle').attr('data-toggle', 'dropdown');
	}
});