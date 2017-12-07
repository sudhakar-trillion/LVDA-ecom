<div class="col-md-6 prd-mrg-btm add-btm-brder">

 <h1 class="mostviewed">Bought Together</h1>

 <div class="products-block most-v product-recently-viewed ">
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
            
            
            <div class ="checkboxCros">
<input type="checkbox" name="addtocrosssale" class="addtocrosssale" crosssaleprice="<?PHP echo $info['prddetails']['SalePrice']?>" id="checkboxCrosInput"  value="<?PHP echo $CrosssaleProduct; ?>" <?PHP  if($info['prddetails']['InCart']=="Yes") echo 'checked' ?> />
<label for="checkboxCrosInput"></label>
</div>


 
<!--<input type="checkbox" name="addtocrosssale" class="addtocrosssale" crosssaleprice="<?PHP echo $info['prddetails']['SalePrice']?>"  value="<?PHP echo $CrosssaleProduct; ?>" <?PHP  if($info['prddetails']['InCart']=="Yes") echo 'checked' ?> />-->

 
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

          
 ?>
                        
            </div>
      </div>
      
</div>      