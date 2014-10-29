$(document).ready(function() {
	$('#info-table').css('opacity', '0');
	$('#language').val($('#lang_id').val());
	
	$('#language').on('change', function() {
		var lang = $(this).find('option:selected').attr('rel');
		window.location.href = '/' + lang + '/admin/info';
	});
	
	$('#info-cat').on('change', function() {
		$('#edit-btn').show();
		var cat_id = $(this).val();
		$.ajax({
			url: '/admin/info/getCategoryFiles/'+cat_id,
			type: 'get',
			cache: false,
			dataType: 'json',
			beforeSend: function() {
				$('#info-table').css('opacity', '0');
				$('#info-table tbody').html('');
			},
			success: function(items) {
				if(items.length == 0) {
					$('#info-table tbody').append('<tr><td class="center v-center" colspan="4">'+$('#no-results').val()+'</td></tr>');
				}
				else {
					for(i = 0; i < items.length; i++) {
						appendFileRow(i+1, items[i]);
					}
				}
				$('#info-table').css('opacity', '1');
			},
			error: function(result) {
				bootbox.alert("An error occured. Please try again!");
			}
		});
	});
	
	$('#edit-btn').on('click', function() {
		var cat_id = $('#info-cat').val();
		$.ajax({
			url: '/admin/info/getCategory',
			type: 'post',
			cache: false,
			dataType: 'json',
			data: { id: cat_id },
			success: function(result) {
				$('#add-new-category').text('Close Form');
				$('#add-new-file').attr('disabled', true);
				$('#create-new-cat').slideDown();
				$('#info-tab').val(result.tab_id);
				$('#info-parent').val(result.parent_id);
				$('#info-lang').val(result.lang_id);
				$('#info-label').val(result.label);
				if(result.is_active == 1)
					$('#info-active').attr('checked', true);
				else
					$('#info-active').removeAttr('checked');
				$('#edit-cat').val(result.id);
				
				$("html, body").animate({
					scrollTop: $('#create-new-cat').offset().top
				}, 300);
			},
			error: function(result) {
				bootbox.alert("An error occured. Please try again!");
			}
		});
	});
	
	/*
	$('.container').on('click', '#info-table tr', function(){
		fileLink = $(this).attr('rel');
		window.open('/resources/files/information/'+fileLink, '_blank');
	});
	*/
	
	$('#add-new-category').on('click', function() {
		if($('#create-new-cat').is(':visible')) {
			$(this).text('Add New Category/Subcategory');
			$('#create-new-cat').slideUp('slow', function() {
				$('#add-new-file').removeAttr('disabled');
				resetCategoryForm();
			});
		}
		else {
			$('#create-new-cat').slideDown();
			$(this).text('Close Form');
			$('#add-new-file').attr('disabled', true);
		}
	});
	
	$('#add-new-file').on('click', function() {
		if($('#create-new-file').is(':visible')) {
			$(this).text('Add New File');
			$('#create-new-file').slideUp();
			$('#add-new-category').removeAttr('disabled');
		}
		else {
			$('#create-new-file').slideDown();
			$(this).text('Close Form');
			$('#add-new-category').attr('disabled', true);
		}
	});
	
	$('#submit-cat-btn').on('click', function() {
		// Check for any conditions may be done.
		$('#create-new-cat').submit();
	});
	
	function appendFileRow(rowIndex, file) {
		$('#info-table tbody').append('<tr rel="'+file.name+'"><td class="center v-center">'+rowIndex+'</td><td class="v-center">'+file.label+'</td><td class="center v-center">'+file.size+'</td><td class="center v-center">'+file.created_at+'</td></tr>');
	}
	
	function resetCategoryForm() {
		$('#info-tab').val(-1);
		$('#info-parent').val(-1);
		$('#info-lang').val(1);
		$('#info-label').val('');
		$('#info-active').removeAttr('checked');
		$('#edit-cat').val(-1);
	}
});