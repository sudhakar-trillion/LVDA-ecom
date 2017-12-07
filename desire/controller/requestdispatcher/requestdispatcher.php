<?php
class ControllerRequestdispatcherrequestdispatcher extends Controller 
{
	
	public function checkdaterange()
	{
		
		if( !isset($this->session->data['SalesReportParams'])  )
		{
			
				$filter_date_start = date('Y-m-d', strtotime(date('Y') . '-' . date('m') . '-01'));
				$filter_date_end = date('Y-m-d');
			
		}
		else
		{
			
			if(  sizeof($this->session->data['SalesReportParams'])>0 )
			{
				$filter_date_start = $this->session->data['SalesReportParams']['filter_date_start'];
				$filter_date_end =  $this->session->data['SalesReportParams']['filter_date_end'];
				
			}
			else
			{
				$filter_date_start = date('Y-m-d', strtotime(date('Y') . '-' . date('m') . '-01'));
				$filter_date_end = date('Y-m-d');
			}
						
			
		}
		
			$filter_date_start = date_create($filter_date_start);
			$filter_date_start = date_format($filter_date_start,'m/d/Y');
			
			
			$filter_date_end = date_create($filter_date_end);
			$filter_date_end = date_format($filter_date_end,'m/d/Y');
		
		echo  $filter_date_start.'-'.$filter_date_end;
			
	}
	
	
	public function checkdaterangegraph()
	{
			$filter_date_start = date('Y-m-d', mktime(0, 0, 0, date("m") , date("d") - 9, date("Y")));
			$filter_date_end = date('Y-m-d');
			
			$filter_date_start = date_create($filter_date_start);
			$filter_date_start = date_format($filter_date_start,'m/d/Y');
			
			
			$filter_date_end = date_create($filter_date_end);
			$filter_date_end = date_format($filter_date_end,'m/d/Y');
			
			echo  $filter_date_start.'-'.$filter_date_end;
	}
	
	public function removefilter()
	{
		
		$this->session->data['SalesReportParams'] = array();
		echo "1";
	}
	
	
	//sales report excel download
	
