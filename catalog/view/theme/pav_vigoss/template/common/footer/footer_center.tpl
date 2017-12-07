<div class="<?php echo str_replace('_','-',$blockid); ?> <?php echo $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
  <div class="container">
    <div class="inside">
       <div class="row">
       
       
        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-12">
          <?php if( $content=$helper->getLangConfig('widget_logo_footer') ) {?>
              <?php echo $content; ?>
          <?php } ?>
          
           <div class="panel-heading">
              <h4 class="panel-title followus">Follow Us On</h4>
            </div>
          
          <ul class="footer-social">
<li class="first"><a class="twitter fa fa-twitter" title="Twitter" href="#"><span>twitter</span></a></li>
<li><a class="google fa fa-google-plus" title="Google" href="#"><span>google </span></a></li>
<li><a class="facebook fa fa-facebook" title="Facebook" href="#"><span>facebook</span></a></li>
<li><a class="youtube fa fa-youtube" title="Youtube" href="#"><span>youtube </span></a></li>
<li><a class="flickr fa fa-flickr" title="Flickr" href="#"><span>Flickr </span></a></li>
</ul>
          
          
        </div>
        
        <!--<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
          <?php
            echo $helper->renderModule('pavpopulartags');
          ?> 
        </div>-->
        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12 column">
          <div class="panel panel-v1">
            <div class="panel-heading">
              <h4 class="panel-title"><?php echo $text_information; ?></h4>
            </div>
            <div class="panel-body">
              <ul class="list-unstyled">
                <?php foreach ($informations as $information) { 
	                if( $information['title'] !='Delivery Information')
    	            {
                ?>
                <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                <?php 
                	}
                } ?>
               <!-- <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>-->
              </ul>
            </div>
          </div>         
        </div>
        <div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
          <div class="panel panel-v1">
            <div class="panel-heading">
              <h4 class="panel-title"><?php echo $text_account; ?></h4>
            </div>
            <div class="panel-body">
              <ul class="list-unstyled">
                <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                <!--<li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
                <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>-->
              </ul>
            </div>
          </div>      
        </div>
        
        <div class="col-sm-3 col-md-3 col-sm-6 col-xs-12 column">
             <div class="panel panel-v1">
            <div class="panel-heading">
              <h4 class="panel-title">Reach Us</h4>
            </div>
            <div class="panel-body">
              
              
              <ul class="list-unstyled" style="padding:0px">
            <li><!--<i class="fa fa-globe"> </i>--> B62, Near Auro Mira School<br>
              <span> D.D Colony, Hyderabad - 500013</span><br>
              <span>Telangana, India.</span> </li>
            <li> <strong>Email:</strong> info@lvda.com</li>
            <li> <strong>Mobile No:</strong> +91 912 394 5689</li>
          </ul>
              
            </div>
          </div>            
        </div>
        
        <!--<div class="col-sm-3 col-md-3 col-sm-6 col-xs-12 column">
             <div class="panel panel-v1">
            <div class="panel-heading">
              <h4 class="panel-title"><?php echo $text_extra; ?></h4>
            </div>
            <div class="panel-body">
              <ul class="list-unstyled">
                <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
                <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
                <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
                <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
                <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
              </ul>
            </div>
          </div>            
        </div>-->

      </div>
    </div>
  </div>
</div>

