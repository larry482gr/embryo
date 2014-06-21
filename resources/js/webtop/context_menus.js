
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
	        selector: '.folder-content .category-div .window-content .file',
	        build: function($trigger, e) {
				return {
			        callback: function(key, options) {
			            switch(key) {
						    case "rename":
						        bootbox.dialog({
						        	title: 'Rename "' + activeLabel + '"',
									message: '<div class="form-group"><input type="text" class="form-control" id="update-file-label" value="'+activeLabel+'" /></div>',
									buttons: {
										cancel: {
											label: "Cancel",
											className: "btn-default",
										},
										ok: {
											label: "OK",
											className: "btn-primary",
											callback: function() {
												updateFile(activeFile, $('#update-file-label').val(), 3);
											}
										}
									}
								});
						        break;
						    case "remove":
						        bootbox.confirm('Are you sure you want to delete "'+activeLabel+'"?', function(result) {
						        	if(result)
										deleteFile(activeFile, activeLabel, 5);
								});
						        break;
						    case "info":
						        getFileInfo(activeFile);
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
						        $('#file-category-div').hide();
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
	        selector: '.trash-file',
	        build: function($trigger, e) {
				return {
			        callback: function(key, options) {
			            switch(key) {
						    case "restore":
								restoreFile(activeFile, activeLabel, 4);
						        break;
						    case "info":
						        getFileInfo(activeFile);
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
						    	// bootbox.alert('Create File');
						    	$('#newFileModal').modal('show');
						    	$('#file-category-div').show();
						        $('#new-file-cat').val($('#file-category-select').val());
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