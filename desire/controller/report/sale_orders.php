<?php
class ControllerReportSaleOrders extends Controller {

	
	public function index() {
		$this->load->language('report/sale_orders');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => ''//$this->url->link('report/sale_order', 'token=' . $this->session->data['token'] . $url, true)
		);

		

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');
		$data['text_all_status'] = $this->language->get('text_all_status');

		$data['column_orderId'] = $this->language->get('column_orderId');
		$data['column_Orderedon'] = $this->language->get('column_Orderedon');
		$data['column_orders'] = $this->language->get('column_orders');
		$data['column_products'] = $this->language->get('column_products');
		$data['column_tax'] = $this->language->get('column_tax');
		$data['column_total'] = $this->language->get('column_total');

		$data['entry_date_start'] = $this->language->get('entry_date_start');
		$data['entry_date_end'] = $this->language->get('entry_date_end');
		$data['entry_category'] = $this->language->get('entry_category');
		$data['entry_product'] = $this->language->get('entry_product');
		$data['column_quanities'] =  $this->language->get('column_quanities');

		$data['token'] = $this->session->data['token'];

		
		$reportparams = array();
		
		$limit=2;
		
		if( isset($_POST['getReport']))
		{
		
			
			extract($_POST);
			
			$rangedates = explode("-",$selected_range_dates);
			
			$startDate = date_create($rangedates[0]);
			$startDate = date_format($startDate,'Y-m-d');
			
			$filter_date_start = $startDate;
			
			$endDate = date_create($rangedates[1]);
			$endDate = date_format($endDate,'Y-m-d');
			
			$filter_date_end = $endDate;
			
			if( isset($filter))
				$filter = $filter;
			else
				$filter = '';
			
			$reportparams['filter_date_start'] = $filter_date_start;
			$reportparams['filter_date_end'] = $filter_date_end;
			$reportparams['limit'] = $limit;
			$reportparams['filter'] = $filter;
		
			$this->session->data['SalesReportParams'] = $reportparams;
			$data['limit'] = $limit;
			$data['filter'] = $filter;
		
		
		}
		else
		{
			if( isset( $this->session->data['SalesReportParams']) && sizeof($this->session->data['SalesReportParams'])>0 )
			{
				$data['limit'] = $this->session->data['SalesReportParams']['limit'];
				$data['filter'] = $this->session->data['SalesReportParams']['filter'];
				
				$reportparams['limit'] = $this->session->data['SalesReportParams']['limit'];
				$reportparams['filter'] = $this->session->data['SalesReportParams']['filter'];
				$reportparams['filter_date_start'] = $this->session->data['SalesReportParams']['filter_date_start'];
				$reportparams['filter_date_end'] = $this->session->data['SalesReportParams']['filter_date_end'];
				
			}
			else
			{
				$limit=2;
				
				$data['limit'] = $limit;
				$data['filter'] = '';
				
				$filter_date_start = date('Y-m-d', strtotime(date('Y') . '-' . date('m') . '-01'));
				$filter_date_end = date('Y-m-d');
				
				
				
				
				
				$reportparams['filter_date_start'] = $filter_date_start;
				$reportparams['filter_date_end'] = $filter_date_end;
				$reportparams['limit'] = 10;
				$reportparams['filter'] = '';
			
			}
		}
		

		$date = new DateTime($reportparams['filter_date_end']);
		$date->modify('+1 day');
		$reportparams['filter_date_end'] =  $date->format('Y-m-d');
		
		$this->load->model('report/sale');
		$data['orders'] = array();	
		
