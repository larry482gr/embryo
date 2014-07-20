	<div class="modal fade" id="editArticleModal" tabindex="-1" role="dialog" aria-labelledby="editArticleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="editArticleModalLabel"><?php echo $news['editArticle']; ?></h4>
	      </div>
	      <div class="modal-body">
	        <div id="modal-loader">
	          <img src="/resources/images/icons/loader.gif" />
	        </div>
	        <div id="modal-form" class="form-group">
	          <form id="edit-article-form">
	          	<div class="form-group">
	          	  <label for="article-title"><?php echo $news['title']; ?></label>
	          	  <input type="text" id="article-title" name="article[title]" class="form-control" />
	          	</div>
	          	<div class="form-group">
	          	  <label for="article-short-desc"><?php echo $news['shortDesc']; ?></label>
	          	  <textarea  id="article-short-desc" name="article[short_desc]" class="form-control"></textarea>
	          	</div>
	          	<div class="form-group">
	          	  <label for="article-long-desc"><?php echo $news['longDesc']; ?></label>
	          	  <textarea  id="article-long-desc" name="article[long_desc]" class="form-control"></textarea>
	          	</div>
	          	<div class="form-group">
	          	  <label for="article-source-label"><?php echo $news['sourceLabel']; ?></label>
	          	  <input type="text" id="article-source-label" name="article[source_label]" class="form-control" />
	          	</div>
	          	<div class="form-group">
	          	  <label for="article-source-link"><?php echo $news['sourceLink']; ?></label>
	          	  <input type="text" id="article-source-link" name="article[source_link]" class="form-control" />
	          	</div>
	          	<div class="form-group">
	          	  <label for="article-carousel-label"><?php echo $news['carousel_label']; ?></label>
	          	  <input type="text" id="article-carousel-label" name="article[carousel_label]" class="form-control" />
	          	</div>
	          	<input class="article-id" name="article[id]" type="hidden" />
	          </form>
	          <button type="button" id="modal-image-btn" class="btn btn-sm btn-primary"><?php echo $news['editImages']; ?></button>
	          <div id="modal-images">
	          	<form id="small-image-form" method="post" action="/admin/articles/editImage" enctype="multipart/form-data">
	          	  <div class="form-group">
	          	    <label for="small-image"><?php echo $news['smallImage']; ?></label>
	          	  </div>
	          	  <div class="form-group">
	          	    <input id="small-image" name="articleImage" type="file" class="pull-left" />
	          	    <button type="button" id="update-small-image" class="btn btn-xs btn-primary"><?php echo $form['update']; ?></button>
	          	  </div>
	          	  <input class="article-id" name="article[id]" type="hidden" />
	          	  <input id="is-carousel" name="isCarousel" type="hidden" value="0" />
	          	</form>
	          	<form id="carousel-image-form" method="post" action="/admin/articles/editImage" enctype="multipart/form-data">
	          	  <div class="form-group">
	          	    <label for="carousel-image"><?php echo $news['carouselImage']; ?></label>
	          	  </div>
	          	  <div class="form-group">
	          	    <input id="carousel-image" name="articleImage" type="file" class="pull-left" />
	          	    <button type="button" id="update-carousel-image" class="btn btn-xs btn-primary"><?php echo $form['update']; ?></button>
	          	  </div>
	          	  <p class="help-block" id="image-same-name"><?php echo $form['sameName']; ?></p>
	          	  <p class="help-block"><?php echo $form['filesAllowed']; ?>.png, .jpg, .jpeg</p>
	          	  <p class="help-block"><?php echo $news['imageInfo']; ?></p>
	          	  <p class="help-block"><?php echo $news['carouselInfo']; ?></p>
	          	  <input class="article-id" name="article[id]" type="hidden" />
	          	  <input id="is-carousel" name="isCarousel" type="hidden" value="1" />
	          	</form>
	          </div>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $form['cancel']; ?></button>
	        <button type="button" id="update-article" class="btn btn-primary"><?php echo $form['update']; ?></button>
	      </div>
	    </div>
	  </div>
	</div>