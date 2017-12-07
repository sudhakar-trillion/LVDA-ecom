<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<script type="text/javascript" src="view/javascript/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="view/javascript/bootstrap/js/bootstrap.min.js"></script>
<link href="view/stylesheet/bootstrap.css" type="text/css" rel="stylesheet" />
<link href="view/javascript/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet" />
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<script src="view/javascript/jquery/datetimepicker/moment.js" type="text/javascript"></script>
<script src="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<link href="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
<link type="text/css" href="view/stylesheet/stylesheet.css" rel="stylesheet" media="screen" />
<?php foreach ($styles as $style) { ?>
<link type="text/css" href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<script src="view/javascript/common.js" type="text/javascript"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>

<link rel="stylesheet" type="text/css" href="view/JQuery-Custom-Date-Picker/daterangepicker.css" />


<style>
.courier .frmSearch {border: 1px solid #a8d4b1;background-color: #c6f7d0;margin: 2px 0px;padding:40px;border-radius:4px;}
.courier #orders-list{float:left;list-style:none;margin-top:36px;padding:0;width:190px;position: absolute;}
.courier #orders-list li{padding: 10px; background: #f0f0f0; border-bottom: #bbb9b9 1px solid;}
.courier #orders-list li:hover{background:#ece3d2;cursor: pointer;}
.courier #search-box{padding: 10px;}


.err-border
{
	border:1px solid #F00 !important;
}


.ml-30
{
	margin-left:30px;
}

#profile
{
	display:none;
}
</style>

</head>
<body>
<div id="container"  class="<?php if ($logged) { } else { echo 'body-bg'; }?>">
<?php if ($logged) { ?>
<header id="header" class="navbar navbar-static-top">
  
    <?php if ($logged) { ?>
  <div class="navbar-header">
    
    <a href="#" target="_blank" class="navbar-brand"><img src="view/image/lvda small logo.png" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" /></a>
    
    <?php if ($logged) { ?>
    <a type="button" id="button-menu" class="pull-left nav-brand-icon"><img src="view/image/icon.png" /></a>
    <?php } ?>
    </div>
  <?php }
  else
  {
  	?>
    <!-- <div class="navbar-header">
    	<img src="view/image/logo.png" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" />
    </div>-->
    <?PHP
  }
  
  if ($logged) { ?>
  
  <ul class="nav pull-right">
    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><span class="label label-danger pull-left"><?php echo $alerts; ?></span> <i class="fa fa-bell fa-lg"></i></a>
      <ul class="dropdown-menu dropdown-menu-right alerts-dropdown">
        <li class="dropdown-header"><?php echo $text_order; ?></li>
        <li><a href="<?php echo $processing_status; ?>" style="display: block; overflow: auto;"><span class="label label-warning pull-right"><?php echo $processing_status_total; ?></span><?php echo $text_processing_status; ?></a></li>
        <li><a href="<?php echo $complete_status; ?>"><span class="label label-success pull-right"><?php echo $complete_status_total; ?></span><?php echo $text_complete_status; ?></a></li>
        <li><a href="<?php echo $return; ?>"><span class="label label-danger pull-right"><?php echo $return_total; ?></span><?php echo $text_return; ?></a></li>
        
       
       <!--
       <li class="divider"></li>
        <li class="dropdown-header"><?php echo $text_customer; ?></li>
        <li><a href="<?php echo $online; ?>"><span class="label label-success pull-right"><?php echo $online_total; ?></span><?php echo $text_online; ?></a></li>
        <li><a href="<?php echo $customer_approval; ?>"><span class="label label-danger pull-right"><?php echo $customer_total; ?></span><?php echo $text_approval; ?></a></li>
        
        -->
        <li class="divider"></li>
        <li class="dropdown-header"><?php echo $text_product; ?></li>
        <li><a href="<?php echo $product; ?>"><span class="label label-danger pull-right"><?php echo $product_total; ?></span><?php echo $text_stock; ?></a></li>
        <li><a href="<?php echo $review; ?>"><span class="label label-danger pull-right"><?php echo $review_total; ?></span><?php echo $text_review; ?></a></li>
        <li class="divider"></li>
        <li class="dropdown-header"><?php echo $text_affiliate; ?></li>
        <li><a href="<?php echo $affiliate_approval; ?>"><span class="label label-danger pull-right"><?php echo $affiliate_total; ?></span><?php echo $text_approval; ?></a></li>
      </ul>
    </li>
    <!--<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-home fa-lg"></i></a>
      <ul class="dropdown-menu dropdown-menu-right">
        <li class="dropdown-header"><?php echo $text_store; ?></li>
        <?php foreach ($stores as $store) { ?>
        <li><a href="<?php echo $store['href']; ?>" target="_blank"><?php echo $store['name']; ?></a></li>
        <?php } ?>
      </ul>
    </li>-->
    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cloud-download fa-lg"></i></a>
      <ul class="dropdown-menu dropdown-menu-right">
        <li class="dropdown-header"><?php echo $text_help; ?></li>
<!--        <li><a href="http://www.opencart.com" target="_blank"><?php echo $text_homepage; ?></a></li>-->
        <li><a href="http://docs.opencart.com" target="_blank"> <?php echo $text_documentation; ?></a></li>
<!--        <li><a href="http://forum.opencart.com" target="_blank"><?php echo $text_support; ?></a></li>-->
      </ul>
    </li>
    <li><a href="<?php echo $logout; ?>" title="Logout"> <i class="fa fa-power-off fa-lg"></i> <span class="hidden-xs hidden-sm hidden-md"><?php #echo $text_logout; ?></span></a></li>
  </ul>
  <?php } ?>
</header>
<?PHP
}
?>