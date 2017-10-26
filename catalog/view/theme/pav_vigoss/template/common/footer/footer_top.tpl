<?PHP
if( $_SESSION['default']['top_footer'] =="Yes" )
{
?>
<div class="<?php echo str_replace('_','-',$blockid); ?> <?php echo $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
  <div class="container">
    <div class="inside">
       <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
          <?php if( $content=$helper->getLangConfig('widget_address') ) {?>
              <?php  
              	echo $content; 
                
                ?>
          <?php } ?>
        </div>
     
       <!-- <div class="col-sm-4 col-md-4 col-sm-6 col-xs-12">   
          <?php //require( ThemeControlHelper::getLayoutPath( 'common/block-social.tpl' ) ); ?>
        </div>
       
        
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
          <?php
           // echo $helper->renderModule('pavnewsletter');
          ?>
        </div>-->
        
      </div>
    </div>
  </div>
</div>
<?PHP
}
?>