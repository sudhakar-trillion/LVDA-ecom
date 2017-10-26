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
	
}//requestdispatcher class ends here