<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
      
      <?PHP
      if($filter!='')
      {
      ?>
      <div class="clear-sales-filter" style="display:inline-block; margin-left:200px">
      <span><?PHP echo $filter; ?></span><i class="fa fa-times"></i>
      
      </div>
      <?PHP
      }?>
    </div>
  </div>
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title" style="line-height: 32px;"><i class="fa fa-bar-chart"></i> <?php echo $text_list; ?></h3>
        
        
        <div class="pull-right"  style="margin-left:20px"> <input type="button"  class="btn btn-success salesreportDownload" value="Excel Download " />  </div>
        
        <div class="pull-right" ><form action="index.php?route=report/sale_orders&token=<?PHP echo $token; ?>" method="POST">  <input type="hidden" name="selected_range_dates" id="selected-range-dates" /> <input type="submit" name="getReport" class="btn btn-primary" id="getReport" value="Get Report" />  </div>
        
        
        
        <div class="col-md-4 pull-right">
        
         <div id="reportrange" class="pull-right " style="background: #fff; cursor: pointer; padding: 8px 10px; border: 1px solid #ccc; width: 100%">
    <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
    <span id="sales-report-range" ></span> <b class="caret"></b>
    
</div>
        </div>
      <div class="clearfix"></div>  
        
        
      </div>
      <div class="panel-body">
        
        <div class="row show-limit" >
        
        <div class="pull-left col-md-3 ">
        <label style="display:inline-block">Show</label>
        <select name="limit" id="limit">
        
        <option value="10" <?PHP if($limit=='10'){ echo 'selected'; }?>>10</option>
        <option value="20" <?PHP if($limit=='20'){ echo 'selected'; }?>>20</option>
        <option value="30" <?PHP if($limit=='30'){ echo 'selected'; }?>>30</option>
        
        
        </select>
        
        </div>
        
        <div class="pull-right report-filter"> 
        <label for="categ-filter">Category</label>
        <input type="radio" id="categ-filter" class="SalesCategory" name="filter" value="category" <?PHP if( $filter=='category'){ echo 'checked';} ?> /> 
        
        <label for="prdct-filter">Product</label>
        <input type="radio" id="prdct-filter" class="SalesCategory" name="filter" value="product"  <?PHP if( $filter=='product'){ echo 'checked';} ?>  />
        </form>
        </div>
        
        <div class="clearfix"></div>
        
        
        </div>
          
        <div class="table-responsive">
          
          <?PHP
          	if($filter=='')
            {
          ?>
          
          <table class="table table-bordered">
            <thead>
              <tr>
              
                <td class="text-left"><?php echo $column_Orderedon; ?></td>
                
                <td class="text-right"><?php echo $column_orders; ?></td>
                
                <td class="text-right"><?php echo $column_products; ?></td>
                <td class="text-right"><?php echo $column_tax; ?></td>
                <td class="text-right"><?php echo $column_total; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ($OrdersData) { ?>
              <?php foreach ($OrdersData as $order) { ?>
              <tr>
                <td class="text-left"><?php echo $order['OrderedOn']; ?></td>
                <td class="text-left"><?php echo $order['TotalOrders']; ?></td>
                <td class="text-right"><?php echo $order['TotalProducts']; ?></td>

                <td class="text-right"><?php echo $order['TotalTAX']; ?></td>
                <td class="text-right"><?php echo $order['TotalSale']; ?></td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
          <?PHP
          }
          else if($filter=='category')
          {
          
          	?>
            <table class="table table-bordered">
            <thead>
              <tr>
             
             <td class="text-left"><?php echo $column_Orderedon; ?></td>
                <td class="text-left"><?php echo $entry_category; ?></td>
                
                <td class="text-right"><?php echo $column_orders; ?></td>
               <td class="text-right"><?php echo $column_quanities; ?></td>
                <td class="text-right"><?php echo $column_tax; ?></td>
                <td class="text-right"><?php echo $column_total; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ( sizeof($OrdersData) > 0)
              {
                foreach( $OrdersData as $orders)
                {
                	?>
                    <tr>
                    	<td><?PHP echo $orders['OrderedOn']?></td>
                        <td><?PHP echo $orders['Category']?></td>
                        
                         <td><?PHP echo $orders['TotalOrders']?></td>
                         <td><?PHP echo $orders['TotalProducts']?></td>
                          <td><?PHP echo $orders['Tax']?></td>
                           <td><?PHP echo $orders['Total']?></td>
                    
                    </tr>
                    <?PHP
                }
              } 
              else { ?>
              <tr>
                <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
            <?PHP
          
          }
          else if($filter=='product')
          {
          	?>
            <table class="table table-bordered">
            <thead>
              <tr>
             <td>SLNO</td>
                <td class="text-left"><?php echo $entry_product; ?></td>
                <td class="text-left"><?php echo $column_Orderedon; ?></td>
                <td class="text-right"><?php echo $column_orders; ?></td>
                <td class="text-right"><?php echo $column_quanities; ?></td>
                <td class="text-right"><?php echo $column_tax; ?></td>
                <td class="text-right"><?php echo $column_total; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ( sizeof($OrdersData) >0)
              {
                foreach( $OrdersData as $prd=>$orders)
                {
	                $slno = $prd+1;
                    $SLNO = $Page+$slno;
                ?>
                    <tr>
                    
                    <td><?PHP echo $SLNO;?></td>
                     <td><?PHP echo $orders['Product'];?></td>
                    <td><?PHP echo $orders['OrderedOn'];?></td>
                    <td><?PHP echo $orders['TotalOrders'];?></td>
                    <td><?PHP echo $orders['TotalProducts'];?></td>
                    <td><?PHP echo $Currency.$orders['Tax'];?></td>
                    <td><?PHP echo $Currency.$orders['Total'];?></td>
                  
                    </tr>
                
                
                <?PHP
                }
              } 
              else { ?>
              <tr>
                <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
            <?PHP
          }
          
          ?>
        </div>
        <div class="row">
         <ul class="pagination">
         <!-- pagination section -->
         <?PHP echo $Pagination; ?>
         </ul>
         
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=report/sale_order&token=<?php echo $token; ?>';
	
	var filter_date_start = $('input[name=\'filter_date_start\']').val();
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').val();
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}
		
	var filter_group = $('select[name=\'filter_group\']').val();
	
	if (filter_group) {
		url += '&filter_group=' + encodeURIComponent(filter_group);
	}
	
	var filter_order_status_id = $('select[name=\'filter_order_status_id\']').val();
	
	if (filter_order_status_id != 0) {
		url += '&filter_order_status_id=' + encodeURIComponent(filter_order_status_id);
	}	

	location = url;
});
//--></script> 
  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script></div>
<?php echo $footer; ?>