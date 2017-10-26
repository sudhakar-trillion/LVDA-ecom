</div>

<?php 
   global $config; 
?>

<?php
  $blockid = 'mass_bottom';
  $blockcls = '';
 
  $ospans = array(1=>12);
  $tmcols = 'col-sm-12 col-xs-12';
  require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );

  $defaultFooter = false;
?>
<?php if( $defaultFooter ) { ?>

<footer>
  <div class="container">
    <div class="row">
      <?php if ($informations) { ?>
      <div class="col-sm-3">
        <h5><?php echo $text_information; ?></h5>
        <ul class="list-unstyled">
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
      <div class="col-sm-3">
        <h5><?php echo $text_service; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_extra; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
          <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
          <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
          <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_account; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>
      </div>
    </div>   
  </div>
</footer>
<?php } else { ?>

<footer id="footer" class="nostylingboxs">
 
  <?php
 
    $blockid = 'footer_top';
    $blockcls = '';
    require( ThemeControlHelper::getLayoutPath( 'common/footer/footer_top.tpl' ) );
  ?>

  <?php

    $blockid = 'footer_center';
    $blockcls = '';
    require( ThemeControlHelper::getLayoutPath( 'common/footer/footer_center.tpl' ) );
  ?>

  <?php
    $blockid = 'footer_bottom';
    $blockcls = '';
    $ospans = array();
    require( ThemeControlHelper::getLayoutPath( 'common/block-footcols.tpl' ) );
  ?>


</footer>

<?php } ?>
<div class="copyright">
  <div class="container clearfix">
    <div class="inner">
      <?php if( $helper->getConfig('enable_custom_copyright', 0) ) { ?>
          <?php echo ' © 2017 LVDA Store. All Rights Reserved. Developed By '; #echo html_entity_decode($helper->getConfig('copyright')); ?>
          <a href="http://www.trillionit./com" target="_blank"> Trillion IT Services PVT LTD</a>
        <?php } else { ?>
          <?php# echo $powered; ?>. 
        <?php } ?>
    </div>
   
  </div>
</div>
<div id="top-scroll" class="bo-social-icons">
    <a href="#" class="bo-social-gray radius-x scrollup"><i class="fa fa-angle-up"></i></a>
  </div>

<?php if( $helper->getConfig('enable_paneltool',0) ){  ?>
  <?php  //echo $helper->renderAddon( 'panel' );?>
<?php } ?>
<?php
  $offcanvas = $helper->getConfig('offcanvas','category');
  if($offcanvas == "megamenu") {
      echo $helper->renderAddon( 'offcanvas');
  } else {
      echo $helper->renderAddon( 'offcanvas-category');
  }

  ?> 


<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->

<!-- Theme created by Welford Media for OpenCart 2.0 www.welfordmedia.co.uk -->



            
                       
                   
            

</div>

</body></html>
<script>

	$(document).ready(function()
	{
		
		$(".pts-parallax:last").css({'margin-bottom':'60px','padding':'60px 0px '});
	});
	
	$(document).on('click','.sticky-reg-login.myaccount, .sticky-logged-in',function()
	{
		
		if( !$(".logged-in").hasClass('toggleDisplay') )
		{
			$(".logged-in").css({'display':'block'});
			$(".logged-in").addClass('toggleDisplay');
		}
		else
		{
				$(".logged-in").css({'display':'none'});
				$(".logged-in").removeClass('toggleDisplay');
		}
		
	});
	
	
	$(document).on('click','#logged-myaccount',function()
	{
		
		if( !$(".logged-in").hasClass('toggleDisplay') )
		{
			$(".logged-in").css({'display':'block'});
			$(".logged-in").addClass('toggleDisplay');
		}
		else
		{
				$(".logged-in").css({'display':'none'});
				$(".logged-in").removeClass('toggleDisplay');
		}
		
	});
	
	


	
	
	$(document).on('click','.dummy, .dummy1, .logo-section,.maincols',function()
	{

		if( $(".logged-in").hasClass('toggleDisplay') )
		{
			$(".logged-in").css({'display':'none'});
				$(".logged-in").removeClass('toggleDisplay');
		}
	});
	
	
	
	
	$(".setting-box").on('click',function()
	{
		if( $(".account-list").hasClass('toggleDisplay') )
		{
			$(".account-list").removeClass('toggleDisplay');
			$(".account-list").css({'display':'none'});
		}
		
		if( $(".logged-in").hasClass('toggleDisplay') )
		{
			$(".logged-in").css({'display':'none'});
				$(".logged-in").removeClass('toggleDisplay');
		}
		
	});
	


$(document).on('click','.menu',function()
{
	$(".ui-autocomplete").css({'display':'none'});
});
	
	
	
	
	
	
</script>

<script type="text/javascript" async="async" defer="defer" data-cfasync="false" src="https://mylivechat.com/chatinline.aspx?hccid=44717497"></script>



<script>
	
	
$(document).on('click',".zmdi-chevron-left",function()
	{
		alert();
	});	
	
</script>


<div id="Prdquickview" class="modal fade forgot-modal" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close quick-view-close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="text-align:left">Quick View</h4>
      </div>
      <div class="modal-body">
        
        
        <div class="product-info">
        
        	<div class="row">
        
        		
                <div class="col-md-6 col-sm-6  image-container">
                <div class="thumbnail image space-20">

          
                  
            <span class="product-label bts prd-spcl"></span>
        
        <a href="" class="imagezoom quick-img-link">
            <img src="" title="Crystal Brandy Glass" alt="Crystal Brandy Glass" id="prdquickview-thumb"  class="product-image-zoom img-responsive">
        </a>
    </div>
                
                </div>
                
                
                <div class="col-md-6 col-sm-6">
          
            <h1 class="heading-left prdct-title" ></h1>
            <p class="prd-desc"></p>
        
         <div class="price detail">
                  <ul class="list-unstyled">
                      
                          <li> 
                          <span class="price-old"></span> 
                          <span class="price-new"></span> 
                          </li>
                  </ul>
              </div>
              
          
                     
          <ul class="list-unstyled">
          
          <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span>Availability:<span class='prd-stock'></span></li>
          
          
<!--                            <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span>Availability:In Stock</li>
                
-->                            <li><span class="check-box text-primary"><i class="zmdi zmdi-check zmdi-hc-fw"></i></span>Product Code: <span class="prd-code"></span></li>
                                      </ul>
         
        
            <div id="product">
                                                      
              <div class="product-buttons-wrap">
                <div class="product-qyt-action space-margin-tb-20 clearfix">
                    <div class="quantity-title qty pull-left">Qty:</div>
                    <div class="quantity-adder pull-left">
                        <div class="quantity-number pull-left">
                            <input type="text" name="quantity" value="1" size="2" id="input-quantity" class="form-control">
                        </div>
                        <div class="quantity-wrapper pull-left">
                        <span class="add-up add-action">
                            <i class="fa fa-plus"></i>
                        </span>
                        <span class=" add-down  add-action">
                            <i class="fa fa-minus"></i>
                        </span>
                        </div>
                       
                    </div>               
                </div>
           
                <input type="hidden" name="product_id" value="">
                <div class="clearfix">
                <div class="pull-left space-right-15">
                    <button type="button" id="button-cart" data-loading-text="Loading..." class="btn btn-primary btn-shopping-cart">
                      <i class="zmdi  zmdi-plus zmdi-hc-fw space-right-5"></i><span>Add to Cart</span>
                    </button>
                </div> 
               
                <div class="pull-left">  
                    <a data-toggle="tooltip" class="btn btn-sm btn-inverse-light quickwishlist" title="" onclick="wishlist.add
                      ('63');" data-original-title="Add to Wish List"><i class="zmdi zmdi-favorite-outline zmdi-hc-fw"></i></a>
                </div>
               
              </div>  
                            </div>
              
              </div>
               
          
          </div>
                
            
            <div class="clearfix"></div>
            
            </div>
        
        
        </div>
        
      </div>
     
    </div>

  </div>
  <div class="clearfix"></div>
</div>

<script>

$(document).on('click','.prd-quick-view',function()
		{
			
			var ProductId = $(this).attr('viewprdct');
			
			//var ProductId='158965896569';
			
			$.ajax({
						url:'index.php?route=requestdispatcher/requestdispatcher/productquickview',
						type:'post',
						data:{"ProductId":ProductId},
						success:function(resp)
						{
							resp = $.trim(resp);
							
							if(resp!='false')
							{
								resp = JSON.parse(resp);
								
								$(".quick-img-link").attr('href',resp.meta_title);
								$(".prdct-title").html("<a href='"+resp.meta_title+"'>"+resp.name+"</a>");
								
								
								$("#prdquickview-thumb").attr('src',resp.ProductImg);
								$(".prd-desc").html(resp.description);
								$(".prd-code").html(resp.model);
								var quantity = resp.quantity;
									quantity = parseInt(quantity);
									
									if(quantity>2)
									{
										$(".modal-body .prd-stock").html('In stock');
										
										$(".modal-body .fa-minus").parent().addClass('add-down');
										$(".modal-body .fa-plus").parent().addClass('add-up');
										
										$(".modal-body .btn-shopping-cart").removeClass('outofstock');
										$(".modal-body .btn-shopping-cart").addClass('quickview-addcart');
										
										$(".modal-body .btn-shopping-cart").attr('onclick','cart.add('+resp.product_id+')');
										
										$(".modal-body .btn-shopping-cart").find('span').html("Add ToCart");
										
										
									}
									else
									{
										$(".modal-body .prd-stock").html('Out of stock');
										$(".modal-body .fa-minus").parent().removeClass('add-down');
										$(".modal-body .fa-plus").parent().removeClass('add-up');
										
										$(".modal-body .btn-shopping-cart").removeClass('quickview-addcart');
										$(".modal-body .btn-shopping-cart").addClass('outofstock');
										$(".modal-body .btn-shopping-cart").attr('onclick','');
										
										$(".modal-body .btn-shopping-cart").find('span').html("OUT OF STOCK");
									}
								
								$("#product_id").val(resp.product_id);
								
								
								$(".quickwishlist").attr('prdid',resp.product_id);
								
								$(".quickwishlist").attr('onclick','wishlist.add('+resp.product_id+')');
								
								
								
								var pricing_sec = '<div class="price-gruop">';
								var special = resp.special;
								pricing_sec=pricing_sec+'<span class="text-price">$'+resp.price+'</span>';
								if(special==null)
								{
									//pricing_sec=pricing_sec+'$'+resp.price;
									$(".modal-body .prd-spcl").css({'display':'none'});
									$(".modal-body .price-new").html(resp.CurrencyCode+" "+resp.price);
									$(".modal-body .price-old").html('');
									
								}
								else
								{
									//pricing_sec=pricing_sec+'<span class="price-old">$'+price-new+'</span> <span class="price-new">$'+resp.special+'</span>';								
									$(".modal-body .price-old").html(resp.CurrencyCode+" "+resp.price);
									$(".modal-body .price-new").html(resp.CurrencyCode+" "+resp.special);
									
									
									
									$(".modal-body .prd-spcl").css({'display':'block'});
									$(".modal-body .prd-spcl").html('<span class="product-label-special">Sale</span>');
								}
								
									//$(".quick-product-pricing .price").html(pricing_sec);
								
							}
							else
							{
								$(".prdct-title").html('Invalid input');
								$(".modal-body").html("<h2>Sorry invalid request</h2>");
								
							}
						}
				
					});
			
			
			
			
				
		
		});

</script>