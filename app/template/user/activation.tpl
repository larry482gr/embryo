<?php echo $header; ?>
	<div class="row">
	  <div class="col-md-8">
	    <h3 class="page-title"><?php echo $form['activationForm']; ?></h3>
	    <form id="login-form" class="form-horizontal" role="form" method="post">
	      <?php
	        if(!empty($invalidError)) {
	      ?>
	      <div class="form-group">
		    <div class="alert alert-danger col-md-offset-1 col-md-8"><?php echo $invalidError; ?></div>
		  </div>
		  <?php
		    }
		  ?>
		  <div class="form-group">
		    <label for="username" class="col-md-3 col-md-offset-1 control-label"><?php echo $form['username']; ?></label>
		    <div class="col-md-5">
		      <input type="text" class="form-control" id="username" name="user[uname]" placeholder="<?php echo $form['username']; ?>" value="<?php echo $username; ?>">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="password" class="col-md-3 col-md-offset-1 control-label"><?php echo $form['password']; ?></label>
		    <div class="col-md-5">
		      <input type="password" class="form-control" id="password" name="user[pass]" placeholder="<?php echo $form['password']; ?>">
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-5">
		      <button type="submit" class="btn btn-primary"><?php echo $form['activate']; ?></button>
		    </div>
		  </div>
		  <input type="hidden" name="user[token]" value="<?php echo $token; ?>" />
		</form>
	  </div>
	<?php echo $left_part; ?>
  </div>
<?php echo $footer; ?>