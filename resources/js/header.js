var dropdown_open = true;


$(document).ready(function(){
	$('.navbar-nav').on('click', 'li', function(){
		if(!$(this).hasClass('dropdown')) {
			$('.navbar-nav li').removeClass('active');
			$(this).addClass('active');
		}
	});
	
    $('.container').on('click', '.dropdown-toggle', function() {
        if(!$(this).parent().hasClass('open')) {
        	$(this).addClass('dropup');
        	$(this).next().slideToggle('fast');
        	dropdown_open = true;
        }
        else {
        	$(this).removeClass('dropup');
        	$(this).next().slideToggle('fast');
        	dropdown_open = false;
        }
    });
    
    $('.container').on('click', function() {
        if($('.dropdown-toggle').parent().hasClass('open') && dropdown_open) {
	        $('.dropdown-toggle').parent().removeClass('open');
        	$('.dropdown-toggle').removeClass('dropup');
        	$('.dropdown-toggle').next().slideToggle('fast');
        }
    });
});