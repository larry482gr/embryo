$(document).ready(function() {
	$('#new-issue').on('click', function() {
		window.location.href = '/admin/todo/newIssue';
	});
	
	$('#issue-submit').on('click', function() {
		$('#issue-description').html($('#issue-description').next().find('iframe').contents().find("body").html());
	});
	
	CKEDITOR.replace( 'issue-description' );
	
	$.fn.modal.Constructor.prototype.enforceFocus = function () {
	    modal_this = this
	    $(document).on('focusin.modal', function (e) {
	        if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length
	        // add whatever conditions you need here:
	        &&
	        !$(e.target.parentNode).hasClass('cke_dialog_ui_input_select') && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
	            modal_this.$element.focus()
	        }
	    })
	};
});