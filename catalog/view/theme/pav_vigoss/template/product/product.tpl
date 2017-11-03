<?php 
  
	$config = $sconfig;

  $themeConfig = (array)$config->get('themecontrol');
  $productConfig = array(     
      'product_enablezoom'         => 1,
      'product_zoommode'           => 'basic',
      'product_zoomeasing'         => 1,
      'product_zoomlensshape'      => "round",
      'product_zoomlenssize'       => "150",
      'product_zoomgallery'        => 0,
      'enable_product_customtab'   => 0,
      'product_customtab_name'     => '',
      'product_customtab_content'  => '',
      'product_related_column'     => 0,        
    );
    $listingConfig = array(   
      'category_pzoom'                    => 1, 
      'quickview'                                 => 0,
      'show_swap_image'                         => 0,
      'catalog_mode'                => 1,
      'layout_pinfo' => 'default'
    ); 
    $listingConfig          = array_merge($listingConfig, $themeConfig );
    $categoryPzoom            = $listingConfig['category_pzoom']; 
    $quickview                = $listingConfig['quickview'];
    $swapimg                  = ($listingConfig['show_swap_image'])?'swap':'';
    $productConfig                = array_merge( $productConfig, $themeConfig );  
    $languageID               = $config->get('config_language_id');   

    $layout_pinfo = $listingConfig['layout_pinfo']; 
?>
<?php echo $header; ?>



<?php if ($Category_Banner) { ?>
        <div class="banner-image" style="margin-top:0px ;background:url('<?php echo $Category_Banner; ?>') no-repeat fixed; padding-top:78px; padding-bottom:41px; color:#fff; position:relative; margin-bottom:30px; text-align:center; overflow:hidden" >


  <ul class="breadcrumb" >
  <div class="container">
    <h1 ><?php echo $heading_title; ?></h1>
   <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php }
     ?>
  </div>   
  </ul>        

        
        </div>
        <?php 
        } 
        else
        {
        	
         ?>
        <div class="banner-image" style="margin-top:-18px ;background:url('<?php echo $Category_Banner; ?>') no-repeat fixed; padding-top:120px; padding-bottom:41px; color:#fff; position:relative; margin-bottom:30px; text-align:center; overflow:hidden" >


  <ul class="breadcrumb" >
  <div class="container">
    <h1 ><?php echo $heading_title; ?></h1>
   <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </div>   
  </ul>        

        
        </div>

        <?PHP
        
        }
        ?>

<!--
<ul class="breadcrumb">
  <div class="container text-left">
    <h1><?php echo $heading_title; ?></h1>
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </div>   
  </ul>
  
  -->
