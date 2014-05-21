<?php echo $header; ?>
  <div class="row">
    <div class="research_content col-md-8">
	    	<h3 class="page-title"><?php echo $content['label']; ?></h3>
			<?php echo nl2br($content['content']); ?>
		</div>
		<?php echo $left_part; ?>  
	</div>
  </div>
  <input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>