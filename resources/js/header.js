$(document).ready(function(){
	$('.navbar-nav').on('click', 'li', function(){
		if(!$(this).hasClass('dropdown')) {
			$('.navbar-nav li').removeClass('active');
			$(this).addClass('active');
		}
	});
	
	if($(window).width() < 970)
		$('.dropdown-toggle').attr('data-toggle', 'dropdown');
	
	$(window).resize(function(){
		if($(window).width() < 970) {
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
		$('.navbar-nav').on('hover', '.dropdown', function() {
			if($(window).width() > 970) {
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
	
	$('.back-to-top-div').on('click', function() {
		$("html, body").animate({
			scrollTop: 0
		}, 300);
	});
	
	$(".social-media").on("mouseover", ".facebook-grey", function () {
        $(".facebook-grey").fadeTo(150,0.1,function(){
        	$(this).removeClass().addClass("facebook").fadeTo(300, 1);
        });
    });
	
    $(".social-media").on("mouseout", ".facebook", function () {
    	$(".facebook").fadeTo(150,0.1,function(){
        	$(this).removeClass().addClass("facebook-grey").fadeTo(300, 1);
        });
    });
    
    $(".social-media").on("mouseover", ".twitter-grey", function () {
    	$(".twitter-grey").fadeTo(150,0.1,function(){
        	$(this).removeClass().addClass("twitter").fadeTo(300, 1);
        });
    });
	
    $(".social-media").on("mouseout", ".twitter", function () {
        $(".twitter").fadeTo(150,0.1,function(){
        	$(this).removeClass().addClass("twitter-grey").fadeTo(300, 1);
        });
    });
});