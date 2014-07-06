$(document).ready(function(){
	if($('#hasSubcategories').val() == 1) {
		$.ajax({
			url: '/'+$('#lang').val()+'/information/getSubcategoryFiles',
			cache: false,
			type: 'post',
			dataType: 'json',
			data: {
				catId: $('#subcategories').find('option:first-child').val()
			},
			success: function(items) {
				$('#info-div').append('<table class="table table-condensed table-bordered table-hover">'+
									  '<thead><tr><td>#</td><td>'+$('#fileName').val()+'</td><td>'+$('#fileSize').val()+'</td><td>'+$('#fileDate').val()+'</td></tr></thead>'+
									  '<tbody></tbody></table>');
									  
				for(i = 0; i < items.length; i++) {
					appendFileRow(i+1, items[i]);
				}
			},
			error: function(items) {
				bootbox.alert("Something bad happened!");
			}
		});
	}

	$('.container').on('click', 'table tr', function(){
		fileLink = $(this).attr('rel');
		window.open('/resources/files/information/'+fileLink, '_blank');
	});
	
	function appendFileRow(rowIndex, file) {
		$('#info-div').find('table tbody').append('<tr rel="'+file.name+'"><td>'+rowIndex+'</td><td>'+file.label+'</td><td>'+file.size+'</td><td>'+file.created_at+'</td></tr>');
	}
});