	/* Pagination ends here  */			
		if( $reportparams['filter']=='' )
		{
			$qry = $this->db->query("select  order_id, date_format(date_added,'%d-%m-%Y') as OrderedOn from oc_order where date_added>='".$reportparams['filter_date_start']."' and date_added<='".$reportparams['filter_date_end']."' group by OrderedOn ");
			
		$total_rows = $qry->num_rows;
		
		$total_res = $total_rows;

		
		
		}
		elseif(  $reportparams['filter']=='category' )
		{
			
		
			
			$qry = $this->db->query("SELECT op.product_id, date_format(ord.date_added,'%Y-%m-%d') as OrderedOn, cat.name as Category, count(*) as TotalOrders, sum(op.quantity) as TotalProducts, sum(op.total) as Total, CASE WHEN sum(op.tax)>0 THEN sum(op.tax) ELSE '0' END as Tax  FROM oc_order as ord left join oc_order_product as op on op.order_id=ord.order_id left join oc_product_to_category as ptc on ptc.product_id=op.product_id left join oc_category_description as cat on cat.category_id=ptc.category_id where ord.date_added>='".$reportparams['filter_date_start']."' and ord.date_added<='".$reportparams['filter_date_end']."' group by OrderedOn,ptc.category_id  ");
			
			$total_rows = $qry->num_rows;
			$total_res = $total_rows;
			
			
		}
		elseif( $reportparams['filter']=='product' )
		{
			
			//$qry = $this->db->query("select  oc.order_id, date_format(oc.date_added,'%d-%m-%Y') as OrderedOn from oc_order oc join oc_order_product as op on op.order_id=oc.order_id where oc.date_added>='".$reportparams['filter_date_start']."' and oc.date_added<='".$reportparams['filter_date_end']."'  group by  oc.order_id ");
			
			$getorderidsqry = $this->db->query("SELECT op.product_id, date_format(ord.date_added,'%Y-%m-%d') as OrderedOn, op.name as Product, count(*) as TotalOrders, sum(op.quantity) as TotalProducts FROM oc_order as ord left join oc_order_product as op on op.order_id=ord.order_id where ord.date_added>='".$reportparams['filter_date_start']."' and ord.date_added<='".$reportparams['filter_date_end']."' group by OrderedOn,op.product_id");
			
			
			$total_rows = $getorderidsqry->num_rows;
			$total_res = $total_rows;
			
			#echo $total_rows ; exit; 
		}
		
	
	if(isset($_GET['page']))
		$page=(int)$_GET['page'];
	else
		$page=1;
	
	$perPage = $reportparams['limit'];
	
	$totalPages = ceil($total_res/$perPage);
		
	$startAt = $perPage * ($page-1);
		
	
	if( isset( $_GET['page'] ) )
		$accessingPage = $_GET['page'];
	else
		$accessingPage = '1';

