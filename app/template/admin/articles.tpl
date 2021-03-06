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
		  	<thead><tr><th></th><th><?php echo $news['title']; ?></th><th><?php echo $news['carousel']; ?></th><th><?php echo $news['carouselPosition']; ?></th><th><?php echo $news['isPublished']; ?></th><th><?php echo $news['publishedAt']; ?></th></tr></thead>
		  	<tbody>
		    <?php
		    	$table_rows = '';
				$i = 1;
		    	foreach($articles as $article) {
		    		$carouselChecked = $article['carousel'] ? 'checked="checked"' : '';
		    		$carouselPotition = $article['carousel'] ? getCarouselDropDown($article['id'], $article['carousel_position'], $carousel_max, $language) : $news['notShownOnCarousel'];
		    		$publishedChecked = $article['is_published'] ? 'checked="checked"' : '';
		    		$published_at = !empty($article['published_at']) ? $article['published_at'] : $news['never'];
		    		$table_rows .= '<tr>';
		    		$table_rows .= '<td class="article" rel="'.$article['id'].'">'.$i++.'</td>';
		    		$table_rows .= '<td class="article" id="article-title-'.$article['id'].'" rel="'.$article['id'].'">'.$article['title'].'</td>';
		    		$table_rows .= '<td class="carousel"><input type="checkbox" rel="'.$article['id'].'" '.$carouselChecked.' /></td>';
		    		$table_rows .= '<td class="carousel_position">'.$carouselPotition.'</td>';
		    		$table_rows .= '<td class="is-published"><input type="checkbox" rel="'.$article['id'].'" '.$publishedChecked.' /></td>';
		    		$table_rows .= '<td id="article-published-'.$article['id'].'">'.$published_at.'</td>';
		    		$table_rows .= '</tr>';
		    	}
				echo $table_rows;
		    ?>
		    </tbody>
		  </table>
		  <button id="add-new-article" class="col-md-2 btn btn-primary"><?php echo $news['addArticle']; ?></button>
		  
		</div>
	</div>
	<input type="hidden" id="lang_id" value="<?php echo $lang_id; ?>" />
	<input type="hidden" id="lang" value="<?php echo $language; ?>" />
	<input type="hidden" id="not-shown" value="<?php echo $news['notShownOnCarousel']; ?>" />
	<input type="hidden" id="show-unpublished-label" value="<?php echo $form['showUnpublished']; ?>" />
	<input type="hidden" id="hide-unpublished-label" value="<?php echo $form['hideUnpublished']; ?>" />
	<input type="hidden" id="show-unpublished" value="0" />
	<input type="hidden" id="never" value="<?php echo $news['never']; ?>" />
	
	<!-- Add Article Modal -->
		<?php require(_DOCUMENT_ROOT_.'/app/template/admin/modals/add_article.tpl'); ?>
	<!-- Add Article Modal -->
	
	<!-- Edit Article Modal -->
		<?php require(_DOCUMENT_ROOT_.'/app/template/admin/modals/edit_article.tpl'); ?>
	<!-- Edit Article Modal -->

	<?php echo $footer; ?>
	
<?php
	function getCarouselDropDown($article_id, $carousel_position, $carousel_max, $language) {
		$drop_down	= '<form role="form" class="form-inline" method="post" action="/'.$language.'/admin/articles/updatePosition/'.$article_id.'">';
		$drop_down .= '<div class="form-group">';
		$drop_down .= '<select class="carousel-drop-down" name="new_position">';
		for($i = 1; $i <= $carousel_max; $i++) {
			$selected = $i == $carousel_position ? 'selected="selected"' : '';
			$drop_down .= '<option '.$selected.'>'.$i.'</option>';
		}
		$drop_down .= '</select>';
		$drop_down .= '<input type="hidden" name="old_position" value="'.$carousel_position.'" />';
		$drop_down .= '</div>';
		$drop_down .= '<div class="form-group submit-position">';
		$drop_down .= '</div>';
		
		$drop_down .= '</form>';
		
		return $drop_down;
	}
?>