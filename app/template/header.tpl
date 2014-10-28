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
	<script src="/resources/js/libraries/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
	<script src="/resources/js/libraries/bootstrap.min.js" type="text/javascript"></script>
	<script src="/resources/js/libraries/bootbox.min.js" type="text/javascript"></script>
	
	<?php
	  if(isset($loadMembersArea)) {
	?>
		<script src="/resources/js/libraries/jquery.ui.position.js" type="text/javascript"></script>
	    <script src="/resources/js/libraries/jquery.contextMenu.js" type="text/javascript"></script>
	    <script src="/resources/js/libraries/screen.js" type="text/javascript"></script>
	    <script src="/resources/js/libraries/prettify.js" type="text/javascript"></script>
	    <script src="/resources/js/libraries/jquery.form.min.js" type="text/javascript"></script>
	    
	    <link href="/resources/css/libraries/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
	    <link href="/resources/css/libraries/screen.css" rel="stylesheet" type="text/css" />
	    <link href="/resources/css/libraries/prettify.sunburst.css" rel="stylesheet" type="text/css" />
	<?php
	  }
	?>
</head>
	<body>
	  <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
          <div class="navbar-header">
            <div class="navbar-brand">
	          <img src='/resources/images/auth_logo.png' id="auth-logo" />
	          <a href="<?php echo '/'.$lang.'/'; ?>"><?php echo $header['siteName']; ?></a>
            </div>
            <button class="navbar-toggle" data-toggle="collapse" data-target="#main-navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <div class="nav-search-form">
              <div id="select-lang-div" class="pull-left">
                <a href="<?php echo $en_href; ?>"><img class="flag-icon" src="/resources/images/countries/uk_circle.png" /></a>
                <a href="<?php echo $gr_href; ?>"><img class="flag-icon" src="/resources/images/countries/gr_circle.png" /></a>
              </div>
              <form action="<?php echo '/'.$lang.'/search'; ?>" method="get" role="search">
              	<div class="form-group">
                  <div class="input-group">
                    <input type="text" id="q" name="q" class="form-control" placeholder="<?php echo $header['search']; ?>" value="<?php echo $search_text; ?>" />
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
          		if($canViewMembersArea) {
          			$active = 'members_area' == $activated_tab ? 'class="active"' : '' ;
	          		$navigation_menu .= '<li '.$active.'><a href="/'.$lang.'/members_area">'.$header['membersArea'].'</a></li>';
          		}
          			
				echo $navigation_menu;
          	?>
          	</ul>
          	<div class="social-media pull-right">
          		<?php
          		  if(!empty($username)) {
          		?>
          		  <div class="col-md-6">
          		    <div class="btn-group">
          		      <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
          		        <i class="glyphicon glyphicon-cog"> </i>
          		        <?php echo $username; ?>
          		      </button>
					  <ul class="dropdown-menu" role="menu">
					    <li><a href="<?php echo '/'.$lang.'/user/'.$userid; ?>"><?php echo $userLang['info']; ?></a></li>
					    <li class="divider"></li>
					    <!--
					    <?php
					      if($canCreateUser) {
					    ?>
					    <li><a href="<?php echo '/'.$lang.'/user/register'; ?>"><?php echo $userLang['createUser']; ?></a></li>
					    <li class="divider"></li>
					    <?php
					      }
					    ?>
					    -->
					    <li><a href="<?php echo '/'.$lang.'/user/logout'; ?>"><?php echo $userLang['logout']; ?></a></li>
					  </ul>
					</div>
				  </div>
				<?php
						$offset = '';
          			}
          			else {
          				$offset = 'col-md-offset-6';
          			}
          		?>
          		<div class="col-md-6 <?php echo $offset; ?>">
          		  <div class="sm-links">
			        <a href="https://www.facebook.com/pages/%CE%A5%CF%80%CE%BF%CE%B2%CE%BF%CE%B7%CE%B8%CE%BF%CF%8D%CE%BC%CE%B5%CE%BD%CE%B7-%CE%91%CE%BD%CE%B1%CF%80%CE%B1%CF%81%CE%B1%CE%B3%CF%89%CE%B3%CE%AE-%CE%BA%CE%B1%CE%B9-%CF%80%CF%81%CE%BF%CF%83%CF%84%CE%B1%CF%83%CE%AF%CE%B1-%CF%84%CE%BF%CF%85-%CE%B5%CE%BC%CE%B2%CF%81%CF%8D%CE%BF%CF%85-in-vitro/260007444185660?ref=hl"><img class="facebook-grey" src="/resources/images/icons/facebook-icon.png"/></a>
			        <a href="https://twitter.com/Bioithiki"><img class="twitter-grey" src="/resources/images/icons/twitter-icon.png"/></a>
          		  </div>
          		</div>
		      </div>
          </div>
        </div>
	  </nav>
      <div class="container">
      <?php
	    if(!empty($invalidError)) {
	  ?>
		<div class="alert alert-danger col-md-10 col-md-offset-1"><?php echo $invalidError; ?></div>
	  <?php
	    }
	  ?>
      <!--[if lt IE 9]>
		  <h5>This page is best viewed in <a href="http://www.mozilla.org/el/firefox/new/">Firefox</a>, <a href="http://www.google.com/intl/el/chrome/browser/">Google Chrome</a>, <a href="http://support.apple.com/downloads/#safari">Safari</a>, <a href="http://www.opera.com/">Opera</a> or <a href="http://windows.microsoft.com/el-gr/internet-explorer/download-ie">Internet Explorer 9 or later</a>.</h5>
	  <![endif]-->