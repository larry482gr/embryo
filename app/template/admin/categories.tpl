<?php echo $dashboard; ?>
	  <div class="col-md-9">
	    <h3 class="page-title">Menu Tabs</h3>
	      <form class="form-horizontal" role="form">
	      <div class="form-group">
		    <label for="language-select" class="col-md-2 control-label">Select language</label>
		    <div class="col-md-3">
		      <select class="form-control input-sm" name="lang_id">
				  <option value="1">English</option>
				  <option value="2">Ελληνικά</option>
				</select>
		    </div>
		  </div>
		  </form>
		  <table class="table table-hover col-md-9">
		  	<thead><tr><th>#</th><th>Label</th><th>Description</th><th>Active</th><th>Subtabs</th></tr></thead>
		  	<tbody>
		    <?php
		    	$table_rows = '';
				$i = 1;
		    	foreach($tabs as $tab) {
		    		$active = $tab['is_active'] ? 'Yes' : 'No';
					$subtabs = $tab['has_submenu'] ? 'Yes' : 'No';
		    		$table_rows .= '<tr><td>'.$i++.'</td><td>'.$tab['label'].'</td><td>'.$tab['description'].'</td><td>'.$active.'</td><td>'.$subtabs.'</td></tr>';
		    	}
				echo $table_rows;
		    ?>
		    </tbody>
		  </table>
		  <button class="btn btn-primary">Add New Tab</button>
		  <form class="form-horizontal" role="form" action="categories/create" method="post">
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
		    <label for="tab_label" class="col-md-2 control-label">Label</label>
		    <div class="col-md-4">
		      <input type="text" class="form-control" id="tab_label" name="tab[label]" placeholder="Label">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="tab_description" class="col-md-2 control-label">Description</label>
		    <div class="col-md-4">
		      <input type="text" class="form-control" id="tab_description" name="tab[description]" placeholder="Description">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="tab_link" class="col-md-2 control-label">Tab Link</label>
		    <div class="col-md-4">
		      <input type="text" class="form-control" id="tab_link" name="tab[link]" placeholder="Link">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="tab_language" class="col-md-2 control-label">Language</label>
		    <div class="col-md-4">
		      <select class="form-control input-sm" name="tab[lang_id]">
				<option value="1">English</option>
				<option value="2">Ελληνικά</option>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-2 col-md-4">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" id="tab_submenu" name="tab[has_submenu]"> Has Submenu?
		        </label>
		      </div>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-2 col-md-4">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" id="tab_active" name="tab[is_active]"> Is Active?
		        </label>
		      </div>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-2 col-md-4">
		      <button type="submit" class="btn btn-primary"><?php echo $form['submit']; ?></button>
		    </div>
		  </div>
		</form>
		</div>
	</div>