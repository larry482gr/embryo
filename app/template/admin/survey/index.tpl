<?php echo $dashboard; ?>
	  <div class="col-md-10">
	    <h3 class="page-title"><?php echo $surveyLang['pageTitle']; ?></h3>
	      <form class="form-inline" role="form">
		      <div class="form-group">
			    <label for="language-select" class="control-label"><?php echo $form['selectLanguage']; ?></label>
			    <select class="form-control input-sm" id="language">
			      <?php
			        foreach($languages as $key => $value) {
			          echo '<option value="'.$value['id'].'" rel="'.$key.'">'.$form[$value['language']].'</option>';
			        }
			      ?>
				</select>
		      </div>
		  </form>
		  <table id="surveys-table" class="table table-condensed table-bordered table-hover col-md-9">
		  	<thead><tr><th></th><th><?php echo $surveyLang['title']; ?></th><th class="center"><?php echo $surveyLang['alias']; ?></th><th class="center"><?php echo $surveyLang['surveyType']; ?></th></tr></thead>
		  	<tbody>
		    <?php
		    	$table_rows = '';
				$i = 1;
				if(!empty($surveys)) {
			    	foreach($surveys as $survey) {
			    		$alias = empty($survey['alias']) ? '-' : $survey['alias'] ;
			    		$survey_type = $survey['is_public'] == 0 ? $surveyLang['surveyPrivate'] : $surveyLang['surveyPublic'];
			    		$table_rows .= '<tr>';
			    		$table_rows .= '<td class="center" rel="'.$survey['id'].'">'.$i++.'</td>';
			    		$table_rows .= '<td id="survey-title-'.$survey['id'].'" rel="'.$survey['id'].'">'.$survey['title'].'</td>';
			    		$table_rows .= '<td class="center" id="survey-alias-'.$survey['id'].'">'.$alias.'</td>';
			    		$table_rows .= '<td class="center" id="survey-type-'.$survey['id'].'">'.$survey_type.'</td>';
			    		$table_rows .= '</tr>';
			    	}
				}
				else {
					$table_rows .= '<tr>';
					$table_rows .= '<td class="center" colspan="4">'.$surveyLang['noResults'].'</td>';
					$table_rows .= '</tr>';
				}
				echo $table_rows;
		    ?>
		    </tbody>
		  </table>
		  <a href="<?php echo '/'.$lang.'/admin/surveys/newSurvey'; ?>" id="create-survey" class="btn btn-primary"><?php echo $surveyLang['createSurvey']; ?></a>
		  
		</div>
	</div>
	<input type="hidden" id="lang_id" value="<?php echo $lang_id; ?>" />
	<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>