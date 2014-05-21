<!DOCTYPE HTML>
<html>
<head>
<!--[if gt IE 8]><!-->
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<!--<![endif]-->
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
        <div class="container-fluid">
          <div class="navbar-header">
            <div class="navbar-brand">
	          <img src='/resources/images/auth_logo.png' id="auth-logo" />
	          <a href="/"><?php echo $header['siteName']; ?></a>
            </div>
            <button class="navbar-toggle" data-toggle="collapse" data-target="#main-navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <div class="nav-search-form">
              <form action="javascript: void(0);" method="get" role="search">
              	<div class="form-group">
                  <div class="input-group">
                    <input type="text" id="q" name="q" class="form-control" placeholder="<?php echo $header['search']; ?>" />
                    <span class="input-group-btn">
                      <button class="btn btn-default">
                        <i class="glyphicon glyphicon-search"></i>
                      </button>
                    </span>
                  </div>
              	</div>
              </form>
            </div>
          </div>
          <div class="collapse navbar-collapse" id="main-navbar">
          	<ul class="nav navbar-nav">
          	<?php
          		$navigation_menu = '';
          		foreach($tabs as $tab) {
          			$link_title = '';
          			$active = '';
          			
          			if(!$tab['has_submenu']) {
          				if($tab['link'] == $activated_tab)
          					$active = 'class="active"';
	          			if(empty($tab['link']))
							$tab['link'] = '#';
						else
							$tab['link'] = '/'.$lang.'/'.$tab['link'];
						if(!empty($tab['description']))
							$link_title = 'title="'.$tab['description'].'"';
						
	          			$navigation_menu .= '<li '.$active.'><a href="'.$tab['link'].'" '.$link_title.'>'.$tab['label'].'</a></li>';
					}
					else {
	          			if(empty($tab['link']))
							$tab['link'] = '#';
						if(!empty($tab['description']))
							$link_title = 'title="'.$tab['description'].'"';
						
						$navigation_menu .= '<li class="dropdown">';
						$navigation_menu .= '<a class="dropdown-toggle" href="'.$tab['link'].'" '.$link_title.'>'.$tab['label'].'</a>';
						$navigation_menu .= '<ul class="dropdown-menu">';
						foreach($subtabs as $subtab) {
							$active = '';
							if($subtab['tab_id'] == $tab['id']) {
								$link_title = '';
								if($subtab['is_divided'])
									$navigation_menu .= '<li class="divider"></li>';
								if(!empty($subtab['header']))
									$navigation_menu .= '<li class="dropdown-header">'.$subtab['header'].'</li>';
								if($subtab['link'] == $activated_tab)
									$active = 'class="active"';
								if(empty($subtab['link']))
									$subtab['link'] = '#';
								else
									$subtab['link'] = '/'.$lang.'/'.$subtab['link'];;
								if(!empty($subtab['description']))
									$link_title = 'title="'.$subtab['description'].'"';
								
								$navigation_menu .= '<li '.$active.'><a href="'.$subtab['link'].'" '.$link_title.'>'.$subtab['label'].'</a></li>';
							}
						}
						$navigation_menu .= '</ul></li>';
					}
          		}
				echo $navigation_menu;
          	?>
          	</ul>
          </div>
        </div>
	  </nav>
      <div class="container">
      <!--[if lt IE 9]>
		  <h5>This page is best viewed in <a href="http://www.mozilla.org/el/firefox/new/">Firefox</a>, <a href="http://www.google.com/intl/el/chrome/browser/">Google Chrome</a>, <a href="http://support.apple.com/downloads/#safari">Safari</a>, <a href="http://www.opera.com/">Opera</a> or <a href="http://windows.microsoft.com/el-gr/internet-explorer/download-ie">Internet Explorer 9 or later</a>.</h5>
	  <![endif]-->