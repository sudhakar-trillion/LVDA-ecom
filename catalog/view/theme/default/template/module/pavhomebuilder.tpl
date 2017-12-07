<?php 
	$template = dirname(__FILE__).'/pagebuilder-rows.tpl'; 
	$level = 1;
?>


	
<div id="pav-homebuilder<?php echo rand(); ?>" class="homebuilder clearfix <?php echo $class ?>">

	 	<?php 
        $cnte=0;
        foreach ( $layouts as $row) { 
	 		$row->level = $level;
$cnte++;
	 	?>
	   
       <!-- 
       Coded by sudhakar on 20-09-2017
       
       I have taken the two same section in below following code 
       that is because client wants the slider to be full width, in order to make the slider full-width we have to
       remove the container class, so i had checked whether the widget name based on the width name i had taken the container
       
       -->
       
       
       
       <div class="home-page-parallax pav-container <?php echo $row->cls; ?> <?php if ( isset($row->parallax)&&$row->parallax ) { ?> pts-parallax <?php } ?>" <?php echo $row->attrs?>>
			
            <!--
            for the below div there was a class called container 
            to meet the client requirement we had removed the class called container
            
             -->
             <!-- Below div is only for the banner slider widget-->
             
            <div class="pav-inner ">
		 
				    <div class="row row-level-<?php echo $row->level; ?> <?php echo $row->sfxcls?>">
				    	<div class="row-inner clearfix" >
					        <?php 
                            
                        
                            foreach( $row->cols as $col ) { ?>
					            <div class="col-lg-<?php echo $col->lgcol; ?> col-md-<?php echo $col->mdcol;?> col-sm-<?php echo $col->smcol;?> col-xs-<?php echo $col->xscol;?> <?php echo $col->sfxcls?> ssr">
					            	<div class="col-inner <?php echo $col->cls;?>" <?php echo $col->attrs?>>

					            		 <?php
                                       
                                         
                                          foreach ( $col->widgets as $widget ){ 
                                          $chkslider = explode(">",$widget->name);
                                          if( isset($widget->content) && trim($chkslider[0]) == "Pav Layers Sliders" ) { 
                                           echo $widget->content;
                                           } 
                                           else
                                           		echo "<div class='emptycontent'></div>";
                                           ?>
						                <?php } ?>
						               
						                <?php if (isset($col->rows)&&$col->rows) { ?>
						                    <?php   
						                        $rows = $col->rows;
						                        $level = $level + 1;
						                         require(  $template ); 
						                    ?>
						                <?php } ?>
					               
					            	</div>
					        	</div>
					        <?php } ?>
			    	</div>
				</div>
		 
		    </div>
            
           <?PHP
	           if( $cnte==2)
               {
               	?>
              <!--  <div class="<?PHP if(sizeof($Subcategories)<5){ echo 'col-md-offset-1'; } ?>" style='padding-top:10px'>
                                                        <?PHP
                                                        	foreach( $Subcategories as $val)
                                                            {
                                                            	?>
                                                                <div class="col-lg-2.4 col-md-2.4 col-sm-2.4 col-xs-12 col"  >
                                                                    <div class="item-inner" style="height:300px; background:#fff">
                                                                    	
                                                                        <a href="<?PHP echo str_replace(" ","-",strtolower($val['meta_title']))?>" style="color:#fff"><img src="image/<?PHP echo $val['ProductImg']; ?>" width="100%"  /></a>
                                                                    
                                                                    </div>
                                                                      <div class="clearfix"></div>
                                                                  </div>
                                                                
                                                                <?PHP
                                                            }
                                                        ?>
                                                        <div class="clearfix"></div>
                                                        </div><strong></strong>-->
                                        
                                        
                                        
                        <div class="container-fluid">   
                           
                           <div class="banner-text">
<div class="row">
<?PHP
$imgnum = 16;
foreach( $Subcategories as $val)
{
?>
<div class="col-sm-4">
<div class="box-col">
<div class="images"><a href="<?PHP echo str_replace(" ","-",strtolower($val['meta_title']))?>"><img src="image/catalog/banner<?PHP echo $imgnum; ?>.jpg" alt=""></a></div>
<div class="des">
<?PHP
$cat=explode("/",strtolower($val['meta_title']));
?>
<a href="<?PHP echo str_replace(" ","-",strtolower($val['meta_title']))?>">View <?PHP echo str_replace("-"," ",$cat[1]);?></a></div>
</div>
</div>

<?PHP
$imgnum++;
}?>

<!--<div class="col-sm-4">
<div class="box-col">
<div class="images"><a href="#"><img src="image/catalog/banner16.jpg" alt=""></a></div>
<div class="des">

<a href="#">View Categories</a></div>
</div>
</div>


<div class="col-sm-4">
<div class="box-col">
<div class="images"><a href="#"><img src="image/catalog/banner18.jpg" alt=""></a></div>
<div class="des">

<a href="#">View Categories</a></div>
</div>
</div>



<div class="col-sm-4">
<div class="box-col">
<div class="images"><a href="#"><img src="image/catalog/banner17.jpg" alt=""></a></div>
<div class="des">

<a href="#">View Categories</a></div>
</div>-->
</div>



<!--<div class="col-sm-3">
<div class="box-col">
<div class="images"><a href="#"><img src="image/catalog/banner17.jpg" alt=""></a></div>
<div class="des">
<h3>Slip-On</h3>
<a href="#">View Categories</a></div>
</div>
<div class="box-col">
<div class="images"><a href="#"><img src="image/catalog/banner18.jpg" alt=""></a></div>
<div class="des">
<h3>HandBags</h3>
<a href="#">View Categories</a></div>
</div>
</div>


<div class="col-sm-3">
<div class="box-col">
<div class="images"><a href="#"><img src="image/catalog/bn1.jpg"/></a></div>
<div class="des">
<h3>Accesories</h3>
<a href="#">View Categories</a></div>
</div>
</div>-->







</div>
</div>
                           
    </div>                                    
                                                        
		
        
        
        
        
                <?PHP
               }	
              
              ?>
              
            <!-- Below div is other than banner widget for the banner slider -->
            
            <div class="pav-inner <?php if ($row->fullwidth==0 ) { ?>container<?php } ?>">
		 
				    <div class="row row-level-<?php echo $row->level; ?> <?php echo $row->sfxcls?>">
				    	<div class="row-inner clearfix" >
					        <?php 
                            
                        
                            foreach( $row->cols as $col ) { ?>
					            <div class="col-lg-<?php echo $col->lgcol; ?> col-md-<?php echo $col->mdcol;?> col-sm-<?php echo $col->smcol;?> col-xs-<?php echo $col->xscol;?> <?php echo $col->sfxcls?>">
					            	<div class="col-inner <?php echo $col->cls;?>" <?php echo $col->attrs?>>

					            		 <?php
                                      
                                         
                                          foreach ( $col->widgets as $widget ){ 
                                           $chkslider = explode(">",$widget->name);
                                           ?>
						                	<?php if( isset($widget->content)  && trim($chkslider[0]) != "Pav Layers Sliders"  ) { ?>
						                     		<?php 
                                                   
                                                    	echo $widget->content; ?>
					                   		<?php } ?>
						                <?php } ?>
						               
						                <?php if (isset($col->rows)&&$col->rows) { ?>
						                    <?php   
						                        $rows = $col->rows;
						                        $level = $level + 1;
                                                echo $template; 
						                         require(  $template ); 
						                    ?>
						                <?php } ?>
					               
					            	</div>
					        	</div>
					        <?php } ?>
			    	</div>
				</div>
		 
		    </div>
            
		</div>
        
		<?php } ?>	

</div>

