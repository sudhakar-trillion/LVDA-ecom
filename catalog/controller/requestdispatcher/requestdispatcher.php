<?php
class ControllerRequestdispatcherrequestdispatcher extends Controller 
{
	
	public function getcities()
	{
		
		
		$query = $this->db->query("SELECT City from oc_cities where StateId=".$_GET['state_d']." and  City like'%".$_GET['term']."%'");
		
		if($query->num_rows>0)
		{
			//foreach($query->row)	
#			echo "<pre>"; print_r($query->rows);
			$cities=array();
			
			foreach( $query->rows as $ind=>$val)
			{
				$cities[]=$val['City'];
			}
			echo json_encode($cities);
		}
		
	}
	
	public function resetcustomerpwd()
	{
		$registeredEmail = trim( $this->request->post['forgetpasswordemail']) ;
		
		$this->load->model('account/customer');
		echo $this->model_account_customer->checkcustomerExists($registeredEmail);
	}

	public function login()
	{
		
	
				$this->load->model('account/customer');
			
			//$this->model_account_customer->deleteLoginAttempts($this->request->post['Email']);	
				
		$login_info = $this->model_account_customer->getLoginAttempts($this->request->post['Email']);
	$error=array();
	
		if ($login_info && ($login_info['total'] >= $this->config->get('config_login_attempts')) && strtotime('-1 hour') < strtotime($login_info['date_modified'])) {
			$error['warning'] = $this->language->get('error_attempts');
			echo "-2";
			exit;
		}

		// Check if customer has been approved.
		$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['Email']);

		if ($customer_info && !$customer_info['status'] ) {
			$error['warning'] = $this->language->get('error_approved');
			echo "-1"; exit;
		}

		if (!$error) {
			if (!$this->customer->login($this->request->post['Email'], $this->request->post['Password'])) {
				
				$this->model_account_customer->addLoginAttempt($this->request->post['Email']);
				echo "0";
			} 
			else {
					$this->model_account_customer->deleteLoginAttempts($this->request->post['Email']);
					
					unset($this->session->data['guest']);

					// Default Shipping Address
					$this->load->model('account/address');
					
					if ($this->config->get('config_tax_customer') == 'payment') 
					{
						$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
					}
					
					if ($this->config->get('config_tax_customer') == 'shipping')
					 {
						$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
					}
					
					// Wishlist
					if (isset($this->session->data['wishlist']) && is_array($this->session->data['wishlist'])) 
					{
						$this->load->model('account/wishlist');
						
						foreach ($this->session->data['wishlist'] as $key => $product_id) 
						{
							$this->model_account_wishlist->addWishlist($product_id);
							unset($this->session->data['wishlist'][$key]);
						}
					}
					
					// Add to activity log
					if ($this->config->get('config_customer_activity')) 
					{
						$this->load->model('account/activity');
					
						$activity_data = array(
												'customer_id' => $this->customer->getId(),
												'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
												);
					
						$this->model_account_activity->addActivity('login', $activity_data);
					}
					
					echo "1";
					
				}
		}


	}//login method ends here

