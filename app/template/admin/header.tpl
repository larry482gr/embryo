<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<?php echo $keywords; ?>" />
<meta name="description" content="<?php echo $description; ?>" /> 
<meta name="language" content="English">
<meta name="owner" content="<?php echo $_SERVER['HTTP_HOST']; ?>">
<meta name="Author" content="<?php echo "Lazaros Kazantzis"; ?>">
<meta name="copyright" content="<?php echo $_SERVER['HTTP_HOST']; ?>"> 
<meta name="robots" content="all">
<meta name="rating" content="general, Safe For Kids " />
<title><?php echo $title; ?></title>
	<?php
		foreach($styles as $style){
			echo '<link rel="'.$style["rel"].'" href="'._CSS_DIR_.$style["href"].'.css" type="text/css" media="'.$style["media"].'" />';	
		}
	?>
	<script src="/resources/js/libraries/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script src="/resources/js/libraries/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
	<script src="/resources/js/libraries/bootstrap.min.js" type="text/javascript"></script>
	<script src="/resources/js/libraries/bootbox.min.js" type="text/javascript"></script>
</head>
	<body>
	  <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container container-fluid">
          <div class="navbar-header">
            <div class="navbar-brand">
	          <img src='/resources/images/auth_logo.png' id="auth-logo" />
	          <a href="/"><?php echo $header['siteName']; ?></a>
            </div>
            <div class="nav-admin-panel">
              <h4 id="panel-title" class="col-md-offset-8"><?php echo $adminHeader['title'] ?></h4>
            </div>
          </div>
        </div>
	  </nav>
      <div class="container">