<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb log-dis">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="col-sm-9 " style="margin:auto; float:none;  margin-top:40px;"><?php echo $content_top; ?>
      <?PHP echo @$Activated;?>
       <?PHP echo @$wishlistNotlogin;?>
    
      <div class="row">
        <div class="col-sm-6">
          <div class="well cu-log">
            <h2><?php echo $text_new_customer; ?></h2>
            <p class="reg-cap"><strong><?php echo $text_register; ?></strong></p>
            <p><?php echo $text_register_account; ?></p>
     
      <a href="<?php echo $register; ?>" class="btn btn-primary reg-button"><?php echo $button_continue; ?></a>
           <div class="clearfix"></div> 
      
      </div>
            
            
            <div class="social-login-section">
<a class="btn btn-block btn-social btn-facebook"  href="<?PHP echo $facebook; ?>" ><span class="fa fa-facebook"></span> Sign in with Facebook       </a>
<a class="btn btn-block btn-social btn-google" href="<?PHP echo $gmailsocial; ?>" ><span class="fa fa-google"></span> Sign in with Google</a>

  </div>
            
            
            
        </div>
        <div class="col-sm-6">
          <div class="well cu-log">
            <h2><?php echo $text_returning_customer; ?></h2>
            <p class="reg-cap"><strong><?php echo $text_i_am_returning_customer; ?></strong></p>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
              <div class="form-group">
               <!-- <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>-->
                <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
              </div>
              <div class="form-group">
               <!-- <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>-->
                <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
                
                <!-- 
	                <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
                 -->
                        </div>
                <a class="ac-for" data-toggle="modal" data-target="#myModal" style="cursor:pointer">Forgotten Password</a>
                
                 <input type="submit" value="<?php echo $button_login; ?>" class="btn btn-primary reg-button pull-right" />
              <?php if ($redirect) { ?>
              <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
              <?php } ?>
         
                
             
            </form>
             <div class="clearfix"></div> 
          </div>
        </div>
      </div>
      <?php echo $content_bottom; ?></div>
<!--
    <?php echo $column_right; ?>
    --></div>
</div>
<?php echo $footer; ?>

<div class="forgot-modal">
                <!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Forgot Password</h4>
      </div>
      <div class="modal-body">
     <div class="form-group">
               
                <input type="text" name="forget-password" id="forget-password-email" value="" placeholder="Enter Email ID"  class="form-control">
                <p class="for-error email_err"></p>
               </div>
             <p class="for-al forgot-pwd-msg"></p>   
            <input type="button" value="Submit" class="btn btn-primary reg-button forget-pwd-btn" style="float:right;">    
           <div class="clearfix"></div>      
      </div>
     <!-- <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>-->
   
    </div>
   

  </div>
</div>
</div>


<script language="javascript">

$(window).load(function()
{
	var iframeid = $('iframe').attr('id');
	
});


$(document).on('keypress',"#forget-password-email",function()
		{
				if ( event.which == 13 ) 
				{
					$(".forget-pwd-btn").trigger('click');
				}
				
			});
	$(document).ready(function()
	{
		
		
		
		
		$(document).on('focus',"#forget-password-email",function()
		{
			$(".email_err").html('');
		});
		
		
		//	$( "#target" ).keypress(function( event ) 
		
		
		$(document).on('click',".forget-pwd-btn",function()
		{
			var forgetpasswordemail = $("#forget-password-email").val();
				forgetpasswordemail = $.trim(forgetpasswordemail);
			
			var OnClick = $(this);
			
			var err_cnt='0';
				
				if(forgetpasswordemail=='')
				{
					err_cnt='1';		
					$(".email_err").html('Enter Email Id');
				}
				else
				{
					var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
					if (filter.test(forgetpasswordemail)) 
					{
						$.ajax({
									url:'index.php?route=requestdispatcher/requestdispatcher/resetcustomerpwd',
									type:'POST',
									data:{'forgetpasswordemail':forgetpasswordemail},
									beforeSend:function(){ OnClick.val('Loading ........').css({'color':'#fff'}); OnClick.attr('disabled',true); },
									success:function(resp)
									{
										OnClick.val('Password Sent'); 
										OnClick.attr('disabled',false); 
										
										//setTimeout(function(){ OnClick.val('Submit').css({'background-color':'#f00'}); $(".forgot-pwd-msg").html('');  }, 5000);
										
										
										resp = $.trim(resp);
										if(resp=='0')
										{
											$(".email_err").html('');
											$(".forgot-pwd-msg").html("<span class='alert alert-danger'>Mail Id does not registered with us</span>")
										}
										else if(resp=='-1')
										{
											$(".email_err").html('');
											$(".forgot-pwd-msg").html("<span class='alert alert-warning'>Unable to reset your password, kindly raise a ticket</span>");
										}
										else if(resp=="1")
										{
											$(".forgot-pwd-msg").html("<span class='alert alert-success'>Password reset successfully kindly check your inbox </span>");
											$("#forget-password-email").val('');
											
										}
									}
									
							
								});
					}
					else 
					{
						err_cnt='1';		
						$(".email_err").html('Enter correct email format');
					}
				}
			
		});
	});

</script>