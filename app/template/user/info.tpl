<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
	    <h3 class="page-title"><?php echo $userLang['info']; ?></h3>
	    <?php
	      if(!$edit) {
	    ?>
		    <p>
		      <?php echo '<b>'.$userLang['firstName'].':</b> '.$user['firstName']; ?>
		    </p>
		    <p>
		      <?php echo '<b>'.$userLang['lastName'].':</b> '.$user['lastName']; ?>
		    </p>
		    <p>
		      <?php echo '<b>'.$userLang['email'].':</b> '.$user['email']; ?>
		    </p>
		    <a href="<?php echo $user['id'].'/edit'; ?>" class="btn btn-sm btn-warning"><?php echo $form['edit']; ?></a>
		    <a href="<?php echo $referer; ?>" class="btn btn-sm btn-default"><?php echo $form['back']; ?></a>
		<?php
		  } else {
		?>
			<form id="edit-form" class="form-horizontal" role="form" method="post">
			  <div class="form-group">
			    <label for="first-name" class="col-md-3 col-md-offset-1 control-label"><?php echo $userLang['firstName']; ?></label>
			    <div class="col-md-5">
			      <input type="text" class="form-control" id="first-name" name="user[firstName]" placeholder="<?php echo $userLang['firstName']; ?>" value="<?php echo $user['firstName']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="last-name" class="col-md-3 col-md-offset-1 control-label"><?php echo $userLang['lastName']; ?></label>
			    <div class="col-md-5">
			      <input type="text" class="form-control" id="last-name" name="user[lastName]" placeholder="<?php echo $userLang['lastName']; ?>" value="<?php echo $user['lastName']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email" class="col-md-3 col-md-offset-1 control-label"><?php echo $userLang['email']; ?></label>
			    <div class="col-md-5">
			      <input type="email" class="form-control" id="email" name="user[email]" placeholder="email" value="<?php echo $user['email']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <div class="col-md-offset-4 col-md-4">
			      <button type="submit" class="btn btn-sm btn-primary"><?php echo $form['submit']; ?></button>
				  <a href="<?php echo $referer; ?>" class="btn btn-sm btn-default"><?php echo $form['back']; ?></a>
			    </div>
			  </div>
			</form>
			<div id="change-pass" class="col-md-4 col-md-offset-4">
			  <?php echo $form['changePass']; ?>
			</div>
			<form id="change-pass-form" class="form-horizontal" role="form" method="post">
			  <div id="welcome" class="form-group">
			    <div class="alert alert-success col-md-offset-1 col-md-8"></div>
			  </div>
		      <div id="change-pass-error" class="form-group">
			    <div class="alert alert-danger col-md-offset-1 col-md-8"></div>
			  </div>
			  <div id="fill-all-error" class="form-group">
			    <div class="alert alert-danger col-md-offset-1 col-md-8"><?php echo $form['fillAll']; ?></div>
			  </div>
			  <div class="form-group">
			    <label for="old-pass" class="col-md-4 control-label"><?php echo $form['oldPass']; ?></label>
			    <div class="col-md-5">
			      <input type="password" class="form-control" id="old-pass" name="user[oldPass]" placeholder="<?php echo $form['oldPass']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="new-pass" class="col-md-4 control-label"><?php echo $form['newPass']; ?></label>
			    <div class="col-md-5">
			      <input type="password" class="form-control" id="new-pass" name="user[newPass]" placeholder="<?php echo $form['newPass']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="confirm-pass" class="col-md-4 control-label"><?php echo $form['confirmPass']; ?></label>
			    <div class="col-md-5">
			      <input type="password" class="form-control" id="confirm-pass" name="user[confirmPass]" placeholder="<?php echo $form['confirmPass']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <div class="col-md-offset-4 col-md-4">
			      <button type="button" id="change-pass-btn" class="btn btn-sm btn-primary"><?php echo $form['submit']; ?></button>
			    </div>
			  </div>
			</form>
		<?php
		  }
		?>
	</div>
	<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
	<?php echo $left_part; ?>  
	</div>
  </div>
<?php echo $footer; ?>