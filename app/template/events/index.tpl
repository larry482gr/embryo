<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
	  <h3 class="page-title"><?php echo $eventLang['pageTitle']; ?></h3>
		  <?php
		  	if(!$events) {
		  	  echo '<h5 class="event-no-results">'.$eventLang['noResults'].'</h5>';
		  	}
		  	else {
		  	  echo '<ul class="event-ul">';
		  	  $list_content = '';
		      foreach($events as $event) {
		        $list_content .= '<li>'.date('d/m/Y', strtotime($event['published_at'])).' - ';
		        if(empty($event['ext_link'])) {
		      	  $list_content .= '<a href="/'.$lang.'/publicity/'.$event['id'].'" target="_blank">'.$event['label'].'</a>';
		        }
		        else {
		      	  $list_content .= '<a href="'.$event['ext_link'].'" target="_blank">'.$event['label'].'</a>';
		        }
		        $list_content .= '</li>';
		      }
		      echo $list_content;
		      echo '</ul>';
		    }
		  ?>
		</div>
		<?php echo $left_part; ?>  
	</div>
  </div>
  <input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>