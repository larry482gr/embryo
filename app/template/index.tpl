<?php echo $header; ?>
	<div class="row">
	  <div class="col-md-8">
	    <div class="carousel slide" id="home-carousel" data-ride="carousel">
	      <ol class="carousel-indicators">
	        <li class="active" data-target="#home-carousel" data-slide-to="0"></li>
	        <li data-target="#home-carousel" data-slide-to="1"></li>
	        <li data-target="#home-carousel" data-slide-to="2"></li>
	      </ol>
	      <div class="carousel-inner">
	        <div class="item active">
	          <img src="/resources/images/carousel/carousel1.png" />
	          <div class="carousel-caption">
	            <h3>Title 1</h3>
	            <p>Description 1</p>
	          </div>
	        </div>
	        <div class="item">
	          <img src="/resources/images/carousel/carousel2.png" />
	          <div class="carousel-caption">
	            <h3>Title 2</h3>
	            <p>Description 2</p>
	          </div>
	        </div>
	        <div class="item">
	          <img src="/resources/images/carousel/carousel3.png" />
	          <div class="carousel-caption">
	            <h3>Title 3</h3>
	            <p>Description 3</p>
	          </div>
	        </div>
	      </div>
	      <a href="#home-carousel" class="left carousel-control" data-slide="prev"><span class='glyphicon glyphicon-chevron-left'></span></a>
	      <a href="#home-carousel" class="right carousel-control" data-slide="next"><span class='glyphicon glyphicon-chevron-right'></span></a>
	    </div>
	  </div>
	  
	  <div class="col-md-4 home-right">
	    <h3>Some other content!</h3>
	  </div>
	</div>
	    
	<div class="row">
	  <div class="col-md-8">
	    <div class="panel panel-primary">
	      <div class="panel-heading">
	        <div class="panel-title"><?php echo $home['latestNews']; ?></div>
	      </div>
	      <div class="panel-body">
	        <?php
	          $latestNews = '';
	       	  foreach($articles as $article) {
	        	$latestNews .= '<dl>
						        <dt>'.$home['publishedOn'].': '.$article['published_at'].'</dt>
								<dd>'.$article['short_desc'].'<span class="help-block pull-right">
						              <small><a href="'.$lang.'/articles/'.$article['id'].'">'.$home['readMore'].'</a></small>
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
<?php echo $footer; ?>