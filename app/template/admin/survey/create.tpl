<?php echo $dashboard; ?>
	  <div class="col-md-10">
	    <h3 class="page-title"><?php echo $surveyLang['createPageTitle']; ?></h3>
	      <form id="new-survey-form" class="col-lg-12 col-md-12 col-sm-12 col-xs-12" role="form" method="post">
		    <div class="form-group">
		      <label for="survey-title"><?php echo $surveyLang['title']; ?></label>
		      <input type="text" class="form-control survey-input" id="survey-title" name="survey[title]" placeholder="<?php echo $surveyLang['title']; ?>"/>
		    </div>
		    <div class="form-group">
		      <label for="survey-alias"><?php echo $surveyLang['alias']; ?></label>
		      <input type="text" class="form-control survey-input" id="survey-alias" name="survey[alias]" placeholder="<?php echo $surveyLang['alias']; ?>"/>
		    </div>
		    <div class="form-group">
		      <label for="survey-type"><?php echo $surveyLang['surveyType']; ?></label>
		      <select class="form-control survey-input" id="survey-type" name="survey[surveyType]">
		        <option value="1"><?php echo $surveyLang['surveyPublic']; ?></option>
		        <option value="0" selected="selected"><?php echo $surveyLang['surveyPrivate']; ?></option>
		      </select>
		    </div>
		    <div class="form-group">
		      <button id="add-category" class="btn btn-success" type="button"><span class="glyphicon glyphicon-plus"></span> <?php echo $surveyLang['addCategory']; ?></button>
		    </div>
		    <div class="form-group">
 		      <button id="submit-survey" class="btn btn-danger" type="submit"><span class="glyphicon glyphicon-save"></span> <?php echo $form['submit']; ?></button>
		    </div>
		  </form>
		</div>
	</div>
	<input type="hidden" id="lang_id" value="<?php echo $lang_id; ?>" />
	<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
	<input type="hidden" id="addSubcategory" value="<?php echo $surveyLang['addSubcategory']; ?>" />
	<input type="hidden" id="addQuestion" value="<?php echo $surveyLang['addQuestion']; ?>" />
	<input type="hidden" id="categoryLabel" value="<?php echo $surveyLang['categoryLabel']; ?>" />
	<input type="hidden" id="subcategoryHeader" value="<?php echo $surveyLang['subcategoryHeader']; ?>" />
	<input type="hidden" id="subcategoryLabel" value="<?php echo $surveyLang['subcategoryLabel']; ?>" />
<?php echo $footer; ?>