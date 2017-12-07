<!--
<fieldset>
<legend><?php #echo $text_captcha; ?></legend>
  <div class="form-group required">
    <?php if (substr($route, 0, 9) == 'checkout/') { ?>
    <label class="control-label" for="input-payment-captcha"><?php echo $entry_captcha; ?></label>
    <input type="text" name="captcha" id="input-payment-captcha" class="form-control" />
    <img src="index.php?route=captcha/basic_captcha/captcha" alt="" />
    <?php } else { ?>
    <label class="col-sm-2 control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>
    <div class="col-sm-10">
      <input type="text" name="captcha" id="input-captcha" class="form-control" />
      <img src="index.php?route=captcha/basic_captcha/captcha" alt="" />
      <?php if ($error_captcha) { ?>
      <div class="text-danger"><?php echo $error_captcha; ?></div>
      <?php } ?>
    </div>
    <?php } ?>
  </div>
</fieldset>

-->

<fieldset>
<!--  <legend><?php echo $text_captcha; ?></legend>-->
  <div class="form-group required">
  <?PHP
  	$requesturi = explode("/",$_SERVER['REQUEST_URI']);

    if( $requesturi[2] == "contactus")
    {
    	?>
            <div class="col-sm-10 pull-right "> 
            <div class="col-sm-9 pl  "> <input type="text" name="captcha" id="input-captcha" class="form-control" placeholder="Captcha" />
            <?php if ($error_captcha) { ?>
            <div class="text-danger"><?php echo $error_captcha; ?></div>
            <?php } ?>
            </div>
            <img src="index.php?route=captcha/basic_captcha/captcha" class="pull-right"  alt="" style="margin-top:0px" />
             <span class="refresh-captcha" style="font-size:25px; padding-top:10px; cursor:pointer"><i class="fa fa-refresh" aria-hidden="true"></i></span>
            
            </div>

            </div>     
        <?PHP
    }
    elseif($requesturi[2]=="index.php?route=checkout")
    {
    ?>
            <div class="col-sm-12 pl pull-right ">
            <div class="col-sm-8 pl  "> <input type="text" name="captcha" id="input-captcha" class="form-control" placeholder="Captcha" />
            <?php if ($error_captcha) { ?>
            <div class="text-danger"><?php echo $error_captcha; ?></div>
            <?php } ?>
            </div>
            <img src="index.php?route=captcha/basic_captcha/captcha" class="pull-right"  alt="" style="margin-top:0px"  />
             <span class="refresh-captcha" style="font-size:25px; padding-top:10px; cursor:pointer"><i class="fa fa-refresh" aria-hidden="true"></i></span>
            
            </div>

            </div>     
        <?PHP
    }
    elseif($requesturi[2]=="return-product")
    {
    	?>
        <div class="col-sm-10  pull-right ">
            <div class="col-sm-8 pl  "> <input type="text" name="captcha" id="input-captcha" class="form-control" placeholder="Captcha"/>
            <?php if ($error_captcha) { ?>
            <div class="text-danger"><?php echo $error_captcha; ?></div>
            <?php } ?>
            </div>
            <img src="index.php?route=captcha/basic_captcha/captcha" class="pull-right"  alt="" style="margin-top:0px" />
             <span class="refresh-captcha" style="font-size:25px; padding-top:10px; cursor:pointer"><i class="fa fa-refresh" aria-hidden="true"></i></span>
            
            </div>
        
        <?PHP
    }
    
    else
    {
#    echo $requesturi[2]; exit; 
    
  ?>
  
    <?php if (substr($route, 0, 9) == 'checkout/') { ?>
    <label class="control-label" for="input-payment-captcha"><?php echo $entry_captcha; ?></label>
    <input type="text" name="captcha" id="input-payment-captcha"   class="form-control" autocomplete="off" value="" placeholder="Captcha" />
    <img src="index.php?route=extension/captcha/basic_captcha/captcha" alt="" style="margin-top:3px" />
    <?php } else {
  ?>
    <!--<label class="col-sm-2 control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>-->
    <div class="col-sm-12 ">
      <div class="col-sm-8  "> <input type="text" name="captcha" id="input-captcha" class="form-control" placeholder="Captcha" /></div>
      <img src="index.php?route=captcha/basic_captcha/captcha"  alt="" style="margin-top:0px" />
      <span class="refresh-captcha" style="font-size:25px; padding-top:10px; cursor:pointer"><i class="fa fa-refresh" aria-hidden="true"></i></span>
      <?php if ($error_captcha) { ?>
      <div class="text-danger"><?php echo $error_captcha; ?></div>
      <?php } ?>
    </div>
    <?php } ?>
  </div>
  <?PHP
  }
  ?>
</fieldset>
