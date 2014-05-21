<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
	    	<h3 class="page-title"><?php echo $membersLinks['pageTitle']; ?></h3>
	    	<?php
		    	$members_divs = '';
				$members_found = false;
				$info_divs = '';
				$visible = 'visible';
				$close_div = false;
				$temp_close_divs = '';
		    	foreach($member_groups as $group) {
		    		if(!$close_div && empty($info_divs) && $j%2 == 1) {
		    			$members_divs .= '</div>'; // Close row div
		    			$members_divs .= '</div>'; // Close member row
		    		}
		    		
		    		if(!empty($temp_close_divs))
		    			$members_divs .= $temp_close_divs;
		    		
		    		if(!empty($info_divs)) {
		    			$members_divs .= '</div>'; // Close row div
		    			$members_divs .= $info_divs;
		    			$members_divs .= '</div>'; // Close member row
		    			$info_divs = '';
		    		}
		    		
		    		if($close_div && $j%2==0)
		    			$members_divs .= '</div>'; // Close member row
		    			
		    		$close_div = false;
		    		$new_group = true;
		    		$j = 0;
		    		foreach($members as $member) {
		    			if($member['group_id'] == $group['id']) {
		    				$members_found = true;
		    				if($j%2 == 0) {
		    					if(!empty($info_divs))
		    						$members_divs .= $info_divs;
		    					$info_divs = '';
		    					if($new_group) {
		    						$members_divs .= '<div id="members'.$group['id'].'" class="col-md-12 members '.$visible.'">';
		    						// $visible = '';
		    						$members_divs .= '<h4 class="group-label">'.$group['label'].'</h4>';
		    					}
		    					$members_divs .= '<div class="row">';
		    				}
		    				$members_divs .= '<div class="member col-md-6 col-sm-6 col-xs-12 pull-left">';
		    				$members_divs .= '<div class="pull-left">';
		    				$members_divs .= '<a href="#" class="thumbnail">';
		    				$member['picture'] = !empty($member['picture']) ? $member['picture'] : "dummy_photo.png";
		    				$members_divs .= '<img class="member-pic" src="/resources/images/members/'.$member['picture'].'" alt="'.$member['name'].'">';
		    				$members_divs .= '</a></div>';
		    				$members_divs .= '<div class="member-links-div pull-left"><h5>'.$member['name'].'</h5>';
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
		    				
		    				if($j%2 == 1) {
		    					$members_divs .= '</div>'; // Close row div
		    					$members_divs .= $info_divs;
		    					$info_divs = '';
		    					$close_div = true;
		    				}
		    				
		    				$temp_close_divs = '';
		    				if($j%2 == 0 && empty($info_divs)) {
		    					$temp_close_divs = '</div></div>';
		    				}
		    				
		    				$new_group = false;
		    				$j++;
		    			}
					}
					if(!$members_found) {
						$members_divs .= '<div id="members'.$group['id'].'" class="col-md-12 members '.$visible.'">';
						$members_divs .= '<h4>'.$group['label'].'</h4>';
						$members_divs .= '<h5>'.$membersLinks['noResults'].'</h5>';
						$members_divs .= '</div>';
					}
					$members_found = false;
		    	}
		    	if(!empty($info_divs)) {
		    		$members_divs .= '</div>'; // Close row div
		    		$members_divs .= $info_divs;
		    		$members_divs .= '</div>'; // Close member row
		    	}
		    	else if($j%2 == 0)
		    		$members_divs .= '</div>'; // Close member row
		    	else {
		    		$members_divs .= '</div>'; // Close row div
		    		$members_divs .= '</div>'; // Close member row
		    	}
		  	echo $members_divs;
		  ?>
		</div>
		<?php echo $left_part; ?>  
	</div>
  </div>
  <input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>