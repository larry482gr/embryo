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
				appendTableHeaders();
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
		if(fileLink.substring(0, 7) == "http://") {
			window.open(fileLink, '_blank');	
		}
		else {
			window.open('/resources/files/information/'+fileLink, '_blank');
		}
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
					$('#info-div').find('#files-div').remove();
					appendTableHeaders();
									  
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
	
	function appendTableHeaders() {
		$('#info-div').append('<div id="files-div" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">'+
							  '<table class="table">'+
							  '<thead><tr><th class="center v-center"></th><th class="v-center">'+$('#fileName').val()+'</th>'+
							  '<th class="center v-center">'+$('#fileSize').val()+'</th><th class="center v-center">'+$('#fileDate').val()+'</th></tr></thead>'+
							  '<tbody></tbody></table></div>');
	}
	
	function appendFileRow(rowIndex, file) {
		$('#info-div').find('table tbody').append('<tr rel="'+file.name+'"><td class="center v-center">'+rowIndex+'</td><td class="v-center">'+file.label+'</td><td class="center v-center">'+file.size+'</td><td class="center v-center">'+file.created_at+'</td></tr>');
	}
});