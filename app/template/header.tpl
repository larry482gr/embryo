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
	  <nav class="navbar navbar-default" role="navigation">
        <div class="container container-fluid">
          <div class="navbar-header">
            <button class="navbar-toggle" data-toggle="collapse" data-target="#main-navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a href="#" class="navbar-brand">Site Name</a>
          </div>
          <div class="collapse navbar-collapse" id="main-navbar">
            <ul class="nav navbar-nav">
              <li><a href="javascript: void(0);">Menu 1</a></li>
              <li><a href="javascript: void(0);">Menu 2</a></li>
              <li class="dropdown">
                <a href="javascript: void(0);" class="dropdown-toggle" data-toggle="dropdown">
                  Menu with submenu
                  <b class='caret'></b>
                </a>
                <ul class="dropdown-menu">
                  <li><a href="javascript: void(0);">Submenu 1</a></li>
                  <li><a href="javascript: void(0);">Submenu 2</a></li>
                  <li><a href="javascript: void(0);">Submenu 3</a></li>
                  <li class="divider"></li>
                  <li class="dropdown-header">Dropdown header</li>
                  <li><a href="javascript: void(0);">Separated Submenu</a></li>
                  <li class="divider"></li>
                  <li><a href="javascript: void(0);">One more separated Submenu</a></li>
                </ul>
              </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <form action="javascript: void(0);" method="get" class="navbar-form navbar-left" role="search">
              	<div class="form-group">
                  <div class="input-group">
                    <input type="text" id="q" name="q" class="form-control" placeholder="Search" />
                    <span class="input-group-btn">
                      <button class="btn btn-default">
                        <i class="glyphicon glyphicon-search"></i>
                      </button>
                    </span>
                  </div>
              	</div>
              </form>
            </ul>
          </div>
        </div>
	  </nav>
      <div class="container">