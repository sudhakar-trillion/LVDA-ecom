<?php
class ControllerRequestdispatcherrequestdispatcher extends Controller 
{
	
	public function checkdaterange()
	{
	
		
		if( !isset($this->session->data['SalesReportParams']) && sizeof($this->session->data['SalesReportParams'])>0 )
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
	
}//requestdispatcher class ends here