<?php echo $header; ?>
	  <div class="row">
	  	<h2 id="survey-title"><?php echo $survey['title']; ?></h2>
	    <div class="page-title"><?php echo $showSurveyLang['surveyProgress']; ?></div>
	    <div class="progress">
		  <div id="survey-progress" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
		    <span id="survey-progress-span" class="sr-only"></span>
		  </div>
		</div>
		<div class="col-md-12">
	      	<?php
	      		foreach($survey_categories as $category) {
	      			echo '<div id="category'.$category['id'].'" class="category-div">';
	      			echo '<h3 id="category-label-'.$category['id'].'">'.$category['label'].'</h3>';
	      			foreach($survey_subcategories[$category['id']] as $subcategory) {
	      				$subcat_header = !empty($subcategory['header']) ? $subcategory['header'].'<br /><br />' : '';
	      				echo '<h4 id="subcategory-label-'.$subcategory['id'].'">'.$subcat_header.$subcategory['label'].'&nbsp;&nbsp;<span class="show-all-answers-label label label-success" rel="'.$subcategory['id'].'">'.$showSurveyLang['showAllAnswers'].'</span></h4>';
	      				foreach($survey_questions[$subcategory['id']] as $question) {
	      					$question_help = !empty($question['help']) ? '<p class="help-block">'.$question['help'].'</p>' : '';
	      					echo '<div class="form-group">';
	      					echo '<h5 id="question-label-'.$question['id'].'" for="question-id-'.$question['id'].'">'.$question['text'].'</h5>';
	      					echo getQuestionAnswers($question['id'], $question['type'], $question['answer_options'], $question['has_other'], $question['has_comment'], $showSurveyLang, $subcategory['id']);
	      					echo $question_help;
	      					echo '</div>';
	      				}
	      			}
	      			echo '</div>';
	      		}
	      		
	      		echo '<ul class="pager">';
	      		echo '<li class="previous disabled"><a href="javascript:previousPage();">&larr; '.$pagingLang['previous'].'</a></li>';
	      		echo '<li class="next"><a href="javascript:nextPage();">'.$pagingLang['next'].' &rarr;</a></li>';
	      		echo '</ul>';
	      	?>
		</div>
		</div>
	</div>
	<input type="hidden" id="lang_id" value="<?php echo $lang_id; ?>" />
	<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
	<input type="hidden" id="total-categories" value="<?php echo $total_categories; ?>" />
	<input type="hidden" id="active-category" value="<?php echo $active_category; ?>" />
	<input type="hidden" id="show-answers" value="<?php echo $showSurveyLang['showAnswers']; ?>" />
	<input type="hidden" id="hide-answers" value="<?php echo $showSurveyLang['hideAnswers']; ?>" />
	<input type="hidden" id="show-all-answers" value="<?php echo $showSurveyLang['showAllAnswers']; ?>" />
	<input type="hidden" id="hide-all-answers" value="<?php echo $showSurveyLang['hideAllAnswers']; ?>" />
	<div id="chart_div"></div>
<?php echo $footer; ?>

<script type="text/javascript">
	var countries = <?php echo json_encode($countries); ?>;
</script>

<?php
	function getQuestionAnswers($id, $type, $answer_options, $has_other, $has_comment, $showSurveyLang, $subcatId) {
		switch($type) {
			case (1):
				return getRadio($id, $type, $answer_options, $has_other, $has_comment, $showSurveyLang, $subcatId);
				break;
			case (2):
				return getCheckbox($id, $type, $answer_options, $has_other, $has_comment, $showSurveyLang, $subcatId);
				break;
			case (3):
				return '<div class="row"><div class="col-md-12"><span id="show-'.$id.'" class="show-answers-label label label-primary sub-label-'.$subcatId.'" rel="'.$id.':'.$type.'">'.$showSurveyLang['showAnswers'].'</span></div></div>';
				break;
			case (4):
				return getInputs($id, $type, $answer_options, $showSurveyLang, $subcatId);
				break;
		}
	}
	
	function getRadio($id, $type, $answer_options, $has_other, $has_comment, $showSurveyLang, $subcatId) {
		$output = '';
		$answer_options = explode('-,-', $answer_options);
		
		$output = '<div class="row"><div class="col-md-12">';
		$output .= '<span id="show-'.$id.'" class="show-answers-label label label-primary sub-label-'.$subcatId.'" rel="'.$id.':'.$type.'">'.$showSurveyLang['showAnswers'].'</span>';
		$output .= $showSurveyLang['possibleAnswers'];
		$possibleAnswers = '';
		foreach($answer_options as $option) {
			$possibleAnswers .= $option.'-,-';
		}
		$possibleAnswers = substr($possibleAnswers, 0, -3);
		$possibleAnswersText = str_replace('-,-', ', ', $possibleAnswers);
		$output .= '<span class="possible-answers" rel="'.$possibleAnswers.'">'.$possibleAnswersText.'</span>';
		$output .= '</div></div>';
			
		return $output;
	}
	
	function getCheckbox($id, $type, $answer_options, $has_other, $has_comment, $showSurveyLang, $subcatId) {
		$output = '';
		$answer_options = explode('-,-', $answer_options);
		
		$output = '<div class="row"><div class="col-md-12">';
		$output .= '<span id="show-'.$id.'" class="show-answers-label label label-primary sub-label-'.$subcatId.'" rel="'.$id.':'.$type.'">'.$showSurveyLang['showAnswers'].'</span>';
		$output .= $showSurveyLang['possibleAnswers'];
		$possibleAnswers = '';
		foreach($answer_options as $option) {
			$possibleAnswers .= $option.'-,-';
		}
		$possibleAnswers = substr($possibleAnswers, 0, -3);
		$possibleAnswersText = str_replace('-,-', ', ', $possibleAnswers);
		$output .= '<span class="possible-answers" rel="'.$possibleAnswers.'">'.$possibleAnswersText.'</span>';
		$output .= '</div></div>';
			
		return $output;
	}
	
	function getInputs($id, $type, $answer_options, $showSurveyLang, $subcatId) {
		$output = '';
		$answer_options = explode('-,-', $answer_options, $subcatId);
		
		$output = '<div class="row"><div class="col-md-12">';
		$output .= '<span id="show-'.$id.'" class="show-answers-label label label-primary sub-label-'.$subcatId.'" rel="'.$id.':'.$type.'">'.$showSurveyLang['showAnswers'].'</span>';
		$output .= $showSurveyLang['possibleAnswers'];
		foreach($answer_options as $option) {
			$output .= $option.', ';
		}
		$output = substr($output, 0, -2);
		$output .= '</div></div>';
			
		return $output;
	}
?>