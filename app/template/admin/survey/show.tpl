<?php echo $dashboard; ?>
	  <div class="col-md-10">
	  	<h2 id="survey-title"><?php echo $survey['title']; ?></h2>
	    <div class="page-title"><?php echo $showSurveyLang['surveyProgress']; ?></div>
	    <div class="progress">
		  <div id="survey-progress" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
		    <span id="survey-progress-span" class="sr-only"></span>
		  </div>
		</div>
		<form id="user-form" class="form-inline" role="form" onsubmit="return false;">
	  	  <div class="form-group">
	  	    <label for="user-fname"><?php echo $userLang['firstName']; ?></label>
	  	    <input type="text" id="user-fname" class="form-control" value="<?php echo isset($user) ? $user['first_name'] : ''; ?>" />
	  	  </div>
	  	  <div class="form-group">
	  	    <label for="user-lname"><?php echo $userLang['lastName']; ?></label>
	  	    <input type="text" id="user-lname" class="form-control" value="<?php echo isset($user) ? $user['last_name'] : ''; ?>" />
	  	  </div>
	  	  <div class="form-group">
	  	    <label for="user-email"><?php echo $userLang['email']; ?></label>
	  	    <input type="email" id="user-email" class="form-control" value="<?php echo isset($user) ? $user['email'] : ''; ?>" />
	  	  </div>
	  	  <div id="email-error-div" class="form-group">
	  	    <p id="email-error" class="help-block"><?php echo $showSurveyLang['emailError']; ?></p>
	  	  </div>
	  	</form>
	  	<div id="required-fields" class="alert alert-danger col-md-12"><?php echo $showSurveyLang['requiredFields']; ?></div>
		<div id="already-completed" class="alert alert-danger col-md-12"><?php echo $showSurveyLang['alreadyCompleted']; ?></div>
	      <form id="survey-form" role="form" method="post" onsubmit="return false;">
	      	<?php
	      		foreach($survey_categories as $category) {
	      			echo '<div id="category'.$category['id'].'" class="category-div">';
	      			echo '<h3 id="category-label-'.$category['id'].'">'.$category['label'].'</h3>';
	      			foreach($survey_subcategories[$category['id']] as $subcategory) {
	      				$subcat_header = !empty($subcategory['header']) ? $subcat_header.'<br />' : '';
	      				echo '<h4 id="subcategory-label-'.$subcategory['id'].'">'.$subcat_header.$subcategory['label'].'</h4>';
	      				foreach($survey_questions[$subcategory['id']] as $question) {
	      					$question_help = !empty($question['help']) ? '<p class="help-block">'.$question['help'].'</p>' : '';
	      					echo '<div class="form-group">';
	      					echo '<h5 id="question-label-'.$question['id'].'" for="question-id-'.$question['id'].'">'.$question['text'].'</h5>';
	      					echo getQuestionAnswers($question['id'], $question['type'], $question['answer_options'], $question['has_other'], $question['has_comment'], $showSurveyLang);
	      					echo $question_help;
	      					echo '</div>';
	      				}
	      			}
	      			echo '</div>';
	      		}
	      		
	      		echo '<button type"button" id="submit-button" class="btn btn-primary"><span class="glyphicon glyphicon-ok-sign"></span>'.$showSurveyLang['submitSurvey'].'</button>';
	      		echo '<ul class="pager">';
	      		echo '<li class="previous disabled"><a href="javascript:previousPage();">&larr; '.$pagingLang['previous'].'</a></li>';
	      		echo '<li class="next"><a href="javascript:nextPage();">'.$pagingLang['next'].' &rarr;</a></li>';
	      		echo '</ul>';
	      	?>
	      	
	  	    <input type="hidden" id="hidden-user-fname" name="user[fname]" value="<?php echo isset($user) ? $user['first_name'] : ''; ?>" />
	  	    <input type="hidden" id="hidden-user-lname" name="user[lname]" value="<?php echo isset($user) ? $user['last_name'] : ''; ?>" />
	  	    <input type="hidden" id="hidden-user-email" name="user[email]" value="<?php echo isset($user) ? $user['email'] : ''; ?>" />
		  </form>
		</div>
	</div>
	<input type="hidden" id="lang_id" value="<?php echo $lang_id; ?>" />
	<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
	<input type="hidden" id="total-categories" value="<?php echo $total_categories; ?>" />
	<input type="hidden" id="active-category" value="<?php echo $active_category; ?>" />
