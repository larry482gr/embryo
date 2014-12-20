$(document).ready(function() {
	// alert(JSON.stringify(countries));
	
	$('.container').on('click', '.show-answers-label', function() {
		var thisLabel = $(this);
		var questionDiv = $(this).parent().parent();
		var questionId = $(this).attr('rel').substring(0, $(this).attr('rel').indexOf(':'));
		var questionType = $(this).attr('rel').substring($(this).attr('rel').indexOf(':')+1);
		$.ajax({
			url: "/research_survey/getAnswers/" + questionId,
			method: 'post',
			dataType: "json",
			data: {
				question_type: questionType
			},
			success: function(result) {
				if(questionType < 3) {
					questionDiv.after(showAnswersTable(result));
				}
				else if(questionType >= 3) {
					questionDiv.after(showPlainAnswers(result));
				}
				questionDiv.next().slideDown('fast', function() {
					toggleShowHideLabel(thisLabel);
				});
			}
		});
	});
	
	$('.container').on('click', '.hide-answers-label', function() {
		var thisLabel = $(this);
		thisLabel.parent().parent().next().slideUp('fast', function() {
			$(this).remove();
			toggleShowHideLabel(thisLabel);
		});
	});
	
	$('.container').on('click', '.show-all-answers-label', function() {
		var subcatId = $(this).attr('rel');
		$('.container').find('.sub-label-'+subcatId).each(function() {
			if($(this).hasClass('show-answers-label')) {
				$(this).click();
			}
		});
		$(this).removeClass('show-all-answers-label');
		$(this).addClass('hide-all-answers-label');
		$(this).text($('#hide-all-answers').val());
	});
	
	$('.container').on('click', '.hide-all-answers-label', function() {
		var subcatId = $(this).attr('rel');
		$('.container').find('.sub-label-'+subcatId).each(function() {
			if($(this).hasClass('hide-answers-label')) {
				$(this).click();
			}
		});
		$(this).removeClass('hide-all-answers-label');
		$(this).addClass('show-all-answers-label');
		$(this).text($('#show-all-answers').val());
	});
	
	function showAnswersTable(jsonResponse) {
		var answersThead = '<thead><tr>';
		var answersTbody = '<tbody><tr>';
		
		for(i = 0; i < jsonResponse.length; i++) {
			answersThead += '<th>' + countries[i] + '</th>';
			answersTbody += '<td>' + jsonResponse[i].answer + '</td>';
		}
		
		answersThead += '</tr></thead>';
		answersTbody += '</tr></tbody>';
		
		var answersTable = '<div class="row answers-row"><div class="col-md-12"><table class="table">' + answersThead + answersTbody + '</table></div></div>';
		
		return answersTable;
	}
	
	function showPlainAnswers(jsonResponse) {
		answers = '<div class="row answers-row">';
		
		for(i = 0; i < jsonResponse.length; i++) {
			answers += '<div class="col-md-12 input-div">';
			answers += '<h5>'+countries[i]+'</h5>';
			answers += jsonResponse[i].answer;
			answers += '</div>';
		}
		
		answers += '</div>';
		
		return answers;
	}
	
	function toggleShowHideLabel(showHideLabel) {
		if(showHideLabel.hasClass('show-answers-label')) {
			showHideLabel.removeClass('show-answers-label');
			showHideLabel.addClass('hide-answers-label');
			showHideLabel.text($('#hide-answers').val());
		}
		else {
			showHideLabel.removeClass('hide-answers-label');
			showHideLabel.addClass('show-answers-label');
			showHideLabel.text($('#show-answers').val());
		}
	}
});