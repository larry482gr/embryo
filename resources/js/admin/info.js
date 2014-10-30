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
		$('#info-cat-id').val(cat_id);
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
					$('#info-table tbody').append('<tr><td class="center v-center" colspan="5">'+$('#no-results').val()+'</td></tr>');
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
	
	$('.container').on('click', '#info-table td.file-label', function() {
		fileLink = $(this).parent().attr('rel');
		window.open('/resources/files/information/'+fileLink, '_blank');
	});
	
	$('.container').on('click', '.edit-filename', function() {
		var edit_id = $(this).attr('rel');
		bootbox.prompt($('#edit-file-name').val(), function(result) {
			if (result !== null) {
				if(result.length > 0)
					updateFileName(edit_id, result);
				else
					bootbox.alert('Cannot update to an empty file name.');
			}
		});
		$('.bootbox-input').val($(this).parent().parent().find('.file-label').html());
	});
	
	//Μηλαπιδου Μαρία, ΔρΝ, Δικηγορος, "Ο ν. 4272/2014 και οι τροποποιήσεις που επιφέρει στο ν. 3305/2005 για την Ιατρικως Υποβοηθούμενη Αναπαραγωγή", 2014
	
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
			$('#info-cat-id').val(-1);
		}
		else {
			$('#create-new-file').slideDown();
			$(this).text('Close Form');
			$('#add-new-category').attr('disabled', true);
			$('#info-cat-id').val($('#info-cat').val());
		}
	});
	
	$('#submit-cat-btn').on('click', function() {
		// Check for any conditions may be done.
		$('#create-new-cat').submit();
	});
	
	function appendFileRow(rowIndex, file) {
		var edit_button = '<button id="edit'+file.id+'" class="edit-filename btn btn-warning" rel="'+file.id+'">Edit</button>';
		$('#info-table tbody').append('<tr rel="'+file.name+'"><td class="center v-center">'+rowIndex+'</td><td class="v-center file-label">'+file.label+'</td><td class="center v-center">'+file.size+'</td><td class="center v-center">'+file.created_at+'</td><td class="center v-center">'+edit_button+'</td></tr>');
	}
	
	function updateFileName(id, label) {
		var file_id = id;
		var file_label = label;
		$.ajax({
			url: '/admin/info/updateFileName',
			type: 'post',
			cache: false,
			dataType: 'text',
			data: { id: file_id, label: file_label },
			success: function(result) {
				if(result > 0) {
					var table_row = $('#info-table tbody').find('#edit'+file_id).parent().parent();
					table_row.find('.file-label').html(file_label);
				}
				else {
					bootbox.alert("An error occured. Please try again!");
				}
			},
			error: function(result) {
				bootbox.alert("An error occured. Please try again!");
			}
		});
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