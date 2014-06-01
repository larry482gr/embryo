<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
	    	<h3 class="page-title"><?php echo $links['pageTitle']; ?></h3>
	    	<?php
	    	  if(isset($links['pageSubtitle']))
			  	echo '<h4 class="page-subtitle">'.$links['pageSubtitle'].'</h4>';
	      	if($categories) {
	      ?>
		  <table id="categories-table" class="table table-hover col-md-9">
		  	<tbody>
		    <?php
		    	$table_rows = '';
				$i = 1;
		    	foreach($link_cats as $link_cat) {
		    		$table_rows .= '<tr class="link-category" rel="'.$link_cat['id'].'"><td>'.$i++.'</td><td>'.$link_cat['label'].'</td></tr>';
		    	}
				echo $table_rows;
		    ?>
		    </tbody>
		  </table>
		  <?php
		  	}
		  	else {
		  ?>
		  <ul class="links-ul">
		  	<?php
		  	  $links_ul = '';
		  	  $first_row = true;
		  	  $close_group = false;
		  	  if(empty($links_array)) {
		  	    $links_ul .= '<li class="links-header">'.$links['noLinks'].'</li>';
		  	  }
		  	  else {
			  	  foreach($links_array as $link) {
			  	    if(!$link['is_group']) {
			  	      if($close_group) {
			  	        $links_ul .= '</ol>';
			  	        $close_group = false;
			  	      }
				  	  if(!empty($link['header'])) {
				  	    if(!$first_row)
				  		  $links_ul .= '<li></li>';	
				  	    $links_ul .= '<li class="links-header">'.$link['header'].'</li>';
				  	  }
				  	  $links_ul .= '<li>'.$link['prepend_text'];
				  	  if(!empty($link['link_label']))
				  	    $links_ul .= ' <a href="'.$link['link_url'].'" target="blank">'.$link['link_label'].'</a> '.$link['append_text'];
				  	  $links_ul .= '</li>';
				  	}
				  	else {
				  	  $close_group = true;
				  	  if(!empty($link['header'])) {
				  	    if(!$first_row)
				  		  $links_ul .= '<li></li>';
				  	    $links_ul .= '<li class="links-header">'.$link['header'].'</li>';
				  	  }
				  	  if(!empty($link['prepend_text']))
				  	  	$links_ul .= '<li>'.$link['prepend_text'].'</li><li><ol class="grouped-links">';
				  	  $links_ul .= '<li><a href="'.$link['link_url'].'" target="blank">'.$link['link_label'].'</a> '.$link['append_text'].'</li>';
				  	}
			  	    $first_row = false;
			  	  }
			 }
		  	  echo $links_ul;
		  	?>
		  </ul>
		  <a href="/<?php echo $lang; ?>/links" class="links-back btn btn-default btn-sm"><?php echo $links['back']; ?></a>
		  <?php
		    }
		  ?>
		</div>
		<?php echo $left_part; ?>  
	</div>
  </div>
  <input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>