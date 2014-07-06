<?php echo $header; ?>
  <div class="row">
    <div class="col-md-8">
      <h3 class="page-title"><?php echo $pageTitle; ?></h3>
      <div id="info-div" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
        <?php
          if(isset($categories)) {
            echo '<ol>';
            foreach($categories as $category) {
              echo '<li><a href="/'.$lang.'/'.$infoPage.'/'.$category['id'].'">'.$category['label'].'</a></li>';
            }
            echo '</ol>';
          }
          else {
            if($subcategories) {
              echo '<div id="subcategories-div" class="col-lg-6 col-md-8 col-sm-12 col-xs-12">';
              echo '<select id="subcategories" class="form-control">';
              foreach($subcategories as $subcategory) {
                echo '<option value="'.$subcategory['id'].'">'.$subcategory['label'].'</option>';
              }
              echo '</select>';
              echo '</div>';
            }
            else if(!empty($files)) {
              echo '<table class="table table-condensed table-bordered table-hover">';
              echo '<thead><tr><td>#</td><td>'.$information['fileName'].'</td><td>'.$information['fileSize'].'</td><td>'.$information['fileDate'].'</td></tr></thead>';
              echo '<tbody>';
              $i = 1;
              foreach($files as $file) {
                echo '<tr rel="'.$file['name'].'"><td>'.$i++.'</td><td>'.$file['label'].'</td><td>'.$file['size'].'</td><td>'.$file['created_at'].'</td></tr>';
              }
              echo '</tbody>';
              echo '</table>';
            }
            else
              echo '<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">No Results</div>';
          }
        ?>
      </div>
    </div>
    <?php echo $left_part; ?>
    </div>
  </div>
  <input type="hidden" id="lang" value="<?php echo $lang; ?>" />
  <input type="hidden" id="hasSubcategories" value="<?php echo $hasSubcategories; ?>" />
  <input type="hidden" id="fileName" value="<?php echo $information['fileName']; ?>" />
  <input type="hidden" id="fileSize" value="<?php echo $information['fileSize']; ?>" />
  <input type="hidden" id="fileDate" value="<?php echo $information['fileDate']; ?>" />
<?php echo $footer; ?>