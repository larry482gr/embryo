	</div> <!-- container closing tag -->
	<div class="footer">
	  <div class="container">
	    <div class="espa pull-left">
	      <img id="espa_logo" src="/resources/images/espa_logo.png" alt="ΈΣΠΑ" />
	    </div>
	    <div class="pull-right">
	      <a class="glow-link" href="#">
	      	<i class="glyphicon glyphicon-user"> </i>
		  	<?php echo $header['membersLogin']; ?>
	      </a>
	    </div>
	  </div>
	</div>
	
	<?php
		foreach($scripts as $script){
			echo '<script src="'._JS_DIR_.$script.'.js" type="text/javascript"></script>';	
		}
	?>

	</body>
</html>