<?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
 <div class="banner-image" style="margin-top:0px ;background:url('image/catalog/cat-banner.jpg') no-repeat fixed; padding-top:80px; padding-bottom:41px; color:#fff; position:relative; margin-bottom:30px; text-align:center; overflow:hidden" >

<ul class="breadcrumb">
<div class="container">	
	    <h1><?php  echo $heading_title; ?></h1>
	    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
	    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
	    <?php } ?>	
</div>
</ul>
 </div>
