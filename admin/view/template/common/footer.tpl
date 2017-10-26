<footer id="footer"><?php echo $text_footer; ?><br /><?php echo $text_version; ?></footer></div>

<!--<script type="text/javascript" src="view/JQuery-Custom-Date-Picker/jquery.min.js"></script>-->
<script type="text/javascript" src="view/JQuery-Custom-Date-Picker/moment.min.js"></script>

<script type="text/javascript" src="view/JQuery-Custom-Date-Picker/daterangepicker.js"></script>

<script type="text/javascript">
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
				
				
			}
		});
	
		
		
    cb(start, end);
    
});
</script>


<script>

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




</script>

</body></html>
