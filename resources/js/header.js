$(document).ready(function(){
	windowWidth = $(window).width();
	$('.navbar-nav').on('click', 'li', function(){
		if(!$(this).hasClass('dropdown')) {
			$('.navbar-nav li').removeClass('active');
			$(this).addClass('active');
		}
	});
	
	if (!navigator.userAgent.match(/Android|BlackBerry|iPhone|iPad|iPod|Opera Mini|IEMobile/i)) {
	    $('.container').on('mouseover', '.dropdown', function() {
	    	$(this).addClass('open');
	    });
	    
	    $('.container').on('mouseout', '.dropdown', function() {
	    	$(this).removeClass('open');
	    });
	}
	else {
		alert("mobile!");
		$('.container').on('mouseover', '.dropdown', function() {
			alert("onClick");
			if(!$(this).hasClass('open')) {
				alert("onClick open");
				$(this).removeClass('open');
				$(this).find('.dropdown-menu').css('height', '0').css('max-height', '0').css('opacity', '0').css('display', 'none');
			}
			else {
				alert("not open");
				$(this).addClass('open');
				$(this).find('.dropdown-menu').css('height', 'auto').css('max-height', '1000px').css('opacity', '1').css('display', 'block');
			}
		});
	}
	
});