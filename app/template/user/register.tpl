<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
	    <h3 class="page-title"><?php echo $form['regForm']; ?></h3>
		    <form id="register-form" class="form-horizontal" role="form" method="post" action="<?php echo '/'.$lang.'/user/register/' ?>" onsubmit="$('#register-btn').click(); return false;">
		      <?php
		        if(isset($registerSuccess)) {
		      ?>
		        <div id="register-success" class="form-group">
			      <div class="alert alert-success col-md-9"><?php echo $registerSuccess; ?></div>
			    </div>
			  <?php
			    }
			    else if(isset($registerError)) {
			  ?>
			    <div id="register-error" class="form-group">
			      <div class="alert alert-danger col-md-9"><?php echo $registerError; ?></div>
			    </div>
			  <?php
			    }
			  ?>
		      <div id="fill-all-error" class="form-group">
			    <div class="alert alert-danger col-md-offset-1 col-md-8"><?php echo $form['fillAll']; ?></div>
			  </div>
			  <div class="form-group">
			    <h4 class="col-md-4 control-label"><?php echo $form['accessInfo']; ?></h4>
			  </div>
			  <div class="form-group">
			    <label for="username" class="col-md-4 control-label"><?php echo $form['username']; ?></label>
			    <div class="col-md-5">
			      <div id="username-input" class="pull-left">
			        <input type="text" class="form-control" id="username" name="user[uname]" placeholder="<?php echo $form['username']; ?>" value="<?php echo $username; ?>" />
			      </div>
			      <div id="username-availability" class="pull-right">
			        <span><?php echo $form['available']; ?></span>
			        <span><?php echo $form['notAvailable']; ?></span>
			      </div>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email" class="col-md-4 control-label"><?php echo $form['email']; ?></label>
			    <div class="col-md-5">
			      <input type="email" class="form-control" id="email" name="user[email]" placeholder="email" value="<?php echo $email; ?>" />
			      <div id="email-availability" class="pull-right">
			        <span><?php echo $form['available']; ?></span>
			        <span><?php echo $form['notAvailable']; ?></span>
			      </div>
			      <p id="email-error" class="help-block"><?php echo $form['emailError']; ?></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="pass" class="col-md-4 control-label"><?php echo $form['password']; ?></label>
			    <div class="col-md-5">
			      <input type="password" class="form-control" id="pass" name="user[pass]" placeholder="<?php echo $form['password']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="confirm-pass" class="col-md-4 control-label"><?php echo $form['confirmPass']; ?></label>
			    <div class="col-md-5">
			      <div id="confirm-input" class="pull-left">
			        <input type="password" class="form-control" id="confirm-pass" name="user[confPass]" placeholder="<?php echo $form['confirmPass']; ?>" />
			      </div>
			      <div id="confirm-sign" class="pull-right">
			        <span class="glyphicon glyphicon-ok-sign"></span>
			        <span class="glyphicon glyphicon-remove-sign"></span>
			      </div>
			    </div>
			  </div>
			  <div class="form-group">
			    <h4 class="col-md-4 control-label"><?php echo $form['userInfo']; ?></h4>
			  </div>
			  <div class="form-group">
			    <label for="firstName" class="col-md-4 control-label"><?php echo $userLang['firstName']; ?></label>
			    <div class="col-md-5">
			      <input type="text" class="form-control" id="firstName" name="user[firstName]" placeholder="<?php echo $userLang['firstName'] ?>" value="<?php echo $user['firstName']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="lastName" class="col-md-4 control-label"><?php echo $userLang['lastName']; ?></label>
			    <div class="col-md-5">
			      <input type="text" class="form-control" id="lastName" name="user[lastName]" placeholder="<?php echo $userLang['lastName'] ?>" value="<?php echo $user['lastName']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="faculty" class="col-md-4 control-label"><?php echo $userLang['faculty']; ?></label>
			    <div class="col-md-5">
			      <input type="text" class="form-control" id="faculty" name="user[faculty]" placeholder="<?php echo $userLang['faculty']; ?>" value="<?php echo $user['faculty']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="postalAddress" class="col-md-4 control-label"><?php echo $userLang['postalAddress']; ?></label>
			    <div class="col-md-5">
			      <input type="text" class="form-control" id="postalAddress" name="user[postalAddress]" placeholder="<?php echo $userLang['postalAddress']; ?>" value="<?php echo $user['postalAddress']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="phoneNumber" class="col-md-4 control-label"><?php echo $userLang['phoneNumber']; ?></label>
			    <div class="col-md-5">
			      <input type="tel" class="form-control" id="phoneNumber" name="user[phoneNumber]" placeholder="<?php echo $userLang['phoneNumber']; ?>" value="<?php echo $user['phoneNumber']; ?>" />
			    </div>
			  </div>
			  <div class="form-group">
			    <div class="col-md-offset-4 col-md-4">
			      <button type="submit" id="register-btn" class="btn btn-sm btn-primary"><?php echo $form['submit']; ?></button>
				  <a href="<?php echo $referer; ?>" class="btn btn-sm btn-default"><?php echo $form['back']; ?></a>
			    </div>
			  </div>
			  <input type="hidden" id="referer" name="referer" value="<?php echo $referer ?>" />
			</form>
	</div>
	<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
	<?php echo $left_part; ?>  
	</div>
  </div>
<?php echo $footer; ?>