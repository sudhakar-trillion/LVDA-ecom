
<div class="clearfix"></div>
<footer id="footer" class="poweredby">
	<!--<?php echo $text_footer; ?>-->
     Powered by <a href="http://www.shopalzo.com/" target="_blank"><img src="view/image/ShopAlzo-logo.png" /></a>
 <!--   <?php echo $text_version; ?> -->
</footer>

</div>

<!--<script type="text/javascript" src="view/JQuery-Custom-Date-Picker/jquery.min.js"></script>-->
<script type="text/javascript" src="view/JQuery-Custom-Date-Picker/moment.min.js"></script>

<script type="text/javascript" src="view/JQuery-Custom-Date-Picker/daterangepicker.js"></script>

<script type="text/javascript">

///get the total uses and the users which are online

$(document).ready(function()
{
	$.ajax({
				url:'index.php?route=requestdispatcher/requestdispatcher/userstats/&token=<?php echo $token; ?>',
				async:false,
				success:function(resp)
				{
					resp = $.trim(resp);
					resp = JSON.parse(resp);
					console.log(resp);
					$.each(resp,function(ind,val)
						{
								if(ind=='TotalCustomers')
									$(".TotalCustomers").html(val+" Customers");
								else if(ind=='TotalCustomersOnline')
								{
									var num = parseInt(val);
									if(num>0)
										$(".TotalCustomersOnline").html(val+" Customers");
									else
										$(".TotalCustomersOnline").html("No Customers");
								}
						});	
				}
			});
});


var salesandorderstats='';
var saleasandorder_range='';

$(function() {
	

    var start = moment().subtract(29, 'days');
    var end = moment();


    function cb(start, end) {
		console.log(start+" "+end);
		console.log( typeof(start)+" "+typeof(start) );
        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
		
		$("#selected-range-dates").val($("#sales-report-range").html() );	
    }

    $('#reportrange').daterangepicker({
        startDate: start,
        endDate: end,
        ranges: {
           'Today': [moment(), moment()],
           'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           'This Month': [moment().startOf('month'), moment().endOf('month')],
		 
           'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
	      'Last Three Months': [moment().subtract(1, 'month').startOf('month'), moment().subtract(4, 'month').endOf('month')]
        }
    }, cb);
	
	
	$.ajax({
			url:'index.php?route=requestdispatcher/requestdispatcher/checkdaterange/&token=<?php echo $token; ?>',
			async:false,
			success:function(resp)
			{
				resp = $.trim(resp);
				
				resp = resp.split("-");
				//console.log(resp[0]+" "+resp[1]);
				start = resp[0];
				end = resp[1];
				
				start = moment(start);
				end = moment(end);
				
				var chkPge = "<?PHP echo $CurentFile?>";
				
				if( chkPge == "common/dashboard" )
				{
					var daterange = resp[0]+"-"+resp[1];
					getsalesandorderstats(daterange);
					
				}
				
				
			}
		});
	

		
    cb(start, end);
    
});


$(document).on('click','.salesorderstatsGo',function()
{
	var daterange = $("#sales-report-range").html();
	getsalesandorderstats(daterange);

});


$(document).on('click','#sales-report-range',function()
{
	setTimeout(
					function()
							{ 
								$(".ranges ul li:first-child").show(); 
								$(".ranges ul li:nth-child(2)").show(); 
								$(".ranges ul li:last-child").show(); 
							}
				, 10);
});

