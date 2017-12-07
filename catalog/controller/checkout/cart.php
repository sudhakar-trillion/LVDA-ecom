<?php
class ControllerCheckoutCart extends Controller {
	public function index() {
		$this->load->language('checkout/cart');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home'),
			'text' => $this->language->get('text_home')
		);

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('checkout/cart'),
			'text' => $this->language->get('heading_title')
		);
		
		if( isset($this->session->data['EditQuantExceeds']))
			{
				$data['EditQuantExceeds'] = $this->session->data['EditQuantExceeds'];			
				unset($this->session->data['EditQuantExceeds']);
			}
		else
			$data['EditQuantExceeds'] = '';
		
		if( isset( $this->session->data['productQuantinstock'] ) )
		{
			$data['productQuantinstock'] = $this->session->data['productQuantinstock'];
			unset($this->session->data['productQuantinstock']);
		}
		else
			$data['productQuantinstock'] = '';
		
		if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_recurring_item'] = $this->language->get('text_recurring_item');
			$data['text_next'] = $this->language->get('text_next');
			$data['text_next_choice'] = $this->language->get('text_next_choice');

			$data['column_image'] = $this->language->get('column_image');
			$data['column_name'] = $this->language->get('column_name');
			$data['column_model'] = $this->language->get('column_model');
			$data['column_quantity'] = $this->language->get('column_quantity');
			$data['column_price'] = $this->language->get('column_price');
			$data['column_total'] = $this->language->get('column_total');

			$data['button_update'] = $this->language->get('button_update');
			$data['button_remove'] = $this->language->get('button_remove');
			$data['button_shopping'] = $this->language->get('button_shopping');
			$data['button_checkout'] = $this->language->get('button_checkout');

			if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
				$data['error_warning'] = $this->language->get('error_stock');
			} elseif (isset($this->session->data['error'])) {
				$data['error_warning'] = $this->session->data['error'];

				unset($this->session->data['error']);
			} else {
				$data['error_warning'] = '';
			}

			if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
				$data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
			} else {
				$data['attention'] = '';
			}

			if (isset($this->session->data['success'])) {
				$data['success'] = $this->session->data['success'];

				unset($this->session->data['success']);
			} else {
				$data['success'] = '';
			}

				$data['action'] = $this->url->link('checkout/cart/edit', '', true);
				//$data['action'] = $this->createLink('my-cart/edit');

			if ($this->config->get('config_cart_weight')) {
				$data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
			} else {
				$data['weight'] = '';
			}

			$this->load->model('tool/image');
			$this->load->model('tool/upload');

			$data['products'] = array();

			$products = $this->cart->getProducts();
			
			foreach ($products as $product) {
				$product_total = 0;

				foreach ($products as $product_2) {
					if ($product_2['product_id'] == $product['product_id']) {
						$product_total += $product_2['quantity'];
					}
				}

				if ($product['minimum'] > $product_total) {
					$data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
				}

				if ($product['image']) {
					$image = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_cart_width'), $this->config->get($this->config->get('config_theme') . '_image_cart_height'));
				} else {
					$image = '';
				}

				$option_data = array();

				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$value = $upload_info['name'];
						} else {
							$value = '';
						}
					}

					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
					);
				}
				
			$checkspecial = $this->db->query("SELECT price FROM oc_product_special where product_id=".$product['product_id']);
			if( $checkspecial->num_rows>0)
			{
			$specialprice=(int)$checkspecial->row['price'];
			
			}
			else
			{
			$specialprice='';
			}

				
				// Display prices
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					
					#echo $product['price'].":".$specialprice; exit; 
					
					if( $specialprice!='')
						$price = $this->currency->format( $this->tax->calculate($specialprice, $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					else
						$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				// Display prices
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					if( $specialprice!='')
						$total = $this->currency->format($this->tax->calculate($specialprice, $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity'], $this->session->data['currency']);
					else
					$total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity'], $this->session->data['currency']);
				} else {
					$total = false;
				}

				$recurring = '';

				if ($product['recurring']) {
					$frequencies = array(
						'day'        => $this->language->get('text_day'),
						'week'       => $this->language->get('text_week'),
						'semi_month' => $this->language->get('text_semi_month'),
						'month'      => $this->language->get('text_month'),
						'year'       => $this->language->get('text_year'),
					);

					if ($product['recurring']['trial']) {
						$recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
					}

					if ($product['recurring']['duration']) {
						$recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					} else {
						$recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					}
				}

			if( $this->session->data['currency'] == "INR")
				$data['Currency'] = "Rs.";
			else
				$data['Currency'] = $this->session->data['currency'];
			

				$data['products'][] = array(
					'cart_id'   => $product['cart_id'],
					'thumb'     => $image,
					'name'      => $product['name'],
					'model'     => $product['model'],
					'option'    => $option_data,
					'recurring' => $recurring,
					'quantity'  => $product['quantity'],
					'stock'     => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
					'reward'    => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
					'price'     => $price,
					'specialprice'=>$specialprice,
					'total'     => $total,
					'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id']),
					"CrossSell" => $product['CrossSell']
				);
			}

			// Gift Voucher
			$data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $key => $voucher) {
					$data['vouchers'][] = array(
						'key'         => $key,
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'], $this->session->data['currency']),
						'remove'      => $this->url->link('checkout/cart', 'remove=' . $key)
					);
				}
			}

			// Totals
			$this->load->model('extension/extension');

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;
			
			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);
			
			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('total/' . $result['code']);
						
						// We have to put the totals in an array so that they pass by reference.
						$this->{'model_total_' . $result['code']}->getTotal($total_data);
					}
				}

				$sort_order = array();

				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $totals);
			}

			$data['totals'] = array();

			foreach ($totals as $total) {
				$data['totals'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'], $this->session->data['currency'])
				);
			}

			$data['continue'] = $this->createLink('');//$this->url->link('common/home');

			//$data['checkout'] = $this->url->link('checkout/checkout', '', true);
			
			
			$data['checkout'] = $this->createLink('checkout');
			

			$this->load->model('extension/extension');

			$data['modules'] = array();
			
			$files = glob(DIR_APPLICATION . '/controller/total/*.php');

			if ($files) {
				foreach ($files as $file) {
					$result = $this->load->controller('total/' . basename($file, '.php'));
					
					if ($result) {
						$data['modules'][] = $result;
					}
				}
			}

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('checkout/cart', $data));
		} else {
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_error'] = $this->language->get('text_empty');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			unset($this->session->data['success']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function add() {
		$this->load->language('checkout/cart');

		$json = array();

		if (isset($this->request->post['product_id'])) 
			$product_id = (int)$this->request->post['product_id'];
		else 
			$product_id = 0;
		
		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);
	
	
		$quantity = (int)$this->request->post['quantity'];
		$err='0';
		
		if( $product_info['quantity'] <=1 )
		{
				$json['error']['Outofstock'] = "Product Out Of Stock";
				$this->response->addHeader('Content-Type: application/json');
				$this->response->setOutput(json_encode($json));
		
		}
		else
		{
		//	echo ($product_info['quantity']-1).":".$quantity; exit;
			
			if( ($product_info['quantity']-1)<$quantity  )
			{
				$json['error']['Outofstock'] = "Quantity which you are trying to add is not available";
				$this->response->addHeader('Content-Type: application/json');
				$this->response->setOutput(json_encode($json));	
				$err='1';
			}
			else
				$err='0';
			
		}

		if ($product_info && $err=='0') {
			if (isset($this->request->post['quantity']) && ((int)$this->request->post['quantity'] >= $product_info['minimum'])) {
				$quantity = (int)$this->request->post['quantity'];
			} 
			else 
			{
				$quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
			}

			if (isset($this->request->post['option'])) {
				$option = array_filter($this->request->post['option']);
			} else {
				$option = array();
			}

			$product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);

			foreach ($product_options as $product_option) {
				if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
					$json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
				}
			}

			if (isset($this->request->post['recurring_id'])) {
				$recurring_id = $this->request->post['recurring_id'];
			} else {
				$recurring_id = 0;
			}

			$recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);

			if ($recurrings) {
				$recurring_ids = array();

				foreach ($recurrings as $recurring) {
					$recurring_ids[] = $recurring['recurring_id'];
				}

				if (!in_array($recurring_id, $recurring_ids)) {
					$json['error']['recurring'] = $this->language->get('error_recurring_required');
				}
			}

			if (!$json) 
			{
				$crosssale="";
				$parentProduct="";
				if( isset($this->request->post['crosssale']) )	
				{
					$crosssale = $this->request->post['crosssale'];
					$parentProduct = $this->request->post['parentProduct'];
				}
			
				
				$prdinf = $this->model_catalog_product->getProduct($this->request->post['product_id']);
				
				$TotalproductQuantity = $prdinf['quantity'];
				
				$productsincart = $this->cart->getProducts();
				
				/*echo "<pre>";
				print_r($productsincart);
				echo "</pre>"*/;

				$prdqntyincart='0';
				$master_exists="no";
				
					if(sizeof($productsincart)>0)
						{
							foreach( $productsincart as $prdct)
							{
								if( in_array($this->request->post['product_id'], $prdct ) )
								{
									$prdqntyincart = $prdct['quantity']	;
						//			echo $prdqntyincart.":".$TotalproductQuantity;
							//		exit;
								}
							}
							
						}
					else
						$prdqntyincart = $this->request->post['quantity']; 
					
//					echo $prdqntyincart.":".$TotalproductQuantity; exit; 
					if(  (($prdqntyincart)+1)<=( ($prdqntyincart)+($TotalproductQuantity)-1) )
					{
						$resp = $this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id,$crosssale,$parentProduct);
						
						$productsincart = $this->cart->getProducts();
			
						foreach( $productsincart as $prdct)
							{
								if( in_array($this->request->post['product_id'], $prdct ) )
									$prdqntyincart = $prdct['quantity']	;
							}
						
							$totalsessions = $this->session->data;
							
							
							if( array_key_exists("customer_id",$totalsessions) )
							{
								if(  array_key_exists("mastersession",$totalsessions)  )	
										$master_exists="yes";
								else
								{
									$master_exists="no";
									if( !array_key_exists('customersess',$totalsessions) )
										$this->session->data['customersess'] = $this->session->data['customer_id']."_".time();
								}
							}
							else
							{
								if(  !array_key_exists("mastersession",$totalsessions)  )
								{	
									$this->session->data['mastersession'] = "master_".time();
									$master_exists="no";
								}
									
							}
							
						
							//now add the product to the temp table for holding product for some time ( say 15 mins ) under this mastersession
								//and reduce the quantity of items for tempory from the products table	if user does not purchase the product with-in the time then add quantity of  the prdocuts to the table.
								
								//now update the quanityt of products to products table
								
				$response =	$this->model_catalog_product->updateQuantity($productsincart,$quantity,$master_exists,$this->request->post['product_id'],'add');
						
						
					if($response>0)
					{
						//$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));
				
				$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->config->get('config_url')."my-cart" );

				// Unset all shipping and payment methods
				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);

				// Totals
				$this->load->model('extension/extension');

				$totals = array();
				$taxes = $this->cart->getTaxes();
				$total = 0;
		
				// Because __call can not keep var references so we put them into an array. 			
				$total_data = array(
					'totals' => &$totals,
					'taxes'  => &$taxes,
					'total'  => &$total
				);
				
				
				
				// Display prices
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$sort_order = array();

					$results = $this->model_extension_extension->getExtensions('total');

					foreach ($results as $key => $value) {
						$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
					}

					array_multisort($sort_order, SORT_ASC, $results);

					foreach ($results as $result) {
						if ($this->config->get($result['code'] . '_status')) {
							$this->load->model('total/' . $result['code']);

							// We have to put the totals in an array so that they pass by reference.
							$this->{'model_total_' . $result['code']}->getTotal($total_data);
						}
					}

					$sort_order = array();

					foreach ($totals as $key => $value) {
						$sort_order[$key] = $value['sort_order'];
					}

					array_multisort($sort_order, SORT_ASC, $totals);
				}

				$json['total'] =  sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
			
					$this->response->addHeader('Content-Type: application/json');
					$this->response->setOutput(json_encode($json));
					}
						else
						{
							
							foreach( $productsincart as $prdct)
							{
								if( in_array($this->request->post['product_id'], $prdct ) )
									$prdct['quantity'] =$prdct['quantity']-$this->request->post['quantity']	;
							}
							
							$json=array();
							if( $response=="-10")
								$json['error']['Outofstock'] = " Invalid request ";
							if( $response=="0")
								$json['error']['Outofstock'] = " Unable to add due to database issues ";
							$this->response->addHeader('Content-Type: application/json');
							$this->response->setOutput(json_encode($json));	
						}
					
							
					}
					else
						{
							$json=array();
							$json['error']['Outofstock'] = " Quantity which you are trying to add is not available ";
							$this->response->addHeader('Content-Type: application/json');
							$this->response->setOutput(json_encode($json));	
							
						}
							
			}
			else
			{
				//$json['error']['Outofstock'] = " Cannot accept more quanity on this product ";
							$this->response->addHeader('Content-Type: application/json');
							$this->response->setOutput(json_encode($json));	
			}
		}
	}

	public function edit() {
		$this->load->language('checkout/cart');

		$this->load->model('catalog/product');

		$json = array();
		
		$prdqntyincart='0';
		$productsincart = $this->cart->getProducts();
		

		// Update
		if (!empty($this->request->post['quantity'])) {
			foreach ($this->request->post['quantity'] as $key => $value) 
			{
				$prdinfo = $this->db->query("SELECT product_id from ".DB_PREFIX."cart where cart_id=".$key);
				
				$product_id = $prdinfo->row['product_id'];
				$editquantity = $value;
				
				
				$prdinf = $this->model_catalog_product->getProduct($product_id);
				
				foreach( $productsincart as $prdct)
					{
						if( in_array($product_id, $prdct ) )
							$prdqntyincart = $prdct['quantity']	;
					}
				
				//echo $prdqntyincart.":$editquantity:";
				
				if($editquantity==0)
					$editquantity = $prdqntyincart;
			
				if( $editquantity<( ($prdinf['quantity']) +$prdqntyincart) || $editquantity==$prdqntyincart )
				{
					//echo $editquantity; exit; 
					$this->cart->update($key, $value);
				}
				else
				{	
					$this->session->data['productQuantinstock'] = $key;
					$this->session->data['EditQuantExceeds'] = '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> Desired quantity for product **** is not in stock!</div>';
				}
				
				
				//$this->db->query("UPDATE " . DB_PREFIX . "cart SET quantity = '" . (int)$quantity . "' WHERE cart_id = '" . (int)$cart_id . "' AND customer_id = '" . (int)$this->customer->getId() . "' AND session_id = '" . $this->db->escape($this->session->getId()) . "'");
				
				
				//echo "UPDATE " . DB_PREFIX . "cart SET quantity = '" . (int)$quantity . "' WHERE cart_id = '" . (int)$cart_id . "' AND customer_id = '" . (int)$this->customer->getId() . "' AND session_id = '" . $this->db->escape($this->session->getId()) . "'";
				
				
				
				$master_exists="no";
				
					
				
						
							$totalsessions = $this->session->data;
							
							if( array_key_exists("customer_id",$totalsessions) )
							{
								if(  array_key_exists("mastersession",$totalsessions)  )	
										$master_exists="yes";
								else
								{
									$master_exists="no";
									if( !array_key_exists('customersess',$totalsessions) )
										$this->session->data['customersess'] = $this->session->data['customer_id']."_".time();
								}
							}
							else
							{
								if(  !array_key_exists("mastersession",$totalsessions)  )
								{	
									$this->session->data['mastersession'] = "master_".time();
									$master_exists="no";
								}
									
							}
						
						
						//echo $editquantity."::".$prdqntyincart; exit; 
						
						if( $editquantity<( ($prdinf['quantity']) +$prdqntyincart) || $editquantity==$prdqntyincart )
						{
						
							$this->model_catalog_product->updateQuantity($productsincart,$editquantity,$master_exists,$product_id,'edit');
						}

							
				
			}
//exit;
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			//$this->response->redirect($this->url->link('checkout/cart'));
			$this->response->redirect($this->createLink('my-cart'));
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function remove() {
		$this->load->language('checkout/cart');
		$this->load->model('catalog/product');

		$json = array();
		$productsincart = $this->cart->getProducts();
		// Remove
		if (isset($this->request->post['key'])) {
			
			$prdinfo = $this->db->query("SELECT product_id from ".DB_PREFIX."cart where cart_id=".$this->request->post['key']);
		/*echo "<pre>";
		print_r($prdinfo);
		exit;*/
			$this->request->post['product_id'] = $prdinfo->row['product_id'];
			
			if( isset($this->request->post['remove']) )
				$this->cart->remove($this->request->post['key'],$this->request->post['remove']);
			else
			$this->cart->remove($this->request->post['key'],'');

			unset($this->session->data['vouchers'][$this->request->post['key']]);

			$this->session->data['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			// Totals
			$this->load->model('extension/extension');

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;

			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);

			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('total/' . $result['code']);

						// We have to put the totals in an array so that they pass by reference.
						$this->{'model_total_' . $result['code']}->getTotal($total_data);
					}
				}

				$sort_order = array();

				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $totals);
			}

			$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
		}
		
		
		
			$prdinf = $this->model_catalog_product->getProduct($this->request->post['product_id']);
			$TotalproductQuantity = $prdinf['quantity'];
				
				/*echo "<pre>";
				print_r($productsincart);
				echo "</pre>"*/;

				$prdqntyincart='0';
				$master_exists="no";
				
					if(sizeof($productsincart)>0)
						{
							foreach( $productsincart as $prdct)
							{
								if( in_array($this->request->post['product_id'], $prdct ) )
									$prdqntyincart = $prdct['quantity']	;
							}
							
						}
					else
						$prdqntyincart = $this->request->post['quantity']; 
			
					//	$resp = $this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id,$crosssale,$parentProduct);
			
						foreach( $productsincart as $prdct)
							{
								if( in_array($this->request->post['product_id'], $prdct ) )
									$prdqntyincart = $prdct['quantity']	;
							}
						
							$totalsessions = $this->session->data;
							
							if( array_key_exists("customer_id",$totalsessions) )
							{
								if(  array_key_exists("mastersession",$totalsessions)  )	
										$master_exists="yes";
								else
								{
									$master_exists="no";
									if( !array_key_exists('customersess',$totalsessions) )
										$this->session->data['customersess'] = $this->session->data['customer_id']."_".time();
								}
							}
							else
							{
								if(  !array_key_exists("mastersession",$totalsessions)  )
								{	
									$this->session->data['mastersession'] = "master_".time();
									$master_exists="no";
								}
									
							}
					
		$this->model_catalog_product->updateQuantity($productsincart,$prdqntyincart,$master_exists,$this->request->post['product_id'],'remove');


		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function createLink($term)
	{
		return $this->config->get('config_url').$term;	
	}

}
