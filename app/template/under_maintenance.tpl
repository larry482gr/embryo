<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
      <h3 class="page-title"><?php echo $pageTitle; ?></h3>
      <div class="alert alert-danger"><?php echo $underMaintenance; ?></div>
    </div>
    <?php echo $left_part; ?>  
  </div>
</div>
<input type="hidden" id="lang" value="<?php echo $lang; ?>" />
<?php echo $footer; ?>