	public function salesreportexcel()
	{
		extract($_POST);
		
		$daterange = explode("-",$daterange);
		
		$startDate  = date_create(trim($daterange[0]));
		$endDate = date_create(trim($daterange[1]));
		
		
		$startDate = date_format($startDate,'Y-m-d');
		$endDate = date_format($endDate,'Y-m-d');
		
		
		
		$endDate = new DateTime($endDate);
		$endDate->modify('+1 day');
		$endDate =  $endDate->format('Y-m-d');
		
		
	$startAt = 0;
	$perPage = $limit;
		
		if( trim($category_filter)=='' )
		{
				$qry = $this->db->query("select count(order_product_id) as TotalProducts, sum(quantity) as quantity, sum(op.total) as Total, sum(op.tax) as TAX,  count(o.order_id) as Orders, date_format(o.date_added,'%d-%m-%Y') as OrderedOn from oc_order as o left join oc_order_product as op on op.order_id=o.order_id where o.date_added>='".$startDate."' and o.date_added<='".$endDate."' group by OrderedOn limit $startAt, $perPage");
				
				if( $qry->num_rows==0 )
				{
					echo "0";	
				}
				else
				{
					
					date_default_timezone_set('Asia/Kolkata');
					// include PHPExcel library and set its path accordingly.
					require('../PHPExcel-1.8/PHPExcel.php');
					$objPHPExcel = new PHPExcel;
					
					$objPHPExcel->setActiveSheetIndex(0);
					$needed_columns = array("A"=>'OrderedOn',"B"=>'No. Orders',"C"=>'No. Products',"D"=>'Tax',"E"=>'Total');
					
					foreach( $needed_columns as $key=>$val )
					{
												
						$objPHPExcel->getActiveSheet()->setCellValue($key.'1', $val);
						$objPHPExcel->getActiveSheet()->getStyle($key.'1')->getFont()->setSize(13);
						$objPHPExcel->getActiveSheet()->getStyle($key.'1')->getFont()->setBold(true);
						$objPHPExcel->getActiveSheet()->getStyle($key.'1')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	
					}
					$objPHPExcel->getActiveSheet()->setTitle("Orders by category"); 
					$excel_sheet_name = time().$_POST['daterange'].$_POST['category_filter'];
					$cnt=1;
					foreach($qry->rows as $order)	
					{

						
						$objPHPExcel->getActiveSheet()->setCellValue('A'.($cnt+1), $order['OrderedOn']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('A'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('A'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('B'.($cnt+1), $order['Orders']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('B'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('B'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('C'.($cnt+1), $order['TotalProducts']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('C'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('C'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('D'.($cnt+1), $order['TAX']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('D'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('D'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('E'.($cnt+1), $order['Total']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('E'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('E'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
					
						
						$cnt++;
					}
					
					$excel_sheet_name = time().$_POST['daterange'].$_POST['category_filter'];
					$excel_sheet_name = str_replace(" ","",$excel_sheet_name);
					
					
					$filename="$excel_sheet_name.xls"; //save our workbook as this file name
					
					header('Content-Type: application/vnd.ms-excel'); //mime type
					header('Content-Disposition: attachment;filename="'.$filename.'"'); //tell browser what's the file name
					header('Cache-Control: max-age=0'); //no cache
					
					//save it to Excel5 format (excel 2003 .XLS file), change this to 'Excel2007' (and adjust the filename extension, also the header mime type)
					//if you want to save it as .XLSX Excel 2007 format
					$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');  
					//force user to download the Excel file without writing it to server's HD
					//$objWriter->save('php://output');
					$objWriter->save($_SERVER['DOCUMENT_ROOT']."/pav-vigoss/".$filename);
					
					echo $filename;
					
					
				}
		}
		else
		{
			if( trim($category_filter)=='category' )
			{
				$getorderidsqry = $this->db->query("SELECT op.product_id, date_format(ord.date_added,'%Y-%m-%d') as OrderedOn, cat.name as Category, count(*) as TotalOrders, sum(op.quantity) as TotalProducts, sum(op.total) as Total, CASE WHEN sum(op.tax)>0 THEN sum(op.tax) ELSE '0' END as TAX  FROM oc_order as ord left join oc_order_product as op on op.order_id=ord.order_id left join oc_product_to_category as ptc on ptc.product_id=op.product_id left join oc_category_description as cat on cat.category_id=ptc.category_id where ord.date_added>='".$startDate."' and ord.date_added<='".$endDate."' group by OrderedOn,ptc.category_id  limit $startAt, $perPage");
				
			if( $getorderidsqry->num_rows > 0 )
			{
				
				
					
					date_default_timezone_set('Asia/Kolkata');
					// include PHPExcel library and set its path accordingly.
					require('../PHPExcel-1.8/PHPExcel.php');
					$objPHPExcel = new PHPExcel;
					
					$objPHPExcel->setActiveSheetIndex(0);
					$needed_columns = array("A"=>'OrderedOn',"B"=>'Category',"C"=>'No. Orders',"D"=>'Tax',"E"=>'Total');
					
					foreach( $needed_columns as $key=>$val )
					{
												
						$objPHPExcel->getActiveSheet()->setCellValue($key.'1', $val);
						$objPHPExcel->getActiveSheet()->getStyle($key.'1')->getFont()->setSize(13);
						$objPHPExcel->getActiveSheet()->getStyle($key.'1')->getFont()->setBold(true);
						$objPHPExcel->getActiveSheet()->getStyle($key.'1')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	
					}
					$objPHPExcel->getActiveSheet()->setTitle("Orders by category"); 
					$excel_sheet_name = time().$_POST['daterange'].$_POST['category_filter'];
					$cnt=1;
					foreach($getorderidsqry->rows as $order)	
					{

						
						$objPHPExcel->getActiveSheet()->setCellValue('A'.($cnt+1), $order['OrderedOn']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('A'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('A'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('B'.($cnt+1), $order['Category']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('B'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('B'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('C'.($cnt+1), $order['TotalOrders']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('C'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('C'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('D'.($cnt+1), $order['TAX']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('D'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('D'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('E'.($cnt+1), $order['Total']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('E'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('E'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
					
						
						$cnt++;
					}
					
					$excel_sheet_name = time().$_POST['daterange'].$_POST['category_filter'];
					$excel_sheet_name = str_replace(" ","",$excel_sheet_name);
					
					
					$filename="$excel_sheet_name.xls"; //save our workbook as this file name
					
					header('Content-Type: application/vnd.ms-excel'); //mime type
					header('Content-Disposition: attachment;filename="'.$filename.'"'); //tell browser what's the file name
					header('Cache-Control: max-age=0'); //no cache
					
					//save it to Excel5 format (excel 2003 .XLS file), change this to 'Excel2007' (and adjust the filename extension, also the header mime type)
					//if you want to save it as .XLSX Excel 2007 format
					$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');  
					//force user to download the Excel file without writing it to server's HD
					//$objWriter->save('php://output');
					$objWriter->save($_SERVER['DOCUMENT_ROOT']."/pav-vigoss/".$filename);
					
					echo $filename;
					
					
				
				
				
				
				
				
				
				
			}
			else
			echo "0";
				
				
				
			}
			else if( trim($category_filter)=='product' )
			{
				$getorderidsqry = $this->db->query("SELECT op.product_id, date_format(ord.date_added,'%Y-%m-%d') as OrderedOn, op.name as Product, count(*) as TotalOrders, sum(op.quantity) as TotalProducts, sum(op.total) as Total, CASE WHEN sum(op.tax)>0 THEN sum(op.tax) ELSE '0' END as Tax   FROM oc_order as ord left join oc_order_product as op on op.order_id=ord.order_id where ord.date_added>='".$startDate."' and ord.date_added<='".$endDate."' group by OrderedOn,op.product_id limit $startAt, $perPage");
				
				if( $getorderidsqry->num_rows > 0 )
				{
					date_default_timezone_set('Asia/Kolkata');
					// include PHPExcel library and set its path accordingly.
					require('../PHPExcel-1.8/PHPExcel.php');
					$objPHPExcel = new PHPExcel;
					
					$objPHPExcel->setActiveSheetIndex(0);
					$needed_columns = array("A"=>'OrderedOn',"B"=>'Product',"C"=>'No. Orders',"D"=>"Quantity","E"=>'Tax',"F"=>'Total');
					
					foreach( $needed_columns as $key=>$val )
					{
												
						$objPHPExcel->getActiveSheet()->setCellValue($key.'1', $val);
						$objPHPExcel->getActiveSheet()->getStyle($key.'1')->getFont()->setSize(13);
						$objPHPExcel->getActiveSheet()->getStyle($key.'1')->getFont()->setBold(true);
						$objPHPExcel->getActiveSheet()->getStyle($key.'1')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	
					}
					$objPHPExcel->getActiveSheet()->setTitle("Orders By Products"); 
					$excel_sheet_name = time().$_POST['daterange'].$_POST['category_filter'];
					$cnt=1;
					foreach($getorderidsqry->rows as $order)	
					{

						
							$objPHPExcel->getActiveSheet()->setCellValue('A'.($cnt+1), $order['OrderedOn']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('A'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('A'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						$objPHPExcel->getActiveSheet()->setCellValue('B'.($cnt+1), $order['Product']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('B'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('B'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
					
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('C'.($cnt+1), $order['TotalOrders']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('C'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('C'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('D'.($cnt+1), $order['TotalProducts']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('D'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('D'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						
						
						$objPHPExcel->getActiveSheet()->setCellValue('E'.($cnt+1), $order['Tax']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('E'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('E'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
						$objPHPExcel->getActiveSheet()->setCellValue('F'.($cnt+1), $order['Total']);
						//change the font size
						$objPHPExcel->getActiveSheet()->getStyle('F'.($cnt+1))->getFont()->setSize(12);
						$objPHPExcel->getActiveSheet()->getStyle('F'.($cnt+1))->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);	
						
					
						
						$cnt++;
					}
					
					$excel_sheet_name = time().$_POST['daterange'].$_POST['category_filter'];
					$excel_sheet_name = str_replace(" ","",$excel_sheet_name);
					
					
					$filename="$excel_sheet_name.xls"; //save our workbook as this file name
					
					header('Content-Type: application/vnd.ms-excel'); //mime type
					header('Content-Disposition: attachment;filename="'.$filename.'"'); //tell browser what's the file name
					header('Cache-Control: max-age=0'); //no cache
					
					//save it to Excel5 format (excel 2003 .XLS file), change this to 'Excel2007' (and adjust the filename extension, also the header mime type)
					//if you want to save it as .XLSX Excel 2007 format
					$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');  
					//force user to download the Excel file without writing it to server's HD
					//$objWriter->save('php://output');
					$objWriter->save($_SERVER['DOCUMENT_ROOT']."/pav-vigoss/".$filename);
					
					echo $filename;
				}
				else
				echo "0";
			}
		}


		
	}
	
	///delete excel once user download 
public function deleteexcelsheet()
{
	

	$path = $_SERVER['DOCUMENT_ROOT']."/pav-vigoss/".$_POST['excelname'];
	unlink($path);
	//unlink($postdata['excelname']);

}
public function getProducts()
{
	$this->load->model('catalog/product');
	$prdcts = $this->model_catalog_product->getProductsCrosssale();	
	
	if($prdcts->num_rows>0)	
	{
		$data='';
		foreach( $prdcts->rows as $prd)
		{
			if( $prd['Special']!='' )
				$price=$prd['Special'];
			else
				$price=$prd['price'];	
			$data.= '<div class="cross-sale-parent-prd" price="'.$price.'" id="product-'.$prd['product_id'].'">'.$prd['name'].'</div>';
		}
		
		echo $data;
	}
	else
		echo "0";
}

//setcross_sale satarts here

	public function setcross_sale()
	{
		$this->load->model('catalog/product');
		extract($_POST);
		
		$insertdata = array(
							"CrossSaleParent"=>$CrossSaleParent,
							"CrossSaleProducts"=>$CrossSaleProducts,
							"CrossSaleProductPrices"=>$CrossSaleProductPrices,
							"ProductPrice"=>$ProductActualPrice
							
							);
		
	if ($this->model_catalog_product->insertCrosssaleProduct($insertdata) )
		echo "1";
	else
		echo "-1";

		
	}


//setcross_sale emds here


// update cross sale products starts here

	
	public function updatecross_sale()
	{
		
		$this->load->model('catalog/product');
		extract($_POST);
		
		$insertdata = array(
							"CrossSaleParent"=>$CrossSaleParent,
							"CrossSaleProducts"=>$CrossSaleProducts,
							"CrossSaleProductPrices"=>$CrossSaleProductPrices,
							"ProductPrice"=>$ProductActualPrice
							
							);
		
	if ($this->model_catalog_product->updateCrosssaleProduct($insertdata) )
		echo "1";
	else
		echo "-1";

	
	
			
	}

// update cross sale products ends here


//clearparentprd starts here

	public function clearparentprd()
	{
		$this->session->data['crosssaleList'] ='';
		$this->session->data['ParentProductName'] = '';
		echo "1";	
	}

//clearparentprd

//get the orders which are shipped


public function getshippeddorders()
{
	
	$this->load->model('sale/order');
	
	$cond = array();
	$orders = $this->model_sale_order->getshippeddorders($_POST['keyword']);

}

//assignTrackingnumber starts here
	
	public function assignTrackingnumber()
	{
		extract($_POST);
		if( $this->session->data['token'] == $_GET['token'])
		{
			$this->load->model('sale/order');
			
			$exists = $this->model_sale_order->checkorderstatus($orderid);
			if( $exists==1)
			{
				
				///get the customer details
				
				$userdetails = $this->model_sale_order->getuserbyorder($orderid,$courierid,$couriername);
				if($userdetails=='1')
					echo "1";
				else if($userdetails=='-1')
					echo "-4";
				else if($userdetails=='-3')	
					echo "-3";
				else if($userdetails=='0')
					echo "-2";
				else if($userdetails=='-5')
					echo "-5";
				
				
				
				
			}
			else
				echo "0";
			
		}
		else
			echo "-1";
	}

//assignTrackingnumber ends here

///getsalesandorder starts hree
	
	public function getsalesandorder()
	{
		if($_POST['range']=="false")
		{
			
		extract($_POST);
		$date1 = $start;
		$date2=$end;
		}
		elseif($_POST['range']=="true")
		{
			
			$daterange = explode("-",$_POST['daterange']);
			
			$startDate  = date_create(trim($daterange[0]));
			$endDate = date_create(trim($daterange[1]));
			
			
			$date1 = date_format($startDate,'Y-m-d');
			$date2 = date_format($endDate,'Y-m-d');
			
			
			
			$endDate = new DateTime($date2);
			$endDate->modify('+1 day');
			$date2 =  $endDate->format('Y-m-d');
			
		}
//		echo $start.":".$end; exit; 
		
		$date1=date_create($date1);
		$date2=date_create($date2);
		
		$cnt=0;
		
		foreach($date1 as $obj)
		{
			if($cnt==0)
			$startdate =  explode("00:00",$obj) ;
			
			$cnt++;
		}
		
		$startDate =  $startdate[0];
		
		$cnt=0;
		
		foreach($date2 as $obj)
		{
			if($cnt==0)
			$lastdate =  explode("00:00",$obj) ;
			
			$cnt++;
		}
		
		$endDate =  $lastdate[0];
		
		$today = date('Y-m-d');
		
		if( trim($today)==trim($endDate))
			{
				$chkmnth = explode("-",$startDate);
				
				if( trim($chkmnth[1])==date('m'))
				$isToday = "yes";
				else
				{
					$chkmnth = array();
					$chkmnth = explode("-",$endDate);
					if( trim($chkmnth[1])==date('m'))
						$isToday = "yes";
					else
						$isToday = "no";
				}
					
			}
		else
		{
			$isToday = "no";
		}
			
		
		//echo $endDate.":".$startDate;
		
		$endDate = (string)$endDate;
		$startDate = (string)$startDate;
		
		 $daysLeft = abs(strtotime($endDate) - strtotime($startDate));
		 $days = $daysLeft/(60 * 60 * 24);
		// echo $days; exit; 
		 $outputdays = array();
		 
		 $dayscnt=0;
		 $stopy='yes';

		 for($i=$days;$i>0;$i--)
		 {
			 $dayscnt++;
			 
				if( $isToday =="yes" )
						$outputdays[] = date('Y-m-d', mktime(0, 0, 0, date("m") , date("d") - ($i), date("Y"))); 
				else
				{
					$mnth = explode("-",$endDate);
					
				//	echo $endDate.":";
					
			//	echo $mnth[1].":".date('m'); exit;
				
					if( $mnth[1]-1 == date('m'))
					{
						//echo $days.":".(int)date('d'); exit; 
						if( $days>(int)date('d'))
						{
							if( $dayscnt<=date('d') )	
								$outputdays[] = date('Y-m-d', mktime(0, 0, 0, $mnth[1] , $mnth[2] - ($i), $mnth[0])); 
						}
						else
							$outputdays[] = date('Y-m-d', mktime(0, 0, 0, $mnth[1] , $mnth[2] - ($i), $mnth[0])); 
					}
					else
						$outputdays[] = date('Y-m-d', mktime(0, 0, 0, $mnth[1] , $mnth[2] - ($i), $mnth[0])); 
				}
					
		 }
		// exit;
		 $cnt=0;
		 $sales=array();
		 $orders=array();
		 
		 foreach($outputdays as $val)
		 {
			 $fulldate =  strtotime($val);
			 $outputdays[$cnt] = date('M-d', $fulldate);
			 $cnt++;			 
			 
			 //check total orders on this date
			 
			$qry = $this->db->query("SELECT sum(total) as TotalSales, count(*) as TotalOrders FROM oc_order WHERE date_added like '".$val."%'");
			
			foreach($qry->rows as $resset)
			{
				if($resset['TotalOrders']==0)	
				{
					$orders[] = 0;
					$sales[]= 0;	
				}
				else
				{
					$orders[] = $resset['TotalOrders'];
					$sales[]=  $resset['TotalSales'];
				}
			}

			 
		 }
		
		$finalopuput=array(
							"outputdays"=>$outputdays,
							"TotalOrders"=>$orders,
							"TotalSales"=>$sales
							);
		 
		 echo json_encode($finalopuput);
		 
		
	}
	
//getsalesandorder ends here


public function getsalesandorderstats()
{
			$daterange = explode("-",$_POST['daterange']);
			
			$startDate  = date_create(trim($daterange[0]));
			$endDate = date_create(trim($daterange[1]));
			
			
			$date1 = date_format($startDate,'Y-m-d');
			$date2 = date_format($endDate,'Y-m-d');
			
			
			
			$endDate = new DateTime($date2);
//			$endDate->modify('day');
			$date2 =  $endDate->format('Y-m-d');
			
		//	echo "SELECT sum(total) as TotalSales, count(*) as TotalOrders FROM oc_order WHERE date_format(date_added,'%Y-%m-%d')>='".$date1."' and date_format(date_added,'%Y-%m-%d')<='".$date2."'"; exit;
			
			
			
			$qry = $this->db->query("SELECT sum(total) as TotalSales, count(*) as TotalOrders FROM oc_order WHERE date_format(date_added,'%Y-%m-%d')>='".$date1."' and date_format(date_added,'%Y-%m-%d')<='".$date2."'");
			
			$row = $qry->row;
			
			$salesstats = array();
			$orderstats = array();
			
			$response=array();
			
			if( $row['TotalOrders']>0 )
			{
				$salesstats['TotalOrders'] = $row['TotalOrders'];
				$salesstats['TotalSales'] = "Rs. ".$row['TotalSales'];
			}
			else
			{
				$salesstats['TotalOrders'] = 0;
				$salesstats['TotalSales'] = "Rs. 0";
			}
			
			$response['salestats'] = $salesstats;
		
			//get the orders which are in pending
			$qrey = $this->db->query("SELECT count(his.order_history_id) PendingOrders FROM oc_order_history his inner join oc_order_status as sta on sta.order_status_id=his.order_status_id where his.order_status_id=1 and ( date_format(his.date_added,'%Y-%m-%d')>='".$date1."' and  date_format(his.date_added,'%Y-%m-%d')<='".$date2."' )");
			
			$PendingOrders = $qrey->row['PendingOrders'];
			
			//echo "SELECT count(his.order_history_id) ReturnedOrders FROM oc_order_history his inner join oc_order_status as sta on sta.order_status_id=his.order_status_id where his.order_status_id=12 and ( date_format(his.date_added,'%Y-%m-%d')>='".$date1."' and  date_format(his.date_added,'%Y-%m-%d')<='".$date2."' )"; exit; 
		
		//getthe orders which are returned 
						$qrey = $this->db->query("SELECT count(his.order_history_id) ReturnedOrders FROM oc_order_history his inner join oc_order_status as sta on sta.order_status_id=his.order_status_id where his.order_status_id=12 and ( date_format(his.date_added,'%Y-%m-%d')>='".$date1."' and  date_format(his.date_added,'%Y-%m-%d')<='".$date2."' )");
			
			$ReturnedOrders = $qrey->row['ReturnedOrders'];
			$response['orderstats'] = array("PendingOrders"=>$PendingOrders,"ReturnedOrders"=>$ReturnedOrders);
		
		
			echo json_encode($response);
			
			
}
	
	//get the user stats
	
	public function userstats()
	{
		$qry = $this->db->query("SELECT  IFNULL(count(*),0) TotalCustomersOnline from oc_customer_online ");	
		$qrey = $this->db->query("SELECT IFNULL(count(*),0) TotalCustomers from oc_customer");
		
		if($qry->num_rows>0)
			$custinfo["TotalCustomers"]=$qrey->row['TotalCustomers'];
		else
			$custinfo["TotalCustomers"]=0;
			
		if($qrey->num_rows>0)
			$custinfo["TotalCustomersOnline"]=$qry->row['TotalCustomersOnline'];
		else
			$custinfo["TotalCustomersOnline"]=0;
			
			
		
		echo json_encode($custinfo);
		
	}
	
	
	// get the top selling ,mostviewed and reviews of the week respectivel 
	
	public function sellingviewedreviews()
	{
		$days = date('d');
		
		 $startDate = date('Y-m-d', strtotime('-'.$days.' days', strtotime(date('Y-m-d'))));	
		 //$startDate = date('Y-m-d', strtotime('-7 days', strtotime(date('Y-m-d'))));	
		 $endDate = date('Y-m-d');
		 
		 //echo "SELECT sum(orprd.quantity) as TotalProducts, orprd.category_name, orprd.name,sum(orprd.total) as Saleamount from oc_order_product as orprd inner join oc_order as ord ord.order_id=orprd.order_id where ord.date_added>='".$startDate."' and  ord.date_added<='".$endDate."' group by product_id"; exit; 
		 
		 //get the top sellings of this week
		 $salesQry = $this->db->query("SELECT sum(orprd.quantity) as TotalProducts, orprd.category_name, orprd.name,sum(orprd.total) as Saleamount from oc_order_product as orprd inner join oc_order as ord on ord.order_id=orprd.order_id where ord.date_added>='".$startDate."' and  ord.date_added<='".$endDate."' group by product_id order by Saleamount DESC");
		 
		 if($salesQry->num_rows>0)
		 {
			 $totalsales = array();
			foreach($salesQry->rows as $sales)	 
			{
				$totalsales[] = array(
										"category_name"=>$sales['category_name'],
										"name"=>$sales['name'],
										"TotalProducts"=>$sales['TotalProducts'],
										"Saleamount"=>$sales['Saleamount']
										);
			}
			$output['TopSelling'] = $totalsales;
		 }
		 else
		 	$output['TopSelling'] = 0;
		
		 
		 //get the most viewed product

		 
//		 echo "SELECT desc.name as ProductName, catdesc.name as CategoryName, prd.viewed as TotalViews, view.ViewedOn  from oc_product as prd join oc_product_description as descp on descp.product_id=prd.product_id join oc_product_to_category as pcat on pcat.product_id=descp.product_id join oc_category_description as cardesc on catdesc.category_id=pcat.category_id join oc_recentviewed_products as view on view.ProductId=prd.product_id where view.ViewedOn>='".$startDate."' and  view.ViewedOn<='".$endDate."' Group by prd.product_id  order by prd.viewed DESC LIMIT 0,5"; exit; 
		 
		 
		 $viewedProducts = $this->db->query("SELECT descp.name as ProductName, catdesc.name as CategoryName, prd.viewed as TotalViews, view.ViewedOn  from oc_product as prd join oc_product_description as descp on descp.product_id=prd.product_id join oc_product_to_category as pcat on pcat.product_id=descp.product_id join oc_category_description as catdesc on catdesc.category_id=pcat.category_id join oc_recentviewed_products as view on view.ProductId=prd.product_id where view.ViewedOn>='".$startDate."' and  view.ViewedOn<='".$endDate."' Group by prd.product_id  order by prd.viewed DESC LIMIT 0,5");
		 
		 if($viewedProducts->num_rows>0)
		 {	
		 	$totalviews=array();
			
		 	foreach($viewedProducts->rows as $views)
			{
				
				$ViewedOn = date_create($views['ViewedOn']);
				$ViewedOn = date_format( $ViewedOn,"d M Y" );
				
				$totalviews[] = array(
										"CategoryName"=>$views['CategoryName'],
										"ProductName"=>$views['ProductName'],
										"TotalViews"=>$views['TotalViews'],
										"ViewedOn"=>$ViewedOn
									);
			}
			$output['MostViewed'] = $totalviews;
		 }
		 else
		 	$output['MostViewed'] = '0';
		 
		 echo json_encode($output);
		 
	}
	
	//get the new reviews 
	
	public function newreviews()
	{
		error_reporting('0');
		$days = date('d');
		
		 $startDate = date('Y-m-d', strtotime('-'.$days.' days', strtotime(date('Y-m-d'))));	
		// $startDate = date('Y-m-d', strtotime('-7 days', strtotime(date('Y-m-d'))));	
		 $endDate = date('Y-m-d');
		 
		 //echo "SELECT rev.author as Customer, SUBSTR(rev.text0,5) as ReviewData, pdesc.name as Product from oc_review as rev join oc_product as prd on prd.product_id=rev.product_id join oc_product_description as pdesc on pdesc.product_id=prd.product_id where date_format(rev.date_added,'%Y-%m-$d')>='".$startDate."' and date_format(rev.date_added,'%Y-%m-$d')<='".$endDate."' and (rev.status=0) "; exit; 
		 
		 $qry = $this->db->query("SELECT rev.review_id, rev.author as Customer, SUBSTR(rev.text,1,5) as ReviewData, pdesc.name as Product from oc_review as rev join oc_product as prd on prd.product_id=rev.product_id join oc_product_description as pdesc on pdesc.product_id=prd.product_id where date_format(rev.date_added,'%Y-%m-$d')>='".$startDate."' and date_format(rev.date_added,'%Y-%m-$d')<='".$endDate."' and (rev.status=0) order by review_id DESC");
		 
		 
		 if($qry->num_rows>0)
		 {
			 $output=array();
			 foreach($qry->rows as $rev)
			 {
					$revdata[] =array(
										"Customer"=>$rev['Customer'],
										"Product"=>$rev['Product'],
										"ReviewData"=>$rev['ReviewData'],
										"review_id"=>$rev['review_id']
									);
									
			 }
			 $output['NewReviews'] = $revdata;
			 
			 echo json_encode($output);
		 }
		 else
		 	echo "0";
		 
	}
	
	//get the rpoducts which are goin to out of stock
	
	public function productsstock()
	{
		
		$qry = $this->db->query("select prd.quantity as AvailQuant, pdesc.name as Product, catdesc.name as Category, sal.total as TotalSales from oc_product as prd join oc_product_description as pdesc on pdesc.product_id=prd.product_id join oc_product_to_category prdcat on prdcat.product_id=prd.product_id join oc_category_description as catdesc on catdesc.category_id=prdcat.category_id join oc_order_product as sal on sal.product_id=prd.product_id  GROUP by prd.product_id order by prd.quantity ASC Limit 5");
		
		$output=array();
		$stockdetails = array();
		
		
		foreach($qry->rows as $stock)
		{
			$stockdetails[]= array(
									"Category"=>$stock['Category'],
									"Product"=>$stock['Product'],	
									"TotalSales"=>$stock['TotalSales'],	
									"AvailQuant"=>$stock['AvailQuant'],	
									);	
		}
		$output['stock'] = $stockdetails;
		echo json_encode($output);
	}
	
}//requestdispatcher class ends here