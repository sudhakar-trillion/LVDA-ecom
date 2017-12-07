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
  
  
    <div class="inner ">
    
    <div class="col-md-6 text-left">
      <?php if( $helper->getConfig('enable_custom_copyright', 0) ) { ?>
          <?php echo ' © 2017 LVDA Store. All Rights Reserved. Developed By '; #echo html_entity_decode($helper->getConfig('copyright')); ?>
          <a href="http://www.trillionit.com" target="_blank"> TrillionIT </a>
        <?php } else { ?>
          <?php# echo $powered; ?>. 
        <?php } ?>
    </div>
    
      <div class="col-md-6 text-right">
    <div class="link-payment">
				<p><img src="image/catalog/payment1.png" alt=""></p>			</div>
    
    
   </div>
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

$(window).load(function()
{
	$(".free-ship-anchor").removeAttr('href');
	$(".free-ship-heading").remove();
	
	$(".emptycontent").parent().parent().parent().parent().parent().remove();
	
	
});


	$(document).ready(function()
	{
		$("#pavo-footer-top").hide();
		
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

<!--
<script type="text/javascript" async="async" defer="defer" data-cfasync="false" src="https://mylivechat.com/chatinline.aspx?hccid=44717497"></script>
-->


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
        <!--<h4 class="modal-title" style="text-align:left">Quick View</h4>-->
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
         
        
            <div id="product" class="popupproduct">
              
              <div class="product_options">
              
              </div>
               
               
                                                      
              <div class="product-buttons-wrap">
                <div class="product-qyt-action space-margin-tb-20 clearfix pull-left">
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
           
                <input type="hidden" name="product_id" id="popupProductId" value="">
               
                <div class="pull-left space-right-15">
                    <button type="button" id="button-cart" data-loading-text="Loading..." class="btn btn-primary btn-shopping-cart button-cart" popup="yes">
                      <i class="zmdi  zmdi-plus zmdi-hc-fw space-right-5"></i><span>Add to Cart</span>
                    </button>
                </div> 
               
                <div class="pull-left">  
                    <a data-toggle="tooltip" class="btn btn-sm btn-inverse-light quickwishlist" title="" onclick="wishlist.add
                      ('63');" data-original-title="Add to Wish List"><i class="zmdi zmdi-favorite-outline zmdi-hc-fw"></i></a>
                </div>
               
			<div class="clearfix"></div>
            <div class="notify-msg"></div>
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

<div id="cart-purchase-notify" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">

<!--
     <button type="button" class="close" data-dismiss="modal">&times;</button> 
-->
        <h4 class="modal-title">Cart going to expire in 5 minutes </h4>
      </div>
      <div class="modal-body">
        <p style="font-size:20px">Kindly complete the purchase with in 5 minutes</p>
        <p>
         <span class="pull-left">Do you want to Continue Shopping</span>
        
        <span style="margin-left:20px">
            <button type="button" class="btn btn-default" data-dismiss="modal" id="IncreaseCartExpiry">Yes</button>
            <button type="button" class="btn btn-default" style="margin-left:5px" data-dismiss="modal" id="destroyCart" >No</button>
        </span>
        </p>
      </div>
      
      
    </div>

  </div>
</div>

<script>
$(document).on('click','.refresh-captcha',function()
{

$(this).prev().attr('src','index.php?route=captcha/basic_captcha/captcha');
	
});

$(document).on('click','#IncreaseCartExpiry, #destroyCart ',function()
{
	var action = $(this).attr('action');
	
	$.ajax({
				url:'index.php?route=requestdispatcher/requestdispatcher/extendcartexpire',
				data:{"action":action},
				success:function()
				{
					
				}
		
		});
});


$(document).on('click',"#Prdquickview .quick-view-close",function()
{
	$("#prdquickview-thumb").attr('src','');
});

$(document).on('click','.prd-quick-view',function()
		{
			
			var ProductId = $(this).attr('viewprdct');
			$("#prdquickview-thumb").attr('src','');
			//var ProductId='158965896569';
			$("#popupProductId").val(ProductId);
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
								
								$("#prdquickview-thumb").attr('src','');
								$("#prdquickview-thumb").attr('src',resp.ProductImg);
								
								$(".prd-desc").html('');
								
								$(".prd-desc").html(resp.description);
								
								
								
								$(".prd-code").html(resp.model);
								
								
								
								if(resp.Options.hasOwnProperty('optns'))
								{
									var heading = "<h3>Available Options</h3>";
									$(".product_options").html(heading);
									
									var cnt=0;
									//console.log(resp.Options.optns);
									
									$.each(resp.Options.optns,function(ind,val)
									{
										
										if( val['required']>0)
											var req='required';
										else
											var req='';
												
												
										if( val['type'] =="radio" )
										{
											var rad = '<div class="form-group '+req+' form-group-v2">';
											var lbel = '<label class="control-label" for="input-option'+val['product_option_id']+'">'+val['name']+'</label>';

											var inputopt = '<div id="input-option'+val['product_option_id']+'" class="radio-options">';
											
											var radiooptions = val['product_option_value'];
											
											var radiodata = '';
											
											
											$.each(radiooptions,function(i,v)
											{ 
												radiodata = radiodata+'<div class="radio"> <label class="radio_label">';
												radiodata = radiodata+' <input type="radio" name="option['+val["product_option_id"]+']" class="radiooptions" value="'+v['product_option_value_id']+'" />';
												if( $.trim(v['image'])=='') 
													radiodata = radiodata+v['name'];
												else
													radiodata = radiodata+'<img src="'+v['image']+'"/>';
												
												if( v['price'])
												{
													radiodata=radiodata+'<span class="optionalPrice"><span class="prefix" id="'+v['price_prefix']+'"> </span><span class="optionalPriceVal" id="'+v['price'].replace("Rs.","")+'"></span></span>';
												}
												
												radiodata = radiodata+'</label></div>';
												
												
											});
											
											inputopt = inputopt+radiodata;
											inputopt=inputopt+"</div>";
											
											
											$(".product_options").append(rad+lbel+inputopt+'</div>');
												
										}
										if( val['type'] =="select" )
										{
											var selct = '<div class="form-group"'+req+'>';
											var selctclose="</div>";
											var selopts = '';
											
											var lbel = '<label class="control-label" for="input-option'+val['product_option_id']+'">'+val['name']+'</label>';
											
											var selctoption = '<select name="option['+val["product_option_id"]+']" id="input-option'+val["product_option_id"]+'" class="form-control">  <option value="">Select '+val['name']+'</option>';
											
											var optionvalues = val['product_option_value'];
												//optionvalues = JSON.parse(optionvalues);
												
												$.each(optionvalues,function(i,v)
												{
													selopts=selopts+'<option value="'+v["product_option_value_id"]+'">'+v["name"];
													if(v['price'])
													{
														selopts=selopts+'('+v["price_prefix"]+v["price"]+')';
													}
													selopts=selopts+'</option>';
													
												});
												selctoption = selctoption+selopts+"</select>";
											
											
											$(".product_options").append(selct+lbel+selctoption+selctclose);
											
												
												
										}
										
										
									});
									
									
								}
								else
									$(".product_options").html('');
								
								
								var quantity = resp.quantity;
									quantity = parseInt(quantity);
									
									if(quantity>2)
									{
										$(".modal-body .prd-stock").html('In stock');
										
										$(".modal-body .fa-minus").parent().addClass('add-down');
										$(".modal-body .fa-plus").parent().addClass('add-up');
										
										$(".modal-body .btn-shopping-cart").removeClass('outofstock');
										$(".modal-body .btn-shopping-cart").addClass('quickview-addcart');
										
										//$(".modal-body .btn-shopping-cart").attr('onclick','cart.add('+resp.product_id+')');
										
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
								pricing_sec=pricing_sec+'<span class="text-price">$'+Math.ceil(resp.price)+'</span>';

								if(special=='' && quantity>2)
								{
									//pricing_sec=pricing_sec+'$'+resp.price;
									$(".modal-body .prd-spcl").css({'display':'none'});
									$(".modal-body .price-new").html(resp.CurrencyCode+" "+Math.ceil(resp.price));
									$(".modal-body .price-old").html('');
									
								}
								else
								{
									if(quantity>2)
									{
										//pricing_sec=pricing_sec+'<span class="price-old">$'+price-new+'</span> <span class="price-new">$'+resp.special+'</span>';								
										$(".modal-body .price-old").html(resp.CurrencyCode+" "+Math.ceil(resp.price));
										$(".modal-body .price-new").html(resp.CurrencyCode+" "+Math.ceil(resp.special));
										$(".modal-body .prd-spcl").css({'display':'block'});
										$(".modal-body .prd-spcl").html('<span class="product-label-special">Sale</span>');
									}
									else
									{
										
										$(".modal-body .price-old").html('');
										$(".modal-body .price-new").html('');
										$(".modal-body .prd-spcl").css({'display':'none'});
									}
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

//notify me when restock

$(document).on('click','#notify_restorck_btn',function()
{
	var Onclick = $(this);
	
	var sEmail = $("#notify_restorck").val();
		sEmail =$.trim(sEmail);
	var Product = $("#product_id").val();
	
	var Err_cnt='0';
		
		if(sEmail=='')
		{
			Err_cnt='1';
			$(".notify-msg").html("Enter Email").addClass('notify-restock');
		}
		else
		{
			$(".notify-msg").html("").removeClass('notify-restock');
			
			var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
			if (filter.test(sEmail)) 
			{
				$(".notify-msg").html("").removeClass('notify-restock');
				
				$.ajax({
						url:'index.php?route=requestdispatcher/requestdispatcher/notifyrestore',
						type:"POST",
						data:{"Product":Product,"UserEmail":sEmail},
						beforeSend:function(){ Onclick.val('Sending..').css({'color':'#d4c085'}); Onclick.prop('disabled',true); },
						success:function(resp)
						{
							resp = $.trim(resp);

							Onclick.prop('disabled',false);
							Onclick.val('Notify').css({'color':'#FFF'});
							  
							if(resp=='1')
								{
									$(".notify-msg").html("We'll notify you once we have it back in stock").removeClass('notify-restock');
									$("#notify_restorck").val('');
								}
							else if(resp=='-1')
								$(".notify-msg").html("You have already asked for notification").addClass('notify-restock');
							
						} //success function ends here
						
						
					});
			}
			else 
			{
				Err_cnt='1';
				$(".notify-msg").html("Enter Correct Email Format").addClass('notify-restock');
			}

		}
	
	
	
	
});
		
		$(document).ready(function()
		{
			//check whether user had added anything to cart 
			//if so then check the time remaing for the cart to expire
			//if it 5 or less than 5 minutes show a notification modal-popup
			//so that user can get a notification and user can take necessary actions
			
			var cartitmes = "<?PHP echo $cartsize; ?>";
				cartitmes = parseInt(cartitmes);
				
				
					setInterval(function()
					{
						$.ajax({
									url:'index.php?route=requestdispatcher/requestdispatcher/checkcartexpiryTime',
									type:"POST",
									data:{},
									success:function(resp)
									{
										resp = $.trim(resp);
										if(resp=="yes")
											$("#cart-purchase-notify").modal('show');
										else
										{
											$("#cart-purchase-notify").modal('hide');
											if(resp == 'deleted')
											{
												$("#cart-total").html('0 item(s) - Rs. 0');
												$('#cart > ul').load('index.php?route=common/cart/info ul li');	
											}
										}
											
									}
						
								});	
				
				
				
					}, 60000);
					
					
				
		
$(document).on('click','#button-cart, .button-cart',function()
	{
		
		$(".prd-err").remove();
		var popup = $(this).attr('popup');
		
		var data='';
		
		if(popup=='no')
		{
			data=$('#product input[type=\'text\'],  input[id=\'product_id\'],  #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea');
			
			//console.log(data);
			
		}
		else if(popup=='yes')
		{
			data=$('.popupproduct input[type=\'text\'],  input[id=\'popupProductId\'], input[name=\'product_id\'],  .popupproduct input[type=\'radio\']:checked, .popupproduct input[type=\'checkbox\']:checked, .popupproduct select, .popupproduct textarea');
			
			//console.log(data);
		}
		
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: data,//$('#product input[type=\'text\'],  input[id=\'product_id\'],  #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
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
						
						if( popup=="no")	
						{
							var element = $('#input-option' + i.replace('_', '-'));
							
							if (element.parent().hasClass('input-group')) {
								element.parent().next().find('p').html('');
								element.parent().after('<p class="prd-err">' + json['error']['option'][i] + '</p>');
							} else {
								element.parent().next().find('p').html('');
								element.after('<p class="prd-err">' + json['error']['option'][i] + '</p>');
							}
						}
						else if( popup=="yes")
						{
							
							var element = $('.popupproduct #input-option' + i.replace('_', '-'));

							console.log(element);
							
							if (element.parent().hasClass('input-group')) {
								element.parent().next().find('p').html('');
								element.parent().after('<p class="prd-err">' + json['error']['option'][i] + '</p>');
							} else {
								element.next().find('p').html('');
								element.after('<p class="prd-err">' + json['error']['option'][i] + '</p>');
							}
							
						}
						
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}
				$('.text-danger').parent().addClass('has-error');
				
				if( popup=="no")
					var addcls = '';
				else
					var addcls = '.popupproduct';
				
				if ( json['error']['Outofstock'] )
				{
					
				//	$('#notification').html('<div class="alert alert-danger">' + json['error']['Outofstock'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					//$('html, body').animate({ scrollTop: 0 }, 'slow');
			
						$(addcls+" .notify-msg").html( json['error']['Outofstock']).css({'color':'red'});
					
					
					
				}

				// Highlight any found errors
							}

			if (json['success']) {
				$('#notification').html('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				var succmsg = '<p class="prd-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></p>';
					
					if( popup=="no")
						$(".notify-msg").html( succmsg).css({'color':'#1db40a','position':'relative'});
				else
					$(".popupproduct .notify-msg").html( succmsg).css({'color':'#1db40a','position':'relative'});
					
				
		          
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
	
 $(document).on('click','.prd-success .close',function()
	 {
		 $(".prd-success").remove();
 	});
			
		});

</script>