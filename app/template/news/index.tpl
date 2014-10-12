<?php echo $header; ?>
  <div class="row">
    <h3 class="page-title"><?php echo $news['pageTitle']; ?></h3>
  </div>
  <div class="row">
    <div class="news-archive col-md-2 col-sm-3 col-xs-3">
      <h4 id="news-archive"><?php echo $news['archive']; ?></h4>
      <ul class="outer no-style">
        <?php
          $year = 3000;
          $month = 0;
          $archiveDiv = '';
          $panelBody = '';
          $monthArray = array();
          $firstYear;
          $firstMonth;
          foreach($articles as $article) {
            
            // Create Archive List
            
            $articleYear = (int) date('Y', strtotime($article['published_at']));
            $articleMonth = (int) date('m', strtotime($article['published_at']));
            if($articleYear < $year) {
              $activeNews = 'hidden';
              if($year != 3000) {
                $monthArray = array_reverse($monthArray);
                foreach($monthArray as $monthDiv) {
                  $archiveDiv .= $monthDiv;
                }
                $archiveDiv .= '</ul></li>';
                unset($monthArray);
                $monthArray = array();
              }
              else 	{
                $panelHeader = $months[$articleMonth].' '.date('Y', strtotime($article['published_at']));
                $activeNews = 'shown';
                $firstYear = $articleYear;
                $firstMonth = $articleMonth;
              }
              $year = $articleYear;
              $month = 0;
              $archiveDiv .= '<li class="year"><span><span class="glyphicon glyphicon-folder-close"></span>&nbsp;&nbsp;'.$year.'</span></li>
              					<li class="months-ul">
			  					  <ul class="months no-style">';
			}
			
			if($articleYear != $firstYear || $articleMonth != $firstMonth)
				$activeNews = 'hidden';
			
			if($articleMonth != $month) {
			  $month = $articleMonth;
			  $monthArray[] = '<li class="month">
              				    <span class="month'.$articleYear.$articleMonth.'" rel="'.$months[$articleMonth].' '.$articleYear.'"><span class="glyphicon glyphicon-folder-close"></span>&nbsp;&nbsp;'.$months[$articleMonth].'&nbsp;&nbsp;</span>
			  				  </li>';
			}
			
			// Create Panel
			$picture = (!empty($article['picture']) && file_exists(_DOCUMENT_ROOT_.'/resources/images/news/'.$article['picture'])) ? '<img src="/resources/images/news/'.$article['picture'].'" class="article-img" />' : "";
	        $panelBody .= '<dl class="article '.$activeNews.' col-md-12 col-sm-12 col-xs-12 month'.$articleYear.$articleMonth.'" rel="'.$months[$articleMonth].' '.$articleYear.'">
						     <dt class="article-title">'.$article['title'].'</dt>
						     <dt><small class="published-at">'.$home['publishedOn'].': '.date('d/m/Y', strtotime($article['published_at'])).'</small></dt>
							 <dd>'.$picture.html_entity_decode(nl2br($article['short_desc'])).'</dd>
							 <small class="pull-right"><a href="news/'.$article['id'].'" target="blank" class="read-more">'.$home['readMore'].'</a></small>
						   </dl>';
          }
          if(isset($monthArray) && !empty($monthArray)) {
            $monthArray = array_reverse($monthArray);
            foreach($monthArray as $monthDiv) {
              $archiveDiv .= $monthDiv;
            }
            $archiveDiv .= '</ul></li>';
            unset($monthArray);
          }
          echo $archiveDiv;
        ?>
      </ul>
    </div>
    <div class="col-md-10 col-sm-8 col-xs-8">
      <div class="panel panel-primary">
	    <div class="panel-heading">
	      <div class="panel-title"><?php echo $panelHeader; ?></div>
	    </div>
	    <div class="news-panel panel-body">
	      <?php echo $panelBody; ?>
	    </div>
	  </div>
    </div>
  </div>
<?php echo $footer; ?>