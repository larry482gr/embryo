<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
      <h3 class="page-title"><?php echo $contact['pageTitle']; ?></h3>
      <h4 class="form-title"><?php echo $form['contactForm']; ?></h4>
      <div class="row">
      	<div class="col-md-7 col-sm-7">
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
		</form>
	  	</div>
	  	<div class="col-md-5 col-sm-5">
	  	  <div class="contact-info">
	  	    <div><span class="glyphicon glyphicon-user"></span>Ε. Συμεωνίδου – Καστανίδου</div>
	  	    <div><span class="glyphicon glyphicon-briefcase"></span><a class="geo-link" href="geo:Αριστοτέλειο Πανεπιστήμιο?q=Αριστοτέλειο Πανεπιστήμιο">Νομική Σχολή ΑΠΘ, γρ. 205</a></div>
	  	    <div><span class="glyphicon glyphicon-phone-alt"></span>Τηλ: <a href="tel:+302310996496">2310 996496</a> / <a href="tel:+302310344308">344308</a></div>
	  	    <div><span class="glyphicon glyphicon-print"></span>Φαξ: 2310 996494</div>
	  	    <div><span class="glyphicon glyphicon-envelope"></span><a href="mailto:kastan@law.auth.gr">kastan@law.auth.gr</a></div>
	  	  </div>
	  	  <div class="contact-info">
	  	    <div><span class="glyphicon glyphicon-user"></span>B. Ταρλατζής</div>
	  	    <div><span class="glyphicon glyphicon-briefcase"></span><a class="geo-link" href="geo:Αριστοτέλειο Πανεπιστήμιο?q=Αριστοτέλειο Πανεπιστήμιο">Σχολή Επιστημών Υγείας AΠΘ</a></div>
	  	    <div><span class="glyphicon glyphicon-phone-alt"></span>Τηλ: <a href="tel:+302310991182">2310 991182</a></div>
	  	    <div><span class="glyphicon glyphicon-envelope"></span><a href="mailto:tarlatzis@gmail.com">tarlatzis@gmail.com</a></div>
	  	  </div>
	  	</div>
      </div>
	</div>
	<?php echo $left_part; ?>  
	</div>
  </div>
  <input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>