var smallImage = '';
var smallImageType = '';
var carouselImage = '';
var carouselImageType = '';

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
				$('#modal-form .article-id').val(article.id);
				$('#edit-article-form #article-title').val(article.title);
				$('#edit-article-form #article-short-desc').val(article.short_desc);
				$('#edit-article-form #article-long-desc').val(article.long_desc);
				$('.cke_contents iframe').contents().find("body").html(article.long_desc);
				$('#edit-article-form #article-source-label').val(article.source_label);
				$('#edit-article-form #article-source-link').val(article.source_link);
				$('#edit-article-form #article-carousel-label').val(article.carousel_label);
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
	
	$('#articles-table').on('change', '.carousel input', function() {
		$('.container').find('button').attr('disabled', true);
		$('#articles-table tbody tr td').find('input:checkbox').attr('disabled', true);
		var articleId = $(this).attr('rel');
		var showOnCarousel = $(this).is(':checked') ? 1 : 0;
		var lang_id = $('#lang_id').val();
		
		$.ajax({
			url: '/admin/articles/updateCarousel',
			type: 'post',
			cache: false,
			data: { articleId: articleId, showOnCarousel: showOnCarousel, langId: lang_id },
			dataType: 'text',
			success: function(result) {
				if(result == 1)
					// bootbox.alert("Carousel successfully updated.");
					window.location.href = '/'+$('#lang').val()+'/admin/articles';
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
	
	$('#articles-table').on('change', '.carousel-drop-down', function() {
		if($(this).val() != $(this).next().val())
			$(this).parent().next().html('<span class="glyphicon glyphicon-ok-sign"></span>');
		else
			$(this).parent().next().html('');
	});
	
	$('#articles-table').on('click', '.submit-position span', function() {
		$(this).parent().parent().submit();
	});
		
	$('#articles-table').on('change', '.is-published input', function() {
		$('.container').find('button').attr('disabled', true);
		$('#articles-table tbody tr td').find('input:checkbox').attr('disabled', true);
		var articleId = $(this).attr('rel');
		var isPublished = $(this).is(':checked') ? 1 : 0;
		var _this = $(this);
		
		$.ajax({
			url: '/admin/articles/updatePublished',
			type: 'post',
			cache: false,
			data: { articleId: articleId, isPublished: isPublished },
			dataType: 'text',
			success: function(result) {
				if(result != 0) {
					bootbox.alert("Article successfully updated.");
					if(result != 1)
						$('#articles-table').find('#article-published-'+articleId).html(result);
				}
				else {
					if(_this.is(':checked'))
						_this.attr('checked', false);
					else
						_this.attr('checked', true);
						
					bootbox.alert("Proceedure finished successfully, but an error occured. Please try again! (Server response: " + result + ")");
				}
			},
			error: function(result) {
				if(_this.is(':checked'))
					_this.attr('checked', false);
				else
					_this.attr('checked', true);
					
				bootbox.alert("Proceedure finished unexpectidly. Please try again! (Server response: " + result + ")");
			}
		})
		.done(function() {
			$('.container').find('button').attr('disabled', false);
			$('#articles-table tbody tr td').find('input:checkbox').attr('disabled', false);
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
			beforeSend: function() {
				$('#articles-table tbody').animate({opacity: 0.2}, 350);
			},
			success: function(result) {
				$('#articles-table tbody').html('');
				
				for(i = 0; i < result.articles.length; i++)
					$('#articles-table tbody').append(getTableRow(i+1, result.articles[i], result.carousel_max));
				
				$('#articles-table tbody').animate({opacity: 1}, 350);
			},
			error: function(result) {
				bootbox.alert("An error occured. Please try again!");
			}
		});
	});
	
	function getTableRow(i, article, carousel_max) {
		var carouselChecked = article.carousel == 1 ? 'checked="checked"' : '';
		var carouselPotition = article.carousel == 1 ? getCarouselDropDown(article.id, article.carousel_position, carousel_max) : $('#not-shown').val();
		var publishedChecked = article.is_published == 1 ? 'checked="checked"' : '';
		var publishedAt = (article.published_at == null || article.published_at.length == 0) ? $('#never').val() : article.published_at;
		var tableRow = '<tr>'+
						'<td class="article" rel="'+article.id+'">'+i+'</td>'+
						'<td class="article" id="article-title-'+article.id+'" rel="'+article.id+'">'+article.title+'</td>'+
						'<td class="carousel"><input type="checkbox" rel="'+article.id+'" '+carouselChecked+' /></td>'+
						'<td class="carousel_position">'+carouselPotition+'</td>'+
						'<td class="is-published"><input type="checkbox" rel="'+article.id+'" '+publishedChecked+' /></td>'+
						'<td id="article-published-'+article.id+'">'+publishedAt+'</td>'+
						'</tr>';
		return tableRow;
	}
	
	function getCarouselDropDown(article_id, carousel_position, carousel_max) {
		var drop_down_options = '';
		for(j = 1; j <= carousel_max; j++) {
			var selected = j == carousel_position ? 'selected="selected"' : '';
			drop_down_options += '<option '+selected+'>'+j+'</option>';
		}
		var drop_down = '<form role="form" class="form-inline" method="post" action="/'+$('#lang').val()+'/admin/articles/updatePosition/'+article_id+'">'+
							'<div class="form-group">'+
							'<select class="carousel-drop-down" name="new_position">'+
							drop_down_options+
							'</select>'+
							'<input type="hidden" name="old_position" value="'+carousel_position+'" />'+
							'</div>'+
							'<div class="form-group submit-position">'+
							'</div>';
							'</form>';
		
		return drop_down;
	}
	
	$('#add-new-article').on('click', function(){
		$('#new-article-title').val('');
		$('#new-article-short-desc').val('');
		$('#new-article-long-desc').val('');
		$('#new-article-source-label').val('');
		$('#new-article-source-link').val('');
		$('#new-article-carousel-label').val('');
		$('#new-article-long-desc').next().find('iframe').contents().find("body").html('');
		$('#addArticleModal').modal('show');
	});
	
	$('#add-article').on('click', function() {
		$('#new-article-long-desc').val($('.cke_contents iframe').contents().find("body").html());
		var lang_id = $('#lang_id').val();
		var articleTitle = $('#new-article-title').val();
		var articleShortDesc = $('#new-article-short-desc').val();
		var articleLongDesc = $('#new-article-long-desc').val();
		var articleSourceLabel = $('#new-article-source-label').val();
		var articleSourceLink = $('#new-article-source-link').val();
		var articleCarouselLabel = $('#new-article-carousel-label').val();
		
		if($.trim(articleTitle).length == 0 || $.trim(articleShortDesc).length == 0) {
			$('#addArticleModal').modal('hide');
			bootbox.alert('You should provide at least article\'s "Title" and "First Paragraph" fields.');
			return;
		}
		else {
			$.ajax({
				url: '/admin/articles/create',
				type: 'post',
				cache: false,
				data: {
					lang_id: lang_id,
					articleTitle: articleTitle,
					articleShortDesc: articleShortDesc,
					articleLongDesc: articleLongDesc,
					articleSourceLabel: articleSourceLabel,
					articleSourceLink: articleSourceLink,
					articleCarouselLabel: articleCarouselLabel
				},
				dataType: 'text',
				success: function(result) {
					$('#addArticleModal').modal('hide');
					if(result != 'error') {
						$('#articles-table tbody tr').each(function(){
							element = $(this).find('td:first-child');
							element.html(parseInt(element.html())+1);
						});
						
						var articleId = result.substring(0, result.indexOf('*::*'));
						var articleTitle = result.substring(result.indexOf('*::*')+4);
						var tableRow = '<tr>'+
										'<td class="article" rel="'+articleId+'">1</td>'+
										'<td class="article" id="article-title-'+articleId+'" rel="'+articleId+'">'+articleTitle+'</td>'+
										'<td class="carousel"><input type="checkbox" rel="'+articleId+'" /></td>'+
										'<td class="carousel_position">'+$('#not-shown').val()+'</td>'+
										'<td class="is-published"><input type="checkbox" rel="'+articleId+'"  /></td>'+
										'<td id="article-published-'+articleId+'">'+$('#never').val()+'</td>'+
									   '</tr>';
									   
						$('#articles-table tbody').prepend(tableRow);
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
	});
	
	$('#update-article').on('click', function(){
		var articleLongDesc = $('#article-long-desc').next().find('iframe').contents().find("body").html();
		var articleId = $('.article-id').val();
		var articleTitle = $('#article-title').val();
		var articleShortDesc = $('#article-short-desc').val();
		// var articleLongDesc = $('#article-long-desc').val();
		var articleSourceLabel = $('#article-source-label').val();
		var articleSourceLink = $('#article-source-link').val();
		var articleCarouselLabel = $('#article-carousel-label').val();
		
		$.ajax({
			url: '/admin/articles/edit',
			type: 'post',
			cache: false,
			data: {
				articleId: articleId,
				articleTitle: articleTitle,
				articleShortDesc: articleShortDesc,
				articleLongDesc: articleLongDesc,
				articleSourceLabel: articleSourceLabel,
				articleSourceLink: articleSourceLink,
				articleCarouselLabel: articleCarouselLabel
			},
			dataType: 'text',
			success: function(result) {
				$('#editArticleModal').modal('hide');
				if(result != 'error') {
					$('#article-title-'+articleId).html(result);
				}
				else {
					bootbox.alert("An error occured. Please try again!");
				}
			},
			error: function(result) {					
				bootbox.alert("An error occured. Please try again!");
			}
		});
	});
	
	var options = {
		success: function(result) {
			$('#editArticleModal').modal('hide');
			showImageResult(result);
		},
		error: function(result) {
			$('#editArticleModal').modal('hide');
			bootbox.alert('<span style="color:#AA0000;">ERROR: unable to upload file.</span>');
		}
	};
	
	$("#small-image-form").ajaxForm(options);
	$("#carousel-image-form").ajaxForm(options);
					
	$("#small-image").change(function() {
		smallImage = this.files[0];
		smallImageType = smallImage.type;
	});
	
	$("#carousel-image").change(function() {
		carouselImage = this.files[0];
		carouselImageType = carouselImage.type;
	});
	
	$('#update-small-image').on('click', function() {
		if(smallImageType == 'image/png' || smallImageType == 'image/jpg' || smallImageType == 'image/jpeg') {
			$('#small-image-form').submit();
		}
		else {
			bootbox.alert('Please check the file types allowed.');
		}
	});
	
	$('#update-carousel-image').on('click', function() {
		if(carouselImageType == 'image/png' || carouselImageType == 'image/jpg' || carouselImageType == 'image/jpeg') {
			$('#carousel-image-form').submit();
		}
		else {
			bootbox.alert('Please check the file types allowed.');
		}
	});
	
	function showImageResult(result) {
		switch (result) {
			case '0':
				bootbox.alert('<span style="color:#00AA00;">File successfully uploaded.</span>');
				break;
			case '1':
				bootbox.alert('<span style="color:#AA0000;">ERROR: undefined file type (carousel/small).</span>');
				break;
			case '2':
				bootbox.alert('<span style="color:#AA0000;">ERROR: image error. Maybe the file is corrupted.</span>');
				break;
			case '3':
				bootbox.alert('<span style="color:#AA0000;">ERROR: make sure that the file\'s type is allowed and it is smaller than 2 MB.</span>');
				break;
			default:
				bootbox.alert('<span style="color:#00AA00;">File successfully uploaded.</span>');
				break;
		}
	}
	
	CKEDITOR.replace( 'new-article-long-desc' );
	CKEDITOR.replace( 'article-long-desc' );
	
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