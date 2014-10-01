var category_id = 0;
$(document).ready(function() {
	var question_options = getQuestionOptions($('#question-types').val());
	
	$('#language').val($('#lang_id').val());
	
	$('#language').on('change', function(){
		var lang = $(this).find('option:selected').attr('rel');
		window.location.href = '/' + lang + '/admin/surveys';
	});
	
	$('#add-category').on('click', function() {
		var new_cat_div = addCategory(category_id);
		$(this).before(new_cat_div);
		$('#new-survey-form').find('#category-div-'+category_id).slideDown('slow');
		category_id++;
	});
	
	$('#new-survey-form').on('click', '.add-subcategory', function() {
		var cat_id = $(this).attr('rel');
		var subcat_id = $(this).next().val();
		var new_subcat_div = addSubcategory(cat_id, subcat_id);
		$(this).before(new_subcat_div);
		$('#new-survey-form').find('#subcategory-div-'+cat_id+subcat_id).slideDown('slow');
		$(this).next().val(parseInt($(this).next().val())+1);
	});
	
	$('#new-survey-form').on('click', '.add-question', function() {
		// loader_icon = $(this).next().next();
		// loader_icon.show().css('display', 'inline-block');
		var cat_id = $(this).attr('rel').substring(0, parseInt($(this).attr('rel').indexOf(':')));
		var subcat_id = $(this).attr('rel').substring(parseInt($(this).attr('rel').indexOf(':')+1));
		var question_id = $(this).next().val();
		// bootbox.alert('cat_id: ' + cat_id + '<br/>subcat_id: ' + subcat_id + '<br/>question_id: ' + question_id);
		var new_question_div = addQuestion(cat_id, subcat_id, question_id);
		$(this).before(new_question_div);
		$('#new-survey-form').find('#question-div-'+cat_id+subcat_id+question_id).slideDown('slow');
		$(this).next().val(parseInt($(this).next().val())+1);
	});
	
	$('#new-survey-form').on('blur', 'input', function() {
		if($(this).val().length > 0) {
			$(this).hide();
			$(this).prev().hide();
			// var edit_icon = '<span class="glyphicon glyphicon-pencil"></span>';
			if($(this).hasClass('survey-input'))
				$(this).prev().before('<h3 class="active-header">'+/*$(this).prev().html()+': ' + */'<span>'+$(this).val()+'</span></h3>');
			else if($(this).hasClass('category-input'))
				$(this).prev().before('<h4 class="active-header">'+/*$(this).prev().html()+': ' + */'<span>'+$(this).val()+'</span></h4>');
			else if($(this).hasClass('subcategory-input'))
				$(this).prev().before('<h5 class="active-header">'+/*$(this).prev().html()+': ' + */'<span>'+$(this).val()+'</span></h5>');
			else if($(this).hasClass('question-input'))
				$(this).prev().before('<h6 class="active-header">'+/*$(this).prev().html()+': ' + */'<span>'+$(this).val()+'</span></h6>');
		}
	});
	
	$('#new-survey-form').on('blur', 'textarea', function() {
		if($(this).val().length > 0) {
			$(this).hide();
			$(this).prev().hide();
			// var edit_icon = '<span class="glyphicon glyphicon-pencil"></span>';
			$(this).prev().before('<h5 class="active-header">'+/*$(this).prev().html()+': ' + */'<span>'+$(this).val()+'</span></h5>');
		}
	});
	
	$('#new-survey-form').on('click', '.active-header', function() {
		$(this).next().show();
		$(this).next().next().show();
		$(this).remove();
	});
	
	$('#new-survey-form').on('click', '.glyphicon-remove', function() {
		$(this).parent().next().slideUp('400');
		$(this).parent().addClass('minimized');
		$(this).hide();
	});
	
	$('#new-survey-form').on('click', '.minimized', function() {
		$(this).next().slideDown('400');
		$(this).removeClass('minimized');
		$(this).find('span').show();
	});
	
	$('#new-survey-form').on('change', '.question-type', function() {
		$(this).find('option:first-child').attr('disabled', true);
		if($(this).val() != '3') {
			if($(this).next().hasClass('answer-options-div'))
				return;
			rel = $(this).attr('rel');
			cat_id =	rel.substring(0, parseInt(rel.indexOf(':')));
			subcat_id = rel.substring(parseInt(rel.indexOf(':'))+1, parseInt(rel.indexOf('#')));
			quest_id =	rel.substring(parseInt(rel.indexOf('#'))+1);
			// bootbox.alert('cat_id: ' + cat_id + '<br/>subcat_id: ' + subcat_id + '<br/>question_id: ' + quest_id);
			answer_options = getAnswerOptionsArea(cat_id, subcat_id, quest_id);
			$(this).after(answer_options);
			$('#new-survey-form').find('#answer-options-div'+cat_id+subcat_id+quest_id).slideDown('slow');
		}
		else if($(this).next().hasClass('answer-options-div')) {
			$(this).next().slideUp('slow', function() {
				$(this).remove();
			})
		}
	});
	
	$('#submit-survey').on('click', function() {
		$('#new-survey-form').submit();
	});
	
	function addCategory(id) {
		var category_div = '<div class="form-group category-div" id="category-div-'+id+'">'+
				      		'<ul class="list-group">'+
					  			'<li class="list-group-item">'+
					  				'<label for="category'+id+'">'+$('#categoryLabel').val()+'</label>'+
					  				'<input type="text" class="form-control category-input" id="category'+id+'" name="survey[category]['+id+']" placeholder="'+$('#categoryLabel').val()+'" />'+
					  			'</li>'+
					  			'<li class="list-group-item">'+
					  				'<button type="button" id="add-subcategory'+id+'" class="btn btn-sm btn-primary add-subcategory" rel="'+id+'"><span class="glyphicon glyphicon-plus"></span> '+$('#addSubcategory').val()+'</button>'+
					  				'<input type="hidden" value="0" />'+
					  			'</li>'+
					  		'</ul>'+
					  	'</div>';
					  	
		return category_div;
	}
	
	function addSubcategory(c_id, s_id) {
		var subcategory_div = '<div class="form-group subcategory-div" id="subcategory-div-'+c_id+s_id+'">'+
					      		'<ul class="list-group">'+
						  			'<li class="list-group-item">'+
						  				'<label for="subcategory-header'+c_id+s_id+'">'+$('#subcategoryHeader').val()+' <span class="glyphicon glyphicon-remove"></span></label>'+
						  				'<input type="text" class="form-control subcategory-input subcategory-header" id="subcategory-header'+c_id+s_id+'" name="survey[subcategory]['+c_id+']['+s_id+'][header]" placeholder="'+$('#subcategoryHeader').val()+'" />'+
						  				'<label for="subcategory-label'+c_id+s_id+'">'+$('#subcategoryLabel').val()+'</label>'+
						  				'<input type="text" class="form-control subcategory-input subcategory-label" id="subcategory-label'+c_id+s_id+'" name="survey[subcategory]['+c_id+']['+s_id+'][label]" placeholder="'+$('#subcategoryLabel').val()+'" />'+
						  			'</li>'+
						  			'<li class="list-group-item question-btn">'+
						  				'<button type="button" id="add-question'+c_id+s_id+'" class="btn btn-xs btn-warning add-question" rel="'+c_id+':'+s_id+'"><span class="glyphicon glyphicon-plus"></span> '+$('#addQuestion').val()+'</button>'+
						  				'<input type="hidden" value="0" />'+
						  				/*'<span class="glyphicon glyphicon-repeat fa-spin"></span>'+*/
						  			'</li>'+
						  		'</ul>'+
						  	  '</div>';
					  	
		return subcategory_div;
	}
	
	function getQuestionOptions(question_types) {
		quest_options = '<option value="-1">'+$('#questionType').val();
		
		quest_types = JSON.parse($('#question-types').val());
		for(i = 0; i < quest_types.length; i++)
			quest_options += '<option value="'+quest_types[i].id+'" rel="'+quest_types[i].codename+'">'+quest_types[i].description+'</option>';
		
		quest_options += '</option>';
		return quest_options;
		
	}
	
	function addQuestion(c_id, s_id, q_id) {
		var question_div = '<div class="form-group question-div" id="question-div-'+c_id+s_id+q_id+'">'+
					      		'<ul class="list-group">'+
						  			'<li class="list-group-item">'+
						  				'<label for="question-text'+c_id+s_id+q_id+'">'+$('#questionText').val()+'</label>'+
						  				'<textarea class="form-control question-textarea" id="question-text'+c_id+s_id+q_id+'" name="survey[question]['+c_id+']['+s_id+']['+q_id+'][text]"></textarea>'+
						  				'<label for="question-help'+c_id+s_id+q_id+'">'+$('#questionHelp').val()+' <span class="glyphicon glyphicon-remove"></span></label>'+
						  				'<textarea class="form-control question-textarea" id="question-help'+c_id+s_id+q_id+'" name="survey[question]['+c_id+']['+s_id+']['+q_id+'][help]"></textarea>'+
						  				'<select class="form-control input-sm question-type" id="question-type'+c_id+s_id+q_id+'" name="survey[question]['+c_id+']['+s_id+']['+q_id+'][type]" rel="'+c_id+':'+s_id+'#'+q_id+'">'+
						  				question_options+
						  				'</select>'+
						  			'</li>'+
						  		'</ul>'+
						  	  '</div>';
					  	
		return question_div;
	}
	
	function getAnswerOptionsArea(c_id, s_id, q_id) {
		var ans_options = '<div class="answer-options-div" id="answer-options-div'+c_id+s_id+q_id+'">'+
							'<label for="question-ans'+c_id+s_id+q_id+'">'+$('#answerOptions').val()+'</label>'+
							'<textarea class="form-control question-textarea" id="question-ans'+c_id+s_id+q_id+'" name="survey[question]['+c_id+']['+s_id+']['+q_id+'][answer_options]"></textarea>'+
							'<p class="help-block question-ans-help">'+$('#answerOptionsHelp').val()+'</p>'+
							'<div class="checkbox">'+
							  '<label for="question-other'+c_id+s_id+q_id+'" class="checkbox-label">'+$('#hasOther').val()+
							    '<input type="checkbox" class="form-control question-checkbox" id="question-other'+c_id+s_id+q_id+'" name="survey[question]['+c_id+']['+s_id+']['+q_id+'][has_other]" />'+
							  '</label>'+
							'</div>'+
							'<div class="checkbox">'+
							  '<label for="question-comment'+c_id+s_id+q_id+'" class="checkbox-label">'+$('#hasComment').val()+
							    '<input type="checkbox" class="form-control question-checkbox" id="question-comment'+c_id+s_id+q_id+'" name="survey[question]['+c_id+']['+s_id+']['+q_id+'][has_comment]" />'+
							  '</label>'+
							'</div>'+
						  '</div>';
						  
		return ans_options;
	}
});