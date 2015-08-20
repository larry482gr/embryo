var activeCategory = -1;
var activeFile = -1;
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
	
	$('#trash, trash-div').droppable({
		// accept: ".categories .category",
		scope: 'dropable',
		hoverClass: "opened",
		drop: function(event, ui) {
			if($(ui.draggable).hasClass('category'))
				deleteCategory(activeCategory, activeLabel, 5);
			else if($(ui.draggable).hasClass('file'))
				// bootbox.alert($(ui.draggable).attr('class') + ' - ' + $(ui.draggable).attr('id'));
				deleteFile(activeFile, activeLabel, 5);
		}
	});
	
	$('#expand-area').on('click', function() {
		if($(this).text() == 'Full Screen') {
			$('#webtop').hide().css('position', 'fixed').css('z-index', '1200').show('slow', function(){
				$('body').css('position', 'fixed').css('height', '100%');
				bootbox.alert('Press "ESC" at any time to exit full screen.');
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
	
	$(document).keyup(function(e) {
		if (e.keyCode == 27 && $('#expand-area').text() == 'Minimize') {
			$('#expand-area').click();
		}
	});
	
	$('.categories').on('dblclick', '.category', function() {
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
			getWindowFiles(id);
			$('#minimized').append('<button type="button" id="cat'+id+'-minimized" class="btn btn-sm btn-default active" rel="cat'+id+'">'+label+'</div>');
			activeTabs.push('#cat'+id+'-minimized');
		}
		$('.folder-content').find('#cat'+id+'-div').css('z-index', getAndIncreaseWindowZ()).show('fast');
		$('.folder-content').find('#cat'+id+'-div').find('div:last-child').css('z-index', getAndIncreaseWindowZ());
		$('.folder-content').find('#cat'+id+'-div').find('div:first-child').css('z-index', getAndIncreaseWindowZ());
	});
	
	$('#trash-div').on('dblclick', '.trash-category', function() {
		selectedItems = [];
		$(this).find('div:last-child').css('background-color', '#FFFFFF').css('color', '#444444');
		if(selectedItems.length == 0) {
			$('.header-options').each(function() {
				if($(this).hasClass('visible'))
					$(this).removeClass('visible').hide().addClass('hidden');
			});
		}
		
		rel = $(this).attr('rel');
		catDeleted = rel.substr(0, rel.indexOf(':'));
		getDeletedItems();
	});
	
	$('#trash-back-btn').on('click', function() {
		getDeletedItems();
		$(this).addClass('disabled');
		$('#trash-front-btn').removeClass('disabled');
	});
	
	$('#trash-front-btn').on('click', function() {
		catDeleted = $(this).attr('rel');
		getDeletedItems();
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
						$(this).removeClass('hidden').fadeIn(100, function() {
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
						$(this).removeClass('visible').fadeOut(100, function() {
							$(this).addClass('hidden');
						});
					}
				});
			}
		}
	});
	
	$('#trash').on('dblclick', function() {
		$('#trash-div').css('z-index', getAndIncreaseWindowZ());
		$('#trash-div').find('div:last-child').css('z-index', getAndIncreaseWindowZ());
		$('#trash-div').find('div:first-child').css('z-index', getAndIncreaseWindowZ());
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
			$(divId).find('div:last-child').css('z-index', getAndIncreaseWindowZ());
			$(divId).find('div:first-child').css('z-index', getAndIncreaseWindowZ());
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
				$(divId).find('div:last-child').css('z-index', getAndIncreaseWindowZ());
				$(divId).find('div:first-child').css('z-index', getAndIncreaseWindowZ());
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
	
	// ===================================================================
	// Try to refactor the following 3 event listeners and merge them to 1
	// ===================================================================
	
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
	
	$('.folder-content').on('mousedown', '.category-div .window-content .file', function(e) {
    	if( e.button == 2 ) {
    		var rel = $(this).attr('rel');
			activeFile = rel.substring(0, rel.indexOf(':'));
			// activeLabel = rel.substring(rel.indexOf(':') + 1);
			activeLabel = $(this).find('.file-label').text();
			infoFileId = '.folder-content .category-div .window-content #file'+activeFile;
			return false;
		}
		return true;
	});
	
	$('#trash-div .window-content').on('mousedown', '.trash-file', function(e) {
    	if( e.button == 2 ) {
    		var rel = $(this).attr('rel');
			activeFile = rel.substring(0, rel.indexOf(':'));
			// activeLabel = rel.substring(rel.indexOf(':') + 1);
			activeLabel = $(this).find('.file-label').text();
			infoFileId = '#trash-div .window-content #trash-file'+activeFile;
			return false;
		}
		return true;
	});
	
	// ===================================================================
	// Try to refactor the following 3 event listeners and merge them to 1
	// ===================================================================
	
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
							deleteFile(value, '', 6);
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
							if(value.indexOf('trash-cat') >= 0) {
								id = value.substring(9);
								trashCatDiv = $('#trash-div .window-content').find('#trash-cat'+id);
								rel = trashCatDiv.attr('rel');
								label = rel.substring(rel.indexOf(':')+1);
								purgeCategory(id, label, 6);
							}
							else if(value.indexOf('trash-file') == 0) {
								id = value.substring(10);
								trashFileDiv = $('#trash-div .window-content').find('#trash-file'+id);
								rel = trashFileDiv.attr('rel');
								label = rel.substring(rel.indexOf(':')+1);
								purgeFile(id, label, 6);
							}
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
					id = value.substring(10);
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
		categoryRel = $(this).parent().parent().attr('rel');
		fileRel = $(this).attr('rel');
		fileLink = '/resources/files/members_area/'+categoryRel.substring(0, categoryRel.indexOf(':'))+"/"+fileRel.substring(fileRel.indexOf(':')+1);
		window.open(fileLink, '_blank');
	});
	
	var options = {
		success: function(result) {
			file = JSON.parse(result);
			$(".folder-content #cat"+file.category_id+"-div .window-content").append(getFileDiv(file));
			$('#newFileModal').modal('hide');
		},
		error: function() {
			$("#message").html("<font color=\'red\'> ERROR: unable to upload file.</font>");
		}
	};
	
	$("#new-file-form").ajaxForm(options);
	
	$("#file-category-div").hide();
	
	$("#file-category-select").on('change', function(){
		$("#new-file-cat").val($(this).val());
	});
					
	$("#new-file").change(function() {
		newFile = this.files[0];
		newFileType = newFile.type;
	});
	
	$('#upload-file').on('click', function() {
		if(newFileType == 'application/pdf' || newFileType == 'application/vnd.ms-word' || newFileType == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document') {
			$('#new-file-form').submit();
		}
		else {
			bootbox.alert('Please check the file types allowed.');
		}
	});
});