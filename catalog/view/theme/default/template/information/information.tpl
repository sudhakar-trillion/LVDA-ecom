<?php echo $header; ?>

 <div class="banner-image" style=" background-image:url(image/catalog/about-banner.jpg); background-position: 0 0;background-repeat: no-repeat;background-size: cover;margin: 0;padding: 120px 0;margin-bottom: 80px;
min-height: 640px;position: relative; background-attachment:fixed;" >

<div class="category-view-position">
		<h2 class="pagecrumbs-title"><?PHP echo $heading_title;?></h2>
		


 
  <div class="container"><!--<h1><?PHP echo $heading_title;?></h1>-->
  
  
    <ul class="breadcrumb">
  
 
  
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
 </div>
</div>
	</div>

<div class="container">

  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <?php echo $description; ?><?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>



<?php echo $footer; ?>