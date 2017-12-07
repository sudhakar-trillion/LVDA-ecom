<div class="col-md-6 prd-mrg-btm add-btm-brder">
	
    <h1 class="mostviewed">May look</h1>
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
                     <span class="special-price"><?PHP echo $upsale['currency']." ".round($upsale['SalePrice'],1);  ?></span>
                  
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