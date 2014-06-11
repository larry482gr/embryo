var activeCategory = -1;
var activeLabel = '';
var fullScreenText = 'Full Screen';
var fullScreenGlyphicon = 'glyphicon glyphicon-fullscreen';
var fullScreenDisabled = false;
var infoCategoryId = '';
var windowZ = 1300;
var activeTabs = [];
var newFileType = '';

$(document).ready(function() {
	// $('.webtop-div').draggable().resizable();
	
	$('#expand-area').on('click', function() {
		if($(this).text() == 'Full Screen') {
			$('#webtop').hide().css('position', 'fixed').css('z-index', '1200').show('slow', function(){
				$('body').css('position', 'fixed').css('height', '100%');
			});
			fullScreenText = 'Minimize';
			fullScreenGlyphicon = 'glyphicon glyphicon-off';
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
		
		rel = $(this).attr('rel');
		id = rel.substring(0, rel.indexOf(':'));
		label = rel.substring(rel.indexOf(':')+1);
		
		$('#minimized').find('button').removeClass('active');
		if($('#minimized').find('#cat'+id+'-minimized').text().length > 0) {
			$('#minimized').find('#cat'+id+'-minimized').addClass('active');
			activeTabs.push('#cat'+id+'-minimized');
		}
		else {
			addNewWindow(id, label);
			$('#minimized').append('<button type="button" id="cat'+id+'-minimized" class="btn btn-sm btn-default active" rel="cat'+id+'">'+label+'</div>');
			activeTabs.push('#cat'+id+'-minimized');
		}
		$('.folder-content').find('#cat'+id+'-div').css('z-index', getAndIncreaseWindowZ()).show('fast');
		$('.folder-content').find('#cat'+id+'-div').find('div').css('z-index', getAndIncreaseWindowZ());
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
				if($(this).hasClass('ui-selected')) {
					id = $.trim($(this).attr('id'));
					if(id.length > 0 && $.inArray(id, selectedItems) == -1) {
						selectedItems.push(id);
					}
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
				if(!$(this).hasClass('ui-selected')) {
					id = $.trim($(this).attr('id'));
					$('#'+id).find('div:last-child').css('background-color', '#FFFFFF').css('color', '#444444');
					selectedItems.pop(id);
				}
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
		$('#trash-div').css('z-index', getAndIncreaseWindowZ());
		$('#trash-div').find('div').css('z-index', getAndIncreaseWindowZ());
		if(!$(this).hasClass('opened')) {
			getDeletedItems();
			$(this).addClass('opened');
			$('#trash-div').show('fast');
			$('#minimized').find('button').removeClass('active');
			if($('#minimized').find('#trash-minimized').text().length > 0) {
				$('#minimized').find('#trash-minimized').addClass('active');
				activeTabs.push('#trash-minimized');
			}
			else {
				$('#minimized').append('<button type="button" id="trash-minimized" class="btn btn-sm btn-default active" rel="trash">Trash</div>');
				activeTabs.push('#trash-minimized');
			}
		}
	});
	
	$('#minimized').on('click', 'button', function() {
		$(this).blur();
		webtopentId = '#'+$(this).attr('rel');
		divId = webtopentId+'-div';
		if($(divId).is(':hidden')) {
			$(divId).css('z-index', getAndIncreaseWindowZ()).show('fast');
			$(divId).find('div').css('z-index', getAndIncreaseWindowZ());
			$(webtopentId).addClass('opened');
			$('#minimized button').removeClass('active');
			$(this).addClass('active');
			activeTabs.push('#'+$(this).attr('id'));
			if(webtopentId.indexOf('cat') > 0) {
				// $('.categories').find('.category').removeClass('opened');
				// $('.categories').find('.category').find('div:first-child').removeClass().addClass('glyphicon glyphicon-folder-close');
				$(webtopentId).addClass('opened');
				$(webtopentId).find('div:first-child').removeClass().addClass('glyphicon glyphicon-folder-open');
			}
		}
		else if($(divId).is(':visible')) {
			if(!$(this).hasClass('active')) {
				$('#minimized button').removeClass('active');
				$(divId).css('z-index', getAndIncreaseWindowZ());
				$(divId).find('div').css('z-index', getAndIncreaseWindowZ());
				$(webtopentId).addClass('opened');
				$(this).addClass('active');
				activeTabs.push('#'+$(this).attr('id'));
				if(webtopentId.indexOf('cat') > 0) {
					$(webtopentId).addClass('opened');
					$(webtopentId).find('div:first-child').removeClass().addClass('glyphicon glyphicon-folder-open');
				}
			}
			else {
				$(divId).hide('fast');
				$(webtopentId).removeClass('opened');
				$(this).removeClass('active');
				activeTabs.pop();
				if(activeTabs.length > 0) {
					divId = activeTabs[activeTabs.length-1].substring(0, activeTabs[activeTabs.length-1].indexOf('-'))+'-div';
					if($(''+divId).is(':visible'))
						$('#minimized').find('button'+activeTabs[activeTabs.length-1]).addClass('active');
				}
				if(webtopentId.indexOf('cat') > 0) {
					$(webtopentId).removeClass('opened');
					$(webtopentId).find('div:first-child').removeClass().addClass('glyphicon glyphicon-folder-close');
				}
			}
		}
		
		/*
		var tabs = '';
		$.each(activeTabs, function(key, value){
			tabs += key+' - '+value;
		});
		bootbox.alert(tabs);
		*/
	});
	
	$('.folder-content').on('click', '.webtop-div button.btn-danger', function() {
		id = '#' + $(this).attr('rel');
		$(this).parent().parent().parent().hide('fast');
		$('#minimized').find(id).remove();
		$('#trash').removeClass('opened');
		if(id.indexOf('cat') > 0) {
			catId = id.substring(0, id.indexOf('-'));
			$(catId).removeClass('opened');
			$(catId).find('div:first-child').removeClass().addClass('glyphicon glyphicon-folder-close');
		}
	});
	
	$('.folder-content').on('click', '.webtop-div button.btn-warning', function() {
		id = '#' + $(this).attr('rel');
		$(this).parent().parent().parent().hide('fast');
		$('#minimized').find(id).removeClass('active');
		$('#trash').removeClass('opened');
		if(id.indexOf('cat') > 0) {
			catId = id.substring(0, id.indexOf('-'));
			$(catId).removeClass('opened');
			$(catId).find('div:first-child').removeClass().addClass('glyphicon glyphicon-folder-close');
		}
	});

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
	
	$('.folder-content').on('mousedown', '.category-div', function(e) {
    	if( e.button == 2 ) {
    		var rel = $(this).attr('rel');
			activeCategory = rel.substring(0, rel.indexOf(':'));
			activeLabel = rel.substring(rel.indexOf(':') + 1);
			infoCategoryId = '.folder-content #cat'+activeCategory+'-div';
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
		if(totalItems > 0) {
			totalItems = totalItems > 1 ? totalItems+' items' : totalItems+' item';
			bootbox.confirm('Are you sure you want to delete '+totalItems+'?', function(result) {
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
		}
		else
			bootbox.alert('No items to remove.');
	});
	
	$('#remove-selected').on('click', function() {
		totalItems = selectedItems.length;
		if(totalItems > 0) {
			totalItems = totalItems > 1 ? totalItems+' items' : totalItems+' item';
			bootbox.confirm('Are you sure you want to delete '+totalItems+'?', function(result) {
				if(result) {
					if(selectedItems.length > 0) {
						$.each(selectedItems, function(key, value) {
							deleteCategory(value, '', 6);
						});
						selectedItems = [];
						$('.header-options').each(function() {
							if($(this).hasClass('visible'))
								$(this).removeClass('visible').hide().addClass('hidden');
						});
					}
				}
			});
		}
		else
			bootbox.alert('No items selected.');
	});
	
	$('#restore-selected').on('click', function() {
		if(selectedItems.length > 0) {
			$.each(selectedItems, function(key, value) {
				if(value.indexOf('trash-cat') >= 0) {
					id = value.substring(9);
					trashCatDiv = $('#trash-div .window-content').find('#trash-cat'+id);
					rel = trashCatDiv.attr('rel');
					label = rel.substring(rel.indexOf(':')+1);
					restoreCategory(id, label, 4);
				}
				else if(value.indexOf('trash-file') == 0) {
					id = value.substring(9);
					trashFileDiv = $('#trash-div .window-content').find('#trash-file'+id);
					rel = trashFileDiv.attr('rel');
					label = rel.substring(rel.indexOf(':')+1);
					restoreFile(id, label, 4);
				}
			});
			selectedItems = [];
			$('.header-options').each(function() {
				if($(this).hasClass('visible'))
					$(this).removeClass('visible').hide().addClass('hidden');
			});
		}
		else
			bootbox.alert('No items selected.');
	});
	
	$('.folder-content').on('dblclick', '.category-div .window-content .file', function() {
		rel = $(this).attr('rel');
		fileLink = '/resources/files/members_area/'+rel.substring(rel.indexOf(':')+1);
		window.open(fileLink, '_blank');
	});
	
	// Disable right click browser menu.
	$('#webtop .panel-body').oncontextmenu = function() { return false; };
	
	$(function(){
	    $.contextMenu({
	        selector: '.categories .category',
	        build: function($trigger, e) {
				return {
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
						}
			        },
			        items: {
			            "rename": {name: "Rename", icon: "pencil"},
			            "remove": {name: "Move to Trash", icon: "remove"},
			            "sep1": "---------",
			            "info": {name: "Info", icon: "info-sign"}
			        }
			    }
			}
		});
	});
	
	$(function(){
	    $.contextMenu({
	        selector: '.category-div',
	        build: function($trigger, e) {
				return {
			        callback: function(key, options) {
			            switch(key) {
						    case "create_file":
						        $('#newFileModal').modal('show');
						        $('#new-file-cat').val(activeCategory);
						        break;
						    case "info":
						        getCategoryInfo(activeCategory);
						        break;
						}
			        },
			        items: {
			            "create_file": {name: "New File", icon: 'file'},
			            "sep1": "---------",
			            "info": {name: "Info", icon: "info-sign"}
			        }
			    }
			}
	    });
	});
	
	$(function(){
	    $.contextMenu({
	        selector: '#trash-div',
	        build: function($trigger, e) {
				return {
			        callback: function(key, options) {
			            switch(key) {
						    case "empty-trash":
						    	$('#trash-div .window-header').find('#empty-trash').click();
						        break;
						    case "remove":
						        $('#trash-div .window-header').find('#remove-selected').click();
						        break;
						    case "restore":
						        $('#trash-div .window-header').find('#restore-selected').click();
						        break;
						}
			        },
			        items: {
			            "empty-trash": {name: "Empty Trash", icon: "ban-circle"},
			            "sep1": "---------",
			            "remove": {name: "Delete Selected Items", icon: "remove-circle"},
			            "restore": {name: "Restore Selected Items", icon: "share-alt"},
			        }
			    }
			}
	    });
	});
	
	$(function(){
	    $.contextMenu({
	        selector: '.trash-category',
	        build: function($trigger, e) {
				return {
			        callback: function(key, options) {
			            switch(key) {
						    case "restore":
								restoreCategory(activeCategory, activeLabel, 4);
						        break;
						    case "info":
						        getCategoryInfo(activeCategory);
						        break;
						}
			        },
			        items: {
			            "restore": {name: "Restore", icon: "share-alt"},
			            "sep1": "---------",
			            "info": {name: "Info", icon: "info-sign"}
			        }
			    }
			}
	    });
	});
	
	$(function(){
	    $.contextMenu({
	        selector: '#top-div',
	        build: function($trigger, e) {
				return {
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
						}
			        },
			        items: {
			        	"full_screen": {name: fullScreenText, icon: 'fullscreen'},
			        	"sep1": "---------",
			            "create_cat": {name: 'New Folder', icon: 'folder-close'},
			            "create_file": {name: "New File", icon: 'file'},
			        }
			    }
			}
	    });
	});
	
	var options = {
		beforeSend: function() {
			$("#progress").show();
			$("#bar").width("0%");
			$("#percent").html("0%");
		},
		uploadProgress: function(event, position, total, percentComplete) {
			$("#bar").width(percentComplete+"%");
			$("#percent").html(percentComplete+"%");
		},
		success: function(result) {
			file = JSON.parse(result);
			$("#bar").width("100%");
			$("#percent").html("100%");
			$(".folder-content #cat"+file.category_id+"-div .window-content").append(getNewFileDiv(file));
			$('#newFileModal').modal('hide');
		},
		error: function() {
			$("#message").html("<font color=\'red\'> ERROR: unable to upload files</font>");
		}
	};
	
	$("#new-file-form").ajaxForm(options);
						
	$("#new-file").change(function() {
		newFile = this.files[0];
		newFileType = newFile.type;
	});
	
	$('#upload-file').on('click', function() {
		if(newFileType == 'application/pdf' || newFileType == 'application/msword' || newFileType == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document') {
			$('#new-file-form').submit();
		}
		else {
			bootbox.alert('Please check the file types allowed.');
		}
	});
	
	function getNewFileDiv(file) {
		return '<div id="file'+file.id+'" class="file col-lg-2 col-md-2 col-sm-4 col-xs-6" rel="'+file.id+':'+file.label+'">'+
					'<div class="glyphicon glyphicon-file"></div>'+
					'<div class="file-label">'+file.labelHtml+'</div>'+
				'</div>';
	}
	
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
	
	function addNewWindow(id, label) {
		var newWindow = '<div id="cat'+id+'-div" class="webtop-div category-div row col-lg-12 col-md-12 col-sm-12 col-xs-12" rel="'+id+':'+label+'">'+
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
	
	function getAndIncreaseWindowZ() {
		return ++windowZ;
	}
});