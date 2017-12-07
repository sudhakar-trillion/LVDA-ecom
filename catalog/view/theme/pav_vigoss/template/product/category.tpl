
<?php echo $header;  ?>


<?php if ($thumb) { ?>
        <div class="banner-image" style="margin-top:0px ;background:url('<?php echo $thumb; ?>') no-repeat fixed; padding-top:78px; padding-bottom:41px; color:#fff; position:relative; margin-bottom:30px; text-align:center; overflow:hidden" >


  <ul class="breadcrumb" >
  <div class="container">
    <h1 ><?php echo $heading_title; ?></h1>
   <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </div>   
  </ul>        

        
        </div>
        <?php }
        else
        {
         ?>
        <div class="banner-image" style="margin-top:-18px ;background:url('<?php echo $thumb; ?>') no-repeat fixed; padding-top:120px; padding-bottom:41px; color:#fff; position:relative; margin-bottom:30px; text-align:center; overflow:hidden" >


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
        } ?>

  <div class="container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-md-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-md-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-md-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
    <!-- 
	    This section is to display the filter search such as color size so its already there in the left side so we are commenting 
        if clients asks filter to be here also then uncomment the below phpline
    
    -->
    <?php #echo $content_top; ?>
      
       <?php if ($thumb || $description) { ?>
      <div class="category-info clearfix hidden-xs hidden-sm">
      <!--  <?php if ($thumb) { ?>
          <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" /></div>
          <?php } ?>-->
          <?php if ($description) { ?>
          <div class="category-description wrapper">
            <?php echo $description; ?>
          </div>
          <?php } ?>
      </div>
      <?php } ?>

      <?php if( false &&  $categories = $helper->getCategoriesById() ){   ?>
     <div class="subcategories panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title"><?php echo $text_refine; ?> </h4>
       </div> 
        <div class="panel-body">
          <?php $col=6; $i=0; $ncol = floor(12/$col); foreach( $categories as $category ){  $i++; ?>
            <?php if($i%$col==1) { ?>
            <div class="row">
            <?php } ?>
            <div class="col-lg-<?php echo $ncol; ?> col-md-3 col-sm-4"><div class="category-item">
              <?php if( $category['thumb'] ){ ?>
                   <div class="image">
                      <a href="<?php echo $category['href']; ?>">
                        <img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" class="img-responsive" />
                      </a>
                  </div>
              <?php } ?>
                <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
            </div></div>
            <?php if( $i%$col==0 || $i==count($categories) ){ ?>
            </div>
            <?php } ?>
          <?php } ?>
        </div>
        </div> 
        <?php } else if ($categories) { ?>
       
          <div class="refine-search panel panel-center space-20">
            <div class="panel-heading">
              <h4 class="panel-title"><?php echo $text_refine; ?></h4>
            </div>
            <div class="panel-body border">
              <?php if (count($categories) <= 20) { ?>
                  
                  <ul class="list-inline ">
                    <?php
                    
                 //   $attr = str_replace(" ","-",strtolower(trim(substr($categories[0]['name'],0,strpos($categories[0]['name'],"(")))));
                    $arr = array();
                
                     foreach ($categories as $category) 
                     { 
                     ?>
                    <li style="width:150px" class="chekmultiple" dualitem="<?PHP echo $attr?>">
                   	<a href="<?php echo $category['href']; ?>"> <img src="image/<?PHP echo $category['latestPrd']; ?>"  style="width:100%; display:block"/></a>
                    <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                    
                    </li>
                    <?php 
                    	
                    } ?>
                  </ul>
              <?php } else { ?>
              <div class="row">
                <?php foreach (array_chunk($categories, ceil(count($categories) / 4)) as $categories) { ?>
                <div class="col-sm-3">
                  <ul class="list-inline">
                    <?php foreach ($categories as $category) { ?>
                    <li><a href="<?php echo $category['href']; ?>"><?php  echo $category['name']; ?></a></li>
                    <?php } ?>
                  </ul>
                </div>
                <?php } ?>
              </div>
              <?php } ?>
            </div>
         </div>    
        
         <!-- end refine-search -->
      <?php } ?>

      <?php if ($products) { ?>
      <?php   require( ThemeControlHelper::getLayoutPath( 'product/product_filter.tpl' ) );   ?>
    
      
        <?php require( ThemeControlHelper::getLayoutPath( 'common/product_collection.tpl' ) );  ?> 
      <?php } ?>
      <?php if (!$categories && !$products) { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      
      <!-- recently viewed products -->
      
      
      <?PHP
	if(sizeof($recentlyviewedProductsInfo)>0)
    {
    
?>

    <div class="row most-nopad">

    
      <h1 class="mostviewed">Recently Viewed Products</h1>
      
          <div class="products-block most-v">
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
      if( $info['special']!=''){?>  <span class="product-label-special product-label"><span class="special">Sale</span></span><?PHP } ?>
			
			<a class="img" href="<?PHP echo $info['href'] ?>"><img src="<?PHP echo $info['ProductImage']?>" alt="Zafferano Ultralight Universal Wine Glasses" class="img-responsive"></a>

	
    <div class="bottom">
                      <div class="cart">            
               <button data-loading-text="Loading..." class="btn btn-danger" type="button" onclick="<?PHP if($info['PrdAvailQuantity']>1){?>cart.add('<?PHP echo $info['ProductId']?>');<?PHP } ?>">
                <?PHP if($info['PrdAvailQuantity']>1){?> <span>Add to Cart</span><?PHP } else echo 'Out Of Stock'; ?>
              </button>
            </div>
                  
          <!--<div class="action">           

            <div class="compare">     
              <button class="btn btn-sm btn-outline-light " type="button" data-toggle="tooltip" data-placement="top" title="" onclick="compare.add('<?PHP echo $info['ProductId']?>');" data-original-title="Compare this Product"><i class="zmdi zmdi-tune zmdi-hc-fw"></i></button> 
            </div>  
            <div class="wishlist">
              <button class="btn btn-sm btn-outline-light " type="button" data-toggle="tooltip" data-placement="top" title="" onclick="wishlist.add('<?PHP echo $info['ProductId']?>');" data-original-title="Add to Wish List"><i class="zmdi zmdi-favorite zmdi-hc-fw"></i></button> 
            </div> 
                         <div class="quickview hidden-sm hidden-xs">
              <a class="iframe-link btn quick-view btn btn-sm btn-outline-light" data-toggle="tooltip" data-placement="top" href="<?PHP echo $info['config_url'] ?>index.php?route=themecontrol/product&amp;product_id=<?PHP echo $info['ProductId']?>" title="" data-original-title="Quick View"><i class="zmdi zmdi-eye zmdi-hc-fw"></i></a>
            </div>
             
                        <div class="zoom hidden-xs hidden-sm">
                                  &nbsp;
                            </div>  
             
          </div>-->
          

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
                        <span class="price-new"><?PHP echo $info['special'];  ?></span>
	                    <span class="price-old"><?PHP echo $info['price'];  ?></span>
                        <?PHP
                    }
                    else
                    {
                   ?>
                   <span class="special-price"><?PHP echo $info['price'];  ?></span>
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
    <!-- recently viewed products ends here -->      
      
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>

<script src="catalog/view/javascript/owl.carousel.js"></script>
<script>


            $(document).ready(function() {
				
				//$(".item").parent().css({'width':'72%'});
				
				
              $('.owl-carousel').owlCarousel({
                loop: false,
				autoplay:false,
				
				slideBy:4,
                responsiveClass: true,
                responsive: {
                  0: {
                    items: 1,
                    nav: true
                  },
                  600: {
                    items: 4,
                    nav: false
                  },
                  1000: {
                    items: 4,
                    nav: true,
					loop: false,
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

</script>
