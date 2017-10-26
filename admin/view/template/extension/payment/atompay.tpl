<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
	<button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
	<a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-default" data-toggle="tooltip"><?php echo $button_cancel; ?></a>
	<!--<div class="buttons" data-toggle="tooltip"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>-->
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
	<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
	<?php } ?>
      </ul>
    </div>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  
    <div class="container-fluid">
      <div class="panel panel-default">
	<div class="panel-body">
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	    <div class="form-group required">
	      <label class="col-sm-2 control-label" for="atompay_url"><?php echo $entry_url; ?></label>
	      <div class="col-sm-10">
		<input type="text" name="atompay_url" value="<?php echo $atompay_url; ?>" placeholder="<?php echo $atompay_url; ?>" id="atompay_url" class="form-control" />            
		<?php if ($error_url) { ?>
		<span class="error"><?php echo $error_url; ?></span>
		<?php } ?>
	      </div>
	    </div>
	    
	    <div class="form-group required">
	      <label class="col-sm-2 control-label" for="atompay_vendor"><?php echo $entry_vendor; ?></label>
	      <div class="col-sm-10">
		<input type="text" name="atompay_vendor" value="<?php echo $atompay_vendor; ?>" placeholder="<?php echo $atompay_vendor; ?>" id="atompay_vendor" class="form-control" />              
		<?php if ($error_vendor) { ?>
		<span class="error"><?php echo $error_vendor; ?></span>
		<?php } ?>
	      </div>
	    </div>
	    
	    <div class="form-group required">
	      <label class="col-sm-2 control-label" for="atompay_password"><?php echo $entry_password; ?></label>
	      <div class="col-sm-10">
		<input type="text" name="atompay_password" value="<?php echo $atompay_password; ?>" placeholder="<?php echo $atompay_password; ?>" id="atompay_password" class="form-control" />              
		<?php if ($error_password) { ?>
		<span class="error"><?php echo $error_password; ?></span>
		<?php } ?>
	      </div>
	    </div>
	    
	    <div class="form-group required">
	      <label class="col-sm-2 control-label" for="atompay_prodid"><?php echo $entry_prodid; ?></label>
	      <div class="col-sm-10">
		<input type="text" name="atompay_prodid" value="<?php echo $atompay_prodid; ?>" placeholder="<?php echo $atompay_prodid; ?>" id="atompay_prodid" class="form-control" />              
		<?php if ($error_prodid) { ?>
		<span class="error"><?php echo $error_prodid; ?></span>
		<?php } ?>
	      </div>
	    </div>
	       
	    <div class="form-group">
	      <label class="col-sm-2 control-label" for="atompay_order_status_id"><?php echo $entry_order_status; ?></label>
	      <div class="col-sm-10">
		<select name="atompay_order_status_id" id="atompay_order_status_id" class="form-control">
		  <?php foreach ($order_statuses as $order_status) { ?>
		  <?php if ($order_status['order_status_id'] == $atompay_order_status_id) { ?>
		  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
		  <?php } else { ?>
		  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
		  <?php } ?>
		  <?php } ?>
		</select>
	      </div>
	    </div>
  
	    <div class="form-group">
	      <label class="col-sm-2 control-label" for="atompay_status"><?php echo $entry_status; ?></label>
	      <div class="col-sm-10">
		<select name="atompay_status" id="atompay_status" class="form-control">
		  <?php if ($atompay_status) { ?>
		  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
		  <option value="0"><?php echo $text_disabled; ?></option>
		  <?php } else { ?>
		  <option value="1"><?php echo $text_enabled; ?></option>
		  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
		  <?php } ?>
		</select>
	      </div>
	    </div>
	    
        
        <!--Skyline-->
        <div class="form-group required">
	      <label class="col-sm-2 control-label" for="atompay_port"><?php echo $entry_port; ?></label>
	      <div class="col-sm-10">
		<input type="text" name="atompay_port" value="<?php echo $atompay_port; ?>" placeholder="<?php echo $atompay_port; ?>" id="atompay_port" class="form-control" />              
		<?php if ($error_port) { ?>
		<span class="error"><?php echo $error_port; ?></span>
		<?php } ?>
	      </div>
	    </div>
        
        <div class="form-group required">
        <label class="col-sm-2 control-label" for="atompay_sslver"><?php echo $entry_sslver; ?></label>
        <div class="col-sm-10">
        <input type="text" name="atompay_sslver" value="<?php echo $atompay_sslver; ?>" placeholder="<?php echo $atompay_sslver; ?>" id="atompay_sslver" class="form-control" />              
        <?php if ($error_port) { ?>
        <span class="error"><?php echo $error_port; ?></span>
        <?php } ?>
        </div>
        </div>
        <!--end skyline-->
	  </form>
	</div>
      </div>
    </div>
</div>
<?php echo $footer; ?>