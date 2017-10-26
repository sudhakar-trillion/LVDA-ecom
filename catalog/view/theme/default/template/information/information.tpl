<?php echo $header; ?>

 <div class="banner-image" style="margin-top:0px ;background:url('image/catalog/cat-banner.jpg') no-repeat fixed; padding-top:80px; padding-bottom:41px; color:#fff; position:relative; margin-bottom:30px; text-align:center; overflow:hidden" >


  <ul class="breadcrumb">
  
  <div class="container"><h1><?PHP echo $heading_title;?></h1></div>
  
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>

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