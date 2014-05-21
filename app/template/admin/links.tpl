<?php echo $dashboard; ?>
	  <div class="col-md-10">
	    <h3 class="page-title">Links Categories</h3>
	      <form class="form-horizontal" role="form">
	      <div class="form-group">
		    <label for="language-select" class="col-md-2 control-label">Select language</label>
		    <div class="col-md-3">
		      <select class="form-control input-sm" name="lang_id">
				  <option value="1">English</option>
				  <option value="2" selected="selected">Ελληνικά</option>
				</select>
		    </div>
		  </div>
		  </form>
		  <table id="links-table" class="table table-hover col-md-9">
		  	<thead><tr><th>#</th><th>Label</th><th>Active</th><th>Position</th></tr></thead>
		  	<tbody>
		    <?php
		    	$table_rows = '';
				$i = 1;
		    	foreach($link_cats as $link_cat) {
		    		$active = $link_cat['is_active'] ? 'Yes' : 'No';
		    		$table_rows .= '<tr><td>'.$i++.'</td><td>'.$link_cat['label'].'</td><td>'.$active.'</td><td>'.$link_cat['position'].'</td></tr>';
		    	}
				echo $table_rows;
		    ?>
		    </tbody>
		  </table>
		  <button id="add-new-category" class="col-md-2 btn btn-primary">Add New Category</button>
		  <button id="add-new-link" class="col-md-offset-8 col-md-2 btn btn-primary">Add New Link</button>
		  
		  <!-- Add New Category Form -->
		  <form id="create-new-category" class="form-horizontal col-md-12" role="form" action="links/createCategory" method="post">
	      <?php
	        if(false) {
	      ?>
	      <div class="form-group">
		    <div class="alert alert-danger col-md-offset-3 col-md-5"><?php echo $invalidError; ?></div>
		  </div>
		  <?php
		    }
		  ?>
		  <div class="form-group">
		    <label for="tab_label" class="col-md-offset-2 col-md-2 control-label">Label</label>
		    <div class="col-md-4">
		      <input type="text" class="form-control" id="tab_label" name="link_cat[label]" placeholder="Label">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="tab_language" class="col-md-offset-2 col-md-2 control-label">Language</label>
		    <div class="col-md-4">
		      <select class="form-control input-sm" name="link_cat[lang_id]">
				<option value="1">English</option>
				<option value="2" selected="selected">Ελληνικά</option>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" id="tab_active" name="link_cat[is_active]"> Is Active?
		        </label>
		      </div>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="tab_language" class="col-md-offset-2 col-md-2 control-label">Position</label>
		    <div class="col-md-2">
		      <select class="form-control input-sm" name="link_cat[position]">
		        <?php
		          if($max_position == null)
		          	$options = '<option value="1" selected="selected">1</option>';
		          else {
		            $selected = '';
		            $options = '';
		            for($i = 0; $i < $max_position+1; $i++) {
		          	  if($i == $max_position)
		          	    $selected = 'selected="selected"';
		          	  $options .= '<option value="'.($i+1).'" '.$selected.'>'.($i+1).'</option>';
		            }
		          }
		          echo $options;
		        ?>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <button type="submit" class="btn btn-primary"><?php echo $form['submit']; ?></button>
		    </div>
		  </div>
		</form>
		
		<!-- Add New Link Form -->
		<form id="create-new-link" class="form-horizontal col-md-12" role="form" action="links/createLink" method="post">
	      <?php
	        if(false) {
	      ?>
	      <div class="form-group">
		    <div class="alert alert-danger col-md-offset-3 col-md-5"><?php echo $invalidError; ?></div>
		  </div>
		  <?php
		    }
		  ?>
		  <div class="form-group">
		    <label for="tab_language" class="col-md-offset-1 col-md-3 control-label">Pick a Link Category</label>
		    <div class="col-md-4">
		      <select class="form-control input-sm" name="link[cat_id]">
		        <?php
		          $linkOptions = '';
		          foreach($link_cats as $link_cat) {
		    		$linkOptions .= '<option value="'.$link_cat['id'].'">'.$link_cat['label'].'</option>';
		    	}
				echo $linkOptions;
		        ?>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="link_header" class="col-md-offset-1 col-md-3 control-label">Header (The title of a group of links)</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="link_header" name="link[header]" placeholder="Header">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="link_prepend" class="col-md-offset-1 col-md-3 control-label">Text before link (if any)</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="link_prepend" name="link[prepend_text]" placeholder="Text before link">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="link_label" class="col-md-offset-1 col-md-3 control-label">Link Label</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="link_label" name="link[link_label]" placeholder="example: AUTH">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="link_url" class="col-md-offset-1 col-md-3 control-label">Link Address</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="link_url" name="link[link_url]" placeholder="example: http://www.auth.gr (Don't forget the prefix: http://)">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="link_append" class="col-md-offset-1 col-md-3 control-label">Text after link (if any)</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="link_append" name="link[append_text]" placeholder="Text after link">
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" id="link_group" name="link[is_group]"> Is this link part of a group?
		        </label>
		      </div>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <button type="submit" class="btn btn-primary"><?php echo $form['submit']; ?></button>
		    </div>
		  </div>
		</form>
		</div>
	</div>
	<?php echo $footer; ?>