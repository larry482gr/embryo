<?php echo $header; ?>
	<div class="row">
	  <div class="col-md-12">
	    <form id="admin-login-form" class="form-horizontal" role="form" method="post">
	      <?php
	        if(!empty($invalidError)) {
	      ?>
	      <div class="form-group">
		    <div class="alert alert-danger col-md-offset-3 col-md-5"><?php echo $invalidError; ?></div>
		  </div>
		  <?php
		    }
		  ?>
		  <div class="form-group">
		    <label for="username" class="col-md-offset-2 col-md-2 control-label"><?php echo $form['username']; ?></label>
		    <div class="col-md-4">
		      <input type="text" class="form-control" id="username" name="admin[uname]" placeholder="<?php echo $form['username']; ?>" value="<?php echo $username; ?>">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="password" class="col-md-offset-2 col-md-2 control-label"><?php echo $form['password']; ?></label>
		    <div class="col-md-4">
		      <input type="password" class="form-control" id="password" name="admin[pass]" placeholder="<?php echo $form['password']; ?>">
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox"> Remember me
		        </label>
		      </div>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <button type="submit" class="btn btn-primary"><?php echo $form['login']; ?></button>
		    </div>
		  </div>
		</form>
	  </div>
	</div>