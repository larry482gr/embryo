<?php echo $header; ?>
  <div class="row">
    <div class="research_content col-md-8">
	    <h3 class="page-title"><?php echo $pageTitle; ?></h3>
	    <div class="row"><div class="col-md-8"><h4><?php echo $search['totalResults'].' "'.$search_text.'": '.$totalResults; ?></h4></div></div>
	    <div class="row">
	      <div class="col-md-12">
	        <h5><?php echo $search['news'].' ('.$totalNews.')'; ?></h5>
	        <?php
	          if($news) {
	            echo '<ol>';
	            foreach($news as $new) {
	              echo '<li><a href="/'.$lang.'/news/'.$new['id'].'">'.$new['title'].'</a></li>';
	            }
	            echo '</ol>';
	          }
	        ?>
	      </div>
	    </div>
	    <div class="row">
	      <div class="col-md-12">
	        <h5><?php echo $search['links'].' ('.$totalLinks.')'; ?></h5>
	        <?php
	          if($links) {
	            echo '<ol>';
	            $link_category = '';
	            foreach($links as $link) {
	              if($link['link_cat'] != $link_category) {
	                if($link_category != '') {
	                  $link_category = $link['link_cat'];
	                  echo '</ol><ol><div class="row">'.$link_category.'</div>';
	                }
	                else {
	                  $link_category = $link['link_cat'];
	              	  echo '<div class="row">'.$link_category.'</div>';
	                }
	              }
	              echo '<li><a href="'.$link['link_url'].'" target="_blank">'.$link['link_label'].'</a></li>';
	            }
	            echo '</ol>';
	          }
	        ?>
	      </div>
	    </div>
	    <div class="row">
	      <div class="col-md-12">
	        <h5><?php echo $search['members'].' ('.$totalMembers.')'; ?></h5>
	        <?php
	          if($members) {
	            echo '<ol>';
	            foreach($members as $member) {
	              echo '<li><a href="/'.$lang.'/research_members/'.$member['id'].'">'.$member['name'].'</a>&nbsp;
	              		(<a href="mailto:'.$member['email'].'">'.$member['email'].'</a>)</li>';
	            }
	            echo '</ol>';
	          }
	        ?>
	      </div>
	    </div>
	</div>
	<?php echo $left_part; ?>  
	</div>
  </div>
  <input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>