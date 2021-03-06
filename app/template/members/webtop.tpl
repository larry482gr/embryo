<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
      <h3 class="page-title"><?php echo $pageTitle; ?></h3>
      <div id="webtop" class="panel panel-primary">
	      <div class="panel-heading">
	        <div class="panel-title">Members Area Webtop<small id="expand-area" class="pull-right"><span class="glyphicon glyphicon-fullscreen"></span>Full Screen</small></div>
	      </div>
	      <div class="panel-body">
	      <div id="top-div" class="row">
		      <!-- Category div -->
		      <div class="categories row">
			      <?php
			        foreach($categories as $cat) {
			          echo '<div id="cat'.$cat['id'].'" class="category" rel="'.$cat['id'].':'.$cat['label'].'"><div class="glyphicon glyphicon-folder-close"></div><div class="category-label">'.$cat['label'].'</div></div>';
			        }
			      ?>
		      </div>
		      <!-- Webtop div -->
		      <div class="folder-content row">
			      <div id="trash-div" class="webtop-div col-lg-12 col-md-12 col-sm-12 col-xs-12">
			      	<div class="window-header row">
			      	  <div class="pull-left">
			      	  	<div class="control-buttons pull-left">
			      	  		<button type="button" id="trash-back-btn" class="btn btn-default btn-xs disabled"><span class="glyphicon glyphicon-arrow-left"></span></button>
			      	  		<button type="button" id="trash-front-btn" class="btn btn-default btn-xs disabled"><span class="glyphicon glyphicon-arrow-right"></span></button>
			      	  	</div>
			      	  	<h4 class="pull-right">
			      	  		Trash
			      	  		<small id="empty-trash" class="header-options">Empty Trash</small>
			      	  		<small id="remove-selected" class="header-options hidden">Delete Selected Items</small>
			      	  		<small id="restore-selected" class="header-options hidden">Restore Selected Items</small>
			      	  	</h4>
			      	  </div>
			      	  <div class="pull-right">
			      	  	<button type="button" class="btn btn-xs btn-warning" rel="trash-minimized"><span class="glyphicon glyphicon-minus"></span></button>
			      	  	<button type="button" class="btn btn-xs btn-danger" rel="trash-minimized"><span class="glyphicon glyphicon-remove"></span></button>
			      	  </div>
			      	</div>
			      	<div class="window-content row">
			      	</div>
			      </div>
		      </div>
	      </div>
	      <!-- Bottom div -->
	      <div id="bottom-div" class="row">
		      <div id="minimized" class="pull-left">
		      </div>
		      <div id="trash" class="pull-right">
		      	<span class="glyphicon glyphicon-trash"></span>
		      </div>
	      </div>
	      </div>
	  </div>
	  <?php
	  	if($profile_id < 3) {
	  		echo '<a href="/'.$lang.'/research_survey/showResearchSurvey/2" target="_blank">Research Survey Results</a>';
	  	}
	  ?>
	</div>
    <?php echo $left_part; ?>  
  </div>
</div>
<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<!-- Modal -->
<div class="modal fade" id="newFileModal" tabindex="-1" role="dialog" aria-labelledby="newFileModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="newFileModalLabel">Upload File</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <form id="new-file-form" method="post" action="<?php echo '/'.$lang.'/members_area/createFile'; ?>" enctype="multipart/form-data">
          	<div id="file-category-div" class="form-group">
          	  <label for="file-category-select">Select a Category</label>
          	  <select id="file-category-select" class="form-control">
          	    <?php
			      foreach($categories as $cat) {
			        echo '<option value="'.$cat['id'].'">'.$cat['label'].'</option>';
			      }
			    ?>
          	  </select>
          	</div>
          	<div class="form-group">
          	  <label for="new-file">Pick a File</label>
          	  <input id="new-file" name="new_file" type="file" />
          	</div>
          	<input id="new-file-cat" name="file_cat" type="hidden" value="" />
          	<p class="help-block">File types allowed: .pdf, .doc, .docx</p>
          	<p class="help-block">Maximum file size: 20 MB</p>
          </form>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" id="upload-file" class="btn btn-primary">Upload</button>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>