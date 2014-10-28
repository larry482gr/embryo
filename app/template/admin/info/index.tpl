<?php echo $dashboard; ?>
	  <div class="col-md-10">
	    <h3 class="page-title">Information Categories</h3>
	      <form class="form-horizontal" role="form" onsubmit="return false;">
		      <div class="form-group">
			    <label for="language" class="col-md-2 control-label">Select language</label>
			    <div class="col-md-3">
			      <select id="language" class="form-control input-sm" name="lang_id">
			      	<?php
			          foreach($languages as $key => $value) {
			            echo '<option value="'.$value['id'].'" rel="'.$key.'">'.$form[$value['language']].'</option>';
			          }
			        ?>
				  </select>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="info-cat" class="col-md-2 control-label">Select category</label>
			    <div class="col-md-3">
			      <select id="info-cat" class="form-control" name="info[cat]">
			        <option value="-1" disabled="disabled" selected="selected">Select a category...</option>
			      	<?php
			      	  $initial = true;
			          foreach($info_subtabs as $subtab) {
			            $main_group = '';
			          	$header = '';
			          	$has_groups = false;
			            foreach($info_main as $main) {
			              $sub_group = '';
			              $has_subcats = false;
			              if($main['tab_id'] == $subtab['id']) {
			                $has_groups = true;
			                foreach($info_sub as $sub) {
			                  if($sub['parent_id'] == $main['id']) {
			                    $has_subcats = true;
				                $sub_group .= '<option value="'.$sub['id'].'">'.$sub['label'].'</option>';
				              }
			                }
			                if(!empty($sub_group)) {
			                  $main_group .= '<optgroup label="'.$main['label'].'">'.$sub_group.'</optgroup>';
			                }
			                else if(!empty($main['label']))
			                  $main_group .= '<option value="'.$main['id'].'">'.$main['label'].'</option>';
			                else
			                  $header = '<option value="'.$main['id'].'">'.$subtab['label'].'</option>';
			              }
			            }
			            if(!$has_groups)
			              $header = '<optgroup label="'.$subtab['label'].'"></optgroup>';
			            
			            if(!$initial)
			              echo '<optgroup label="------------------------------------------"></optgroup>';
			              
			            if(empty($header)) {
			              echo '<optgroup label="'.$subtab['label'].'">';
			              echo $main_group;
			              echo '</optgroup>';
			            }
			            else {
			              echo $header;
			              echo $main_group;
			            }
			            $initial = false;
			          }
			        ?>
				  </select>
			    </div>
			  </div>
		  </form>
		  
		  <table id="info-table" class="table table-condensed table-bordered table-hover col-md-9">
		  	<thead><tr><th></th><th><?php echo $information['fileName']; ?></th><th><?php echo $information['fileSize']; ?></th><th><?php echo $information['fileDate']; ?></th></tr></thead>
		  	<tbody>
		    </tbody>
		  </table>
		  <button id="add-new-category" class="col-md-3 btn btn-primary">Add New Category/Subcategory</button>
		  <button id="add-new-file" class="col-md-offset-7 col-md-2 btn btn-primary">Add New File</button>
		  
		  <!-- Add New Category Form -->
		  <form id="create-new-cat" class="form-horizontal col-md-12" role="form" action="/admin/info/createCategory" method="post">
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
		    <label for="info-tab" class="col-md-offset-1 col-md-3 control-label">Reference tab</label>
		    <div class="col-md-4">
		      <select id="info-tab" class="form-control" name="info[tab_id]">
		        <option value="-1" disabled="disabled" selected="selected">Select a tab...</option>
			      	<?php
			          foreach($info_subtabs as $subtab) {
			          	echo '<option value="'.$subtab['id'].'">'.$subtab['label'].'</option>';
			          }
			        ?>
		      </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="info-cat" class="col-md-offset-1 col-md-3 control-label">Reference category</label>
		    <div class="col-md-4">
		      <select id="info-cat" class="form-control" name="info[parent_id]">
		        <option value="-1" selected="selected">Select a category...</option>
			      	<?php
			          foreach($info_main as $main) {
			            if(!empty($main['label']))
			          	  echo '<option value="'.$main['id'].'">'.$main['label'].'</option>';
			          }
			        ?>
		      </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="info-lang" class="col-md-offset-1 col-md-3 control-label">Language</label>
		    <div class="col-md-4">
		      <select id="info-lang" class="form-control" name="info[lang_id]">
		        <?php
			      foreach($languages as $key => $value) {
			        echo '<option value="'.$value['id'].'" rel="'.$key.'">'.$form[$value['language']].'</option>';
			      }
			    ?>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="info-label" class="col-md-offset-2 col-md-2 control-label">Label</label>
		    <div class="col-md-4">
		      <input type="text" class="form-control" id="info-label" name="info[label]">
		    </div>
		  </div>
		  <div class="col-md-offset-4 checkbox">
		    <label>
		      <input type="checkbox" name="info[is_active]"> Is active?
		    </label>
		  </div>
		  <div class="form-group submit-div">
		    <div class="col-md-offset-4 col-md-4">
		      <button type="button" class="btn btn-primary"><?php echo $form['submit']; ?></button>
		    </div>
		  </div>
		</form>
		
		<!-- Add New Link Form -->
		<form id="create-new-file" class="form-horizontal col-md-12" role="form" action="members/createMember" method="post" enctype="multipart/form-data">
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
		    <label for="member_group" class="col-md-offset-1 col-md-3 control-label">Pick a Group</label>
		    <div class="col-md-4">
		      <select class="form-control input-sm" id="member_group" name="member[group_id]">
		        <?php
		          $groupOptions = '';
		          foreach($member_groups as $group) {
		    		$groupOptions .= '<option value="'.$group['id'].'">'.$group['label'].'</option>';
		    	}
				echo $groupOptions;
		        ?>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="member_name" class="col-md-offset-1 col-md-3 control-label">Name</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="member_name" name="member[name]" placeholder="Research Member's Full Name">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="member_email" class="col-md-offset-1 col-md-3 control-label">Email</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="member_email" name="member[email]" placeholder="Research Member's Email">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="member_picture" class="col-md-offset-1 col-md-3 control-label">Picture</label>
		    <div class="col-md-6">
			  <img class="thumbnail" id="form-thumbnail" src="">
		      <input type="file" id="member_picture" name="member_picture">
		      <p class="help-block">File types allowed: .jpeg, .jpg, .png</p>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="member_cv" class="col-md-offset-1 col-md-3 control-label">Bio (CV)</label>
		    <div class="col-md-6">
		      <textarea class="form-control" id="member_cv" name="member[cv]"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="member_pubs" class="col-md-offset-1 col-md-3 control-label">Publications</label>
		    <div class="col-md-6">
		      <textarea class="form-control" id="member_pubs" name="member[pubs]"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <button type="submit" class="btn btn-primary"><?php echo $form['submit']; ?></button>
		    </div>
		  </div>
		  <input type="hidden" id="member_id" name="member_id" value="-1" />
		  <input type="hidden" id="edit" name="edit" value="0" />
		</form>
		</div>
	</div>
	<input type="hidden" id="lang_id" value="<?php echo $lang_id; ?>" />
	<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
	<input type="hidden" id="no-results" value="<?php echo $information['noResults']; ?>" />
	<?php echo $footer; ?>