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
				$('#info-div').append('<table class="table table-condensed table-bordered">'+
									  '<thead><tr><td class="center v-center"></td><td class="v-center">'+$('#fileName').val()+'</td><td class="center v-center">'+$('#fileSize').val()+'</td><td class="center v-center">'+$('#fileDate').val()+'</td></tr></thead>'+
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
	
	$('.container').on('change', '#subcategories', function() {
		var cat_id = $('#subcategories').val();
		$.ajax({
			url: '/'+$('#lang').val()+'/information/getSubcategoryFiles',
			cache: false,
			type: 'post',
			dataType: 'json',
			data: {
				catId: cat_id
			},
			success: function(items) {
				$('#info-div table').animate({opacity: 0}, 200, function() {
					$('#info-div table').remove();
					$('#info-div').append('<table class="table table-condensed table-bordered" style="opacity: 0">'+
										  '<thead><tr><td class="center v-center"></td><td class="v-center">'+$('#fileName').val()+'</td><td class="center v-center">'+$('#fileSize').val()+'</td><td class="center v-center">'+$('#fileDate').val()+'</td></tr></thead>'+
										  '<tbody></tbody></table>');
									  
					for(i = 0; i < items.length; i++) {
						appendFileRow(i+1, items[i]);
					}
					
					$('#info-div table').animate({opacity: 1}, 200);
				});
			},
			error: function(items) {
				bootbox.alert("Something bad happened!");
			}
		});
	});
	
	function appendFileRow(rowIndex, file) {
		$('#info-div').find('table tbody').append('<tr rel="'+file.name+'"><td class="center v-center">'+rowIndex+'</td><td class="v-center">'+file.label+'</td><td class="center v-center">'+file.size+'</td><td class="center v-center">'+file.created_at+'</td></tr>');
	}
});