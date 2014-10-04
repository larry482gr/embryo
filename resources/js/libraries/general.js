function paging(numrows, currentPage, rowsPerPage, paging_div, limit) {
	limit = typeof limit !== 'undefined' ? limit : 3;
    var flag = 0;
    var startPage = 1;
    var previous = '';
    var next = '';
    var current = '';
    var totalPages = Math.ceil(numrows/rowsPerPage);
    currentPage = Number(currentPage);

    if(totalPages > currentPage+limit)
    	flag = currentPage+limit+1;
    else
    	flag = totalPages+1;

	if(currentPage > limit+1)
    	startPage = currentPage-limit+1;
    else
    	startPage = 1;

	if(totalPages > 1) {
    	if(currentPage != 1) {
        	var t = _lang.Previous === undefined? 'Previous' : _lang.Previous;
            previous = '<button title="PreviousPage" class="btn btn-mini previousPage">&laquo; ' + t + '</button>';
        }
        else {
        	previous = '';
        }

        if(currentPage != totalPages) {
        	var t = _lang.Next === undefined? 'Next' : _lang.Next;
            next = '<button title="NextPage" class="btn btn-mini nextPage">' + t +' &raquo;</button>';
        }
        else {
        	next = '';
        }
    }
    
    var paging = previous;
    for(page = startPage; page < flag; page++) {
    	if(currentPage == page)
        	current = 'btn-primary';
        else
        	current = '';
            paging = paging + '<button class="btn btn-mini number ' + current + '" title="' + page + '">' + page + '</button>';
    }
    paging = paging + next;

    // Extends to support multiple div for the same paging
    if (paging_div instanceof Array) {
    	for (var i = 0; i < paging_div.length; i++) {
	        $('#'+paging_div[i]).html(paging);
	    }
	} else {
		$('#'+paging_div).html(paging);
	}
}

function ucfirst(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}