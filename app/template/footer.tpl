	</div> <!-- container closing tag -->
	<div class="footer">
	  <div class="container">
	    <div class="espa pull-left">
	      <img id="espa_logo" src="/resources/images/espa_logo.png" alt="ΈΣΠΑ" />
	    </div>
	    <?php
	      if($showLogin) {
	    ?>
	    	<div class="back-to-top-div">
		      <span id="back-to-top" class="glyphicon glyphicon-chevron-up"></span>
		    </div>
		    <div class="pull-right">
		      <a class="glow-link" href="<?php echo '/'.$lang.'/user/membersLogin'; ?>">
		      	<i class="glyphicon glyphicon-user"> </i>
			  	<?php echo $header['membersLogin']; ?>
		      </a>
		    </div>
		<?php
		  }
		?>
	  </div>
	</div>
	
	<?php
		foreach($scripts as $script){
			echo '<script src="'._JS_DIR_.$script.'.js" type="text/javascript"></script>';	
		}
	?>

	</body>
</html>