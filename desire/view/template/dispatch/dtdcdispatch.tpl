<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['report/href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-bar-chart"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <div class="well">
          <div class="row courier">
            <div class="col-sm-6">
              
              <div class="form-group col-md-6">
                <label class="control-label" for="input-date-end"><?php echo $element_orderId; ?></label>
                <div class="input-group date">
                  <input type="text" name=""  placeholder="<?php echo $placeholder_orderId; ?>" id="search-box" class="form-control orderide" />
                  <span class="orderid-err"></span>
                  <div id="suggesstion-box"></div>
                  </div>
              </div>
              
              
              <div class="form-group col-md-6">
                <label class="control-label" for="input-date-end"><?php echo $element_courierid; ?></label>
                <div class="input-group date">
                  <input type="text" name=""  placeholder="<?php echo $placeholder_courierid; ?>" class="form-control courierid" maxlength="11" />
                  <span class="courierid-err"></span>
                  </div>
              </div>
              
            </div>
            <div class="col-sm-6">
              
              <div class="form-group" style="margin-top:22px">
              
                <input type="button" class="btn btn-primary assigntracknumber" id='' couriername='DTDC' value="<?PHP echo $element_assign; ?>" />
                <span class="ml-30 assign-msg"></span>
              </div>

            </div>
          </div>
        </div>
        
        
        
      </div>
    </div>
  </div>

  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script></div>
<?php echo $footer; ?>