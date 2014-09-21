<?php echo $dashboard; ?>
	  <div class="col-md-10">
	    <h3 class="page-title"><?php echo $surveyLang['createPageTitle']; ?></h3>
	      <form id="new-survey-form" class="col-lg-6 col-md-8 col-sm-12 col-xs-12" role="form" method="post">
		    <div class="form-group">
		      <label for="survey-title"><?php echo $surveyLang['title']; ?></label>
		      <input type="text" class="form-control" id="survey-title" name="survey[title]" placeholder="<?php echo $surveyLang['title']; ?>">
		    </div>
		    <div class="form-group">
		      <label for="survey-alias"><?php echo $surveyLang['alias']; ?></label>
		      <input type="text" class="form-control" id="survey-alias" name="survey[alias]" placeholder="<?php echo $surveyLang['alias']; ?>">
		    </div>
		    <div class="form-group">
		      <label for="survey-type"><?php echo $surveyLang['surveyType']; ?></label>
		      <select class="form-control" id="survey-type" name="survey[surveyType]">
		        <option value="1"><?php echo $surveyLang['surveyPublic']; ?></option>
		        <option value="0" selected="selected"><?php echo $surveyLang['surveyPrivate']; ?></option>
		      </select>
		    </div>
		    <div class="form-group">
		      <button id="add-category" class="btn btn-primary" type="button"><span class="glyphicon glyphicon-plus"></span> <?php echo $surveyLang['addCategory']; ?></button>
		    </div>
		    <div class="form-group">
 		      <button id="submit-survey" class="btn btn-success" type="submit"><span class="glyphicon glyphicon-save"></span> <?php echo $form['submit']; ?></button>
		    </div>
		  </form>
		</div>
	</div>
	<input type="hidden" id="lang_id" value="<?php echo $lang_id; ?>" />
	<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>