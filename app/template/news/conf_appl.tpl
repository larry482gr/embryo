<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
      <div class="panel panel-primary">
	      <div class="panel-heading">
	        <div class="panel-title"><?php echo $confAppl['onlineAppl']; ?></div>
	      </div>
	      <div class="panel-body">
	        <form id="conf-appl-form" class="form-horizontal" role="form" action="/news/send_application" method="post">
	        <dl>
	          <dt><h5><?php echo $confAppl['personalInfo']; ?></h5></dt>
	            <dd>
					  <div class="form-group">
					    <label for="appl-title" class="col-sm-3 control-label"><?php echo $confAppl['title']; ?>: </label>
					    <div class="col-sm-9 col-md-4">
					      <select id="appl-title" class="form-control" name="appl[title]">
					        <?php
					          foreach($confAppl['titleOptions'] as $titleOption) {
					            echo '<option value="'.$titleOption.'">'.$titleOption.'</option>';
					          }
					        ?>
					      </select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-fname" class="col-sm-3 control-label"><?php echo $confAppl['fname']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="text" class="form-control" id="appl-fname" name="appl[fname]" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-lname" class="col-sm-3 control-label"><?php echo $confAppl['lname']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="text" class="form-control" id="appl-lname" name="appl[lname]" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-faculty" class="col-sm-3 control-label"><?php echo $confAppl['faculty']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="text" class="form-control" id="appl-faculty" name="appl[faculty]" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-country" class="col-sm-3 control-label"><?php echo $confAppl['country']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <select id="appl-country" class="form-control" name="appl[country]">
					        <?php
					          foreach($countryList as $country) {
					            $selected = $country == 'Greece' ? 'selected="selected"' : '';
					            echo '<option value="'.$country.'" '.$selected.'>'.$country.'</option>';
					          }
					        ?>
					      </select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-city" class="col-sm-3 control-label"><?php echo $confAppl['city']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="text" class="form-control" id="appl-city" name="appl[city]" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-pocode" class="col-sm-3 control-label"><?php echo $confAppl['pocode']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="text" class="form-control" id="appl-pocode" name="appl[pocode]" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-address" class="col-sm-3 control-label"><?php echo $confAppl['address']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="text" class="form-control" id="appl-address" name="appl[address]" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-mcc" class="col-sm-3 control-label"><?php echo $confAppl['phoneCountryCode']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="tel" class="form-control" id="appl-mcc" name="appl[mcc]" placeholder="30" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-mnc" class="col-sm-3 control-label"><?php echo $confAppl['phoneCityCode']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="tel" class="form-control" id="appl-mnc" name="appl[mnc]" placeholder="2310" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-tel" class="col-sm-3 control-label"><?php echo $confAppl['phoneNumber']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="tel" class="form-control" id="appl-tel" name="appl[tel]" placeholder="123456" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-fax" class="col-sm-3 control-label"><?php echo $confAppl['fax']; ?>:</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="tel" class="form-control" id="appl-fax" name="appl[fax]" placeholder="123456" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="appl-email" class="col-sm-3 control-label"><?php echo $confAppl['email']; ?>: *</label>
					    <div class="col-sm-9 col-md-4">
					      <input type="email" class="form-control" id="appl-email" name="appl[email]" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-12 control-label"><?php echo $confAppl['interest']; ?>:</label>
					    <div class="radio col-md-12">
						  <label>
						    <input type="radio" name="material" id="appl-material1" value="1" checked="checked">
						    <?php echo $confAppl['watch']; ?>
						  </label>
						</div>
						<div class="radio col-md-12">
						  <label>
						    <input type="radio" name="material" id="appl-material2" value="2">
						    <?php echo $confAppl['watchAndGet']; ?>
						  </label>
						</div>
					  </div>
	            </dd>
	            <dt><h5><?php echo $confAppl['finance']; ?></h5></dt>
	            <dd>
	              <h4 id="contact-tel"><?php echo $confAppl['contactPhones']; ?>: <span><?php echo $confAppl['contactPhoneNumbers']; ?></span></h4>
	            </dd>
	            <dd>
	              <div class="form-group" id="conf-submit">
	                <button type="button" id="appl-submit" class="btn btn-danger"><?php echo $confAppl['submit']; ?></button>
				  </div>
	        </dl>
	        </form>
	      </div>
      </div>
	</div>
	<script type="text/javascript">
	  var success = '<?php echo $confAppl['success']; ?>';
	  var required_fields = '<?php echo $confAppl['required']; ?>';
	  var invalid_email = '<?php echo $confAppl['invalidEmail']; ?>';
	  var at_least_one = '<?php echo $confAppl['atLeastOne']; ?>';
	  var only_digits = '<?php echo $confAppl['onlyNumeric']; ?>';
	</script>
	<?php echo $left_part; ?>  
  </div>
</div>
<?php echo $footer; ?>