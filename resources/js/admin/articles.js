$(document).ready(function(){
	$('#language').val($('#lang_id').val());
	
	$('#articles-table').on('change', '.carousel input', function(){
		var articleId = $(this).attr('rel');
		var showOnCarousel = $(this).is(':checked') ? 1 : 0;
		
		$.ajax({
			url: '/admin/articles/updateCarousel',
			type: 'post',
			cache: false,
			data: { articleId: articleId, showOnCarousel: showOnCarousel },
			dataType: 'text',
			success: function(result) {
				if(result == 1)
					bootbox.alert("Carousel successfully updated.");
				else {
					if($(this).is(':checked'))
						$(this).attr('checked', false);
					else
						$(this).attr('checked', true);
						
					bootbox.alert("An error occured. Please try again!");
				}
			},
			error: function(result) {
				if($(this).is(':checked'))
					$(this).attr('checked', false);
				else
					$(this).attr('checked', true);
					
				bootbox.alert("An error occured. Please try again!");
			}
		});
	});
	
	$('#articles-table').on('change', '.is-published input', function(){
		var articleId = $(this).attr('rel');
		var isPublished = $(this).is(':checked') ? 1 : 0;
		
		$.ajax({
			url: '/admin/articles/updatePublished',
			type: 'post',
			cache: false,
			data: { articleId: articleId, isPublished: isPublished },
			dataType: 'text',
			success: function(result) {
				if(result == 1)
					bootbox.alert("Article successfully updated.");
				else {
					if($(this).is(':checked'))
						$(this).attr('checked', false);
					else
						$(this).attr('checked', true);
						
					bootbox.alert("An error occured. Please try again!");
				}
			},
			error: function(result) {
				if($(this).is(':checked'))
					$(this).attr('checked', false);
				else
					$(this).attr('checked', true);
					
				bootbox.alert("An error occured. Please try again!");
			}
		});
	});
	
	$('#show-unpublished-btn').on('click', function(){
		var lang_id = $('#lang_id').val();
		var showUnpublished = $('#show-unpublished').val() == 0 ? 1 : 0;
		$('#show-unpublished').val(showUnpublished);
		$(this).text(showUnpublished == 1 ? $('#hide-unpublished-label').val() : $('#show-unpublished-label').val());
		
		$.ajax({
			url: '/admin/articles/getArticles',
			type: 'post',
			cache: false,
			data: { lang_id: lang_id, showUnpublished: showUnpublished },
			dataType: 'json',
			beforeSend: function(){
				
			},
			success: function(result) {
				var tableRows = '';
				$('#articles-table tbody').animate({opacity: 0.0}, 250, function(){
					for(i = 0; i < result.length; i++) {
						tableRows += getTableRow(i+1, result[i]);
					}
					$('#articles-table tbody').html(tableRows);
					$('#articles-table tbody').animate({opacity: 1}, 350);
				});
			},
			error: function(result) {
				bootbox.alert("An error occured. Please try again!");
			}
		});
	});
	
	function getTableRow(i, article) {
		var carouselChecked = article.carousel == 1 ? 'checked="checked"' : '';
		var publishedChecked = article.is_published == 1 ? 'checked="checked"' : '';
		var tableRow = '<tr>'+
						'<td class="article" rel="'+article.id+'">'+i+'</td>'+
						'<td class="article" rel="'+article.id+'">'+article.title+'</td>'+
						'<td class="carousel"><input type="checkbox" rel="'+article.id+'" '+carouselChecked+' /></td>'+
						'<td class="is-published"><input type="checkbox" rel="'+article.id+'" '+publishedChecked+' /></td>'+
						'<td>'+article.published_at+'</td>'+
						'</tr>';
		return tableRow;
	}
});