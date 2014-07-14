<?php echo $dashboard; ?>
	  <div class="col-md-10">
	    <h3 class="page-title"><?php echo $news['pageTitle']; ?></h3>
	      <form class="form-inline" role="form">
	      <div class="form-group">
		    <label for="language-select" class="control-label"><?php echo $form['selectLanguage']; ?></label>
		    <select class="form-control input-sm" id="language">
		      <?php
		        foreach($languages as $key => $value) {
		          echo '<option value="'.$value['id'].'" rel="'.$key.'">'.$form[$value['language']].'</option>';
		        }
		      ?>
			</select>
	      </div>
		  <div class="form-group pull-right">
		    <button type="button" class="btn btn-sm btn-primary" id="show-unpublished-btn"><?php echo $form['showUnpublished']; ?></button>
		  </div>
		  </form>
		  <table id="articles-table" class="table table-condensed table-bordered table-hover col-md-9">
		  	<thead><tr><th>#</th><th><?php echo $news['title']; ?></th><th><?php echo $news['carousel']; ?></th><th><?php echo $news['isPublished']; ?></th><th><?php echo $news['publishedAt']; ?></th></tr></thead>
		  	<tbody>
		    <?php
		    	$table_rows = '';
				$i = 1;
		    	foreach($articles as $article) {
		    		$carouselChecked = $article['carousel'] ? 'checked="checked"' : '';
		    		$publishedChecked = $article['is_published'] ? 'checked="checked"' : '';
		    		$table_rows .= '<tr>';
		    		$table_rows .= '<td class="article" rel="'.$article['id'].'">'.$i++.'</td>';
		    		$table_rows .= '<td class="article" rel="'.$article['id'].'">'.$article['title'].'</td>';
		    		$table_rows .= '<td class="carousel"><input type="checkbox" rel="'.$article['id'].'" '.$carouselChecked.' /></td>';
		    		$table_rows .= '<td class="is-published"><input type="checkbox" rel="'.$article['id'].'" '.$publishedChecked.' /></td>';
		    		$table_rows .= '<td>'.$article['published_at'].'</td>';
		    		$table_rows .= '</tr>';
		    	}
				echo $table_rows;
		    ?>
		    </tbody>
		  </table>
		  <button id="add-new-category" class="col-md-2 btn btn-primary">Add New Article</button>
		  
		  <!-- Add New Category Form -->
<!--
		  <form id="create-new-category" class="form-horizontal col-md-12" role="form" action="links/createCategory" method="post">
	      <?php
	        if(false) {
	      ?>
	      <div class="form-group">
		    <div class="alert alert-danger col-md-offset-3 col-md-5"><?php echo $invalidError; ?></div>
		  </div>
		  <?php
		    }
		  ?>
		  <div class="form-group">
		    <label for="tab_label" class="col-md-offset-2 col-md-2 control-label">Label</label>
		    <div class="col-md-4">
		      <input type="text" class="form-control" id="tab_label" name="link_cat[label]" placeholder="Label">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="tab_language" class="col-md-offset-2 col-md-2 control-label">Language</label>
		    <div class="col-md-4">
		      <select class="form-control input-sm" name="link_cat[lang_id]">
				<option value="1">English</option>
				<option value="2" selected="selected">Ελληνικά</option>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" id="tab_active" name="link_cat[is_active]"> Is Active?
		        </label>
		      </div>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="tab_language" class="col-md-offset-2 col-md-2 control-label">Position</label>
		    <div class="col-md-2">
		      <select class="form-control input-sm" name="link_cat[position]">
		        <?php
		          if($max_position == null)
		          	$options = '<option value="1" selected="selected">1</option>';
		          else {
		            $selected = '';
		            $options = '';
		            for($i = 0; $i < $max_position+1; $i++) {
		          	  if($i == $max_position)
		          	    $selected = 'selected="selected"';
		          	  $options .= '<option value="'.($i+1).'" '.$selected.'>'.($i+1).'</option>';
		            }
		          }
		          echo $options;
		        ?>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <button type="submit" class="btn btn-primary"><?php echo $form['submit']; ?></button>
		    </div>
		  </div>
		</form>
-->		
		<!-- Add New Link Form -->