	$links='';

if($accessingPage>1)
{

$links.=" <li><a href='index.php?route=report/sale_orders&token=".$data['token'] ."'>First</a></li>";

if($page<=$totalPages)
{
	$prev=$page-1;
	
	if($prev<=0)
	{
		$prev=1;
	}
	
	$links.=" <li><a href='index.php?route=report/sale_orders&token=".$data['token'] ."&page=".$prev."'>Prev</a></li>";
	//$links.="<a href='index.php'>First</a>";
	
}
}



for ($i = $page-5; $i<10+$page-5; $i++) {
		
		   if($i>0 && $i<=$totalPages){
		   
		   //  $links .= "<a href='index.php?page=$i'> $i</a>";
		   
			$links .= ($i != $page ) ? " <li><a href='index.php?route=report/sale_orders&token=".$data['token'] ."&page=".$i."'> $i</a></li> " : "<li class='active'><a >$page</a></li> ";
			
		   }
}



if($accessingPage<$totalPages)
{
	if($page<$totalPages)
	{
			$next=$page+1;
			
			if($next<0)
			 {
				$next=1;
			 }
			 
			$links=$links." <li><a href='index.php?route=report/sale_orders&token=".$data['token'] ."&page=".$next."'>Next</a></li>";
			
	}
	
	else
	{
			$next=$page+1;
			
			if($next>$totalPages)
			{
				$next=$totalPages;
			}
			$links=$links." <li><a href='index.php?route=report/sale_orders&token=".$data['token'] ."&page=".$next."'>Next</a></li>";
	}
	$links=$links."<li><a href='index.php?route=report/sale_orders&token=".$data['token'] ."&page=".$totalPages."'>Last</a></li>";
}



/* Pagination ends here  */

if($totalPages>1)
	$data['Pagination'] = $links;
else
	$data['Pagination'] = '';

$ordersdata = '';


if( $reportparams['filter']=='' )
		{
			
			//from the below query we will get number of orders and ordered date in between two dates

			$qry = $this->db->query("select count(order_product_id) as TotalProducts, sum(quantity) as quantity, sum(op.total) as Total, sum(op.tax) as TAX,  count(o.order_id) as Orders, date_format(o.date_added,'%d-%m-%Y') as OrderedOn from oc_order as o left join oc_order_product as op on op.order_id=o.order_id where o.date_added>='".$reportparams['filter_date_start']."' and o.date_added<='".$reportparams['filter_date_end']."' group by OrderedOn limit $startAt, $perPage");
			
		/*	
		echo "<pre>";
			print_r($qry);
		exit;
		*/	
			
			if($qry->num_rows>0)
			{
				foreach( $qry->rows as $orders)	
				{
					$OrderedOn = $orders['OrderedOn'];
					$Ordered = date_create($OrderedOn);
					$Ordered = date_format($Ordered,'Y-m-d');
					
					
					$date = new DateTime($Ordered);
					
					$date->modify('+1 day');
					$Order_on =  $date->format('Y-m-d');
					
					
					$qrey = $this->db->query("select  count(o.order_id) as Orders, date_format(o.date_added,'%d-%m-%Y') as OrderedOn from oc_order as o  where o.date_added>='".$Ordered."' and o.date_added<='".$Order_on."'   group by OrderedOn");
					
					$ordersdata[ ]= array(
											"TotalOrders" => $qrey->row['Orders'],
											'OrderedOn'=> $OrderedOn,
											//'TotalProducts' => $orders['TotalProducts'],
											'TotalProducts' => $orders['quantity'],
											"TotalSale"=>$orders['Total'],
											"TotalTAX"=>$orders['TAX'],
											
											);
				}
				
				
			}
			else
			{
					
			}
			
		
		
		/*  echo "<pre>"; print_r($ordersdata);  exit; */
		}
else if( $reportparams['filter']=='product' )
		{
			
			$getorderidsqry = $this->db->query("SELECT op.product_id, date_format(ord.date_added,'%Y-%m-%d') as OrderedOn, op.name as Product, count(*) as TotalOrders, sum(op.quantity) as TotalProducts, sum(op.total) as Total, CASE WHEN sum(op.tax)>0 THEN sum(op.tax) ELSE '0' END as Tax   FROM oc_order as ord left join oc_order_product as op on op.order_id=ord.order_id where ord.date_added>='".$reportparams['filter_date_start']."' and ord.date_added<='".$reportparams['filter_date_end']."' group by OrderedOn,op.product_id limit $startAt, $perPage");
			
		
			
			$prd_order=array();
			$products = array();
	

		if( $getorderidsqry->num_rows>0 )	
			 $ordersdata =  $getorderidsqry->rows;
		else
			$ordersdata =  array();
		}
		
elseif($reportparams['filter']=='category')
{
	
	$getorderidsqry = $this->db->query("SELECT op.product_id, date_format(ord.date_added,'%Y-%m-%d') as OrderedOn, cat.name as Category, count(*) as TotalOrders, sum(op.quantity) as TotalProducts, sum(op.total) as Total, CASE WHEN sum(op.tax)>0 THEN sum(op.tax) ELSE '0' END as Tax  FROM oc_order as ord left join oc_order_product as op on op.order_id=ord.order_id left join oc_product_to_category as ptc on ptc.product_id=op.product_id left join oc_category_description as cat on cat.category_id=ptc.category_id where ord.date_added>='".$reportparams['filter_date_start']."' and ord.date_added<='".$reportparams['filter_date_end']."' group by OrderedOn,ptc.category_id  limit $startAt, $perPage");
			
		
			
			$prd_order=array();
			$products = array();
	

		if( $getorderidsqry->num_rows>0 )	
			 $ordersdata =  $getorderidsqry->rows;
		else
			$ordersdata =  array();
		
}
		
		

/*	
echo "<pre>";
print_r($ordersdata);
exit;
*/

//get the default currency

$curr = $this->db->query("SELECT value FROM `oc_setting` WHERE `key`='config_currency'");

if( $curr->row['value'] == "INR")
	$data['Currency'] = 'Rs.';
else
	$data['Currency'] = '$';

if( isset($_GET['page']) )
{
	$slno = ($_GET['page']-1)*10;
	$data['Page'] = $slno;
}
else
	$data['Page'] = 0;


		$data['OrdersData'] = $ordersdata;
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('report/sale_orders', $data));
	}
	
}