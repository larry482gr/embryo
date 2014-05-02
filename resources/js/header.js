$(document).ready(function(){
	$('.navbar-nav').on('click', 'li', function(){
		if(!$(this).hasClass('dropdown')) {
			$('.navbar-nav li').removeClass('active');
			$(this).addClass('active');
		}
	});
	
	if($(window).width() < 768)
		$('.dropdown-toggle').attr('data-toggle', 'dropdown');
	
	$(window).resize(function(){
		if($(window).width() < 768) {
			$('.dropdown-toggle').attr('data-toggle', 'dropdown');
			$('.dropdown-menu').css('display', '');
		}
		else {
			$('.dropdown-toggle').attr('data-toggle', '');
			$('.dropdown-menu').hide();
			$('.dropdown').removeClass('open');
		}
	});
	
	if (!navigator.userAgent.match(/Android|BlackBerry|iPhone|iPad|iPod|Opera Mini|IEMobile/i)){
		$('.container').on('hover', '.dropdown', function() {
			if($(window).width() > 768) {
				if($(this).hasClass('open')) {
					$(this).find('.dropdown-menu').hide();
					$(this).removeClass('open');
				}
				else {
					$(this).find('.dropdown-menu').slideDown('fast');
					$(this).addClass('open');
				}
			}
		});
	}
	else {
		$('.dropdown-toggle').attr('data-toggle', 'dropdown');
	}
});