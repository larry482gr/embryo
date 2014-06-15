	var catDeleted = -1;
	
	function getDeletedItems() {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/getDeletedItems',
			type: 'post',
			cache: false,
			dataType: 'json',
			data: { catDeleted: catDeleted},
			success: function(items) {
				$('#trash-div .window-content').html('');
				if(items.categories) {
					categoriesSize = items.categories.length
					for(i = 0; i < categoriesSize; i++) {
						$('#trash-div .window-content').append(getDeletedCategoryDiv(items.categories[i]));
					}
				}
				if(items.files) {
					filesSize = items.files.length
					for(i = 0; i < filesSize; i++) {
						$('#trash-div .window-content').append(getDeletedFileDiv(items.files[i]));
					}
				}
			},
			error: function(result) {
				bootbox.alert("Error getting deleted items!");
			}
		})
		.done(function() {
			if(catDeleted != -1) {
				$('.control-buttons').find('button').addClass('disabled');
				$('#trash-back-btn').removeClass('disabled');
				$('#trash-front-btn').attr('rel', catDeleted);
			}
			catDeleted = -1;
			$('.header-options').each(function() {
				if($(this).hasClass('visible')) {
					$(this).removeClass('visible').addClass('hidden');
				}
			});
		});
	}
	
	function getDeletedCategoryDiv(category) {
		return '<div id="trash-cat'+category.id+'" class="trash-category col-lg-2 col-md-2 col-sm-4 col-xs-6" rel="'+category.id+':'+category.label+'">'+
				'<div class="glyphicon glyphicon-folder-close"></div>'+
				'<div class="category-label">'+category.labelHtml+'</div>'+
			   '</div>';
	}
	
	function getRestoredCategoryDiv(category) {
		return '<div id="cat'+category.id+'" class="category" rel="'+category.id+':'+category.label+'">'+
					'<div class="glyphicon glyphicon-folder-close"></div>'+
					'<div class="category-label">'+category.labelHtml+'</div>'+
				'</div>';
	}
	
	function getDeletedFileDiv(file) {
		return '<div id="trash-file'+file.id+'" class="trash-file col-lg-2 col-md-2 col-sm-4 col-xs-6" rel="'+file.id+':'+file.label+'">'+
				'<div class="glyphicon glyphicon-file"></div>'+
				'<div class="file-label">'+file.labelHtml+'</div>'+
			   '</div>';
	}
	
	function getFileDiv(file) {
		return '<div id="file'+file.id+'" class="file col-lg-2 col-md-2 col-sm-4 col-xs-6" rel="'+file.id+':'+file.label+'">'+
					'<div class="glyphicon glyphicon-file"></div>'+
					'<div class="file-label">'+file.labelHtml+'</div>'+
				'</div>';
	}
	
	function createNewCategory(label) {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/createCategory',
			type: 'post',
			cache: false,
			data: { label: label },
			dataType: 'json',
			success: function(cat) {
				$('.categories').append('<div id="cat'+cat.id+'" class="category" rel="'+cat.id+':'+cat.label+'"><div class="glyphicon glyphicon-folder-close"></div><div class="category-label">'+cat.labelHtml+'</div></div>');
			},
			error: function(result) {
				bootbox.alert("Error creating category!");
			}
		});
	}
	
	function updateCategory(id, label, toState) {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/updateCategory',
			type: 'post',
			cache: false,
			data: { id: id, label: label, toState: toState },
			dataType: 'json',
			success: function(cat) {
				$('.categories').find('#cat'+cat.id).attr('rel', cat.id+':'+cat.label);
				$('.categories').find('#cat'+cat.id).html('<div class="glyphicon glyphicon-folder-close"></div><div class="category-label">'+cat.labelHtml+'</div>');
			},
			error: function(result) {
				bootbox.alert("Error creating category!");
			}
		});
	}
	
	function deleteCategory(id, label, toState) {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/updateCategory',
			type: 'post',
			cache: false,
			data: { id: id, label: label, toState: toState },
			dataType: 'json',
			success: function(cat) {
				$('.categories').find('#cat'+cat.id).remove();
				$('#trash-div .window-content').append(getDeletedCategoryDiv(cat));
			},
			error: function(result) {
				bootbox.alert("Error creating category!");
			}
		});
	}
	
	function restoreCategory(id, label, toState) {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/updateCategory',
			type: 'post',
			cache: false,
			data: { id: id, label: label, toState: toState },
			dataType: 'json',
			success: function(cat) {
				$('#trash-div .window-content').find('#trash-cat'+cat.id).remove();
				$('.categories').append(getRestoredCategoryDiv(cat));
				$('.categories').find('.category').draggable({
						start: function() {
						$(this).css('z-index', getAndIncreaseWindowZ());
						var rel = $(this).attr('rel');
						activeCategory = rel.substring(0, rel.indexOf(':'));
						activeLabel = rel.substring(rel.indexOf(':') + 1);
						infoCategoryId = '.folder-content #cat'+activeCategory+'-div';
					}
				});
			},
			error: function(result) {
				bootbox.alert("Error restoring category!");
			}
		})
		.done(function() {
			$('.categories .category').draggable({
				scope: 'dropable',
				start: function() {
					$(this).css('z-index', getAndIncreaseWindowZ());
					var rel = $(this).attr('rel');
					activeCategory = rel.substring(0, rel.indexOf(':'));
					activeLabel = rel.substring(rel.indexOf(':') + 1);
					infoCategoryId = '.folder-content #cat'+activeCategory+'-div';
				}
			});
		});
	}
	
	function getCategoryInfo(id) {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/getCategoryInfo',
			type: 'post',
			cache: false,
			data: { id: id },
			dataType: 'json',
			success: function(catInfo) {
				$(infoCategoryId).popover({trigger: 'hover', html: true, content: catInfo.created+catInfo.updated+catInfo.totalFiles+catInfo.totalFileSize}).popover('show');
				
				$(infoCategoryId).on('hidden.bs.popover', function(e) {
					$(this).off('hidden.bs.popover');
					$(this).popover('destroy');
				});
			},
			error: function(result) {
				bootbox.alert("Error getting category info!");
			}
		});
	}
	
	function updateFile(id, label, toState) {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/updateFile',
			type: 'post',
			cache: false,
			data: { id: id, label: label, toState: toState },
			dataType: 'json',
			success: function(file) {
				$('.category-div').find('#file'+file.id).attr('rel', file.id+':'+file.label);
				$('.category-div').find('#file'+file.id).html('<div class="glyphicon glyphicon-file"></div><div class="file-label">'+file.labelHtml+'</div>');
			},
			error: function(result) {
				bootbox.alert("Error creating category!");
			}
		});
	}
	
	function deleteFile(id, label, toState) {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/updateFile',
			type: 'post',
			cache: false,
			data: { id: id, label: label, toState: toState },
			dataType: 'json',
			success: function(file) {
				$('.category-div').find('#file'+file.id).remove();
				$('#trash-div .window-content').append(getDeletedFileDiv(file));
			},
			error: function(result) {
				bootbox.alert("Error deleting file!");
			}
		});
	}
	
	function restoreFile(id, label, toState) {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/updateFile',
			type: 'post',
			cache: false,
			data: { id: id, label: label, toState: toState },
			dataType: 'json',
			success: function(file) {
				$('#trash-div .window-content').find('#trash-file'+file.id).remove();
				$('.folder-content #cat'+file.category_id+'-div .window-content').append(getFileDiv(file));
			},
			error: function(result) {
				bootbox.alert("Error restoring category!");
			}
		})
		.done(function(){
			$('.file').draggable({
				appendTo: '#top-div',
				scope: 'dropable',
				revert: 'invalid',
				helper: 'clone',
				scroll: false,
				zIndex: 2000,
				start: function() {
					$(this).hide();
					// $(this).parent().css('overflow', 'hidden');
					$(this).css('z-index', getAndIncreaseWindowZ());
					var rel = $(this).attr('rel');
					activeFile = rel.substring(0, rel.indexOf(':'));
					activeLabel = rel.substring(rel.indexOf(':') + 1);
					infoCategoryId = '.folder-content #file'+activeFile;
				},
				stop: function() {
					$(this).show();
					// $(this).parent().css('overflow', 'auto');
				}
			});
		});
	}
	
	function getFileInfo(id) {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/getFileInfo',
			type: 'post',
			cache: false,
			data: { id: id },
			dataType: 'json',
			success: function(fileInfo) {
				$(infoFileId).popover({trigger: 'hover', html: true, content: fileInfo.created+fileInfo.updated+fileInfo.filesize}).popover('show');
				
				$(infoFileId).on('hidden.bs.popover', function(e) {
					$(this).off('hidden.bs.popover');
					$(this).popover('destroy');
				});
			},
			error: function(result) {
				bootbox.alert("Error getting file info!");
			}
		});
	}
	
	function addNewWindow(id, label) {
		var newWindow = '<div id="cat'+id+'-div" class="webtop-div category-div filedrag-div col-lg-12 col-md-12 col-sm-12 col-xs-12" rel="'+id+':'+label+'">'+
					      	'<div class="window-header row">'+
					      	  '<div class="pull-left">'+
					      	  	'<h4>'+
					      	  		label+
					      	  		'<small id="open-selected" class="header-options hidden">Open Selected Items</small>'+
					      	  		'<small id="remove-selected" class="header-options hidden">Delete Selected Items</small>'+
					      	  	'</h4>'+
					      	  '</div>'+
					      	  '<div class="pull-right">'+
					      	  	'<button type="button" class="btn btn-xs btn-warning" rel="cat'+id+'-minimized"><span class="glyphicon glyphicon-minus"></span></button>'+
					      	  	'<button type="button" class="btn btn-xs btn-danger" rel="cat'+id+'-minimized"><span class="glyphicon glyphicon-remove"></span></button>'+
					      	  '</div>'+
					      	'</div>'+
					      	'<div class="window-content row">'+
					      	'</div>'+
					      '</div>';
		$('.folder-content').append(newWindow);
	}
	
	function getWindowFiles(id) {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/getCategoryFiles',
			type: 'post',
			cache: false,
			dataType: 'json',
			data: { categoryId: id },
			success: function(items) {
				$('.folder-content #cat'+id+'-div .window-content').html('');
				if(items.files) {
					filesSize = items.files.length
					for(i = 0; i < filesSize; i++) {
						$('.folder-content #cat'+id+'-div .window-content').append(getFileDiv(items.files[i]));
					}
				}
			},
			error: function(result) {
				bootbox.alert("Error getting deleted items!");
			}
		})
		.done(function(){
			$('.file').draggable({
				appendTo: '#top-div',
				scope: 'dropable',
				revert: 'invalid',
				helper: 'clone',
				scroll: false,
				zIndex: 2000,
				start: function() {
					$(this).hide();
					// $(this).parent().css('overflow', 'hidden');
					$(this).css('z-index', getAndIncreaseWindowZ());
					var rel = $(this).attr('rel');
					activeFile = rel.substring(0, rel.indexOf(':'));
					activeLabel = rel.substring(rel.indexOf(':') + 1);
					infoCategoryId = '.folder-content #file'+activeFile;
				},
				stop: function() {
					$(this).show();
					// $(this).parent().css('overflow', 'auto');
				}
			});
		});
	}
	
	function getAndIncreaseWindowZ() {
		return ++windowZ;
	}