$(document).ready(function() {
	$('#info-table').css('opacity', '0');
	$('#language').val($('#lang_id').val());
	
	$('#language').on('change', function() {
		var lang = $(this).find('option:selected').attr('rel');
		window.location.href = '/' + lang + '/admin/info';
	});
	
	$('#info-cat').on('change', function() {
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
	
	$('.container').on('click', '#info-table tr', function(){
		fileLink = $(this).attr('rel');
		window.open('/resources/files/information/'+fileLink, '_blank');
	});
	
	$('#add-new-category').on('click', function() {
		if($('#create-new-cat').is(':visible'))
			$('#create-new-cat').slideUp();
		else
			$('#create-new-cat').slideDown();
	});
	
	$('#add-new-file').on('click', function() {
		if($('#create-new-file').is(':visible'))
			$('#create-new-file').slideUp();
		else
			$('#create-new-file').slideDown();
	});
	
	function appendFileRow(rowIndex, file) {
		$('#info-table tbody').append('<tr rel="'+file.name+'"><td class="center v-center">'+rowIndex+'</td><td class="v-center">'+file.label+'</td><td class="center v-center">'+file.size+'</td><td class="center v-center">'+file.created_at+'</td></tr>');
	}
});