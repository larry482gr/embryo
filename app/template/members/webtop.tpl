<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
      <h3 class="page-title"><?php echo $pageTitle; ?></h3>
      <div id="webtop" class="panel panel-primary">
	      <div class="panel-heading">
	        <div class="panel-title">Members Area Webtop<small id="expand-area" class="pull-right"><span class="glyphicon glyphicon-fullscreen"></span>Full Screen</small></div>
	      </div>
	      <div class="panel-body">
	      <div id="top-div">
		      <!-- Category div -->
		      <div class="categories col-lg-2 col-md-2 col-sm-2 col-xs-2">
			      <?php
			        foreach($categories as $cat) {
			          echo '<div id="cat'.$cat['id'].'" class="category" rel="'.$cat['id'].':'.$cat['label'].'"><div class="glyphicon glyphicon-folder-close"></div><div class="category-label">'.str_replace(" ", "<br/>", $cat['label']).'</div></div>';
			        }
			      ?>
		      </div>
		      <!-- Webtop div -->
		      <div class="folder-content col-lg-10 col-md-10 col-sm-10 col-xs-10">
			      <div id="trash-div" class="webtop-div row col-lg-12 col-md-12 col-sm-12 col-xs-12">
			      	<div class="window-header row">
			      	  <div class="pull-left">
			      	  	<h4>
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
	      <div id="bottom-div">
		      <div id="minimized" class="pull-left">
		      </div>
		      <div id="trash" class="pull-right">
		      	<span class="glyphicon glyphicon-trash"></span>
		      </div>
	      </div>
	      </div>
	  </div>
	</div>
    <?php echo $left_part; ?>  
  </div>
</div>
<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<iframe id="upload_target" name="upload_target" src="#" style="width:0;height:0;border:0px solid #fff;"></iframe>
<?php echo $footer; ?>