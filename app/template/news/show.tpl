<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
      <h3 class="page-title"><?php echo $news['pageTitle']; ?></h3>
        <h4><?php echo $article['title']; ?><br/><small class="published-at"><?php echo $home['publishedOn'].': '.date('d/m/Y', time($article['published_at'])); ?></small></h4>
        <div class="col-md-12 article">
          <?php
          	$picture = !empty($article['picture']) ? '<img src="/resources/images/news/'.$article['picture'].'" class="article-img" />' : "";
          	echo $picture.$article['short_desc'].'<br/><br/>'.nl2br($article['long_desc']);
          ?>
        </div>
	</div>
	<?php echo $left_part; ?>  
  </div>
</div>
<?php echo $footer; ?>