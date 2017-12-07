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
  <div class="row">
  
 <?php #echo $column_left; ?> 
  <!--
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-md-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-md-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-md-12'; ?>
    <?php } ?>
-->
    <div id="content" class="col-md-12"><?php echo $content_top; ?>
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
          
           <?php if ($review_status) { ?>
            <div class="rating">
              <p>
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($rating < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><!--<i class="fa fa-star-o fa-stack-1x"></i>--></span>
                <?php } ?>
                <?php } ?>
              
              <!--  <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $reviews; ?></a> / <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"  ><?php echo $text_write; ?></a>-->
              
               
                <a href="" onclick="return false;" ><?php echo " Voted by ".str_replace("reviews","",$reviews)." Customers"; ?></a>
              
              </p>
              
            </div>
            <?php } ?>  
          
          
            <h1 class="heading-left"><?php echo $heading_title; ?></h1>
        
        <!-- Price of the product -->
        
          <?php if ($price) { ?>
              <div class="price detail">
                  <ul class="list-unstyled">
                      <?php if (!$special) { ?>
                          <li>
                              <span class="price-new"> <?php echo str_replace("RS","Rs",$price); ?> </span>
                          </li>
                      <?php } else { ?>

                          <li> <span class="price-new"> <?php echo str_replace("RS","Rs",$special); ?> </span> <span class="price-old"><?php echo str_replace("RS","Rs",$price); ?></span> </li>
                      <?php } ?>
                  </ul>
              </div>
          <?php } ?>
    
          <ul class="list-unstyled">
             <!-- <?php if ($tax) { ?>
                  <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
              <?php } ?>-->

              <?php if ($discounts) { ?>
                  <li>
                  </li>
                  <?php foreach ($discounts as $discount) { ?>
                      <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
                  <?php } ?>
              <?php } ?>
          </ul>
          
           <ul class="list-unstyled">
          
          <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span><?php echo $text_stock; ?><?php if ($AvailQuantity > 1) { echo $stock;} else echo "<b>".$OutOfStock."</b>"; ?></li>
          
          
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
        
        <!-- product description -->
        
 		<div class="prdct-description">
        	<?php echo $description; ?>
		</div> 
           
            <div id="product">
              <?php if ($options) { ?>
            
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
                <div id="input-option<?php echo $option['product_option_id']; ?>" class="radio-options">
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
                           <input type="hidden" name="product_id" id="product_id" value="<?php echo $product_id; ?>" />
            <?php 
               if ($AvailQuantity > 1) 
               {  
               ?>
              <div class="product-buttons-wrap">
                <div class="product-qyt-action  clearfix pull-left">
                    <div class="quantity-title qty pull-left"><?php echo $entry_qty; ?>:</div>
                    <div class="quantity-adder pull-left">
                        <div class="quantity-number pull-left">
                            <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
                        </div>
                        <div class="quantity-wrapper pull-left">
                        <span class="<?PHP if($AvailQuantity>1) {?>add-up <?PHP } ?>add-action">
                            <i class="fa fa-plus"></i>
                        </span>
                        <span class="<?PHP if($AvailQuantity>1) {?> add-down <?PHP } ?> add-action">
                            <i class="fa fa-minus"></i>
                        </span>
                        </div>
                       
                    </div>               
                </div>

                 
                <div class="pull-left ">
                    <button type="button" id="<?PHP if($AvailQuantity>1) {?>button-cart<?PHP }else echo 'out-of-stock' ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary">
                      <i class="zmdi <?PHP if($AvailQuantity>1) {?> zmdi-plus<?PHP } ?> zmdi-hc-fw space-right-5"></i><span><?php if($AvailQuantity>1) { echo $button_cart; } else echo 'Out of Stock'; ?></span>
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
                  <div class="clearfix"></div>
                <div class="notify-msg"></div>
                 
               </div>
             
              <?PHP
              }
              else
              {
              	echo "<p class='notify-restock'>".$notify_restock."</p>";
                ?>
                 

                 <div>
                <input typer="text" name="notify_restorck" id="notify_restorck" placeholder="Enter Email" class="notify-element" />
                <input type="button" name="notify_restorck_btn" id="notify_restorck_btn" value="Notify" />
                <div class="clearfix"></div>   
                </div>
                <span class="notify-msg"></span>
                <?PHP
              }
              ?>  
              <?php if ($minimum > 1) { ?>
              <div class="alert alert-info space-top-10"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
              <?php } ?>

         
              <!-- AddThis Button BEGIN -->
				
                <!--
                <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
                <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>
				-->	
                    
	            <!-- AddThis Button END -->
              </div>
     
          <div>
          
          
          <div class="accordion collapse-right space-margin-tb-60 prdct-reviews-accordion">
        <div id="accordion-v5">
               
                
                 <?php if ($review_status) { ?>
                 <div class="panel panel-default " id="writereview">
                    <div class="panel-heading">
                   <div>
                    <span class="pull-right customer-review-writing" data-toggle="modal" data-target="#ReviewForm"><?PHP echo $text_write; ?></span>
	               </div>
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion-v5" class="collapsed reviewsection" href="#collapse-v5-tab_review">
                                <h3>Read Reviews <i class="fa fa-caret-down reviewcaret"></i></h3>
                            </a>
                        </h4>
                         
                       
                    </div>
                    <div id="collapse-v5-tab_review" class="panel-collapse collapse">
                        <div class="panel-body">
                            <div class="tab-pane" id="tab-review">
                            <div id="review"></div>
                             
                            </div>
                        </div>  
                    </div>        
                </div>
                 <?php  } ?>
                  

        </div>
</div>
          
          </div>
          
          
          </div>
          
           
        </div>
      </div>

 



   <?php //require( ThemeControlHelper::getLayoutPath( 'product/info/'.$layout_pinfo.'.tpl' ) );  ?>
   
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
    
<div class="shopalzo-mis-widgets">    

<?PHP
	if( $crosssaleproducts!='0')
    	require( ThemeControlHelper::getLayoutPath( 'product/info/cross-sale.tpl' ) ); 
    if($upsaleProducts!='0')
        require( ThemeControlHelper::getLayoutPath( 'product/info/up-sale.tpl' ) ); 
    
    ?>

<div class="clearfix"></div>

 <?php 
 	if ($products) 
 		{  
		 $heading_title = $text_related; $customcols = 4; ?>
        <div class="panel panel-center product-related col-md-6 prd-mrg-btm"> <?php require( ThemeControlHelper::getLayoutPath( 'common/products_carousel.tpl' ) );  ?>   </div>
<?php 
		} 
?>


    <!-- recently viewed products -->
    
      <?PHP
	if(sizeof($recentlyviewedProductsInfo)>0)
     require( ThemeControlHelper::getLayoutPath( 'product/info/recently-viewed.tpl' ) ); 
    ?>
        <!-- recently viewed products ends here-->

</div><!--  shopalzo-mis-widgets ends here -->
        
</div>

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
		data: $('#product input[type=\'text\'],  input[id=\'product_id\'],  #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
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
							element.parent().after('<p class="prd-err">' + json['error']['option'][i] + '</p>');
						} else {
							element.after('<p class="prd-err">' + json['error']['option'][i] + '</p>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}
				$('.text-danger').parent().addClass('has-error');

				if ( json['error']['Outofstock'] )
				{
					
				//	$('#notification').html('<div class="alert alert-danger">' + json['error']['Outofstock'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					//$('html, body').animate({ scrollTop: 0 }, 'slow');
					
					$(".notify-msg").html( json['error']['Outofstock']).css({'color':'red'});
					
					
				}

				// Highlight any found errors
							}

			if (json['success']) {
				//$('#notification').html('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				var succmsg = '<p class="prd-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></p>';
				
				$(".notify-msg").html( succmsg).css({'color':'#1db40a','position':'relative'});
		          
          if( $("#cart #cart-total").hasClass("cart-mini-info") ){
              json['total'] = json['total'].replace(/-(.*)+$/,"");
          }
          $('#cart-total').html(json['total']);
          
				//$('html, body').animate({ scrollTop: 0 }, 'slow');
				
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

//$('#button-review').on('click', function() {
	
	$(document).on('click','#button-review',function()
	{
	
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
			  //$('html, body').animate({  scrollTop: $('#writereview').offset().top }, 800);
			$('#form-review').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
		  }
		  if (json['success']) {
		//	   $('html, body').animate({  scrollTop: $('#writereview').offset().top }, 800);
			$('#form-review').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
	
		  //  $('input[name=\'name\']').val('');
			$('textarea[name=\'text\']').val('');
			$('#input-captcha').val('');
			$('input[name=\'rating\']:checked').prop('checked', false);
		  }
		}
	  });
});