<div class="container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-md-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-md-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-md-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <div class="product-info">
        <div class="row">
          <?php if ($column_left || $column_right) { ?>
          <?php $class = 'col-md-6 col-sm-6'; ?>
          <?php } else { ?>
          <?php $class = 'col-md-6'; ?>
          <?php } ?>
          
          <?php require( ThemeControlHelper::getLayoutPath( 'product/preview/default.tpl' ) );  ?> 

          <?php if ($column_left || $column_right) { ?>
          <?php $class = 'col-md-6 col-sm-6'; ?>
          <?php } else { ?>
          <?php $class = 'col-md-6'; ?>
          <?php } ?>
          <div class="<?php echo $class; ?>">
          
            <h1 class="heading-left"><?php echo $heading_title; ?></h1>
        
            <?php if ($review_status) { ?>
            <div class="rating">
              <p>
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($rating < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
              
              <!--  <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $reviews; ?></a> / <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"  ><?php echo $text_write; ?></a>-->
              
                <a style="cursor:pointer" class='view-reviews'><?php echo $reviews; ?></a> 
                / 
                <a href="" onclick="return false;" class='writereview'  ><?php echo $text_write; ?></a>
              
              </p>
              
            </div>
            <?php } ?>

             <?php if ($price) { ?>
              <div class="price detail">
                  <ul class="list-unstyled">
                      <?php if (!$special) { ?>
                          <li>
                              <span class="price-new"> <?php echo $price; ?> </span>
                          </li>
                      <?php } else { ?>

                          <li> <span class="price-new"> <?php echo $special; ?> </span> <span class="price-old"><?php echo $price; ?></span> </li>
                      <?php } ?>
                  </ul>
              </div>
          <?php } ?>
    
          <ul class="list-unstyled">
              <?php if ($tax) { ?>
                  <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
              <?php } ?>

              <?php if ($discounts) { ?>
                  <li>
                  </li>
                  <?php foreach ($discounts as $discount) { ?>
                      <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
                  <?php } ?>
              <?php } ?>
          </ul>
          
                     
          <ul class="list-unstyled">
          
          <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_stock; ?><?php if ($AvailQuantity > 1) { echo $stock;} else echo $OutOfStock; ?></li>
          
          
<!--              <?php if ($stock) { ?>
              <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_stock; ?><?php echo $stock; ?></li>
              <?php } ?>  
-->              <?php if ($manufacturer) { ?>
                  <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
              <?php } ?>
              <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_model; ?> <?php echo $model; ?></li>
              <?php if ($reward) { ?>
                  <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_reward; ?> <?php echo $reward; ?></li>
              <?php } ?>
              <?php if ($points) { ?>
                  <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_points; ?> <?php echo $points; ?></li>
              <?php } ?>
          </ul>
         
        
            <div id="product">
              <?php if ($options) { ?>
              <hr>
              <h3><?php echo $text_option; ?></h3>
              <?php foreach ($options as $option) { ?>
              <?php if ($option['type'] == 'select') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                  <?php if ($option_value['price']) { ?>
                  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                  <?php } ?>
                  </option>
                  <?php } ?>
                </select>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'radio') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> form-group-v2">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <div id="input-option<?php echo $option['product_option_id']; ?>">
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <div class="radio">
                    <label>
                      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                      <?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']) { ?>
                      (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                      <?php } ?>
                    </label>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'checkbox') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> form-group-v2">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <div id="input-option<?php echo $option['product_option_id']; ?>">
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                      <?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']) { ?>
                      (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                      <?php } ?>
                    </label>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'image') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> form-group-v2">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <div id="input-option<?php echo $option['product_option_id']; ?>">
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <div class="radio">
                    <label>
                      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                      <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']) { ?>
                      (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                      <?php } ?>
                    </label>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'text') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'textarea') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'file') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'date') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <div class="input-group date">
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                  <span class="input-group-btn">
                  <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'datetime') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <div class="input-group datetime">
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'time') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <div class="input-group time">
                  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <?php } ?>
              <?php } ?>
              <?php } ?>
              <?php if ($recurrings) { ?>
              <hr>
              <h3><?php echo $text_payment_recurring ?></h3>
              <div class="form-group required">
                <select name="recurring_id" class="form-control">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($recurrings as $recurring) { ?>
                  <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                  <?php } ?>
                </select>
                <div class="help-block" id="recurring-description"></div>
              </div>
              <?php } ?>
                          
              <div class="product-buttons-wrap">
                <div class="product-qyt-action space-margin-tb-20 clearfix">
                    <div class="quantity-title qty pull-left"><?php echo $entry_qty; ?>:</div>
                    <div class="quantity-adder pull-left">
                        <div class="quantity-number pull-left">
                            <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
                        </div>
                        <div class="quantity-wrapper pull-left">
                        <span class="<?PHP if($AvailQuantity>2) {?>add-up <?PHP } ?>add-action">
                            <i class="fa fa-plus"></i>
                        </span>
                        <span class="<?PHP if($AvailQuantity>2) {?> add-down <?PHP } ?> add-action">
                            <i class="fa fa-minus"></i>
                        </span>
                        </div>
                       
                    </div>               
                </div>
           
                <input type="hidden" name="product_id" id="product_id" value="<?php echo $product_id; ?>" />
                <div class="clearfix">
                <div class="pull-left space-right-15">
                    <button type="button" id="<?PHP if($AvailQuantity>2) {?>button-cart<?PHP }else echo 'out-of-stock' ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary">
                      <i class="zmdi <?PHP if($AvailQuantity>2) {?> zmdi-plus<?PHP } ?> zmdi-hc-fw space-right-5"></i><span><?php if($AvailQuantity>2) { echo $button_cart; } else echo 'Out of Stock'; ?></span>
                    </button>
                </div> 
                <div class="pull-left space-right-15">
                    <a data-toggle="tooltip" class="btn btn-sm btn-inverse-light" title="<?php echo $button_compare; ?>" onclick="compare.add
                      ('<?php echo $product_id; ?>');"><i class="zmdi zmdi-tune zmdi-hc-fw"></i></a>
                </div>
                <div class="pull-left">  
                    <a data-toggle="tooltip" class="btn btn-sm btn-inverse-light" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add
                      ('<?php echo $product_id; ?>');"><i class="zmdi zmdi-favorite-outline zmdi-hc-fw"></i></a>
                </div>
               
              </div>  
              <?php if ($minimum > 1) { ?>
              <div class="alert alert-info space-top-10"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
              <?php } ?>
              </div>
               <hr> 
              <!-- AddThis Button BEGIN -->
				
                <!--
                <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
                <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>
				-->	
                    
	            <!-- AddThis Button END -->
              </div>
     
          
          </div>
        </div>
      </div>

   <?php  require( ThemeControlHelper::getLayoutPath( 'product/info/'.$layout_pinfo.'.tpl' ) );  ?>
   
    <?PHP
	if( $crosssaleproducts=='0')
    {
    ?>  <div>
    <?PHP
    }
    ?>
     <?php echo $content_bottom; ?></div>
  <?PHP
	if( $crosssaleproducts=='0')
    {
    ?>  <div>
    <?PHP
    }
    ?>
    <?php echo $column_right; ?></div>

