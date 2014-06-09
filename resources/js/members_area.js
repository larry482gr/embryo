var activeCategory = -1;
var activeLabel = '';
var fullScreenText = 'Full Screen';
var fullScreenGlyphicon = 'glyphicon glyphicon-fullscreen';
var fullScreenDisabled = false;
var infoCategoryId = '';

$(document).ready(function() {
	// $('.webtop-div').draggable().resizable();
	
	$('#expand-area').on('click', function() {
		if($(this).text() == 'Full Screen') {
			$('#webtop').hide().css('position', 'fixed').css('z-index', '1200').show('slow', function(){
				$('body').css('position', 'fixed').css('height', '100%');
			});
			fullScreenText = 'Minimize';
			fullScreenGlyphicon = 'glyphicon glyphicon-resize-small';
		}
		else {
			$('body').css('position', 'relative').css('height', 'auto');
			$('#webtop').hide().css('position', 'relative').css('z-index', '').show('slow');
			fullScreenText = 'Full Screen';
			fullScreenGlyphicon = 'glyphicon glyphicon-fullscreen';
		}
		
		$(this).html('<span class="'+fullScreenGlyphicon+'"></span>'+fullScreenText);
	});
	
	$('.category').on('dblclick', function() {
		if(!$(this).hasClass('opened')) {
			$(this).addClass('opened');
			$(this).find('div:first-child').removeClass().addClass('glyphicon glyphicon-folder-open');
		}
	});
	
	$('#trash-div').on('dblclick', '.trash-category', function() {
		if(!$(this).hasClass('opened')) {
			$(this).addClass('opened');
			$(this).find('div:first-child').removeClass().addClass('glyphicon glyphicon-folder-open');
		}
		
		selectedItems = [];
		$(this).find('div:last-child').css('background-color', '#FFFFFF').css('color', '#444444');
		if(selectedItems.length == 0) {
			$('.header-options').each(function() {
				if($(this).hasClass('visible'))
					$(this).removeClass('visible').hide().addClass('hidden');
			});
		}
	});
	
	var selectedItems = [];
	
	$('#trash-div .window-content').selectable({
		selected: function( event, ui ) {
			selectedItems = [];
			$(this).find('div').each(function() {
				id = $.trim($(this).attr('id'));
				if(id.length > 0 && $.inArray(id, selectedItems) == -1) {
					selectedItems.push(id);
				}
			});
			
			$.each(selectedItems, function(key, value) {
				$('#'+value).find('div:last-child').css('background-color', '#2A2A37').css('color', '#FFFFFF');
			});
			
			if(selectedItems.length > 0) {
				$('.header-options').each(function() {
					if($(this).hasClass('hidden'))
						$(this).removeClass('hidden').fadeIn('fast', function(){
							$(this).addClass('visible');
						});
				});
			}
		},
		unselected: function( event, ui ) {
			$(this).find('div').each(function() {
				id = $.trim($(this).attr('id'));
				$('#'+id).find('div:last-child').css('background-color', '#FFFFFF').css('color', '#444444');
				selectedItems.pop(id);
			});
			
			if(selectedItems.length == 0) {
				$('.header-options').each(function() {
					if($(this).hasClass('visible')) {
						$(this).removeClass('visible').fadeOut('fast', function(){
							$(this).addClass('hidden');
						});
					}
				});
			}
		}
	});
	
	
	
	$('#trash').on('dblclick', function() {
		if(!$(this).hasClass('opened')) {
			getDeletedItems();
			$(this).addClass('opened');
			$('#trash-div').show('fast');
			if($('#minimized').find('#trash-minimized').text().length > 0)
				$('#minimized').find('#trash-minimized').addClass('active');
			else
				$('#minimized').append('<button type="button" id="trash-minimized" class="btn btn-sm btn-default active" rel="trash">Trash</div>')
		}
	});
	
	$('#minimized').on('dblclick', 'button', function() {
		$(this).blur();
		elementId = '#'+$(this).attr('rel');
		divId = elementId+'-div';
		if($(divId).is(':hidden')) {
			$(divId).show('fast');
			$(elementId).addClass('opened');
			$('#minimized button').removeClass('active');
			$(this).addClass('active');
		}
		else if($(divId).is(':visible')) {
			$(this).blur();
			$(divId).hide('fast');
			$(elementId).removeClass('opened');
			$(this).removeClass('active');
		}
	});
	
	$('.webtop-div button.btn-danger').on('click', function() {
		id = '#' + $(this).attr('rel');
		$(this).parent().parent().parent().hide('fast');
		$('#minimized').find(id).remove();
		$('#trash').removeClass('opened');
	});
	
	$('.webtop-div button.btn-warning').on('click', function() {
		id = '#' + $(this).attr('rel');
		$(this).parent().parent().parent().hide('fast');
		$('#minimized').find(id).removeClass('active');
		$('#trash').removeClass('opened');
	});
	
	$('#webtop .panel-body').oncontextmenu = function() { return false; };

	$('.categories').on('mousedown', '.category', function(e) {
    	if( e.button == 2 ) {
    		var rel = $(this).attr('rel');
			activeCategory = rel.substring(0, rel.indexOf(':'));
			activeLabel = rel.substring(rel.indexOf(':') + 1);
			infoCategoryId = '.categories #cat'+activeCategory;
			return false;
		}
		return true;
	});
	
	$('#trash-div .window-content').on('mousedown', '.trash-category', function(e) {
    	if( e.button == 2 ) {
    		var rel = $(this).attr('rel');
			activeCategory = rel.substring(0, rel.indexOf(':'));
			activeLabel = rel.substring(rel.indexOf(':') + 1);
			infoCategoryId = '#trash-div .window-content #trash-cat'+activeCategory;
			return false;
		}
		return true;
	});
	
	$('#top-div').mousedown(function(e) {
    	if( e.button == 2 ) {
				$('.context-menu-list').next().prev().find('li:first-child').html('<span class="'+fullScreenGlyphicon+'"></span>'+fullScreenText);
			return false;
		}
		return true;
	});
	
	$('#empty-trash').on('click', function() {
		var trashCats = [];
		var trashFiles = [];
		$('#trash-div .window-content').find('div').each(function(){
			if($(this).hasClass('trash-category')) {
				rel = $(this).attr('rel');
				trashCats.push(rel.substring(0, rel.indexOf(':')));
			}
			else if($(this).hasClass('trash-file')) {
				rel = $(this).attr('rel');
				trashFiles.push(rel.substring(0, rel.indexOf(':')));
			}
		});
		
		totalItems = trashCats.length + trashFiles.length;
		bootbox.confirm('Are you sure you want to delete '+totalItems+' items?', function(result) {
			if(result) {
				if(trashCats.length > 0) {
					$.each(trashCats, function(key, value) {
						deleteCategory(value, '', 6);
					});
				}
				
				if(trashFiles.length > 0) {
					$.each(trashFiles, function(key, value) {
						deleteCategory(value, '', 6);
					});
				}
			}
		});
	});
	
	$('#remove-selected').on('click', function() {
		totalItems = selectedItems.length;
		totalItems = totalItems.length > 1 ? totalItems+' items' : totalItems+' item';
		bootbox.confirm('Are you sure you want to delete '+totalItems+'?', function(result) {
			if(result) {
				if(selectedItems.length > 0) {
					$.each(selectedItems, function(key, value) {
						deleteCategory(value, '', 6);
					});
				}
			}
		});
	});
	
	$('#restore-selected').on('click', function() {
		if(selectedItems.length > 0) {
			$.each(selectedItems, function(key, value) {
				if(value.indexOf('trash-cat') == 0)
					restoreCategory(value.substring(9), '', 4);
				else if(value.indexOf('trash-file') == 0)
					restoreFile(value.substring(10), '', 4);
				
			});
		}
	});
	
	$(function(){
	    $.contextMenu({
	        selector: '#top-div', 
	        callback: function(key, options) {
	        	switch(key) {
				    case "full_screen":
				        $('#expand-area').click();
				        fullScreenDisabled = !fullScreenDisabled;
				        break;
				    case "create_cat":
				        bootbox.prompt("Create New Folder", function(label) {
				        	if(label !== null && $.trim(label.length) == 0) {
				        		bootbox.alert("You should provide a label for the new folder");
				        		return false;
				        	}
							else if (label !== null) {
								createNewCategory(label);
							}
						});
				        break;
				    case "create_file":
				        bootbox.alert('Create File');
				        break;
				    default:
				    	$('#expand-area').click();
				}
	        },
	        items: {
	        	"full_screen": {name: fullScreenText, icon: 'fullscreen'},
	        	"full_screen_sep": "---------",
	            "create_cat": {name: 'New Folder', icon: 'folder-close'},
	            "create_file": {name: "New File", icon: 'file'},
	        }
	    });
	});
	
	$(function(){
	    $.contextMenu({
	        selector: '.category', 
	        callback: function(key, options) {
	            switch(key) {
				    case "rename":
				        bootbox.dialog({
				        	title: 'Rename "' + activeLabel + '"',
							message: '<div class="form-group"><input type="text" class="form-control" id="update-label" value="'+activeLabel+'" /></div>',
							buttons: {
								cancel: {
									label: "Cancel",
									className: "btn-default",
								},
								ok: {
									label: "OK",
									className: "btn-primary",
									callback: function() {
										updateCategory(activeCategory, $('#update-label').val(), 3);
									}
								}
							}
						});
				        break;
				    case "remove":
				        bootbox.confirm('Are you sure you want to delete "'+activeLabel+'"?', function(result) {
				        	if(result)
								deleteCategory(activeCategory, activeLabel, 5);
						});
				        break;
				    case "info":
				        getCategoryInfo(activeCategory);
				        break;
				    default:
				    	$('#expand-area').click();
				}
	        },
	        items: {
	            "rename": {name: "Rename", icon: "pencil"},
	            "remove": {name: "Move to Trash", icon: "remove"},
	            "sep1": "---------",
	            "info": {name: "Info", icon: "info-sign"}
	        }
	    });
	});
	
	$(function(){
	    $.contextMenu({
	        selector: '.trash-category', 
	        callback: function(key, options) {
	            switch(key) {
				    case "restore":
						restoreCategory(activeCategory, activeLabel, 4);
				        break;
				    case "info":
				        getCategoryInfo(activeCategory);
				        break;
				    default:
				    	$('#expand-area').click();
				}
	        },
	        items: {
	            "restore": {name: "Restore", icon: "share-alt"},
	            "sep1": "---------",
	            "info": {name: "Info", icon: "info-sign"}
	        }
	    });
	});
	
	function getDeletedItems() {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/getDeletedItems',
			type: 'post',
			cache: false,
			dataType: 'json',
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
	
	/*
	function getRestoredFileDiv(file) {
		return '<div id="trash-file'+file.id+'" class="trash-file col-lg-2 col-md-2 col-sm-4 col-xs-6" rel="'+file.id+':'+file.label+'">'+
				'<div class="glyphicon glyphicon-file"></div>'+
				'<div class="file-label">'+file.label+'</div>'+
			   '</div>';
	}
	*/
	
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
			},
			error: function(result) {
				bootbox.alert("Error restoring category!");
			}
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
				$(infoCategoryId).popover({trigger: 'click', html: true, content: catInfo.created+catInfo.updated+catInfo.totalFiles+catInfo.totalFileSize}).popover('show');
				$(infoCategoryId).on('click', function() {
					$(this).popover('destroy');
				});
			},
			error: function(result) {
				bootbox.alert("Error getting category info!");
			}
		});
	}
});