	</div> <!-- container closing tag -->
	<!--
	<div class="footer">
	  <!--
	  <div class="container">
	    <h5>Footer Content to be added...</h5>
	  </div>
	</div>
	-->
	<?php
		foreach($scripts as $script){
			echo '<script src="'._JS_DIR_.$script.'.js" type="text/javascript"></script>';	
		}
	?>

	</body>
</html>