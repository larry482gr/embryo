  <div class="col-lg-3 col-md-4 col-sm-12 col-xs-12">
	<div class="row">
	  <div class="col-md-12">
	    <div class="carousel slide" id="home-carousel" data-ride="carousel">
	      <ol class="carousel-indicators">
	        <?php
	          $carouselIndicators = '';
	          $activeIndicator = 'active';
	          $itemsNo = count($carouselArticles);
	          for($i = 0; $i < $itemsNo; $i++) {
	            if(!empty($carouselIndicators))
	       	  		$activeIndicator = '';
	            $carouselIndicators .= '<li class="'.$activeIndicator.'" data-target="#home-carousel" data-slide-to="'.$i.'"></li>';
	          }
	          echo $carouselIndicators;
	        ?>
	      </ol>
	      <div class="carousel-inner">
	        <?php
	          $carouselItems = '';
	          $activeItem = 'active';
	       	  foreach($carouselArticles as $item) {
	       	  	$picture = !empty($item['picture']) ? '<img src="/resources/images/carousel/'.$item['picture'].'" />' : '<img src="/resources/images/carousel/no_picture_found" alt="'.$home['noPicture'].'" />';
	       	  	if(!empty($carouselItems))
	       	  		$activeItem = '';
	        	$carouselItems .= '<div class="item '.$activeItem.'" rel="'.$item['id'].'"><a href="/'.$lang.'/news/'.$item['id'].'">
						        	'.$picture.'
									<div class="carousel-caption">
									  <h5>'.$item['title'].'</h5>
									</div></a>
								  </div>';
	       	  }
	       	  echo $carouselItems;
	        ?>
	      </div>
	      <a href="#home-carousel" class="left carousel-control" data-slide="prev"><span class='glyphicon glyphicon-chevron-left'></span></a>
	      <a href="#home-carousel" class="right carousel-control" data-slide="next"><span class='glyphicon glyphicon-chevron-right'></span></a>
	    </div>
	  </div>
	</div>
	<div class="row">
	  <div class="col-md-12">
	    <div class="panel panel-primary">
	      <div class="panel-heading">
	        <div class="panel-title"><?php echo $home['news']; ?></div>
	      </div>
	      <div class="panel-body">
	        <?php
	          $latestNews = '';
	       	  foreach($articles as $article) {
	        	$latestNews .= '<dl>
						        <dt>'.$home['publishedOn'].': '.date('d/m/Y', strtotime($article['published_at'])).'</dt>
								<dd>'.$article['short_desc'].'<span class="help-block pull-right">
						              <small><a href="/'.$lang.'/news/'.$article['id'].'">'.$home['readMore'].'</a></small>
						            </span>
								  </dd>
						        </dl>';
	       	  }
	       	  echo $latestNews;
	        ?>
	      </div>
	    </div>
	  </div>
	</div>
  </div>