<?php echo $header; ?>
	<div class="row">
	  <div class="col-md-8">
	    <h3 class="page-title"><?php echo $form['passRecSys']; ?></h3>
	    <form id="pass-reset-form" class="form-horizontal" role="form" method="post">
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
		    <div id="pass-reset-error" class="alert alert-danger col-md-offset-1 col-md-8"></div>
		  </div>
		  <?php
		    if(isset($recoverResult)) {
		      if($recoverResult == 1) {
		  ?>
			  <div class="form-group">
			    <div id="pass-reset-success" class="alert alert-success col-md-offset-1 col-md-8"><?php echo $form['recoverSuccess']; ?></div>
			  </div>
		  <?php
		  	  }
		  	  else if($recoverResult == 0) {
		  ?>
		  	  <div class="form-group">
			    <div id="pass-reset-fail" class="alert alert-success col-md-offset-1 col-md-8"><?php echo $form['ohNo']; ?></div>
			  </div>
		  <?php
		      }
		    }
		  ?>
		  <div class="form-group">
		    <label for="email" class="col-md-3 col-md-offset-1 control-label"><?php echo $form['email']; ?></label>
		    <div class="col-md-5">
		      <input type="email" class="form-control" id="email" name="user[email]" placeholder="<?php echo $form['email']; ?>" />
		      <p id="email-error" class="help-block"><?php echo $form['emailError']; ?></p>
		    </div>
		  </div>
		  <div id="or" class="col-md-offset-4 col-md-5">
		    <?php echo '-- '.$form['or'].' --'; ?>
		  </div>
		  <div class="form-group">
		    <label for="username" class="col-md-3 col-md-offset-1 control-label"><?php echo $form['username']; ?></label>
		    <div class="col-md-5">
		      <input type="text" class="form-control" id="username" name="user[uname]" placeholder="<?php echo $form['username']; ?>" />
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-5">
		      <button type="button" id="pass-reset-btn" class="btn btn-primary"><?php echo $form['recover']; ?></button>
		    </div>
		  </div>
		</form>
	  </div>
	  <input type="hidden" id="lang" value="<?php echo $lang; ?>" />
	  <input type="hidden" id="pass-one-field-error" value="<?php echo $form['recoverOneFieldError']; ?>" />
	  <input type="hidden" id="pass-email-not-found-error" value="<?php echo $form['recoverEmailNotFound']; ?>" />
	  <input type="hidden" id="pass-username-not-found-error" value="<?php echo $form['recoverUsernameNotFound']; ?>" />
	<?php echo $left_part; ?>
  </div>
<?php echo $footer; ?>