<?PHP
	if( $crosssaleproducts!='0')
    {
    ?>
     <h1 class="mostviewed">Bought Together</h1>
     <div class="products-block most-v product-recently-viewed">
      		<div class="owl-carousel owl-theme">
            
            
            <?PHP
                foreach( $crosssaleproducts as $key=>$info)
                {
               
               	//echo "<pre>";
                //print_r($info['prddetails']);

                ?>
                <div class="item mostviewed_prdcts" > 
        
        <div class="col-lg-12 col-md-12 col-sm-6 col-xs-12   last first">			
			
<div class="product-block item-default" itemscope="">

			 <div class="image">
		 	<!-- text sale-->
            <?PHP  $CrosssaleProduct = $info['prddetails']['CrosssaleProduct']; ?>

 <input type="checkbox" style="float: right; width:20px" name="addtocrosssale" class="addtocrosssale" crosssaleprice="<?PHP echo $info['prddetails']['SalePrice']?>" value="<?PHP echo $CrosssaleProduct; ?>" <?PHP  if($info['prddetails']['InCart']=="Yes") echo 'checked' ?> />


 
			<a class="img" href="<?PHP echo $info['prddetails']['href'] ?>"><img src="<?PHP echo $info['prddetails']['ProductImage']?>"  class="img-responsive"></a>
                        
					</div>
		
	<div class="product-meta">
		<div class="left">
			<h3 class="name"><a href="<?PHP echo $info['prddetails']['href'] ?>"><?PHP echo $info['prddetails']['name'] ?></a></h3>

            <div class="price" itemscope="" itemprop="offers">
                     <span class="special-price"><?PHP echo $info['prddetails']['currency']." ".$info['prddetails']['SalePrice'];  ?></span>
                  
                    <meta content="" itemprop="priceCurrency">
            </div>
                
                
					</div>

		<div class="clearfix"></div>

	</div>
    <div class="clearfix"></div>

</div>
</div>
        
        
        <div class="clearfix"></div>
        
         </div>
                <?PHP
                
                
                }
            }
          
 ?>
                        
            </div>
      </div>
      
    <?PHP

    if($upsaleProducts=='0')
    {
    
    }
    else{
    ?>
    <h1 class="mostviewed">You may also be interested in</h1>
    <div class="products-block most-v product-recently-viewed">
		 <div class="owl-carousel owl-theme">
    <?PHP
    		foreach( $upsaleProducts as $upsale)
            {
            ?>
            <div class="item mostviewed_prdcts" > 
        
        <div class="col-lg-12 col-md-12 col-sm-6 col-xs-12   last first">			
			
<div class="product-block item-default" itemscope="">

			 <div class="image">
 
			<a class="img" href="<?PHP echo $upsale['href'] ?>"><img src="<?PHP echo $upsale['ProductImage']?>"  class="img-responsive"></a>
                        
					</div>
		
	<div class="product-meta">
		<div class="left">
			<h3 class="name"><a href="<?PHP echo $upsale['href'] ?>"><?PHP echo $upsale['name'] ?></a></h3>

            <div class="price" itemscope="" itemprop="offers">
                     <span class="special-price"><?PHP echo $upsale['currency']." ".$upsale['SalePrice'];  ?></span>
                  
                    <meta content="" itemprop="priceCurrency">
            </div>
                
                
					</div>

		<div class="clearfix"></div>

	</div>
    <div class="clearfix"></div>

</div>
</div>
        
        
        <div class="clearfix"></div>
        
         </div>
            <?PHP
            }
        	?>
         </div>
	</div>
            <?PHP
        }
        
    
    ?>



 <?php if ($products) {  $heading_title = $text_related; $customcols = 4; ?>
        <div class="panel panel-center product-related"> <?php require( ThemeControlHelper::getLayoutPath( 'common/products_carousel.tpl' ) );  ?>   </div>
      <?php } ?>


    <!-- recently viewed products -->
    
      <?PHP
	if(sizeof($recentlyviewedProductsInfo)>0)
    {
    ?>
            <div class="row most-nopad">


      <h1 class="mostviewed">Recently Viewed Products</h1>
      
          <div class="products-block most-v product-recently-viewed">
      <div class="owl-carousel owl-theme">
      
      <?PHP
      foreach($recentlyviewedProductsInfo as $info)
      {
     
      
      ?>
      <div class="item mostviewed_prdcts" > 
        
        <div class="col-lg-12 col-md-12 col-sm-6 col-xs-12   last first">			
			
<div class="product-block item-default" itemscope="">

			 <div class="image">
		 	<!-- text sale-->
 <?PHP
      if( $info['special']!=''){?>  <span class="product-label bts"><span class="product-label-special product-label"><span class="special">Sale</span></span></span><?PHP } ?>
			
			<a class="img" href="<?PHP echo $info['href'] ?>"><img src="<?PHP echo $info['ProductImage']?>" alt="Zafferano Ultralight Universal Wine Glasses" class="img-responsive"></a>

	
                
                
           <!--     <button type="button" class="btn btn-info btn-sm eye-zoom prd-quick-view" viewprdct="<?PHP echo $info['ProductId']?>" data-toggle="modal" data-target="#Prdquickview"><i class="fa fa-eye"></i></button>-->
 
                
                
						<!-- quickview-->
                        
                        <div class="bottom">
                      <div class="cart">            
                <button data-loading-text="Loading..." class="btn btn-danger" type="button" onclick="<?PHP if($info['PrdAvailQuantity']>2){?>cart.add('<?PHP echo $info['ProductId']?>');<?PHP } ?>">
                <?PHP if($info['PrdAvailQuantity']>2){?> <span>Add to Cart</span><?PHP } else echo 'Out Of Stock'; ?>
              </button>
            </div>
                  
          <div class="action">           

            <div class="compare">     
              <button class="btn btn-sm btn-outline-light " type="button" data-toggle="tooltip" data-placement="top" title="" onclick="compare.add('<?PHP echo $info['ProductId']?>');" data-original-title="Compare this Product"><i class="zmdi zmdi-tune zmdi-hc-fw"></i></button> 
            </div>  
            <div class="wishlist">
              <button class="btn btn-sm btn-outline-light " type="button" data-toggle="tooltip" data-placement="top" title="" onclick="wishlist.add('<?PHP echo $info['ProductId']?>');" data-original-title="Add to Wish List"><i class="zmdi zmdi-favorite zmdi-hc-fw"></i></button> 
            </div> 
                         <div class="quickview hidden-sm hidden-xs">
             <!-- <a class="iframe-link btn quick-view btn btn-sm btn-outline-light" data-toggle="tooltip" data-placement="top" href="<?PHP echo $info['config_url'] ?>index.php?route=themecontrol/product&amp;product_id=<?PHP echo $info['ProductId']?>" title="" data-original-title="Quick View"><i class="zmdi zmdi-eye zmdi-hc-fw"></i></a>-->
             
              <a class="btn btn-info btn-sm eye-zoom prd-quick-view" viewprdct="<?PHP echo $info['ProductId']?>" data-toggle="modal" data-target="#Prdquickview"  title="<?php echo $objlang->get('quick_view'); ?>" ><i class="zmdi zmdi-eye zmdi-hc-fw"></i></a>
             
            </div>
             
                        <div class="zoom hidden-xs hidden-sm">
                                  &nbsp;
                            </div>  
             
          </div>
          

        </div>
                        
                        
                        
                        
					</div>
		
	<div class="product-meta">
		<div class="left">
			<h3 class="name"><a href="<?PHP echo $info['href'] ?>"><?PHP echo $info['ProductName'] ?></a></h3>

            <div class="price" itemscope="" itemprop="offers">
                   
                   <?PHP
                   	if( $info['special']!='')
                    {
                    	?>
                        <span class="price-new"><?PHP echo $CurrencySymbol." ".$info['special'];  ?></span>
	                    <span class="price-old"><?PHP echo $CurrencySymbol." ".$info['price'];  ?></span>
                        <?PHP
                    }
                    else
                    {
                   ?>
                   <span class="special-price"><?PHP echo $CurrencySymbol. $info['price'];  ?></span>
                   <?PHP
                   }
                   ?>
                     
                    
                    <meta content="900.00" itemprop="price">
                    <meta content="" itemprop="priceCurrency">
            </div>
                
                
					</div>

		<div class="clearfix"></div>

	</div>
    <div class="clearfix"></div>

</div>



                
                  	
		</div>
        
        
        <div class="clearfix"></div>
        
         </div>
    <?PHP
    }
    ?>
      
      
      </div>
     
      
      
      
      </div>
      
    </div>
<?PHP
    }
