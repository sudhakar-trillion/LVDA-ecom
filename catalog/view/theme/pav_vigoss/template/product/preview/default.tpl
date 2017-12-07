<?php $id = rand();  ?>
<?php if ($thumb || $images) { ?>
<div class="<?php echo $class; ?>  image-container">


<div class="col-xs-12 product-thumb-xs" style="display:none">

<div class="lvda-thum-vertical" >

	<div class="owl-carousel owl-theme custom1">
       <?php 
            if( $productConfig['product_zoomgallery'] == 'slider' && $thumb ) {  
            $eimages = array( 0=> array( 'popup'=>$popup,'thumb'=> $thumb )  ); 
            $images = array_merge( $eimages, $images );
            }
            
        	foreach ($images as  $image) { 
         ?>
        
        
        <div class="item clearfix">
                        <a style="cursor:pointer" title="<?php echo $heading_title; ?>" class="imagezoom " data-zoom-image="<?php echo $image['popup']; ?>" data-image="<?php echo $image['popup']; ?>">
                            <img src="<?php echo $image['thumb']; ?>" style="max-width:<?php echo $config->get('theme_default_image_additional_width');?>px"  title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" data-zoom-image="<?php echo $image['popup']; ?>" class="product-image-zoom img-responsive lvda-thumbnail " />
                        </a>
                    </div>
        
        <?PHP
        }
        ?>
        
    </div>
</div>
</div>

 <?php 
      if( $productConfig['product_zoomgallery'] == 'slider' && $thumb ) 
      {  
          $eimages = array( 0=> array( 'popup'=>$popup,'thumb'=> $thumb )  ); 
          $images = array_merge( $eimages, $images );
        }
        
        if(sizeof($images)>4)
	        $nextbtn='nextbtn';
        else
        	$nextbtn='';
   ?>

<div class="col-md-3 main-prd pr">
<div class="pre-btn" id="prv"><i class="fa fa-chevron-up"></i></div>
<?PHP
if(sizeof($images)>4)
{
?>
<div class="nxt-btn <?PHP echo $nextbtn; ?>" id="nxt"><i class="fa fa-chevron-down"></i></div>
<?PHP
}
?>




<div class="prd-thumbs-ssr">




       <!--  <a style="cursor:pointer" title="<?php echo $heading_title; ?>" class="imagezoom " data-zoom-image="<?php echo $image['popup']; ?>" data-image="<?php echo $image['popup']; ?>">
       -->
<?PHP
foreach ($images as  $image) 
{
?>
             <img src="<?php echo $image['thumb']; ?>"  title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" data-zoom-image="<?php echo $image['popup']; ?>" class="product-image-zoom img-responsive lvda-thumbnail " />
         <?PHP
         }
         
         ?>
 <span class="clearfix"></span>
</div>
 <span class="clearfix"></span>
</div>


<div class="col-md-9 pl">
    <?php if ($thumb) { ?>
    <div class="thumbnail image space-20 lvda-zoom-thumb">

        <?php if( isset($date_available) && $date_available == date('Y-m-d')) {   ?>            
        <span class="product-label product-label-new">
            <span><?php echo 'New'; ?></span>  
        </span>                                             
        <?php } ?>  
        <?php if( $special )  { ?>          
            <span class="product-label bts"><span class="product-label-special"><?php echo $objlang->get( 'text_sale' ); ?></span></span>
        <?php } ?>

        <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" >
            <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" data-zoom-image="<?php echo $thumb; ?>" class="img-responsive view-product-zoom clickedthumbnail "/>
        </a>
    </div>
    <?php } ?>  
    </div>
    
     
<!--     
    <div class="thumbnails thumbs-preview horizontal ">
        <?php if ($images) {        $icols = 5; $i= 0; ?>
         <div class="image-additional olw-carousel  owl-carousel-play effect-carousel-v1" id="image-additional"   data-ride="owlcarousel">     
             <div id="image-additional-carousel" class="owl-carousel" data-show="<?php echo $icols; ?>" data-pagination="false" data-navigation="true">
                <?php 
                if( $productConfig['product_zoomgallery'] == 'slider' && $thumb ) {  
                    $eimages = array( 0=> array( 'popup'=>$popup,'thumb'=> $thumb )  ); 
                    $images = array_merge( $eimages, $images );
                }
         
                foreach ($images as  $image) { ?>
                    <div class="item clearfix">
                        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="imagezoom" data-zoom-image="<?php echo $image['popup']; ?>" data-image="<?php echo $image['popup']; ?>">
                            <img src="<?php echo $image['thumb']; ?>" style="max-width:<?php echo $config->get('theme_default_image_additional_width');?>px"  title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" data-zoom-image="<?php echo $image['popup']; ?>" class="product-image-zoom img-responsive" />
                        </a>
                    </div>
                <?php } ?>      
            </div>

            <?php
            if(count($images)>$icols){
            ?>
            <div class="carousel-controls-v3">
                    <a class="left carousel-control carousel-xs" href="#carousel-<?php echo $id; ?>" data-slide="prev">
                           <i class="zmdi zmdi-chevron-left zmdi-hc-fw"></i>
                    </a>
                    <a class="right carousel-control carousel-xs" href="#carousel-<?php echo $id; ?>" data-slide="next">
                            <i class="zmdi zmdi-chevron-right zmdi-hc-fw"></i>
                    </a>
             </div> 

            <?php } ?>
        </div>          
       
        <?php } ?> 
    </div>
    -->
</div>          
<?php } ?>

