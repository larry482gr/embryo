<?php echo $dashboard; ?>
	  <div class="col-md-10">
	    <h3 class="page-title">Member Groups</h3>
	      <form class="form-horizontal" role="form">
	      <div class="form-group">
		    <label for="language-select" class="col-md-2 control-label">Select language</label>
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
		  </form>
		  <table id="groups-table" class="table table-hover col-md-9">
		  	<thead><tr><th>#</th><th>Group Name</th></tr></thead>
		  	<tbody>
		    <?php
		    	$group_table_rows = '';
		    	$members_divs = '';
				$i = 1;
				$j = 0;
				$members_found = false;
				$info_divs = '';
				$visible = 'visible';
				$close_div = false;
		    	foreach($member_groups as $group) {
		    		$group_table_rows .= '<tr id="group'.$group['id'].'" rel="'.$group['id'].'" class="group-row"><td>'.$i++.'</td><td>'.$group['label'].'</td></tr>';
		    		
		    		if(!$close_div && empty($info_divs) && $j%2 == 1) {
		    			$members_divs .= '</div>'; // Close row div
		    			$members_divs .= '</div>'; // Close member row
		    		}
		    		
		    		if(!empty($temp_close_divs))
		    			$members_divs .= $temp_close_divs;
		    		
		    		if(!empty($info_divs)) {
		    			$members_divs .= '</div>'; // Close row div
		    			$members_divs .= $info_divs;
		    			$members_divs .= '</div>'; // Close member row
		    			$info_divs = '';
		    		}
		    		if($close_div && $j%2==0)
		    			$members_divs .= '</div>'; // Close member row
		    			
		    		$close_div = false;
		    		$new_group = true;
		    		$j = 0;
		    		foreach($members as $member) {
		    			if($member['group_id'] == $group['id']) {
		    				$members_found = true;
		    				if($j%2 == 0) {
		    					if(!empty($info_divs))
		    						$members_divs .= $info_divs;
		    					$info_divs = '';
		    					if($new_group) {
		    						$members_divs .= '<div id="members'.$group['id'].'" class="col-md-12 members '.$visible.'">';
		    						$visible = '';
		    						$members_divs .= '<h4>'.$group['label'].'</h4>';
		    					}
		    					$members_divs .= '<div class="row">';
		    				}
		    				$members_divs .= '<div class="member col-md-6">';
		    				$members_divs .= '<div class="pull-left">';
		    				$members_divs .= '<a href="#" class="thumbnail">';
		    				$member['picture'] = !empty($member['picture']) ? $member['picture'] : "dummy_photo.png";
		    				$members_divs .= '<img class="member-pic" rel="'.$member['id'].'" src="/resources/images/members/'.$member['picture'].'" alt="'.$member['name'].'">';
		    				$members_divs .= '</a></div>';
		    				$members_divs .= '<div class="member-links-div pull-left"><h5>'.$member['name'].'</h5>';
		    				if($member['cv'] != null) {
		    					$members_divs .= '<a href="javascript:showCV('.$member['id'].')" rel="cv'.$member['id'].'" class="member-links"><i class="glyphicon glyphicon-info-sign"></i>&nbsp;&nbsp;'.$membersLinks['cv'].'</a>';
		    					$info_divs .= '<div id="cv'.$member['id'].'" class="col-md-12 member-cv">'.nl2br($member['cv']).'</div>';
		    				}
		    				if($member['pubs'] != null) {
		    					$members_divs .= '<a href="#" rel="pubs'.$member['id'].'" class="member-links"><i class="glyphicon glyphicon-book"></i>&nbsp;&nbsp;'.$membersLinks['publications'].'</a>';
		    					$info_divs .= '<div id="pubs'.$member['id'].'" class="col-md-12 member-pubs">'.nl2br($member['pubs']).'</div>';
		    				}
		    				if($member['email'] != null)
		    					$members_divs .= '<a href="mailto:'.$member['email'].'" class="member-links"><i class="glyphicon glyphicon-envelope"></i>&nbsp;&nbsp;'.$membersLinks['contact'].'</a>';
		    				$members_divs .= '</div>'; // Close member-links outer div
		    				$members_divs .= '</div>'; // Close member div
		    				
		    				if($j%2 == 1) {
		    					$members_divs .= '</div>'; // Close row div
		    					$members_divs .= $info_divs;
		    					$info_divs = '';
		    					$close_div = true;
		    				}
		    				
		    				$temp_close_divs = '';
		    				if($j%2 == 0 && empty($info_divs)) {
		    					$temp_close_divs = '</div></div>';
		    				}
		    				
		    				$new_group = false;
		    				$j++;
		    			}
					}
					if(!$members_found) {
						$members_divs .= '<div id="members'.$group['id'].'" class="col-md-12 members '.$visible.'">';
						$members_divs .= '<h4>'.$group['label'].'</h4>';
						$members_divs .= '<h5>'.$membersLinks['noResults'].'</h5>';
						$members_divs .= '</div>';
					}
					$members_found = false;
		    	}
		    	if(!empty($info_divs)) {
		    		$members_divs .= '</div>'; // Close row div
		    		$members_divs .= $info_divs;
		    		$members_divs .= '</div>'; // Close member row
		    	}
		    	else if($j%2 == 0)
		    		$members_divs .= '</div>'; // Close member row
		    	else {
		    		$members_divs .= '</div>'; // Close row div
		    		$members_divs .= '</div>'; // Close member row
		    	}
				echo $group_table_rows;
		    ?>
		    </tbody>
		  </table>
		  <?php
		  	echo $members_divs;
		  ?>
		  <button id="add-new-group" class="btn btn-primary">Add New Group</button>
		  <button id="add-new-member" class="pull-right btn btn-primary">Add New Member</button>
		  
		  <!-- Add New Category Form -->
		  <form id="create-new-group" class="form-horizontal col-md-12" role="form" action="members/createGroup" method="post">
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
		    <label for="group_label" class="col-md-offset-2 col-md-2 control-label">Label</label>
		    <div class="col-md-4">
		      <input type="text" class="form-control" id="group_label" name="group[label]" placeholder="Group Label">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="group_language" class="col-md-offset-2 col-md-2 control-label">Language</label>
		    <div class="col-md-4">
		      <select class="form-control input-sm" id="group_language" name="group[lang_id]">
				<?php
		          foreach($languages as $key => $value) {
		          	$selected = $value['id'] == $lang_id ? 'selected="selected"' : '';
		            echo '<option value="'.$value['id'].'" rel="'.$key.'" '.$selected.'>'.$form[$value['language']].'</option>';
		          }
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
		<form id="create-new-member" class="form-horizontal col-md-12" role="form" action="members/createMember" method="post" enctype="multipart/form-data">
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
	<input type="hidden" id="lang" value="<?php echo $language; ?>" />
	<?php echo $footer; ?>