?>
        <!-- recently viewed products ends here-->
        
</div>




<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('#button-cart').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'],  input[id=\'product_id\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart').button('loading');
		},
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {

				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}
				$('.text-danger').parent().addClass('has-error');

				if ( json['error']['Outofstock'] )
				{
					
					$('#notification').html('<div class="alert alert-danger">' + json['error']['Outofstock'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				// Highlight any found errors
							}

			if (json['success']) {
				$('#notification').html('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
		          
          if( $("#cart #cart-total").hasClass("cart-mini-info") ){
              json['total'] = json['total'].replace(/-(.*)+$/,"");
          }
          $('#cart-total').html(json['total']);
          
				$('html, body').animate({ scrollTop: 0 }, 'slow');
				
				$('#cart > ul').load('index.php?route=common/cart/info ul li');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: $("#form-review").serialize(),
    beforeSend: function() {
      $('#button-review').button('loading');
    },
    complete: function() {
      $('#button-review').button('reset');
    },
    success: function(json) {
      $('.alert-success, .alert-danger').remove();

      if (json['error']) {
		  $('html, body').animate({  scrollTop: $('#writereview').offset().top }, 800);
        $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
      }

      if (json['success']) {
		   $('html, body').animate({  scrollTop: $('#writereview').offset().top }, 800);
        $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

      //  $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').prop('checked', false);
      }
    }
  });
});

