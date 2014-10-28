<?php echo $dashboard; ?>
	  <div class="col-md-10">
	    <h3 class="page-title">New Issue</h3>
		  <form role="form" method="post" action="/admin/todo/createIssue">
		    <div class="form-group">
		      <label for="issue-title">Title</label>
		      <input type="text" class="form-control" id="issue-title" name="issue[title]">
		    </div>
		    <div class="form-group">
		      <label for="issue-tab">Relative Tab</label>
		      <select id="issue-tab" name="issue[tab_id]">
		        <?php
		          $tab_language_id = '';
		          foreach($tabs as $tab) {
		            if(!empty($tab_language_id) && ($tab['lang_id'] != $tab_language_id))
		              echo '<optgroup label="--------------------------------------">';
		            $tab_language_id = $tab['lang_id'];
		            if($tab['has_submenu'] == 0) {
		              echo '<option id="tab'.$tab['id'].'" class="tab-option" value="t'.$tab['id'].'">'.$tab['label'].'</option>';
		            }
		            else {
		              echo '<optgroup label="'.$tab['label'].'">';
		              foreach($subtabs as $subtab) {
		                if($subtab['tab_id'] == $tab['id']) {
		                  echo '<option id="sub'.$subtab['id'].'" value="s'.$subtab['id'].'">'.$subtab['label'].'</option>';
		                }
		              }
		              echo '</optgroup>';
		            }
		          }
		        ?>
		      </select>
		    </div>
		    <div class="form-group">
		      <label for="issue-priority">Priority</label>
		      <select id="issue-priority" name="issue[priority]">
		        <option value="1">Urgent</option>
		        <option value="2">High</option>
		        <option value="3" selected="selected">Normal</option>
		        <option value="4">Low</option>
		        <option value="5">Very Low</option>
		      </select>
		    </div>
		    <div class="form-group">
		      <label for="issue-assign">Assigned at</label>
		      <select id="issue-assign" name="issue[assign]">
		        <?php
		          foreach($users as $user) {
		            echo '<option id="user'.$user['id'].'" value="'.$user['id'].'">'.$user['first_name'].' '.$user['last_name'].'</option>';
		          }
		        ?>
		      </select>
		    </div>
		    <div class="form-group">
		      <label for="issue-description">Description</label>
		      <textarea id="issue-description" name="issue[description]"></textarea>
		    </div>
		    <button type="button" id="issue-submit" class="btn btn-primary">Submit</button>
		  </form>
		</div>
	</div>
	<?php echo $footer; ?>