$(document).ready(function() 
{ 
	
	//$(".add-btm-brder img").css({'height':'190px'});

	$("#writereview .panel-heading").css({'border':'none'});

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
<!--
<?php if( $productConfig['product_enablezoom'] ) { ?>
<script type="text/javascript" src=" catalog/view/javascript/jquery/elevatezoom/elevatezoom-min.js"></script>
<script type="text/javascript">

    var zoomCollection = '<?php echo $productConfig["product_zoomgallery"]=="basic"?".product-image-zoom":"#image";?>';
    $( zoomCollection ).elevateZoom({
    <?php if( $productConfig['product_zoommode'] != 'basic' ) { ?>
    zoomType  : "<?php echo $productConfig['product_zoommode'];?>",
    <?php } ?>
	
    lensShape : "<?php echo $productConfig['product_zoomlensshape'];?>",
    lensSize    :<?php echo (int)$productConfig['product_zoomlenssize'];?>,
    easing:true,
    gallery:'image-additional-carousel',
    cursor: 'pointer',
    galleryActiveClass: "active",
	tint:true, tintColour:'#000', tintOpacity:0.5,easingDuration:3000,zoomWindowFadeIn:1000 
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
-->
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

	});

</script>



<script src="catalog/view/javascript/owl.carousel.js"></script>


<script>

$(window).load(function()
{ 
$('.owl-theme .owl-nav').css({'top':'2px','background':'#000'});



});
 $(document).ready(function() {
		
$(".row.most-nopad .products-block.most-v .owl-item").css("border","none !important");
	$(".owl-item, .products-block, .item.mostviewed_prdcts").css({"border":"none"});
	$(".products-block img").css({"border":"none"});

				
				//$(".item").parent().css({'width':'72%'});
            $('.owl-carousel').owlCarousel({
                loop: false,
				autoplay:false,
				margin: 10,
				slideBy:3,
                responsiveClass: true,
			
                responsive: {
                  0: {
                    items: 1,
                    nav: true
                  },
                  600: {
                    items: 3,
                    nav: false
                  },
                  1000: {
                    items: 3,
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



$(document).on('click','.lvda-thumbnail',function()
{
	var thumbnail = $(this).attr('src');
	
	thumbnail = thumbnail.replace('62x81','420x546');
	$(".clickedthumbnail").attr('src',thumbnail);
	$(".clickedthumbnail").attr('data-zoom-image',thumbnail);
	$(".zoomLens img").attr('src',thumbnail);
	
	$(".zoomWindow").css({'background-image':'url('+thumbnail+')'});
});

</script>

<?php echo $footer; ?>

<script src="catalog/view/javascript/elevatezoom/jquery.elevatezoom.js"></script>

<script>
 $(".view-product-zoom").elevateZoom({scrollZoom : true},{zoomWindowPosition:10},{zoomWindowWidth:300, zoomWindowHeight:100} );
 
 var incr=0;
var decr=$('.prd-thumbs a').length;
var clicks=0;
var trans =0;
var len = 0;

$(document).ready(function()
{
	$(".row.most-nopad .products-block.most-v .owl-item").css("border","none");

	$(".lvda-zoom-thumb").css({'height':'508px'});
	
	var imgthumb = $(".lvda-zoom-thumb img").height();
		imgthumb = parseInt(imgthumb);
		
		if(imgthumb>508)
			$(".lvda-zoom-thumb img").css({'height':'497px'});
		
	//$(".nextbtn").on('click',function()
	$(document).on('click','.nextbtn',function()
	{

		
		/*
		$("#prv").show();
		incr = parseInt(incr);
		var done='0';
		incr= (incr)+(1);
		
		var len = ($('.prd-thumbs-ssr a').length)*($('.prd-thumbs-ssr a img').height());
				
				var divident = parseInt($('.prd-thumbs-ssr a').length)+incr-(1);
					len = (len)/(divident);
					len = "-"+len;
					
				if( len == chkfinaltrans )
					$("#nxt").hide();
		
		
		if( incr==1 )
		{
			$('.prd-thumbs-ssr a').each(function(ind,val)
			{
				$('.prd-thumbs-ssr a').eq((ind)-(1)).css({'transform':'translateY(-'+$('.prd-thumbs-ssr a img').height()+'%)'});
			});
			
			if( len == "-110" && parseInt($('.prd-thumbs-ssr a').length)==5)
			$("#nxt").hide();
		}
		else
		{
				var trns = $('.prd-thumbs-ssr a').attr('style');
				trns = trns.split("(");
				trns = trns[1].split('%');
				var finaltrans = parseInt(trns[0]);
				
				finaltrans = (finaltrans)-($('.prd-thumbs-ssr a img').height()+(10.75));
				var chkfinaltrans = finaltrans;
				
				
				if(chkfinaltrans<0)
					$('.prd-thumbs-ssr a').css({'transform':'translateY('+finaltrans+'%)'});
				
				var len = ($('.prd-thumbs-ssr a').length)*($('.prd-thumbs-ssr a img').height());
				
				var divident = parseInt($('.prd-thumbs-ssr a').length);
					len = ((len)/(divident))*incr;
					len = (len)+(10.75);
					len = "-"+len;
					
				if( len == finaltrans && incr==parseInt($('.prd-thumbs-ssr a').length)-3 )
						$("#nxt").hide();
					
		}
	
	 */
	 
	 	$(".pre-btn").addClass('prebtn');
		
		$("#prv").show();
		incr = parseInt(incr);
		var done='0';
		incr= (incr)+(1);
		
		var len = ($('.prd-thumbs-ssr img').length)*($('.prd-thumbs-ssr  img').height());
				
				var divident = parseInt($('.prd-thumbs-ssr img').length)+incr-(1);
					len = (len)/(divident);
					len = "-"+len;
					
				if( len == chkfinaltrans )
					$("#nxt").hide();
		
		
		if( incr==1 )
		{
			$('.prd-thumbs-ssr img').each(function(ind,val)
			{
				$('.prd-thumbs-ssr img').eq((ind)-(1)).css({'transform':'translateY(-'+$('.prd-thumbs-ssr img').height()+'px)'});
			});
			
			var rnd = (parseInt($('.prd-thumbs-ssr img').length));
				rnd = parseInt(rnd);

				if( rnd<=5 )
						$("#nxt").removeClass('nextbtn');
		}
		else
		{
				var trns = $('.prd-thumbs-ssr img').attr('style');
				trns = trns.split("(");
				trns = trns[1].split('%');
				var finaltrans = parseInt(trns[0]);
				
				finaltrans = (finaltrans)-($('.prd-thumbs-ssr img').height());
				var chkfinaltrans = finaltrans;
				
				
				if(chkfinaltrans<0)
					$('.prd-thumbs-ssr img').css({'transform':'translateY('+finaltrans+'px)'});
				
				var len = ($('.prd-thumbs-ssr img').length)*($('.prd-thumbs-ssr img').height());
				
				var divident = parseInt($('.prd-thumbs-ssr img').length);
					len = ((len)/(divident))*(incr);
					len = (len)+(10.75);
					
					len = "-"+len;
					
				//	alert(len+":"+finaltrans+":"+incr+":"+ parseInt($('.prd-thumbs-ssr img').length) );
					
					var rnd = (parseInt($('.prd-thumbs-ssr img').length))/2;
						rnd = parseInt(rnd);	
				if( incr>=rnd )
						$("#nxt").removeClass('nextbtn');
					
		}
	
	
	 
	});

	//$(".prebtn").on('click',function()
	$(document).on('click','.prebtn',function()
	{
		incr=(incr)-(1);
		
		if(!$("#nxt").hasClass('nextbtn'))
			$("#nxt").addClass('nextbtn');
			
		var trns = $('.prd-thumbs-ssr img').attr('style');
				trns = trns.split("(");
		
				trns = trns[1].split('%');
				
				var finaltrans = parseInt(trns[0]);
				console.log(finaltrans);
				
				finaltrans = (finaltrans)+($('.prd-thumbs-ssr img').height());
				console.log(finaltrans);
				var chkfinaltrans = finaltrans;
				
				if(chkfinaltrans<0)
				{
					$('.prd-thumbs-ssr img').css({'transform':'translateY('+finaltrans+'px)'});
				}
				else
				{
					$('.prd-thumbs-ssr img').css({'transform':'translateY(0%)'});
					$("#prv").removeClass('prebtn');
				}
	});

 });
 
 
 $(document).on('click','#ReviewForm .close',function()
 {
	 $(".alert").remove();
 });
 
 $(document).on('click','.customer-review-writing',function()
 {
	 $(".alert").remove();
 });
 
 $(document).on('click','.prd-success .close',function()
 {
	 $(".prd-success").remove();
 });
 
 
 $(document).ready(function()
{ 
	$('.products-block').css({'background':'#eee'});
});

$(document).on('click','.refresh-captcha',function()
{

$(this).prev().attr('src','index.php?route=captcha/basic_captcha/captcha');
	
});
 
</script>

<div id="ReviewForm" class="modal fade forgot-modal" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Provide Your Review</h4>
      </div>
      <div class="modal-body">
        
          <form class="form-horizontal" id="form-review">
           
                                <?php if ($review_guest) { ?>
                                <div class="form-group required">
                                  <div class="col-sm-12">
                                  <!--  <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>-->
                                    <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" placeholder="<?php echo $entry_name; ?>" class="form-control" />
                                  </div>
                                </div>
                                <div class="form-group required">
                                  <div class="col-sm-12">
                                    <!--<label class="control-label" for="input-review"><?php echo $entry_review; ?></label>-->
                                    <textarea name="text" rows="5" id="input-review" class="form-control" placeholder="<?php echo $entry_review; ?>"></textarea>
                                    <div class="help-block"><?php echo $text_note; ?></div>
                                  </div>
                                </div>
                                <div class="form-group required">
                                  <div class="col-sm-12">
                                    <label class="control-label"><?php echo $entry_rating; ?></label>
                                    &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                                    <input type="radio" name="rating" value="1" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="2" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="3" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="4" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="5" />
                                    &nbsp;<?php echo $entry_good; ?></div>
                                </div>

                                <?php echo $captcha; ?>


                                <div class="buttons clearfix">
                                  <div class="pull-right">
                                    <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary reg-button">Submit </button>
                                  </div>
                                </div>
                                <?php } else { ?>
                                <?php echo $text_login; ?>
                                <?php } ?>
                              </form>
        
        
      </div>
      
    </div>

  </div>
</div>