$(document).ready(function() { 
	$('.thumbnail a').click(
		function(){  
			$.magnificPopup.open({
			  items: {
			    src:  $('img',this).attr('src')
			  },
			  type: 'image'
			});	
			return false;
		}
	);
});
//--></script> 
<?php if( $productConfig['product_enablezoom'] ) { ?>
<script type="text/javascript" src=" catalog/view/javascript/jquery/elevatezoom/elevatezoom-min.js"></script>
<script type="text/javascript">
    var zoomCollection = '<?php echo $productConfig["product_zoomgallery"]=="basic"?".product-image-zoom":"#image";?>';
    $( zoomCollection ).elevateZoom({
    <?php if( $productConfig['product_zoommode'] != 'basic' ) { ?>
    zoomType        : "<?php echo $productConfig['product_zoommode'];?>",
    <?php } ?>
    lensShape : "<?php echo $productConfig['product_zoomlensshape'];?>",
    lensSize    : <?php echo (int)$productConfig['product_zoomlenssize'];?>,
    easing:true,
    gallery:'image-additional-carousel',
    cursor: 'pointer',
    galleryActiveClass: "active"
  });
 
</script>
<?php } else { ?> 
<script type="text/javascript">
  $(document).ready(function() {
    $('thumbnails').magnificPopup({
      type:'image',
      delegate:{
        enable:true
      }
    });
  });
</script>
<?php } ?>


<?php echo $footer; ?>

