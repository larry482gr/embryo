<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
      <h3 class="page-title"><?php echo $news['pageTitle']; ?></h3>
        <h4><?php echo $article['title']; ?><br/><small class="published-at"><?php echo $home['publishedOn'].': '.date('d/m/Y', strtotime($article['published_at'])); ?></small></h4>
        <div class="col-md-12 article">
          <?php
          	$picture = (!empty($article['picture']) && file_exists(_DOCUMENT_ROOT_.'/resources/images/news/'.$article['picture'])) ? '<img src="/resources/images/news/'.$article['picture'].'" class="article-img" />' : "";
          	$short_desc = !empty($article['short_desc']) ? $article['short_desc'].'<br/><br/>' : "" ;
          	echo $picture.$short_desc.nl2br($article['long_desc']);
          	if(!empty($article['source_label'])) {
          	  echo '<br/><br/>';
          	  echo $news['source'].'<a href="'.$article['source_link'].'" target="_blank">'.$article['source_label'].'</a>';
          	}
          ?>
        </div>
	</div>
	<?php echo $left_part; ?>  
  </div>
</div>
<?php echo $footer; ?>