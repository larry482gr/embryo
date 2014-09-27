var category_id = 0;

$(document).ready(function(){
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
	
	$('#new-survey-form').on('blur', 'input', function() {
		if($(this).val().length > 0) {
			$(this).attr('type', 'hidden');
			$(this).prev().hide();
			var edit_icon = '<span class="glyphicon glyphicon-pencil"></span>';
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
	
	$('#new-survey-form').on('click', '.active-header', function() {
		$(this).next().show();
		$(this).next().next().attr('type', 'text');
		$(this).remove();
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
						  				'<label for="subcategory-header'+c_id+s_id+'">'+$('#subcategoryHeader').val()+'</label>'+
						  				'<input type="text" class="form-control subcategory-input subcategory-header" id="subcategory-header'+c_id+s_id+'" name="survey[subcategory]['+c_id+']['+s_id+'][header]" placeholder="'+$('#subcategoryHeader').val()+'" />'+
						  				'<label for="subcategory-label'+c_id+s_id+'">'+$('#subcategoryLabel').val()+'</label>'+
						  				'<input type="text" class="form-control subcategory-input subcategory-label" id="subcategory-label'+c_id+s_id+'" name="survey[subcategory]['+c_id+']['+s_id+'][label]" placeholder="'+$('#subcategoryLabel').val()+'" />'+
						  			'</li>'+
						  			'<li class="list-group-item">'+
						  				'<button type="button" id="add-question'+c_id+s_id+'" class="btn btn-xs btn-warning add-question" rel="'+c_id+':'+s_id+'"><span class="glyphicon glyphicon-plus"></span> '+$('#addQuestion').val()+'</button>'+
						  				'<input type="hidden" value="0" />'+
						  			'</li>'+
						  		'</ul>'+
						  	  '</div>';
					  	
		return subcategory_div;
	}
});