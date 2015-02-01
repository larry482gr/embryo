$(document).ready(function() {
	// alert(JSON.stringify(countries));
	
	$('.container').on('click', '.show-answers-label', function() {
		var this_element = $(this);
		var thisLabel = $(this);
		var questionDiv = $(this).parent().parent();
		var questionId = $(this).attr('rel').substring(0, $(this).attr('rel').indexOf(':'));
		var questionType = $(this).attr('rel').substring($(this).attr('rel').indexOf(':')+1);
		var questionLabel = $('.container').find('h5#question-label-'+questionId).html();
		
		$.ajax({
			url: "/research_survey/getAnswers/" + questionId,
			method: 'post',
			dataType: "json",
			data: {
				question_type: questionType
			},
			success: function(result) {
				if(questionType < 3) {
					questionDiv.after(showAnswersTable(result, questionId));
					var possibleAnswers = this_element.parent().find('.possible-answers').attr('rel').split('-,-'), i, l;
					getChartVars(questionLabel, questionId, possibleAnswers, result);
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
		var questionId = $(this).attr('rel').substring(0, $(this).attr('rel').indexOf(':'));
		thisLabel.parent().parent().next().slideUp('fast', function() {
			$(this).remove();
			toggleShowHideLabel(thisLabel);
			$('.container').find('#chart-div-'+questionId).hide();
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
	
	function showAnswersTable(jsonResponse, questionId) {
		var answersThead = '<thead><tr>';
		var answersTbody = '<tbody><tr>';
		
		for(i = 0; i < jsonResponse.length; i++) {
			answersThead += '<th>' + countries[i] + '</th>';
			answersTbody += '<td>' + jsonResponse[i].answer + '</td>';
		}
		
		answersThead += '</tr></thead>';
		answersTbody += '</tr></tbody>';
		
		var answersTable = '<div class="row answers-row"><div class="col-md-12"><table class="table">' + answersThead + answersTbody + '</table>' +
						   '</div></div><div class="row chart-div" id="chart-div-'+questionId+'"></div>';
		
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
	
	function getChartVars(questionLabel, questionId, possibleAnswers, jsonResponse) {
        var rows = [];
        var total;
        for (i = 0, l = possibleAnswers.length; i < l; i++) {
			total = 0;
			for(j = 0; j < jsonResponse.length; j++) {
				if(jsonResponse[j].answer.indexOf('<br/>') > -1) {
					var answers = jsonResponse[j].answer.split('<br/>'), z, s;
					for(z = 0, s = answers.length; z < s; z++) {
						if($.trim(answers[z]) === $.trim(possibleAnswers[i])) {
							total++;
						}
					}
				}
				else {
					if($.trim(jsonResponse[j].answer) === $.trim(possibleAnswers[i])) {
						total++;
					}
				}
			}
			rows[i] = [$.trim(possibleAnswers[i]), parseFloat((total*100/7.0).toFixed(2))];
			// alert(parseFloat((total*100/7.0).toFixed(2)));
		}
           
		drawChart(questionLabel, questionId, rows);
	}
	
	// Radialize the colors
    Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function (color) {
        return {
            radialGradient: { cx: 0.5, cy: 0.3, r: 0.7 },
            stops: [
                [0, color],
                [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
            ]
        };
    });
      
      function drawChart(questionLabel, questionId, rows) {
	      // Build the chart
        $('.container').find('#chart-div-'+questionId).highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: questionLabel
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b><br/>Total Countries Share: <b>{point.y:.2f}%</b>',
            },
            plotOptions: {
            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                showInLegend: true,
	                dataLabels: {
	                    enabled: true,
	                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
	                    style: {
	                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
	                    },
	                    connectorColor: 'silver'
	                }
	            }
			},
            series: [{
                type: 'pie',
                name: 'Total Answers Share',
                data: rows
            }]
        });
      }
});