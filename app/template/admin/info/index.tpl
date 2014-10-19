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
		  <button id="add-new-category" class="col-md-2 btn btn-primary" disabled="disabled">Add New Category</button>
		  <button id="add-new-file" class="col-md-offset-8 col-md-2 btn btn-primary" disabled="disabled">Add New File</button>
		</div>
	</div>
	<input type="hidden" id="lang_id" value="<?php echo $lang_id; ?>" />
	<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
	<input type="hidden" id="no-results" value="<?php echo $information['noResults']; ?>" />
	<?php echo $footer; ?>