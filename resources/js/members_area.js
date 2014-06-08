var activeCategory = -1;
var activeCategory = '';
var fullScreenText = 'Full Screen';
var fullScreenGlyphicon = 'glyphicon glyphicon-fullscreen';
var fullScreenDisabled = false;

$(document).ready(function() {
	// $('.webtop-div').draggable().resizable();
	
	$('#expand-area').on('click', function() {
		if($(this).text() == 'Full Screen') {
			$('#webtop').hide().css('position', 'fixed').css('z-index', '1200').show('slow');
			fullScreenText = 'Minimize';
			fullScreenGlyphicon = 'glyphicon glyphicon-resize-small';
		}
		else {
			$('#webtop').hide().css('position', 'relative').css('z-index', '').show('slow');
			fullScreenText = 'Full Screen';
			fullScreenGlyphicon = 'glyphicon glyphicon-fullscreen';
		}
		
		$(this).html('<span class="'+fullScreenGlyphicon+'"></span>'+fullScreenText);
	});
	
	$('.category').on('dblclick', function(){
		if(!$(this).hasClass('opened')) {
			$(this).addClass('opened');
			$(this).find('div:first-child').removeClass().addClass('glyphicon glyphicon-folder-open');
		}
	});
	
	$('#trash').on('dblclick', function() {
		if(!$(this).hasClass('opened')) {
			getDeletedItems();
			$(this).addClass('opened');
			$('#trash-div').show('fast');
			if($('#minimized').find('#trash-minimized').text().length > 0)
				$('#minimized').find('#trash-minimized').css('background-color', '#999999');
			else
				$('#minimized').append('<div id="trash-minimized" rel="trash">Trash</div>')
		}
	});
	
	$('#minimized').on('dblclick', 'div', function() {
		$(this).blur();
		elementId = '#'+$(this).attr('rel');
		divId = elementId+'-div';
		if($(divId).is(':hidden')) {
			$(divId).show('fast');
			$(elementId).addClass('opened');
			$(this).css('background-color', '#999999');
		}
		else if($(divId).is(':visible')) {
			$(this).blur();
			$(divId).hide('fast');
			$(elementId).removeClass('opened');
			$(this).css('background-color', '#CCCCCC');
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
		$('#minimized').find(id).css('background-color', '#CCCCCC');
		$('#trash').removeClass('opened');
	});
	
	$('#webtop .panel-body').oncontextmenu = function() { return false; };

	$('.category').mousedown(function(e) {
    	if( e.button == 2 ) {
    		var rel = $(this).attr('rel');
			activeCategory = rel.substring(0, rel.indexOf(':'));
			activeLabel = rel.substring(rel.indexOf(':') + 1);
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
				        bootbox.prompt("Create New Category", function(label) {
				        	if(label !== null && $.trim(label.length) == 0)
				        		bootbox.alert("You should provide a label for the new category");
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
	            "create_cat": {name: 'New Category', icon: 'folder-close'},
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
				    case "create_file":
				        bootbox.alert('Create File');
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
	
	function getDeletedItems() {
		$.ajax({
			url: '/'+$('#lang').val()+'/members_area/getDeletedItems',
			type: 'post',
			cache: false,
			dataType: 'json',
			success: function(items) {
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
		return '<div class="category col-lg-1 col-md-2 col-sm-4 col-xs-6">'+
				'<div class="glyphicon glyphicon-folder-close"></div>'+
				'<div class="category-label">'+category.label+'</div>'+
			   '</div>';
	}
	
	function getDeletedFileDiv(file) {
		return '<div class="file col-lg-1 col-md-2 col-sm-4 col-xs-6">'+
				'<div class="glyphicon glyphicon-file"></div>'+
				'<div class="file-label">'+file.label+'</div>'+
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
			url: '/'+$('#lang').val()+'/members_area/deleteCategory',
			type: 'post',
			cache: false,
			data: { id: id, label: label, toState: toState },
			dataType: 'json',
			success: function(cat) {
				$('.categories').find('#cat'+cat.id).remove();
			},
			error: function(result) {
				bootbox.alert("Error creating category!");
			}
		});
	}
});