<?php echo $footer; ?>

<?php
	function getQuestionAnswers($id, $type, $answer_options, $has_other, $has_comment, $showSurveyLang) {
		switch($type) {
			case (1):
				return getRadio($id, $answer_options, $has_other, $has_comment, $showSurveyLang);
				break;
			case (2):
				return getCheckbox($id, $answer_options, $has_other, $has_comment, $showSurveyLang);
				break;
			case (3):
				return getTextarea($id);
				break;
			case (4):
				return getInputs($id, $answer_options);
				break;
		}
	}
	
	function getRadio($id, $answer_options, $has_other, $has_comment, $showSurveyLang) {
		$output = '';
		$answer_options = explode('-,-', $answer_options);
		$i = 1;
		
		foreach($answer_options as $option) {
			$other_class = ($has_other == 1 && $i == count($answer_options)) ? 'is-other' : '' ;
			$comment_class = ($has_comment == 1 && $i == count($answer_options)) ? 'is-comment' : '' ;
			$output .= '<div class="radio">';
			$output .= '<label>';
			$output .= '<input type="radio" class="'.$other_class.$comment_class.'" name="question['.$id.'][answer]" value="'.$i.'" rel="answer-'.$id.'" />'.$option;
			$output .= '</label>';
			$output .= '</div>';
			$i++;
		}
		
		if($has_other == 1)
			$output .= '<input type="text" class="form-control" id="other-'.$id.'" name="question['.$id.'][other]" disabled />';
		else if($has_comment == 1)
			$output .= '<p>'.$showSurveyLang['comment'].'</p><textarea id="comment-'.$id.'" class="form-control comment-area" rows="2" name="question['.$id.'][comment]"></textarea>';
			
		return $output;
	}
	
	function getCheckbox($id, $answer_options, $has_other, $has_comment, $showSurveyLang) {
		$output = '';
		$answer_options = explode('-,-', $answer_options);
		$i = 1;
		
		foreach($answer_options as $option) {
			$other_class = ($has_other == 1 && $i == count($answer_options)) ? 'is-other' : '' ;
			$comment_class = ($has_comment == 1 && $i == count($answer_options)) ? 'is-comment' : '' ;
			$output .= '<div class="checkbox">';
			$output .= '<label>';
			$output .= '<input type="checkbox" class="'.$other_class.$comment_class.'" name="question['.$id.'][answer]['.$i.']" rel="answer-'.$id.'-'.$i.'" />'.$option;
			$output .= '</label>';
			$output .= '</div>';
			$i++;
		}
		
		if($has_other == 1)
			$output .= '<input type="text" class="form-control" id="other-'.$id.'-'.($i-1).'" name="question['.$id.'][other]" disabled />';
		else if($has_comment == 1)
			$output .= '<p>'.$showSurveyLang['comment'].'</p><textarea id="comment-'.$id.'-'.($i-1).'" class="form-control comment-area" rows="2" name="question['.$id.'][comment]"></textarea>';
			
		return $output;
	}
	
	function getTextarea($id) {
		$output = '<textarea class="form-control input-area" rows="4" name="question['.$id.'][answer]"></textarea>';
		
		return $output;
	}
	
	function getInputs($id, $answer_options) {
		$output = '';
		$answer_options = explode('-,-', $answer_options);
		$i = 1;
		
		foreach($answer_options as $option) {
			$output .= '<div class="mult-input-div">';
			$output .= '<label class="mult-input-label pull-left">'.$option.'</label>';
			$output .= '<input type="text" class="form-control input-sm mult-input-text" name="question['.$id.'][answer]['.$i.']" />';
			$output .= '</div>';
			$i++;
		}
			
		return $output;
	}
?>