$(function() {
	

    var start = moment().subtract(29, 'days');
    var end = moment();


    function cb(start, end) {
		
		console.log(start+" "+end);
		console.log( typeof(start)+" "+typeof(start) );
        $('#sales-reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
		
		$("#selected-range-dates").val($("#sales-report-range").html() );	
    }

    $('#sales-reportrange').daterangepicker({
        startDate: start,
        endDate: end,
        ranges: {
           'Today': [moment(), moment()],
           'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           'This Month': [moment().startOf('month'), moment().endOf('month')],
		 
           'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
	    //  'Last Three Months': [moment().subtract(1, 'month').startOf('month'), moment().subtract(4, 'month').endOf('month')]
        }
    }, cb);
	
	
	$.ajax({
			url:'index.php?route=requestdispatcher/requestdispatcher/checkdaterange/&token=<?php echo $token; ?>',
			async:false,
			success:function(resp)
			{
				resp = $.trim(resp);
				resp = resp.split("-");
				//console.log(resp[0]+" "+resp[1]);
				start = resp[0];
				end = resp[1];
				
				start = moment(start);
				end = moment(end);
				
				
			}
		});
	

		
    cb(start, end);
    
});

</script>


<script>
$(document).on('click','.salesreportrange',function()
{
	
	setTimeout(
				function()
							{ 
								$(".ranges ul li:first-child").hide(); 
								$(".ranges ul li:nth-child(2)").hide(); 
								$(".ranges ul li:last-child").hide(); 
								
							}
				, 80);

	
	
});

$(window).on('load',function()
{
	$(".ranges").find('li').addClass('dateranges');
	$("#selected-range-dates").val($("#sales-report-range").html() );	
});


$(document).on('click','.dateranges',function()
{
	$("#selected-range-dates").val($("#sales-report-range").html() );	
});

$(document).on('change','#limit, .SalesCategory',function()
{
	$("#getReport").trigger('click');
});


$(document).on('click','.clear-sales-filter i',function()
{
	
		var filter = $(".clear-sales-filter span").html();
			filter = $.trim(filter);
			
			
		$.ajax({
				url:'index.php?route=requestdispatcher/requestdispatcher/removefilter/&token=<?php echo $token; ?>',
				async:false,
				data:{'filter':filter},
				type:'POST',
				success:function(resp)
				{
					location.href="index.php?route=report/sale_orders&token=<?PHP echo $token;?>";	
				}
			
			});
	
});

</script>
	

<script>


    $(document).ready(function()
    {
		

		
		
		$(".salesreportDownload").on('click',function()
		{
			var daterange = $("#sales-report-range").html();
			var limit = $("#limit").val();
			var category_filter ='';
			
			if( $('input:radio:checked').length ==1 )
			{
				category_filter = $('input:radio:checked').val();	
			}
			
			$.ajax({
						url:'index.php?route=requestdispatcher/requestdispatcher/salesreportexcel/&token=<?php echo $token; ?>',
						async:false,
						data:{'daterange':daterange,"limit":limit,"category_filter":category_filter},
						type:'POST',
						success:function(resp)
						{
							if(resp!='0')
							{
								//return false;
								location.href='http://192.168.0.5/pav-vigoss/'+resp;
								
								
								setTimeout(
								$.ajax({
								url:'index.php?route=requestdispatcher/requestdispatcher/deleteexcelsheet/&token=<?php echo $token; ?>',
								type:'POST',
								data:{"excelname":resp},
								}).success(function() { 	})
								,3000);	
								
							}
							
						}
				});
				
		});
		    	
		
		$("#cross-sale-parent-prd").on('keyup',function()
		{
			var prdwildcard = $(this).val();
			
			prdwildcard = $.trim(prdwildcard);
			
			if(prdwildcard!='')
			{
			$.ajax({
					
						url:'index.php?route=requestdispatcher/requestdispatcher/getProducts/&token=<?php echo $token; ?>',
								type:'POST',
								data:{"prdwildcard":prdwildcard},
								success:function(resp)
								{
									resp = $.trim(resp);
									if(resp!='0')
									{
										$("#product-list").css({'display':'block','color':'#000'});	
										$("#product-list").html(resp);
									}
									else
									{
										$("#product-list").html('');
										$("#product-list").css({'display':'none'});	
											
									}
									
									
								}
								
				});//ajax ends here
			}
		});//keyup ends here
		

    });

$(document).on('click','#product-list .cross-sale-parent-prd',function()
{

	var ide = $(this).attr('id');
	var prdname = $(this).html();

	var prdide= ide.split('-');

	$(".cross-sale-parent-prd").val(prdname);
	$("#product-list").html('');
	$("#product-list").css({'display':'none'});	
	$("#cross-sale-parent-prd-selected").val(prdide[1]);
	
});

$(document).on('click','.crosssale_addmore',function()
{
	var len = $(".cross-sale-prd-section").length;
	
	var chkparentSel = $(".cross-sale-parent-prd").val();
		chkparentSel = $.trim(chkparentSel);
	
	var err_cnt='0';
		
	if( chkparentSel == '' )
	{
		$(".cross-sale-parent-prd-error").addClass('text-danger');
		$(".cross-sale-parent-prd-error").html('Select Product');	
		err_cnt = '1';
	}
	else
	{
		$(".cross-sale-parent-prd-error").removeClass('text-danger');
		$(".cross-sale-parent-prd-error").html('');	
	}
	
	$(".cross-sale-prd").each(function()
	{
		if( $.trim($(this).val())=='' )
		{
			err_cnt = '1';
			var nxt = $(this).next();
			
			nxt.addClass('text-danger');
			$(this).next().html('Select Product');
		}
		else
		{
			$(this).next().removeClass('text-danger');
			$(this).next().html('');
		}
	});
	
	
	$(".cross-sale-prd-price").each(function()
	{
		
		if( $.trim($(this).val())=='' )
		{
			err_cnt = '1';
			$(this).next().addClass('text-danger');
			$(this).next().html('Enter Sale Price');
		}
		else
		{
			$(this).next().removeClass('text-danger');
			$(this).next().html('');
		}
		
	});
	
	
		
	if( err_cnt == '0' )
	{
		var div = '<div class="cross-sale-prd-section col-md-12 sale-prd-section" id="crosssale_remove'+len+'"><div class="col-md-2 remlp"> <label class="col-sm-12 control-label" for="input-category"><span data-toggle="tooltip" title="Auto Suggest">Cross Sale Product</span></label>  </div> <div class="col-md-3 "> <input type="text"  value="" placeholder="Enter Cross Sale Product" class="form-control cross-sale-prd" /><span></span> <input type="hidden"  class="cross-sale-prd-selected"   />  <div class="cross-sale-product-list well well-sm" style="height: 150px; overflow: auto; display:none"> </div> </div><div class="col-md-2 remlp"><input type="text" value="" placeholder="Actual Price" class="form-control ActualPrice" readonly="readonly"/></div>  <div class="col-md-2 remlp"> <input type="text"  value="" placeholder="Enter Price"  class="form-control cross-sale-prd-price" />  </div> <div class="col-md-3 remlp pull-right"> <input type="button" class="btn  btn-danger crosssale_remove" value="Remove"  /> </div> <div class="clearfix"></div></div>';
	
$(".cross-sale-prd-section:last").after(div);
	}

});



//this section of code is for cross sale product list autocomplete

$(document).on('keyup',".cross-sale-prd",function()
{
	
	var Par = $(this).parent().parent().attr('id');
	
	console.log(Par);
			var prdwildcard = $(this).val();
			
			prdwildcard = $.trim(prdwildcard);
			
			if(prdwildcard!='')
			{
			$.ajax({
					
								url:'index.php?route=requestdispatcher/requestdispatcher/getProducts/&token=<?php echo $token; ?>',
								type:'POST',
								data:{"prdwildcard":prdwildcard},
								success:function(resp)
								{
									resp = $.trim(resp);
									if(resp!='0')
									{
										$("#"+Par+" .cross-sale-product-list").removeClass('text-danger');
										$("#"+Par+" .cross-sale-product-list").css({'display':'block'});	
										$("#"+Par+" .cross-sale-product-list").html(resp);
									}
									else
									{
										$("#"+Par+" .cross-sale-product-list").html('');
										$("#"+Par+" .cross-sale-product-list").css({'display':'none'});	
											
									}
									
									
								}//sucess ends here
								
				});//ajax ends here
			}
		
	
	
});

$(document).on('click','.cross-sale-product-list .cross-sale-parent-prd',function()
{
	var par = $(this).parent().parent().parent().attr('id');
	var ActualPrice = $(this).attr('price');
	
	var prdname = $(this).html();

	var ide = $(this).attr('id');
	var prdide= ide.split('-');
	

	$("#"+par+" .ActualPrice").attr('placeholder','Actual Price: '+ActualPrice);
	$("#"+par+" .ActualPrice").val(ActualPrice);
	
	$("#"+par+" .cross-sale-prd").val(prdname);
	
	$("#"+par+" .cross-sale-product-list").html('');
	$("#"+par+" .cross-sale-product-list").css({'display':'none'});	
	$("#"+par+" .cross-sale-prd-selected").val(prdide[1]);

});

$(document).on('click','.crosssale_remove',function()
{
	var par = $(this).parent().parent().attr('id');
	
	if( confirm("Do you want to remove this product form cross sale") )
	{
		$("#"+par).remove();	
	}
});




// submit-cross-sale starts here

$(document).on('click','.submit-cross-sale',function()
{
	var crosssaleparentprd = $(".cross-sale-parent-prd").val();
		crosssaleparentprd = $.trim(crosssaleparentprd);
		
	var err_cnt='0';
		if(crosssaleparentprd=='')
		{
			err_cnt='1';
			
			$(".cross-sale-parent-prd-error").addClass('text-danger');
			$(".cross-sale-parent-prd-error").html("Select product");
		}
		else
		{
			$(".cross-sale-parent-prd-error").removeClass('text-danger');
			$(".cross-sale-parent-prd-error").html("");
		}
		
		$(".cross-sale-prd").each(function()
	{
		if( $.trim($(this).val())=='' )
		{
			err_cnt = '1';
			var nxt = $(this).next();
			
			nxt.addClass('text-danger');
			$(this).next().html('Select Product');
		}
		else
		{
			$(this).next().removeClass('text-danger');
			$(this).next().html('');
		}
	});
	
	
	$(".cross-sale-prd-price").each(function()
	{
		
		if( $.trim($(this).val())=='' )
		{
			err_cnt = '1';
			$(this).next().addClass('text-danger');
			$(this).next().html('Enter Sale Price');
		}
		else
		{
			$(this).next().removeClass('text-danger');
			$(this).next().html('');
		}
		
	});
		
		
		if( err_cnt=='0')
		{
			
			var CrossSaleProducts=[];
			
			$(".cross-sale-prd-selected").each(function(index,val) 
			{ 
				var newarr = {'CrossSaleProduct':$(this).val()};
				CrossSaleProducts.push(newarr);
			});
			
			var CrossSaleProductPrices=[];
			
			$(".cross-sale-prd-price").each(function(index,val) 
			{ 
				var newarr = {'CrossSaleProductPrice':$(this).val()};
				CrossSaleProductPrices.push(newarr);
			});
		
			var CrossSaleParent = $("#cross-sale-parent-prd-selected").val();
	
			var ProductActualPrice = [];
			
			$(".ActualPrice").each(function()
			{
				console.log($(this).val());
				
				var newarr = {'ProductPrice':$(this).val()};
				ProductActualPrice.push(newarr);
			});
		
			
	
			$.ajax({
						url:'index.php?route=requestdispatcher/requestdispatcher/setcross_sale/&token=<?php echo $token; ?>',
						type:'POST',
						data:{"CrossSaleParent":CrossSaleParent,"CrossSaleProducts":CrossSaleProducts,"CrossSaleProductPrices":CrossSaleProductPrices,"ProductActualPrice":ProductActualPrice},
						success:function(resp)
						{
							
							resp = $.trim(resp);
							if(resp=="1")
							{
								$(".crosssale_msg").html("<p class='alert alert-success'>Cross sale products added successfully</p>");
								$("form#crosssale_form")[0].reset();
								
								var len = $(".sale-prd-section").length;
								
								$(".sale-prd-section").each(function(ind,val)
								{
										if(ind!='0')
										$(this).remove();
										else
										{
											$("#ActualProducPrice").removeAttr('readonly');
											$("#ActualProducPrice").val('');
											$("#ActualProducPrice").attr('placeholder','Actual Price:');
											
											//oc_crossSale_products
										}
								});

							}
							else
								$(".crosssale_msg").html("<p class='alert alert-danger'>Unable to insert cross sale products</p>");
							
						}//success ends here
								
				
				
					});//ajax ends here		
					

		}

	
});

//submit-cross-sale ends here

// update cross sale products starts here
	
	
$(document).on('click','.update-cross-sale',function()
{
var crosssaleparentprd = $(".cross-sale-parent-prd").val();
		crosssaleparentprd = $.trim(crosssaleparentprd);
		
	var err_cnt='0';
		if(crosssaleparentprd=='')
		{
			err_cnt='1';
			
			$(".cross-sale-parent-prd-error").addClass('text-danger');
			$(".cross-sale-parent-prd-error").html("Select product");
		}
		else
		{
			$(".cross-sale-parent-prd-error").removeClass('text-danger');
			$(".cross-sale-parent-prd-error").html("");
		}
		
		$(".cross-sale-prd").each(function()
	{
		if( $.trim($(this).val())=='' )
		{
			err_cnt = '1';
			var nxt = $(this).next();
			
			nxt.addClass('text-danger');
			$(this).next().html('Select Product');
		}
		else
		{
			$(this).next().removeClass('text-danger');
			$(this).next().html('');
		}
	});
	
	
	$(".cross-sale-prd-price").each(function()
	{
		
		if( $.trim($(this).val())=='' )
		{
			err_cnt = '1';
			$(this).next().addClass('text-danger');
			$(this).next().html('Enter Sale Price');
		}
		else
		{
			$(this).next().removeClass('text-danger');
			$(this).next().html('');
		}
		
	});
		
		
		if( err_cnt=='0')
		{
			
			var CrossSaleProducts=[];
			
			$(".cross-sale-prd-selected").each(function(index,val) 
			{ 
				var newarr = {'CrossSaleProduct':$(this).val()};
				CrossSaleProducts.push(newarr);
			});
			
			var CrossSaleProductPrices=[];
			
			$(".cross-sale-prd-price").each(function(index,val) 
			{ 
				var newarr = {'CrossSaleProductPrice':$(this).val()};
				CrossSaleProductPrices.push(newarr);
			});
		
			var CrossSaleParent = $("#cross-sale-parent-prd-selected").val();
	
			var ProductActualPrice = [];
			
			$(".ActualPrice").each(function()
			{
				console.log($(this).val());
				
				var newarr = {'ProductPrice':$(this).val()};
				ProductActualPrice.push(newarr);
			});

		var Crosssaleid = $("#CrosssaleID").val();
			
			$updatedata = {"Crosssaleid":Crosssaleid,"CrossSaleParent":CrossSaleParent,"CrossSaleProducts":CrossSaleProducts,"CrossSaleProductPrices":CrossSaleProductPrices,"ProductActualPrice":ProductActualPrice};
			
			console.log($updatedata);
			
		//	return false;
			
			
	
			$.ajax({
						url:'index.php?route=requestdispatcher/requestdispatcher/updatecross_sale/&token=<?php echo $token; ?>',
						type:'POST',
						data:$updatedata,
						success:function(resp)
						{
							
							resp = $.trim(resp);
							if(resp=="1")
							{
								$(".crosssale_msg").html("<p class='alert alert-success'>Cross sale products added successfully</p>");
								
								var len = $(".sale-prd-section").length;
								
								$(".sale-prd-section").each(function(ind,val)
								{
										if(ind!='0')
										$(this).remove();
										
								});

							}
							else
								$(".crosssale_msg").html("<p class='alert alert-danger'>Unable to insert cross sale products</p>");
							
						}//success ends here
								
				
				
					});//ajax ends here		
					

		}
	
});

//update cross saleproducts ends here

$("#search-box").keyup(function(){
	var wildcard = $(this).val();
	
		$.ajax({
					type: "POST",
					url:'index.php?route=requestdispatcher/requestdispatcher/getshippeddorders/&token=<?php echo $token; ?>',
					data:{'keyword':wildcard},
					beforeSend: function(){
						$("#search-box").css("background","#FFF url(LoaderIcon.gif) no-repeat 165px");
					},
					success: function(data){
						$("#suggesstion-box").show();
						$("#suggesstion-box").html(data);
						$("#search-box").css("background","#FFF");
					} //success function ends here
			});//ajax ends here
	});

$(document).on('click','#orders-list li#found',function()
{
	var orderide = $(this).attr('class');
	$("#search-box").val(orderide);
	$("#suggesstion-box").html('');
	$("#suggesstion-box").hide();
	$(".courierid").focus();
	
});

$(document).on('click','.well,.footer,.notfound ',function()
{
	$("#suggesstion-box").html('');
	$("#suggesstion-box").hide();
	
});


$(document).on('click',".assigntracknumber",function()
{
	var Onclick = $(this);
	var Err_cnt='0';
	
	
	var couriername = $(this).attr('couriername');
		couriername = $.trim(couriername);
		
		
	var orderid = $("#search-box").val();
		orderid = $.trim(orderid);
		
		if(orderid=='')
		{
			Err_cnt='1';
			$("#search-box").addClass('err-border');
			$(".orderid-err").html('Provide order id').css({'color':'red'});;
		}
		else
		{
			$("#search-box").removeClass('err-border');
			$(".orderid-err").html('');
		}
	
	var courierid = $(".courierid").val();
		courierid = $.trim(courierid);
	
	if( courierid.length>8 && courierid.length<12)
	{
		
			$(".courierid-err").html('');	
			$(".courierid").removeClass('err-border');
	}
	else
		{
			Err_cnt='1';
			$(".courierid-err").html('Tracking number should be 9-11 digit').css({'color':'red'});	
			$(".courierid").addClass('err-border');
		}
	
	if(Err_cnt=='0')
	{
		$.ajax({
				
				url:'index.php?route=requestdispatcher/requestdispatcher/assignTrackingnumber/&token=<?php echo $token; ?>',
				type:"POST",
				data:{"couriername":couriername,"orderid":orderid,"courierid":courierid},
				beforeSend:function(){  Onclick.prop('disabled',true); },
				success:function(resp)
				{
					resp = $.trim(resp);
					
					if( resp == "0")
					{
						$(".assign-msg").addClass('alert alert-danger');
						$(".assign-msg").html("Please chekc the order id");
					}
					else if( resp == '-1' )
					{
						$(".assign-msg").addClass('alert alert-danger');
						$(".assign-msg").html("Invalid request");
					}
					else if( resp == '1' )
					{
						$(".assign-msg").addClass('alert alert-success');
						$(".assign-msg").html("Successfully assigned and sent mail to cusotmer");
						$("#search-box").val('');
						$(".courierid").val('');
						
					}
					else if( resp == '-2' )
					{
						$(".assign-msg").addClass('alert alert-warning');
						$(".assign-msg").html("Unable to find customer details");
						
					}
					else if( resp == '-3' )
					{
						$(".assign-msg").addClass('alert alert-warning');
						$(".assign-msg").html("Tracking number already assigned ");
						
					}
					else if( resp == '-4' )
					{
						$(".assign-msg").addClass('alert alert-warning');
						$(".assign-msg").html("Assigning failed, due to error in seding email ");
						
					}
					else if( resp == '-5' )
					{
						$(".assign-msg").addClass('alert alert-warning');
						$(".assign-msg").html("Failed to update Tracking number try again ");
						
					}
					 Onclick.prop('disabled',false);
				}//success function ends here
				
			});	//ajax ends here
	}
		
});

$(document).ready(function()
{
	
	
	$(".nav-brand-icon").on('click',function()
	{
		if( !$("#column-left").hasClass('active') )
		{
			$("a.navbar-brand").hide();	
			$(this).css({'position':'inherit','margin-top':'6px'});
			$(".navbar-header").css({'background':'none'});
			$("li#dashboard").css({"margin-top":'12px'});
		}
		else
		{
			$("a.navbar-brand").show();	
			$(this).css({'position':'absolute','margin-top':'0px'});
			$(".navbar-header").css({'background':'#FFF'});
			$("li#dashboard").css({"margin-top":'0px'});
		}
			
				
	});
	
});


</script>

<?PHP
if($CurentFile=="common/dashboard")
{
	?>
    <script src="view/javascript/highcharts/highcharts-nov-10-2017.js"></script>
    <script src="view/javascript/highcharts/highcharts-more-nov-10-2017.js"></script>
    <script src="view/javascript/highcharts/exporting-nov-10-2017.js"></script>
    <script src="view/javascript/highcharts/pareto-nov-10-2017.js"></script>
    
    <script>
	
	var orders = [];
	var sales = [];
	var start='';
	var end='';
	var categories=[];
	var TotalOrders = [];
	var TotalSales= [];
	
	

$(function() {
	

    var start = moment().subtract(29, 'days');
    var end = moment();


    function cb(start, end) {
		
		console.log(start+" "+end);
		console.log( typeof(start)+" "+typeof(start) );
        $('#sales-reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
		
		$("#selected-range-dates").val($("#sales-report-range").html() );	
    }

    $('#sales-reportrange').daterangepicker({
        startDate: start,
        endDate: end,
        ranges: {
           'Today': [moment(), moment()],
           'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           'This Month': [moment().startOf('month'), moment().endOf('month')],
		 
           'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
	    //  'Last Three Months': [moment().subtract(1, 'month').startOf('month'), moment().subtract(4, 'month').endOf('month')]
        }
    }, cb);
	
	
	$.ajax({
			url:'index.php?route=requestdispatcher/requestdispatcher/checkdaterangegraph/&token=<?php echo $token; ?>',
			async:false,
			success:function(resp)
			{
				resp = $.trim(resp);
				resp = resp.split("-");
				//console.log(resp[0]+" "+resp[1]);
				start = resp[0];
				end = resp[1];
				
				start = moment(start);
				end = moment(end);
				
				$.ajax({
							url:'index.php?route=requestdispatcher/requestdispatcher/getsalesandorder/&token=<?php echo $token; ?>',
							type:"POST",
							data:{'start':resp[0],"end":resp[1],'range':"false"},
							async:false,
							success:function(resp)
							{
								resp=$.trim(resp);
								resp = JSON.parse(resp);
								
								var days = resp.outputdays;
								var Orders = resp.TotalOrders;
								var Sales = resp.TotalSales;
								
								
								categories=[];
								$.each(days,function(ind,val)
								{ 
									categories.push(val);
								});
								
								TotalSales=[];
								TotalOrders = [];
								
								$.each(Orders,function(ind,val)
								{
									TotalOrders.push(parseInt(val));
								});
								
								$.each(Sales,function(ind,val)
								{
									TotalSales.push(parseFloat(val));
								});
								
								
							}
						}); console.log(categories+"type"+typeof(categories));
						
							Highcharts.chart('sales-order-analysis', 
							{
		
    chart: {
        zoomType: 'xy'
    },
    title: {
        text: ''
    },
    subtitle: {
        text: ''
    },
    xAxis: [{
        categories: categories,//['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        crosshair: true
    }],
    yAxis: [{ // Primary yAxis
        labels: {
            format: '',
            style: {
                color: Highcharts.getOptions().colors[1]
            }
        },
        title: {
            text: '',
            style: {
                color: Highcharts.getOptions().colors[1]
            }
        }
    }, { // Secondary yAxis
        title: {
            text: '',
            style: {
                color: Highcharts.getOptions().colors[0]
            }
        },
        labels: {
            format: '',
            style: {
                color: Highcharts.getOptions().colors[0]
            }
        },
        opposite: true
    }],
    tooltip: {
        shared: true
    },
	 credits: {   enabled: false  },
	 exporting: { enabled: false },
   /* legend: {
        layout: 'vertical',
        align: 'left',
        x: 120,
        verticalAlign: 'top',
        y: 100,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
    },*/
    series: [{
        name: 'Sales',
        type: 'column',
		 colorByPoint: true,
        yAxis: 1,
        data: TotalSales,//[49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
        tooltip: {
            valuePrefix: 'Rs. '
        }

    }, {
        name: 'Orders',
        type: 'spline',
        data: TotalOrders,//[7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6],
        tooltip: {
            valueSuffix: ''
        }
    }] 
	});
				
			}
		});
	

		
    cb(start, end);
    
});


$(document).on('click','.sales-order-analysis-go',function()
{
	var daterange = $(".salesreportrange").html();
	
	
	$.ajax({
							url:'index.php?route=requestdispatcher/requestdispatcher/getsalesandorder/&token=<?php echo $token; ?>',
							type:"POST",
							data:{'range':"true","daterange":daterange},
							async:false,
							success:function(resp)
							{
								resp=$.trim(resp);
								resp = JSON.parse(resp);
								
								var days = resp.outputdays;
								var Orders = resp.TotalOrders;
								var Sales = resp.TotalSales;
								
								
								categories=[];
								$.each(days,function(ind,val)
								{ 
									categories.push(val);
								});
								
								TotalSales=[];
								TotalOrders = [];
								
								$.each(Orders,function(ind,val)
								{
									TotalOrders.push(parseInt(val));
								});
								
								$.each(Sales,function(ind,val)
								{
									TotalSales.push(parseFloat(val));
								});
								
								
							}
						}); console.log(categories+"type"+typeof(categories));
	
	
	
	Highcharts.chart('sales-order-analysis', 
	{
		
    chart: {
        zoomType: 'xy'
    },
    title: {
        text: ''
    },
    subtitle: {
        text: ''
    },
    xAxis: [{
        categories: categories,//['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        crosshair: true
    }],
    yAxis: [{ // Primary yAxis
        labels: {
            format: '',
            style: {
                color: Highcharts.getOptions().colors[1]
            }
        },
        title: {
            text: '',
            style: {
                color: Highcharts.getOptions().colors[1]
            }
        }
    }, { // Secondary yAxis
        title: {
            text: '',
            style: {
                color: Highcharts.getOptions().colors[0]
            }
        },
        labels: {
            format: '',
            style: {
                color: Highcharts.getOptions().colors[0]
            }
        },
        opposite: true
    }],
    tooltip: {
        shared: true
    },
	 credits: {   enabled: false  },
	 exporting: { enabled: false },
   /* legend: {
        layout: 'vertical',
        align: 'left',
        x: 120,
        verticalAlign: 'top',
        y: 100,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
    },*/
    series: [{
        name: 'Sales',
        type: 'column',
		 colorByPoint: true,
        yAxis: 1,
        data: TotalSales,//[49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
        tooltip: {
            valuePrefix: 'Rs. '
        }

    }, {
        name: 'Orders',
        type: 'spline',
        data: TotalOrders,//[7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6],
        tooltip: {
            valueSuffix: ''
        }
    }] 
	});
	
});
	</script>
    <?PHP
}
?>

<script>
function getsalesandorderstats(daterange)
{

	$.ajax({
				url:'index.php?route=requestdispatcher/requestdispatcher/getsalesandorderstats/&token=<?php echo $token; ?>',
				async:false,
				type:"POST",
				data:{"daterange":daterange},
				success:function(resp)
				{
					resp=$.trim(resp);
					resp = JSON.parse(resp);
					
					var sales_stats = resp.salestats;
					console.log(sales_stats);
					$.each(sales_stats,function(ind,val)
					{
						if(ind=='TotalOrders')
							$(".TotalOrders").html(val);
						else if(ind=='TotalSales')
							$(".SalesAmount").html(val);
						
					});
					
					var orderstats = resp.orderstats;
					
					$.each(orderstats,function(ind,val)
					{ 
						if(ind=='PendingOrders')
						{
							var orderspending = parseInt(val);
							if(orderspending>0)
								$(".PendingOrdes").html(val);
							else
								$(".PendingOrdes").html('No orders(0)');
						}
						else if( ind=='ReturnedOrders')
						{
							var ReturnedOrders = parseInt(val);
							if(ReturnedOrders>0)
								$(".ReturnedOrders").html(val);
							else
								$(".ReturnedOrders").html('No orders(0)');
						}
					});
					
				}
				
		});		
}


//get the top selling, most viewed, new reviews from the past week.

$(document).ready(function()
{
	
	$.ajax({
				url:'index.php?route=requestdispatcher/requestdispatcher/sellingviewedreviews/&token=<?php echo $token; ?>',
				async:false,
				type:"POST",
				success:function(resp)
				{
					resp = $.trim(resp);
					resp = JSON.parse(resp);
					
					if(resp.TopSelling!='0')
					{
						var tr = "";
						$.each(resp.TopSelling,function(ind,val)
						{
							console.log(val);
							tr=tr+'<tr><td title="'+val.category_name+'">'+val.category_name.substr(0,16)+'...</td><td title="'+val.name+'">'+val.name.substr(0,16)+'...</td><td >'+val.TotalProducts+'</td><td>Rs. '+val.Saleamount+'</td></td></tr>';
							
						});
					}
					else
						var tr = "<tr><td colspan='2'></td><td>No sales found</td></tr>"
					
					$("#topsales").html(tr);
					
					
					var tr='';
					var labels = ['text bg-green','text bg-blue','text bg-light-blue','text bg-orange','text bg-red'];
					if(resp.MostViewed!='0')
					{
						$.each(resp.MostViewed,function(ind,val)
						{
							tr = tr+'<tr><td title="'+val.CategoryName+'">'+val.CategoryName.substr(0,16)+'...</td><td title="'+val.ProductName+'">'+val.ProductName.substr(0,16)+'...</td><td>'+val.TotalViews+'</td><td class="'+labels[ind]+'">'+val.ViewedOn+'</td></tr>';	
						});
					}
					else
						var tr = "<tr><td colspan='2'></td><td>No products found </td></tr>"
						$("#mostviewed").html(tr);
					
					
				}
			});
			
	$.ajax({
				url:'index.php?route=requestdispatcher/requestdispatcher/newreviews/&token=<?php echo $token; ?>',
				async:false,
				type:"POST",
				success:function(resp)
				{
					resp = $.trim(resp);
					
					resp = JSON.parse(resp);
					
					var tr='';
					if(resp!='0')
					{
						$.each(resp.NewReviews, function(ind,val) 
						{  
							tr = tr+'<tr><td>'+val.Customer+'</td>';
							tr = tr+'<td>'+val.Product+'</td>';
							tr = tr+'<td>'+val.ReviewData+'</td>';
							tr = tr+'<td><a href="index.php?route=catalog/review/edit&&token=<?php echo $token; ?>&&review_id='+val.review_id+'&filter_status=0" target="_blank" class="btn btn-sm btn-primary">View</a></td></tr>';
						});
					}
					else
						var tr = "<tr><td colspan='2'></td><td>No reviews found </td></tr>"

						$("#newreviews").html(tr);
					
				
				}
			});	
			
			//get the products which are going to out of stock		
			
			$.ajax({
				url:'index.php?route=requestdispatcher/requestdispatcher/productsstock/&token=<?php echo $token; ?>',
				async:false,
				type:"POST",
				success:function(resp)
				{
					resp = $.trim(resp);
					
					resp = JSON.parse(resp);
					var labels = ['bg-green','bg-blue','bg-light-blue','bg-orange','bg-red']
					var tr='';
					if(resp!='0')
					{
						$.each(resp.stock, function(ind,val) 
						{  
							tr = tr+'<tr><td>'+val.Category+'</td>';
							tr = tr+'<td>'+val.Product+'</td>';
							tr = tr+'<td>'+val.TotalSales+'</td>';
							tr = tr+'<td><span class="label '+labels[ind]+'">'+val.AvailQuant+'</span></td>';
						});
					}
					else
						var tr = "<tr><td colspan='2'></td><td>No reviews found </td></tr>"

						$("#closingstock").html(tr);
					
				
				}
			});

});


</script>


</body></html>
