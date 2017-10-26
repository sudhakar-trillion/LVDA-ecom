<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
   <div class="container-fluid">
    <!--  <div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $text_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
        
        
        
        <button type="button" data-toggle="tooltip"  class="btn btn-danger" ><i class="fa fa-trash-o"></i></button>
      </div>-->
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div
  ></div>
  <div class="container-fluid" style="min-height:500px">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default" style="position:relative">
    
      <div style="position:absolute; top:2px; z-index:99999999999; right:12px; width:400px ">
         <form method="post" action="<?PHP  echo $selfpage?>" autocomplete="off">   
            <div style="float:left; width:300px; margin-right:30px">
            <?PHP
            if($ParentProductName!='')
            {
            	?>
                <span class="clearparent_prd "> <i style="top:-10px; font-size:16px; padding:10px; margin-left:10px; cursor:pointer; color:#F00;  border-radius:100%; width:10px; right:105px; position:absolute" class="fa fa-remove"></i></span>
                <?PHP
            }
            ?>
            
            
            <input type="text" placeholder="<?php echo $product_placeholder; ?>" id="cross-sale-parent-prd" name="ParentProductName" class="form-control cross-sale-parent-prd" value='<?PHP echo $ParentProductName?>' />
                <input type="hidden" id="cross-sale-parent-prd-selected" name="ParentProduct"  />
                <div id="product-list" class="well well-sm" style="height: 150px; overflow: auto; display:none">
                
                </div>
            </div>
             <input type="submit" class="btn btn-primary" name="searchcrosssalePrdcts" value="Search" />
            
               </form> 
                
               
                <div class="clearfix"></div>        
        </div>
    
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
                

                 
                 
              </div>
      <div class="panel-body">
        
        <?PHP
        	if($getCrosssaleList=='0')
            {
            
            }
            else
            {
            ?>
            <table class="table table-bordered">
    <thead>
      <tr>
        <th><?PHP echo $rowheading_SLNO?></th>
        <th><?PHP echo $rowheading_ParentProduct?></th>
        
        <th><?PHP echo $rowheading_CrossSaleProduct?></th>
        <th><?PHP echo $rowheading_CrossSalePrice?></th>
        
        <th><?PHP echo $rowheading_ProductPrice?></th>
        <th><?PHP echo $rowheading_Actions?></th>
        
      </tr>
    </thead>
            <?PHP
            	foreach( $getCrosssaleList as $key=>$val)
                {
                	?>
                    <tr>
                    	<td><?PHP echo $key+1;?></td>
                        <td><?PHP echo $val['parent']?></td>
                         <td><?PHP echo $val['name']?></td>
                         
                          <td><?PHP echo $val['SalePrice']?></td>
                           <td><?PHP echo $val['ProductActualPrice']?></td>
                           
                            <td><a class="btn btn-primary" href="<?PHP echo $editcrosssale?>&CrossSaleId=<?PHP echo $val['CrossSaleId']?>">EDIT</a></td>
                    
                    
                    </tr>
                   <?PHP
                }
            }
        ?>
        </table>
        
        </div>        
        
       </div>
       </div>
       

  
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	var url = 'index.php?route=catalog/product&token=<?php echo $token; ?>';

	var filter_name = $('input[name=\'filter_name\']').val();

	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_model = $('input[name=\'filter_model\']').val();

	if (filter_model) {
		url += '&filter_model=' + encodeURIComponent(filter_model);
	}

	var filter_price = $('input[name=\'filter_price\']').val();

	if (filter_price) {
		url += '&filter_price=' + encodeURIComponent(filter_price);
	}

	var filter_quantity = $('input[name=\'filter_quantity\']').val();

	if (filter_quantity) {
		url += '&filter_quantity=' + encodeURIComponent(filter_quantity);
	}

	var filter_status = $('select[name=\'filter_status\']').val();

	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}

	location = url;
});
//--></script>
  <script type="text/javascript"><!--
$('input[name=\'filter_name\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'filter_name\']').val(item['label']);
	}
});

$('input[name=\'filter_model\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_model=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['model'],
						value: item['product_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'filter_model\']').val(item['label']);
	}
});
//--></script>



<?php echo $footer; ?>

<script>
	$(document).ready(function()
	{
		$("#cross-sale-parent-prd").blur(function()
		{
			var val = $(this).val();
				val = $.trim(val);
				
				if(val=="")
					$("#cross-sale-parent-prd-selected").val('');
				
		});
		
		$(".clearparent_prd").on('click',function()
		{
			if( confirm('Do you want to clear') )
			{
				$.ajax({
							url:'index.php?route=requestdispatcher/requestdispatcher/clearparentprd/&token=<?php echo $token; ?>',
							success:function(resp)
							{
								resp=$.trim(resp);
								if(resp==='1')
								{
										console.log(document.location);
										window.location.href=document.location;
								}
								//	window.location.reload(window.location.href);// = "index.php?route=route=catalog/product_viewcrosssale&token=<?php echo $token; ?>";
							}
							
				});//ajax ends here
			}
		});
		
	});
</script>