<script>

	$(document).ready(function()
	{
		
		$(document).on('click','.writereview',function()
		{
			$('.reviewsection').trigger('click'); 
			if(!$(".reviewsection").hasClass('collapsed'))
				$('html, body').animate({  scrollTop: $('#writereview').offset().top }, 800);
			else
			{
				//$('.reviewsection').trigger('click'); 
				//$('html, body').animate({  scrollTop: $('#writereview').offset().top }, 800);
			}
			
		});
		
		
	/*	$(document).on('click','.view-reviews',function()
		{
			
			setTimeout(function()
									{ 
										
										if( !$(".reviewsection").hasClass('collapsed') )
											$('html, body').animate({  scrollTop: $('#tab-review').offset().top }, 800);
										else
										{
											$('html, body').animate({  scrollTop: $('#tab-review').offset().top }, 800);
											$('.reviewsection').trigger('click'); 
										}
										
										
									}, 100);
			
			
			
		
		});*/
		
		
		
		
	});

</script>



<script src="catalog/view/javascript/owl.carousel.js"></script>


<script>

$(window).load(function()
{ 
$('.owl-theme .owl-nav').css({'top':'2px','background':'#000'});



});
            $(document).ready(function() {
				

				
				//$(".item").parent().css({'width':'72%'});
            $('.owl-carousel').owlCarousel({
                loop: false,
				autoplay:false,
				margin: 10,
				slideBy:5,
                responsiveClass: true,
                responsive: {
                  0: {
                    items: 1,
                    nav: true
                  },
                  600: {
                    items: 5,
                    nav: false
                  },
                  1000: {
                    items: 5,
                    nav: true,
					loop: false,
                    margin: 0
                  }
                }
              });
			  
			  
			  var owl = $('.owl-carousel');
				owl.owlCarousel();
			  
			  owl.on('changed.owl.carousel', function(event) 
			  {
  					//alert();
				});
            });
			
			
			
			 $(document).ready(function() {
				

				
				//$(".item").parent().css({'width':'72%'});
            $('.owl-carousel').owlCarousel({
                loop: false,
				autoplay:false,
				margin: 10,
				slideBy:5,
                responsiveClass: true,
                responsive: {
                  0: {
                    items: 1,
                    nav: true
                  },
                  600: {
                    items: 5,
                    nav: false
                  },
                  1000: {
                    items: 5,
                    nav: true,
					loop: false,
                    margin: 0
                  }
                }
              });
			  
			  
			  var owl = $('.owl-carousel');
				owl.owlCarousel();
			  
			  owl.on('changed.owl.carousel', function(event) 
			  {
  					//alert();
				});
            });
			
			//
			
			$(document).on('click','.addtocrosssale',function()
			{
				
				if($(this).prop('checked'))
					{
						var add_remove="add";
						var product = $(this).val();
						var crosssale = $(this).attr('crosssaleprice');
								
					}
				else
				{
					var add_remove="remove";
					var product = $(this).val();
					var crosssale = $(this).attr('crosssaleprice');
				}
				
				
				
			});
			
$(document).on('click','.addtocrosssale',function()
			{
				
				if($(this).prop('checked'))
					{
						var add_remove="add";
						var product = $(this).val();
						var crosssale = $(this).attr('crosssaleprice');
						var parentProduct = $("#product_id").val();
						
						sendingData = {"product_id":product,"quantity":'1',"crosssale":crosssale,"parentProduct":parentProduct};

							$.ajax({
									
									url: 'index.php?route=checkout/cart/add',
									type: 'post',
									data:sendingData,
									success:function(json)
									{
										
										if( $("#cart #cart-total").hasClass("cart-mini-info") ){
										json['total'] = json['total'].replace(/-(.*)+$/,"");
										}
										$('#cart-total').html(json['total']);
										
										$('html, body').animate({ scrollTop: 0 }, 'slow');
										
										$('#cart > ul').load('index.php?route=common/cart/info ul li');
									}
									
									
									}); //ajax ends here
						
					}
				else
				{
					var add_remove="remove";
					var product = $(this).val();
					var crosssale = $(this).attr('crosssaleprice');
					var parentProduct = $("#product_id").val();
					cart.remove(product+'_remove.'+parentProduct);
				}
				
				
				
			});			

</script>


