$(document).ready(function(){
	$('.container').on('click', '#add-new-group', function(){
		if(!$(this).hasClass('add-form-open')) {
			$(this).addClass('add-form-open');
			$(this).text('Close Form');
			$('#create-new-group').slideDown('fast');
			$('#add-new-member').attr('disabled', true);
		}
		else {
			$(this).removeClass('add-form-open');
			$(this).text('Add New Group');
			$('#create-new-group').slideUp('fast');
			$('#add-new-member').attr('disabled', false);
		}
	});
	
	$('.container').on('click', '#add-new-member', function(){
		if(!$(this).hasClass('add-form-open')) {
			$(this).addClass('add-form-open');
			$(this).text('Close Form');
			$('#create-new-member').slideDown('fast');
			$('#add-new-group').attr('disabled', true);
			$('#member_group').val("1");
			$('#member_name').val("");
			$('#member_email').val("");
			$('#form-thumbnail').hide();
			$('#member_picture').val("");
			$('#member_cv').val("");
			$('#member_pubs').val("");
		}
		else {
			$(this).removeClass('add-form-open');
			$(this).text('Add New Member');
			$('#create-new-member').slideUp('fast');
			$('#add-new-group').attr('disabled', false);
		}
	});
	
	$('.container').on('click', 'tr.group-row', function() {
		group_id = $(this).attr('rel');
		$('div.members').removeClass('visible');
		$('div#members'+group_id).addClass('visible');
	});
	
	$('.container').on('click', 'a.thumbnail', function(e) {
		e.preventDefault();
	});
	
	$('.member-pic').on('click', function() {
		id = $(this).attr('rel');
		$.get('/admin/members/show/'+id,
			function(result) {
				if(!$('#add-new-member').hasClass('add-form-open'))
					$('#add-new-member').click();
				$('#form-thumbnail').hide();
				$('#member_group').val(result.member.group_id);
				$('#member_name').val(result.member.name);
				$('#member_email').val(result.member.email);
				$('#member_cv').val(result.memberInfo.cv);
				$('#member_pubs').val(result.memberInfo.pubs);
				if(result.member.picture.length > 0) {
					$('#form-thumbnail').show();
					$('#form-thumbnail').attr('src', '/resources/images/members/'+result.member.picture);
				}
				$('#edit').val("1");
				$('#member_id').val(result.member.id);
			}, "json");
	});
});

function showCV(id) {
	if($('div #cv'+id).hasClass('cv-open')) {
		$('div #cv'+id).removeClass('cv-open');
		$('div #cv'+id).slideUp('fast');
	}
	else {
		$('.member-cv').removeClass('cv-open');
		$('.member-cv').slideUp('fast');
		$('.member-pubs').removeClass('pubs-open');
		$('.member-pubs').slideUp('fast');
		$('div #cv'+id).slideDown('fast');
		$('div #cv'+id).addClass('cv-open');
	}
}