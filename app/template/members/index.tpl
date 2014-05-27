<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
	    	<h3 class="page-title"><?php echo $membersLinks['pageTitle']; ?></h3>
	    	<?php
	    	  $members_divs = '';
	    	  $info_divs = '';
	    	  $i = 0;
	    	  foreach($members as $member) {
	    	  	if($i%3 == 0) {
	    	  	  if(!empty($memberDivs))
	    	  	    $members_divs .= '</div>';
	    	  	  if(!empty($info_divs))
		    		$members_divs .= $info_divs;
		    	  $info_divs = '';
	    	  	  $members_divs .= '<div class="row">';
	    	  	}
	    	  	  $members_divs .= '<div class="member col-md-4 col-sm-4 col-xs-12 pull-left">';
			  	  $members_divs .= '<div class="col-md-5 col-sm-5 col-xs-12">';
			  	  $members_divs .= '<a href="javascript:showCV('.$member['id'].')" class="thumbnail">';
			  	  $member['picture'] = !empty($member['picture']) ? $member['picture'] : "dummy_photo.png";
			  	  $members_divs .= '<img class="member-pic" src="/resources/images/members/'.$member['picture'].'" alt="'.$member['name'].'">';
			  	  $members_divs .= '</a></div>';
			  	  $members_divs .= '<div class="member-links-div col-md-7 col-sm-7 col-xs-12"><h5>'.$member['name'].'</h5>';
			  	  if($member['cv'] != null) {
			  	  	$members_divs .= '<a href="javascript:showCV('.$member['id'].')" rel="cv'.$member['id'].'" class="member-links"><i class="glyphicon glyphicon-info-sign"></i>&nbsp;&nbsp;'.$membersLinks['cv'].'</a>';
		    		$info_divs .= '<div id="cv'.$member['id'].'" class="col-md-12 member-cv">'.nl2br($member['cv']).'</div>';
				  }
		    	  if($member['pubs'] != null) {
		    		$members_divs .= '<a href="javascript:showPubs('.$member['id'].')" rel="pubs'.$member['id'].'" class="member-links"><i class="glyphicon glyphicon-book"></i>&nbsp;&nbsp;'.$membersLinks['publications'].'</a>';
		    		$info_divs .= '<div id="pubs'.$member['id'].'" class="col-md-12 member-pubs">'.nl2br($member['pubs']).'</div>';
				  }
				  if($member['email'] != null)
		    		$members_divs .= '<a href="mailto:'.$member['email'].'" class="member-links"><i class="glyphicon glyphicon-envelope"></i>&nbsp;&nbsp;'.$membersLinks['contact'].'</a>';
				  $members_divs .= '</div>'; // Close member-links outer div
				  $members_divs .= '</div>'; // Close member div
				  
				  if($i%3 == 2) {
		    		$members_divs .= '</div>'; // Close row div
		    		$members_divs .= $info_divs;
		    		$info_divs = '';
		    	  }			
				  $i++;	
	    	  }
	    	  if(!empty($info_divs)) {
		    	$members_divs .= '</div>'; // Close row div
		    	$members_divs .= $info_divs;
		      }
		      else {
		      	$members_divs .= '</div>'; // Close row div
		      }
	    	  
			  echo $members_divs;
		  ?>
		</div>
		<?php echo $left_part; ?>  
	</div>
  </div>
  <input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>