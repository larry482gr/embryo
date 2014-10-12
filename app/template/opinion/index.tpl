<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
      <h3 class="page-title"><?php echo $opinion['pageTitle']; ?></h3>
      	  <?php
	        if(!empty($invalidError)) {
	      ?>
	      <div class="form-group">
		    <div class="alert alert-danger col-md-8"><?php echo $invalidError; ?></div>
		  </div>
		  <?php
		    }
		  ?>
		  <?php
	        if(!empty($successMessage)) {
	      ?>
	      <div class="form-group">
		    <div class="alert alert-success col-md-8"><?php echo $successMessage; ?></div>
		  </div>
		  <?php
		    }
		  ?>
      <div class="row">
      	<div class="col-md-7 col-sm-7">
      	  <ul class="links-ul">
      	    <li><a href="<?php echo '/'.$lang.'/survey/'.$opinionSurvey['id']; ?>"><?php echo $opinion['surveyLink']; ?></a></li>
      	    <li><a href="javascript:showHideForm()"><?php echo $form['opinionForm']; ?></a></li>
      	  </ul>
      	  <form id="contact-form" class="form-horizontal" role="form" method="post">
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
		    <label for="full_name" class="col-md-4 col-sm-4 col-xs-12 control-label"><?php echo $form['fullName']; ?></label>
		    <div class="col-md-7 col-sm-7 col-xs-9">
		      <input type="text" class="form-control" id="full_name" name="contact[full_name]" placeholder="<?php echo $form['fullName']; ?>">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="email" class="col-md-4 col-sm-4 col-xs-12 control-label"><?php echo $form['email']; ?></label>
		    <div class="col-md-7 col-sm-7 col-xs-9">
		      <input type="email" class="form-control" id="email" name="contact[email]" placeholder="<?php echo $form['email']; ?>">
		      <p id="email-error" class="help-block"><?php echo $form['emailError']; ?></p>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="subject" class="col-md-4 col-sm-4 col-xs-12 control-label"><?php echo $form['subject']; ?></label>
		    <div class="col-md-7 col-sm-7 col-xs-9">
		      <input type="text" class="form-control" id="subject" name="contact[subject]" placeholder="<?php echo $form['subject']; ?>">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="message" class="col-md-4 col-sm-4 col-xs-12 control-label"><?php echo $form['message']; ?></label>
		    <div class="col-md-7 col-sm-7 col-xs-9">
		      <textarea rows="9" class="form-control" id="message" name="contact[message]"><?php echo $form['messagePlaceholder']; ?></textarea>
		      <p id="required-block" class="help-block"><?php echo $form['allRequired']; ?></p>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-sm-offset-4 col-md-4 col-sm-4">
		      <button type="button" class="btn btn-primary"><span class="glyphicon glyphicon-send"></span><?php echo $form['send']; ?></button>
		    </div>
		  </div>
		  <input type="hidden" id="message-placeholder" value="<?php echo $form['messagePlaceholder']; ?>" />
		  <input type="hidden" id="opinion-form" value="1" />
		</form>
	  	</div>
      </div>
	</div>
	<?php echo $left_part; ?>  
	</div>
  </div>
  <input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>