public function writereview()
{
	$this->load->model('catalog/review');
	$this->model_catalog_review->addReview($this->request->post['ProductId'], $this->request->post);	
			
	
}
	
	public function productquickview()
	{
		//$this->load->language('extension/module/themecontrol');
		$this->load->model('tool/image');
		
		$product_id = $_POST['ProductId'];	
		
		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);
		$product_info['ProductImg'] = $this->config->get('config_url').'image/'.$product_info['image'];
		
		$product_info['description'] = html_entity_decode($product_info['description']);
		$product_info['meta_title'] = $this->url->link('product/product', 'product_id=' . $product_info['product_id']);
		
		
		if( $this->session->data['currency'] == "INR")
			$product_info['CurrencyCode'] = "Rs";
		else	
			$product_info['CurrencyCode'] = "USD";
		
		$prdoptions = $this->model_catalog_product->getProductOptions($product_id);
		$data = array();
		
		foreach ($prdoptions as $option) 
		{
			
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
						} else {
							$price = false;
						}

						$product_option_value_data[] = array(
							'product_option_value_id' => $option_value['product_option_value_id'],
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							'image'                   => $this->model_tool_image->resize($option_value['image'], 25, 25),
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
					else
					{
						$product_option_value_data[] = array(
							'product_option_value_id' => @$option_value['product_option_value_id'],
							'option_value_id'         => @$option_value['product_option_value'],
							'name'                    => @$option_value['name'],
							'image'                   => $this->model_tool_image->resize(@$option_value['image'], 50, 50),
							'price'                   => @$price,
							'price_prefix'            => @$option_value['price_prefix']
						);
					}
					
				}

				$data['optns'][] = array(
					'product_option_id'    => $option['product_option_id'],
					'product_option_value' => $product_option_value_data,
					'option_id'            => $option['option_id'],
					'name'                 => $option['name'],
					'type'                 => $option['type'],
					'value'                => $option['value'],
					'required'             => $option['required']
				);
			
		}
		
		
		$product_info['Options'] = $data;
			
		echo json_encode($product_info);
		
		
	}

	public function getproducts()
	{
	$count = 0;
	$data = '';
	if(strlen($_GET['term'])>0)
	{
	   $this->load->model('catalog/category');
	   
	  $result = $this->model_catalog_category->getSearch($_GET);
	  $arr = array();
	  $count = count($result);
	  foreach($result as $row)
	  {
		  
		 $arr[]= '<li><a href="'.$this->config->get('config_url').str_replace(" ","-",strtolower($row['keyword'])).'">'.str_replace("-"," ",$row['keyword']).' </a></li>'; 
	  }
	}
	
	
	//$arr = array('count' => $count, 'data' => $data);
    echo json_encode($arr);	
	}
	
	public function addremovecrosssale()
	{
		echo "<pre>";	
			print_r( $_POST );
		exit;
	}
	
	public function notifyrestore()
	{
		extract($_POST);
		
		$this->load->model('catalog/product');
		
		$resp = $this->model_catalog_product->notifyrestore($Product,$UserEmail);
		
		if($resp>0)
		echo "1";
		else if($resp=='-1')
			echo "-1";
		else
			echo "0";
	}
	
	public function checkcartexpiryTime()
	{
		if( isset($this->session->data['mastersession']) )
		{
			
			$mastersession  = $this->session->data['mastersession'];
			
			$data = $this->db->query("SELECT ExpireBy from oc_temp_cart where User_Master_Session='".$mastersession."' order by TempId DESC limit 1");
			
			if($data->num_rows>0)
			{
				$timenow = time()+300;

				//echo $data->row['ExpireBy']-$timenow; exit; 
				
				if( ($data->row['ExpireBy']-$timenow)<=300 )
					{
						if( ($data->row['ExpireBy']-$timenow)<300)
							{
								 $this->cartexpires($mastersession);
								 unset($this->session->data['mastersession']);
								 echo "deleted";
							}
						else
							echo "yes";
						
					}
				else
					if($data->row['ExpireBy']<=($timenow-300))
					{
						 $this->cartexpires($mastersession);
						 echo "no";
					}
					else				
						echo "no";
			}
			else
				echo "ssrno";
			
		}
		else
			echo "no";
	}
	
	public function cartexpires($mastersession)
	{
		//now delete the cart itmes and rollback the products which are in this session
		//get the products ids of this cart
						
		$prdcts_cart = $this->db->query("SELECT  ProductId, Quantity from oc_temp_cart where User_Master_Session='".$mastersession."' ");

		if($prdcts_cart->num_rows>0)
		{
			foreach($prdcts_cart->rows as $prdcts)	
			{
				//add the quantity to the quantity of the product in the product table
				
				$quanty = $this->db->query("Select quantity from oc_product where product_id=".$prdcts['ProductId']);
				if($quanty->num_rows>0)
				{
					
					$this->db->query(" UPDATE oc_product SET quantity=".(($quanty->row['quantity'])+$prdcts['Quantity'])." where  product_id=".$prdcts['ProductId']);
					$this->db->query("DELETE FROM oc_temp_cart where User_Master_Session='".$mastersession."' and ProductId=".$prdcts['ProductId']);						
					foreach ($this->cart->getProducts() as $product) 
					{
						if( $product['product_id']==$prdcts['ProductId'])		
							$this->db->query("DELETE FROM oc_cart where cart_id=".$product['cart_id']." and session_id='".$_COOKIE['PHPSESSID']."'");
					}
						
						
				}
					
			}
			return "deleted";
				
		}
		else
			return "no";
						
							
						
	
	}
	
	public function getcartitems()
	{
		$cartitems = $this->cart->getProducts();
		$quantity = 0;
		if( sizeof($cartitems)>0)
		{
			
			foreach($cartitems as $prdct)
			{
				$quantity = $quantity+$prdct['quantity'];
			}
		}
		echo $quantity;
		
			}
			
	public function extendcartexpire()
	{
		

		$totalsessions = $this->session->data;
		
		$sessionId =  $_COOKIE['PHPSESSID'];
				
		if( array_key_exists("customer_id",$totalsessions) )
			$User_Master_Session = $this->session->data['customer_id'];
		else
			$User_Master_Session = $this->session->data['mastersession'];
			
		$qrey = $this->db->query("SELECT ExpireBy from oc_temp_cart where User_Master_Session='".$User_Master_Session."' ");	
		
		//echo "SELECT ExpireBy from oc_temp_cart where User_Master_Session='".$User_Master_Session."' "; exit; 
		
		$ExpireBy = $qrey->row['ExpireBy'];
		
		
		
		if($_GET['action'] =='extend' )
			{
				$ExpireBy =$ExpireBy+300;	
				$this->db->query("update oc_temp_cart set ExpireBy=".$ExpireBy." where User_Master_Session='".$User_Master_Session."' ");
			}
			
		if($_GET['action'] =='destroy' )
			$this->cartexpires($User_Master_Session);
	
			
		
			
		
	}
			
	
}//requestdispatcher class ends here