<!--
		<form id="create-new-link" class="form-horizontal col-md-12" role="form" action="links/createLink" method="post">
	      <?php
	        if(false) {
	      ?>
	      <div class="form-group">
		    <div class="alert alert-danger col-md-offset-3 col-md-5"><?php echo $invalidError; ?></div>
		  </div>
		  <?php
		    }
		  ?>
		  <div class="form-group">
		    <label for="tab_language" class="col-md-offset-1 col-md-3 control-label">Pick a Link Category</label>
		    <div class="col-md-4">
		      <select class="form-control input-sm" name="link[cat_id]">
		        <?php
		          $linkOptions = '';
		          foreach($link_cats as $link_cat) {
		    		$linkOptions .= '<option value="'.$link_cat['id'].'">'.$link_cat['label'].'</option>';
		    	}
				echo $linkOptions;
		        ?>
			  </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="link_header" class="col-md-offset-1 col-md-3 control-label">Header (The title of a group of links)</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="link_header" name="link[header]" placeholder="Header">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="link_prepend" class="col-md-offset-1 col-md-3 control-label">Text before link (if any)</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="link_prepend" name="link[prepend_text]" placeholder="Text before link">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="link_label" class="col-md-offset-1 col-md-3 control-label">Link Label</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="link_label" name="link[link_label]" placeholder="example: AUTH">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="link_url" class="col-md-offset-1 col-md-3 control-label">Link Address</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="link_url" name="link[link_url]" placeholder="example: http://www.auth.gr (Don't forget the prefix: http://)">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="link_append" class="col-md-offset-1 col-md-3 control-label">Text after link (if any)</label>
		    <div class="col-md-6">
		      <input type="text" class="form-control" id="link_append" name="link[append_text]" placeholder="Text after link">
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" id="link_group" name="link[is_group]"> Is this link part of a group?
		        </label>
		      </div>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-md-offset-4 col-md-4">
		      <button type="submit" class="btn btn-primary"><?php echo $form['submit']; ?></button>
		    </div>
		  </div>
		</form>
-->
		</div>
	</div>
	<input type="hidden" id="lang_id" value="<?php echo $lang_id; ?>" />
	<input type="hidden" id="show-unpublished-label" value="<?php echo $form['showUnpublished']; ?>" />
	<input type="hidden" id="hide-unpublished-label" value="<?php echo $form['hideUnpublished']; ?>" />
	<input type="hidden" id="show-unpublished" value="0" />
	
	<!-- Edit Modal -->
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
	          <form id="edit-article-form" method="post" action="<?php echo '/admin/articles/edit'; ?>" enctype="multipart/form-data">
	          	<div class="form-group">
	          	  <label for="article-title"><?php echo $news['title']; ?></label>
	          	  <input type="text" id="article-title" name="article[title]" class="form-control" />
	          	</div>
	          	<div class="form-group">
	          	  <label for="article-short-desc form"><?php echo $news['shortDesc']; ?></label>
	          	  <textarea  id="article-short-desc" name="article[short_desc]" class="form-control"></textarea>
	          	</div>
	          	<div class="form-group">
	          	  <label for="article-long-desc"><?php echo $news['longDesc']; ?></label>
	          	  <textarea  id="article-long-desc" name="article[long_desc]" class="form-control"></textarea>
	          	</div>
	          	<button type="button" id="modal-image-btn" class="btn btn-sm btn-primary"><?php echo $news['editImages']; ?></button>
	          	<div id="modal-images">
	          	  <div class="form-group">
	          	    <label for="small-image"><?php echo $news['smallImage']; ?></label>
	          	    <input id="small-image" name="article[small_image]" type="file" />
	          	  </div>
	          	  <div class="form-group">
	          	    <label for="carousel-image"><?php echo $news['carouselImage']; ?></label>
	          	    <input id="carousel-image" name="article[carousel_image]" type="file" />
	          	  </div>
	          	  <p class="help-block"><?php echo $form['filesAllowed']; ?>.png, .jpg, .jpeg</p>
	          	  <p class="help-block"><?php echo $news['imageInfo']; ?></p>
	          	  <p class="help-block"><?php echo $news['carouselInfo']; ?></p>
	          	</div>
	          	<input id="article-id" name="article[id]" type="hidden" />
	          </form>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	        <button type="button" id="upload-file" class="btn btn-primary">Upload</button>
	      </div>
	    </div>
	  </div>
	</div>

	<?php echo $footer; ?>