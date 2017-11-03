<?php
class ControllerCatalogproductviewcrosssale extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/product_viewcrosssale');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product');
		$url = '';
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

	$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_add'),
			'href' => $this->url->link('catalog/product_crosssale', 'token=' . $this->session->data['token'] . $url, true)
		);
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('cross_sale_title'),
			'href' => $this->url->link('catalog/product_viewcrosssale', 'token=' . $this->session->data['token'] . $url, true)
		);


		$data['heading_title'] 	=	$this->language->get('cross_sale_title');
		$data['text_add']		=	$this->language->get('text_add');
		$data['heading_title'] 	= 	$this->language->get('heading_title');
		$data['text_list']		=	$this->language->get('text_list');
		
		$data['product_placeholder'] 		=	$this->language->get('product_placeholder');
		$data['rowheading_SLNO'] 	=	$this->language->get('rowheading_SLNO');
		$data['rowheading_ParentProduct'] = $this->language->get('rowheading_ParentProduct');
		$data['rowheading_CrossSaleProduct'] = $this->language->get('rowheading_CrossSaleProduct');
		$data['rowheading_CrossSalePrice'] = $this->language->get('rowheading_CrossSalePrice');
		$data['rowheading_ProductPrice'] = $this->language->get('rowheading_ProductPrice');
		$data['rowheading_Actions'] = $this->language->get('rowheading_Actions');
		
		$data['editcrosssale'] = $this->url->link('catalog/product_editcrosssale', 'token=' . $this->session->data['token'] . $url, true);
		$data['selfpage'] = $this->url->link('catalog/product_viewcrosssale', 'token=' . $this->session->data['token'] . $url, true);
		
		
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}


		$url = '';

	//get the cross sale products list
	$cond = '';
	$ParentProductName='';
	if( isset($this->request->post['ParentProduct']) && $this->request->post['ParentProduct']>0 )
	{
				$this->session->data['crosssaleList'] = trim($this->request->post['ParentProduct']);
				$cond=$this->session->data['crosssaleList'];
				$this->session->data['ParentProductName'] = trim($this->request->post['ParentProductName']);
	}
	

	
	if( isset($this->session->data['crosssaleList']) && $this->session->data['crosssaleList']>0 )
	{
		$cond = $this->session->data['crosssaleList'];
		$ParentProductName = $this->session->data['ParentProductName'];
	}


$data['ParentProductName'] = $ParentProductName;

		$total_res = $this->model_catalog_product->getCrosssaleList($cond,$start='',$limit='',$orderby='',$orderbyfield='');

		$limit=10;


if(isset($_GET['page']))
		$page=(int)$_GET['page'];
	else
		$page=1;
	
	$perPage = $limit;
	
	$totalPages = ceil($total_res/$perPage);
		
	$startAt = $perPage * ($page-1);
		
	
	if( isset( $_GET['page'] ) )
		$accessingPage = $_GET['page'];
	else
		$accessingPage = '1';

	$links='';

if($accessingPage>1)
{

$links.=" <li><a href='index.php?route=catalog/product_viewcrosssale&token=".$data['token'] ."'>First</a></li>";

if($page<=$totalPages)
{
	$prev=$page-1;
	
	if($prev<=0)
	{
		$prev=1;
	}
	
	$links.=" <li><a href='index.php?route=catalog/product_viewcrosssale&token=".$data['token'] ."&page=".$prev."'>Prev</a></li>";
	//$links.="<a href='index.php'>First</a>";
	
}
}



for ($i = $page-5; $i<10+$page-5; $i++) {
		
		   if($i>0 && $i<=$totalPages){
		   
		   //  $links .= "<a href='index.php?page=$i'> $i</a>";
		   
			$links .= ($i != $page ) ? " <li><a href='index.php?route=catalog/product_viewcrosssale&token=".$data['token'] ."&page=".$i."'> $i</a></li> " : "<li class='active'><a >$page</a></li> ";
			
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
			 
			$links=$links." <li><a href='index.php?route=catalog/product_viewcrosssale&token=".$data['token'] ."&page=".$next."'>Next</a></li>";
			
	}
	
	else
	{
			$next=$page+1;
			
			if($next>$totalPages)
			{
				$next=$totalPages;
			}
			$links=$links." <li><a href='index.php?route=catalog/product_viewcrosssale&token=".$data['token'] ."&page=".$next."'>Next</a></li>";
	}
	$links=$links."<li><a href='index.php?route=catalog/product_viewcrosssale&token=".$data['token'] ."&page=".$totalPages."'>Last</a></li>";
}



/* Pagination ends here  */

if($totalPages>1)
	$data['Pagination'] = $links;
else
	$data['Pagination'] = '';	

	

$start = $startAt;

	
		$data['getCrosssaleList'] = $this->model_catalog_product->getCrosssaleList($cond,$start,$limit,$orderby='',$orderbyfield='');
		
		if($data['getCrosssaleList']=="0" && isset($_GET['page']))
		{
			if($_GET['page']>1)
			{
				$pge=$_GET['page']-1;
				if($pge==1)				
					{
						$redpge="http://192.168.0.3/".$_SERVER['PHP_SELF']."?route=catalog/product_viewcrosssale&token=".$this->session->data['token'];
					?>
                    <script>
                	window.location.href="<?PHP echo $redpge;?>";
                </script>
                    <?PHP		
					}
				else
				{
					$redpge =  "http://192.168.0.3/".$_SERVER['PHP_SELF']."?route=catalog/product_viewcrosssale&token=".$this->session->data['token']."&page=".$pge; 
				?>
                <script>
                	window.location.href="<?PHP echo $redpge;?>";
                </script>
                <?PHP
				}
				
				
			}
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/view_product_crosssell', $data));
	
	}


	}
