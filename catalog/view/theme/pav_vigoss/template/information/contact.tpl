<?php
    $config = $sconfig;
    $theme  = $themename;
    $themeConfig = (array)$config->get('themecontrol');
?>
<?php  echo $header; ?> <?php require( ThemeControlHelper::getLayoutPath( 'common/mass-header.tpl' )  ); ?>
<div class="main-columns container ">
   <div class="container-inside"> 
  
  <div class="row"><?php if( $SPAN[0] ): ?>
			<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</aside>	
		<?php endif; ?> 
  
   <div id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>"><div id="content" class="space-padding-0"><?php echo $content_top; ?>
      <!-- <h1 class="page-title"><?php //echo $heading_title; ?></h1> -->
<!--      <h3 class="heading-left"><?php echo $text_location; ?></h3>
-->
      


    
      <?php if ($locations) { ?>
      <h3><?php echo $text_store; ?></h3>
      <div class="panel-group" id="accordion">
        <?php foreach ($locations as $location) { ?>
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4 class="panel-title"><a href="#collapse-location<?php echo $location['location_id']; ?>" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><?php echo $location['name']; ?> <i class="fa fa-caret-down"></i></a></h4>
          </div>
          <div class="panel-collapse collapse" id="collapse-location<?php echo $location['location_id']; ?>">
            <div class="panel-body">
              <div class="row">
                <?php if ($location['image']) { ?>
                <div class="col-sm-3"><img src="<?php echo $location['image']; ?>" alt="<?php echo $location['name']; ?>" title="<?php echo $location['name']; ?>" class="img-thumbnail" /></div>
                <?php } ?>
                <div class="col-sm-3"><strong><?php echo $location['name']; ?></strong><br />
                  <address>
                  <?php echo $location['address']; ?>
                  </address>
                  <?php if ($location['geocode']) { ?>
                  <a href="https://maps.google.com/maps?q=<?php echo urlencode($location['geocode']); ?>&hl=en&t=m&z=15" target="_blank" class="btn btn-info"><i class="fa fa-map-marker"></i> <?php echo $button_map; ?></a>
                  <?php } ?>
                </div>
                <div class="col-sm-3"> <strong><?php echo $text_telephone; ?></strong><br>
                  <?php echo $location['telephone']; ?><br />
                  <br />
                  <?php if ($location['fax']) { ?>
                  <strong><?php echo $text_fax; ?></strong><br>
                  <?php echo $location['fax']; ?>
                  <?php } ?>
                </div>
                <div class="col-sm-3">
                  <?php if ($location['open']) { ?>
                  <strong><?php echo $text_open; ?></strong><br />
                  <?php echo $location['open']; ?><br />
                  <br />
                  <?php } ?>
                  <?php if ($location['comment']) { ?>
                  <strong><?php echo $text_comment; ?></strong><br />
                  <?php echo $location['comment']; ?>
                  <?php } ?>
                </div>
              </div>
            </div>
          </div>
        </div>
        <?php } ?>
      </div>
      <?php } ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal bg-white space-padding-20">
        <div class="row">
              <?php 
                $html = html_entity_decode($themeConfig['contact_customhtml'][$config->get('config_language_id')]);
                $c = 0;
                $c2 = 8;
              
              ?>
              <fieldset class="col-md-4">
                   <h3 class="heading-left"><?php echo $text_store; ?></h3>
                    <div class="contact-customhtml">
                      <div class="content">
                          
                          <div class="panel-contact-info">
                            <div class="panel-body">
                              <div class="row">
                                <?php if ($image) { ?>
                                <div class="col-sm-12"><img src="<?php echo $image; ?>" alt="<?php echo $store; ?>" title="<?php echo $store; ?>" class="img-thumbnail" /></div>
                                <?php } ?>
                     
                                    <div class="media">
                                      <div class="media-icon pull-left"><span class="fa fa-home fa-2x"></span></div>
                                      <div class="media-body">
                                        <h5 class="media-heading"><?php echo $store; ?></h5>
                                             <address>
                                            <?php echo $address; ?>
                                            </address>
                                            <?php if ($geocode) { ?>
                                            <a href="https://maps.google.com/maps?q=<?php echo urlencode($geocode); ?>&hl=en&t=m&z=15" target="_blank" class="btn btn-info"><i class="fa fa-map-marker"></i> <?php echo $button_map; ?></a>
                                            <?php } ?>
                                      </div>
                                    </div>

                                    <div class="media">
                                      <div class="media-icon pull-left"><span class="fa fa-phone fa-2x"></span></div>
                                      <div class="media-body">
                                        <h5 class="media-heading"><?php echo $text_telephone; ?></h5>
                                            <?php echo $telephone; ?><br />
                                            <br />
                                            <?php if ($fax) { ?>
                                            <strong><?php echo $text_fax; ?></strong><br>
                                            <?php echo $fax; ?>
                                            <?php } ?>
                                      </div>
                                    </div>
                                   <?php if ($open) { ?>
                                    <div class="media">
                                      <div class="media-icon pull-left"><span class="fa fa-phone fa-2x"></span></div>
                                      <div class="media-body">
                                        <h5 class="media-heading"><?php echo $text_open; ?></h5>
                                            <?php echo $open; ?>
                                      </div>
                                    </div>
                                    <?php } ?>
                             
                                   <?php if ($comment) { ?>
                                    <div class="media">
                                      <div class="media-icon pull-left"><span class="fa fa-phone fa-2x"></span></div>
                                      <div class="media-body">
                                        <h5 class="media-heading"><?php echo $text_comment; ?></h5>
                                            <?php echo $comment; ?>
                                      </div>
                                    </div>
                                    <?php } ?>

                              </div>
                            </div>
                          </div>
                        
                          <?php if( !empty($html) ) { ?>
                           <div class="panel-contact-custom">  
                            <?php echo $html; ?>
                           </div>
                          <?php } ?> 

                      </div>
                    </div>
              </fieldset>
              <fieldset class="col-md-8 " style="background:#f1f1f1">
                <h3 class="heading-left"><?php echo $text_contact; ?></h3>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
                    <?php if ($error_name) { ?>
                    <div class="text-danger"><?php echo $error_name; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
                    <?php if ($error_email) { ?>
                    <div class="text-danger"><?php echo $error_email; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-enquiry"><?php echo $entry_enquiry; ?></label>
                  <div class="col-sm-10">
                    <textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
                    <?php if ($error_enquiry) { ?>
                    <div class="text-danger"><?php echo $error_enquiry; ?></div>
                    <?php } ?>
                  </div>
                </div>
        
          <?php echo $captcha; ?>
                 <div class="buttons no-bg-bt clearfix">
                  <div class="pull-right">
                    <input class="btn btn-default con-check" type="submit" value="<?php echo $button_submit; ?>" />
                  </div>
                </div>
              </fieldset> 
        </div>      
       
      </form>
  <?php echo $content_bottom; ?></div>
   </div> 
<?php if( $SPAN[2] ): ?>
	<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?></div>
</div>
</div>


<div class="contact-location hidden-xs ">
                  <div id="contact-maps">
                  
                  <iframe width="1925"  height="450"  frameborder="0" style="border:0" src="http://www.google.com/maps/embed/v1/place?key=AIzaSyC2Gj6jfoHrfUP8FwQMOSiMJm1rVIXoUHI&q=<?PHP echo $locations[0]['address']?>" allowfullscreen>
</iframe>
                  
                  </div>
</div>

 <?php // Jquery googlemap api v3?>


   <script type="text/javascript" src="https://www.google.com/maps/embed/v1/place?key=AIzaSyC2Gj6jfoHrfUP8FwQMOSiMJm1rVIXoUHI&q=B62"></script>

<script>
/*
var latitude='';
var longitude='';
var addr = 'B62, Near Auro Mira School D.D Colony, Hyderabad - 500013 Telangana, India';

//Function to covert address to Latitude and Longitude
var getLocation =  function(address) {
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': address}, function(results, status) {

  if (status == google.maps.GeocoderStatus.OK) {
    latitude = results[0].geometry.location.lat();
    longitude = results[0].geometry.location.lng();
    console.log(latitude+":"+longitude);
      } 
  }); 
}

//Call the function with address as parameter
getLocation(addr);
*/
</script>


<!--
 <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&language=en"></script>
 -->
    <script type="text/javascript" src="catalog/view/javascript/gmap/gmap3.min.js"></script>
    <script type="text/javascript" src="catalog/view/javascript/gmap/gmap3.infobox.js"></script>
    <script type="text/javascript">
        
/*		var mapDiv, map, infobox;
        var lat = latitude;
        var lon = longitude;
		
        jQuery(document).ready(function($) {
            mapDiv = $("#contact-map");
            mapDiv.height(400).gmap3({
                map:{
                    options:{
                        center:[lat,lon],
                        zoom: 15
                    }
                },
                marker:{
                    values:[
                        {latLng:[lat, lon], data:"79-99 Beaver Street, New York, NY 10005, USA"},
                    ],
                    options:{
                        draggable: false
                    },
                    events:{
                          mouseover: function(marker, event, context){
                            var map = $(this).gmap3("get"),
                                infowindow = $(this).gmap3({get:{name:"infowindow"}});
                            if (infowindow){
                                infowindow.open(map, marker);
                                infowindow.setContent(context.data);
                            } else {
                                $(this).gmap3({
                                infowindow:{
                                    anchor:marker, 
                                    options:{content: context.data}
                                }
                              });
                            }
                        },
                        mouseout: function(){
                            var infowindow = $(this).gmap3({get:{name:"infowindow"}});
                            if (infowindow){
                                infowindow.close();
                            }
                        }
                    }
                }
            });
        });
		*/
    </script>
    
    <?php //end contact map ?>
<?php echo $footer; ?>
