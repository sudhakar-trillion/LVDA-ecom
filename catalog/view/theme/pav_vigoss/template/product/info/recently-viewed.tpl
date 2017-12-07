<div class="col-md-6 prd-mrg-btm">
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
                        <span class="price-new"><?PHP echo $CurrencySymbol." ".round($info['special'],1);  ?></span>
	                    <span class="price-old"><?PHP echo $CurrencySymbol." ".round($info['price'],1);  ?></span>
                        <?PHP
                    }
                    else
                    {
                   ?>
                   <span class="special-price"><?PHP echo $CurrencySymbol. round($info['price'],1);  ?></span>
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

</div>    