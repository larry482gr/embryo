	<div class="modal fade" id="addArticleModal" tabindex="-1" role="dialog" aria-labelledby="addArticleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="addArticleModalLabel"><?php echo $news['newArticle']; ?></h4>
	      </div>
	      <div class="modal-body">
	        <div class="form-group">
	          <form id="new-article-form">
	          	<div class="form-group">
	          	  <label for="new-article-title"><?php echo $news['title']; ?></label>
	          	  <input type="text" id="new-article-title" name="article[title]" class="form-control" />
	          	</div>
	          	<div class="form-group">
	          	  <label for="new-article-short-desc"><?php echo $news['shortDesc']; ?></label>
	          	  <textarea  id="new-article-short-desc" name="article[short_desc]" class="form-control"></textarea>
	          	</div>
	          	<div class="form-group">
	          	  <label for="new-article-long-desc"><?php echo $news['longDesc'].' <small>'.$form['optional'].'</small>'; ?></label>
	          	  <textarea  id="new-article-long-desc" name="article[long_desc]" class="form-control"></textarea>
	          	</div>
	          	<div class="form-group">
	          	  <label for="new-article-source-label"><?php echo $news['sourceLabel'].' <small>'.$form['optional'].'</small>'; ?></label>
	          	  <input type="text" id="new-article-source-label" name="article[source_label]" class="form-control" />
	          	</div>
	          	<div class="form-group">
	          	  <label for="new-article-source-link"><?php echo $news['sourceLink'].' <small>'.$form['optional'].'</small>'; ?></label>
	          	  <input type="text" id="new-article-source-link" name="article[source_link]" class="form-control" />
	          	</div>
	          	<div class="form-group">
	          	  <label for="new-article-carousel-label"><?php echo $news['carousel_label'].' <small>'.$form['optional'].'</small>'; ?></label>
	          	  <input type="text" id="new-article-carousel-label" name="article[carousel_label]" class="form-control" />
	          	</div>
	          </form>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $form['cancel']; ?></button>
	        <button type="button" id="add-article" class="btn btn-primary"><?php echo $form['submit']; ?></button>
	      </div>
	    </div>
	  </div>
	</div>