$(document).ready(function(){
	$('#language').val($('#lang_id').val());
	
	$('#language').on('change', function(){
		var lang = $(this).find('option:selected').attr('rel');
		window.location.href = '/' + lang + '/admin/articles';
	});
	
	$('#articles-table').on('click', '.article', function(){
		var articleId = $(this).attr('rel');
		$.ajax({
			url: '/admin/articles/getArticle/'+articleId,
			type: 'get',
			cache: false,
			dataType: 'json',
			beforeSend: function(){
				$('#editArticleModal').find('#modal-form').css('height', '0px').css('opacity', '0');
				$('#editArticleModal').modal('show');
			},
			success: function(article) {
				$('#editArticleModal').find('#modal-loader').hide();
				$('#edit-article-form #article-id').val(article.id);
				$('#edit-article-form #article-title').val(article.title);
				$('#edit-article-form #article-short-desc').val(article.short_desc);
				$('#edit-article-form #article-long-desc').val(article.long_desc);
				$('#editArticleModal').find('#modal-form').css('height', 'auto').animate({opacity: 1}, 400);
			},
			error: function(result) {
				$('#editArticleModal').modal('hide');
				bootbox.alert("An error occured. Please try again!");
			}
		})
		.done(function(){
			$('.container').find('button').attr('disabled', false);
			$('#articles-table tbody tr td').find('input:checkbox').attr('disabled', false);
		});
	});
	
	$('#modal-image-btn').on('click', function(){
		$('#modal-images').slideToggle();
	});
	
	$('#articles-table').on('change', '.carousel input', function(){
		$('.container').find('button').attr('disabled', true);
		$('#articles-table tbody tr td').find('input:checkbox').attr('disabled', true);
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
		})
		.done(function(){
			$('.container').find('button').attr('disabled', false);
			$('#articles-table tbody tr td').find('input:checkbox').attr('disabled', false);
		});
	});
	
	$('#articles-table').on('change', '.is-published input', function(){
		$('.container').find('button').attr('disabled', true);
		$('#articles-table tbody tr td').find('input:checkbox').attr('disabled', true);
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
		})
		.done(function(){
			$('.container').find('button').attr('disabled', false);
			$('#articles-table tbody tr td').find('input:checkbox').attr('disabled', false);
		});;
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