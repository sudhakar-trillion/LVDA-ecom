
<div class="product-block clearfix">
    <?php if ($product['thumb']) {    ?>      
      <div class="image">
        <?php if( $product['special'] ) {   ?>
          <span class="product-label bts"><span class="product-label-special"><?php echo $objlang->get('text_sale'); ?></span></span>
        <?php } ?>

        <div class="product-img img">
          <a class="img" title="<?php echo $product['name']; ?>" href="<?php echo $product['href']; ?>">
            <img class="img-responsive" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
          </a>       
        </div>
        <div class="bottom">
          <?php if( !isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode'] ) { ?>
            <div class="cart">            
               <button data-loading-text="Loading..." class="btn btn-danger" type="button" onclick="<?PHP if( $product['PrdAvailQuantity']>1){?>cart.add('<?php echo $product['product_id']; ?>')<?PHP } ?>;">
                 <span><?php if( $product['PrdAvailQuantity']>1){ echo $button_cart;} else echo "Out Of Stock"; ?></span>
              </button>
            </div>
        <?php } ?>
          
          <div class="action">           

            <div class="compare">     
              <button class="btn btn-sm btn-outline-light " type="button" data-toggle="tooltip" data-placement="top" title="<?php echo $objlang->get("button_compare"); ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="zmdi zmdi-tune zmdi-hc-fw"></i></button> 
            </div>  
            <div class="wishlist">
              <button class="btn btn-sm btn-outline-light " type="button" data-toggle="tooltip" data-placement="top" title="<?php echo $objlang->get("button_wishlist"); ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="zmdi zmdi-favorite zmdi-hc-fw"></i></button> 
            </div> 
            <?php if ( isset($quickview) && $quickview ) { ?>
             <div class="quickview hidden-sm hidden-xs">
             <!-- <a class="iframe-link btn quick-view btn btn-sm btn-outline-light" data-toggle="tooltip" data-placement="top" href="<?php echo $ourl->link('themecontrol/product','product_id='.$product['product_id']);?>"  title="<?php echo $objlang->get('quick_view'); ?>" ><i class="zmdi zmdi-eye zmdi-hc-fw"></i></a>-->
             
              <span data-toggle="tooltip" data-placement="top" title="<?php echo $objlang->get('quick_view'); ?>">
             <a class="btn btn-info btn-sm eye-zoom prd-quick-view" viewprdct="<?PHP echo $product['product_id']?>" data-toggle="modal" data-target="#Prdquickview"  title="<?php echo $objlang->get('quick_view'); ?>" ><i class="zmdi zmdi-eye zmdi-hc-fw"></i></a>
             </span>
             
            </div>
            <?php } ?> 
            <?php if( isset($categoryPzoom) && $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
            <div class="zoom hidden-xs hidden-sm">
                <?php if( isset($categoryPzoom) && $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
                 <!-- <a data-toggle="tooltip" data-placement="top" href="<?php echo $zimage;?>" class="product-zoom info-view colorbox cboxElement btn btn-sm btn-outline-light" title="<?php echo $product['name']; ?>"><i class="zmdi zmdi-zoom-in zmdi-hc-fw"></i></a>-->
                 &nbsp;
                <?php } ?>
            </div>  
            <?php } ?> 
          </div>
          

        </div>   
      </div>
    <?php } ?>

  <div class="product-meta">        
        <div class="name-price clearfix">
         <h6 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h6> 
           <?php if ($product['rating']) { ?>
        <div class="rating">
          <?php for ($is = 1; $is <= 5; $is++) { ?>
          <?php if ($product['rating'] < $is) { ?>
          <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
          <?php } else { ?>
          <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i>
          </span>
          <?php } ?>
          <?php } ?>
          </div>
        <?php } ?>    
           <?php if ($product['price']) { ?>
          <div class="price">
            <?php if (!$product['special']) {  ?>
              <span class="price-new"><?php echo $product['price']; ?></span>
              <?php if( preg_match( '#(\d+).?(\d+)#',  $product['price'], $p ) ) { ?> 
              <?php } ?>
            <?php } else { ?>
              <span class="price-old"><?php echo $product['price']; ?></span>
              <span class="price-new"><?php echo $product['special']; ?></span> 
              <?php if( preg_match( '#(\d+).?(\d+)#',  $product['special'], $p ) ) { ?> 
              <?php } ?>

            <?php } ?>
          </div>
          <?php } ?>
        </div>                
        <?php if( isset($product['description']) ){ ?> 
        <p class="description"><?php echo utf8_substr( strip_tags($product['description']),0,200);?>...</p>
        <?php } ?>    
          
                   
  </div>  
</div>





