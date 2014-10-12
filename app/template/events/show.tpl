<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
      <h3 class="page-title"><?php echo $eventLang['pageTitle']; ?></h3>
        <h4><?php echo $event['label']; ?><br/><small class="published-at"><?php echo $home['publishedOn'].': '.date('d/m/Y', strtotime($event['published_at'])); ?></small></h4>
        <div class="col-md-12 article">
          <?php
          	$picture = (!empty($event['picture']) && file_exists(_DOCUMENT_ROOT_.'/resources/images/events/'.$event['picture'])) ? '<img src="/resources/images/events/'.$event['picture'].'" class="event-img" />' : "";
          	echo $picture.nl2br($event['description']);
          ?>
        </div>
	</div>
	<?php echo $left_part; ?>  
  </div>
</div>
<?php echo $footer; ?>