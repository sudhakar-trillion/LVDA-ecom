<?php 
	$template = dirname(__FILE__).'/pagebuilder-rows.tpl'; 
	$level = 1;
?>

	
<div id="pav-homebuilder<?php echo rand(); ?>" class="homebuilder clearfix <?php echo $class ?>">

	 	<?php foreach ( $layouts as $row) { 
	 		$row->level = $level;

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
					            <div class="col-lg-<?php echo $col->lgcol; ?> col-md-<?php echo $col->mdcol;?> col-sm-<?php echo $col->smcol;?> col-xs-<?php echo $col->xscol;?> <?php echo $col->sfxcls?>">
					            	<div class="col-inner <?php echo $col->cls;?>" <?php echo $col->attrs?>>

					            		 <?php
                                       
                                         
                                          foreach ( $col->widgets as $widget ){ 
                                          $chkslider = explode(">",$widget->name);
                                          if( isset($widget->content) && trim($chkslider[0]) == "Pav Layers Sliders" ) { 
                                           echo $widget->content;
                                           } 
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
						                     		<?php echo $widget->content; ?>
					                   		<?php } ?>
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
            
		</div>
        
		<?php } ?>	

</div>

