<?php

class ControllerAccountTrisociallogin extends Controller {
	private $error = array();

	public function index() 
	{
		
		$this->load->model('account/customer');
		
	/*
	
		echo "<Pre>";
		print_r( $_SESSION['GmailUserProfile']);
		exit; 
	*/
	
	
		
		//check whether the social login user already exists with us.
		
		$SocialLoginEmail='';
		
		
		
		foreach( $_SESSION['GmailUserProfile'] as $ind=>$val )
			{
			
				if($ind!="__PHP_Incomplete_Class_Name")
				{
					
					if( $ind=='email')
					{
						$SocialLoginEmail = $val;
					}
				}
			}
	
	
	//get the custome id
	
	$qry = $this->db->query("select customer_id from oc_customer where email='".$SocialLoginEmail."'");
	if($qry->num_rows>0)
	{
		if ($this->login_customer ($qry->row['customer_id']))
			$this->response->redirect($this->config->get('config_url').'my-account');
	}
	
//if user is for first time		
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate())
		{
			// Read Customer Data
			$customer_data = $this->request->post;
			
			// Add Password
			$customer_data['password'] = $this->generate_hash (8);
			
				$customer_data['company'] = '';
				$customer_data['address_1'] = '';
				$customer_data['address_2'] = '';
				$customer_data['city'] = '';
				$customer_data['postcode'] = '';
				$customer_data['country_id'] = 0;
				$customer_data['zone_id'] = 0;				
			
				$customer_data['socilalogin']='yes';
			
			// Create Customer
			$customer_id = $this->model_account_customer->addCustomer($customer_data);
			
		#	echo $customer_id; exit; 
			
			//written by sudhakar
			
			if (is_numeric ($customer_id))
						{
							
							// Everything OK
							if ($this->login_customer ($customer_id))
							{
							
								$this->response->redirect($this->config->get('config_url').'my-account');
							}
							
						}
			
			
			//till here
			
			
			// Custom Group Set
			if ( ! $this->is_default_group_behaviour())
			{
				// Custom Group			
				$customer_group_id = $this->config->get('oneall_customer_group');
					
				// Force the group, as addCustomer only sets it if groups are displayed on the frontend
				if (is_numeric ($customer_group_id))
				{
					$result = $this->db->query("UPDATE " . DB_PREFIX . "customer SET customer_group_id='" . intval ($customer_group_id) . "' WHERE customer_id='" . intval ($customer_id) . "'");
				}
			}	
			
			// Link the customer to this social network.
			if ($this->link_tokens_to_customer_id ($customer_id, $user_data ['user_token'], $user_data ['identity_token'], $user_data ['identity_provider']) !== false)
			{
				// Login
				if ($this->login_customer($customer_id))
				{				
					// Update statistics
					$this->count_login_identity_token ($user_data ['identity_token']);
					
					// Remove Session Data
					unset ($this->session->data['oneall_user_data']);
					
					// Redirect Target
					if (isset($this->request->post['oa_redirect']) && strlen (trim ($this->request->post['oa_redirect'])) > 0)
					{
						$redirect_to = trim ($this->request->post['oa_redirect']);
					}
					else
					{
						$redirect_to = 'account/success';
					}
					
					// Redirect User
					$this->response->redirect($this->url->link($redirect_to, '', true));
				}
			}
		
		
		
		}
		
		
		$data = array_merge ($this->load->language('account/register'), $this->load->language('extension/module/oneall'));
		
		$data['oa_heading_desc'] = 'PLEASE TAKE A MINUTE TO VERIFY YOUR <strong style="font-weight:600; color:#f00">SOCIAL LOGIN </strong>DETAILS';
		
		
		$data['error_warning'] = (isset($this->error['warning']) ? $this->error['warning'] : '');
		$data['error_firstname'] = (isset($this->error['firstname']) ? $this->error['firstname'] : '');
		$data['error_lastname'] = (isset($this->error['lastname']) ? $this->error['lastname'] : '');
		$data['error_email'] = (isset($this->error['email']) ? $this->error['email'] : '');
		$data['error_telephone'] = (isset($this->error['telephone']) ? $this->error['telephone'] : '');
		$data['error_address_1'] = (isset($this->error['address_1']) ? $this->error['address_1'] : '');
		$data['error_city'] = (isset($this->error['city']) ? $this->error['city'] : '');
		$data['error_postcode'] = (isset($this->error['postcode']) ? $this->error['postcode'] : '');
		$data['error_country'] = (isset($this->error['country']) ? $this->error['country'] : '');
		$data['error_zone'] = (isset($this->error['zone']) ? $this->error['zone'] : '');
		$data['error_custom_field'] = (isset($this->error['custom_field']) ? $this->error['custom_field'] : '');
		
		$data['action'] = $this->config->get('config_url').'social-login-register';
		$data['oneall_ask_address'] = $this->config->get ('oneall_ask_address');
	
		
		//check whether social login user already exists or not
		
		// First Name
		if (isset($this->request->post['firstname']))
		{
			$data['firstname'] = $this->request->post['firstname'];
		} 
		else
		{
			// Restore from social network profile
			if ( ! empty ($user_data['user_first_name']))
			{
				$data['firstname'] = $user_data['user_first_name'];
			}
			else
			{
				$data['firstname'] = '';
			}
		}

		// Last Name
		if (isset($this->request->post['lastname']))
		{
			$data['lastname'] = $this->request->post['lastname'];
		}
		else
		{
			// Restore from social network profile
			if ( ! empty ($user_data ['user_last_name']))
			{
				$data['lastname'] = $user_data ['user_last_name'];
			}
			else
			{
				$data['lastname'] = '';
			}
		}
	
		// Email
		if (isset($this->request->post['email']))
		{
			$data['email'] = $this->request->post['email'];
		}
		else
		{
			// Restore from social network profile
			if ( ! empty ($user_data ['user_email']))
			{
				$data['email'] = $user_data ['user_email'];
			}
			else
			{
				$data['email'] = '';
			}
		}
	
		// Telephone Number
		if (isset($this->request->post['telephone']))
		{
			$data['telephone'] = $this->request->post['telephone'];
		}
		else
		{
			$data['telephone'] = '';
		}
	
		// Fax Number
		if (isset($this->request->post['fax']))
		{
			$data['fax'] = $this->request->post['fax'];
		}
		else
		{
			$data['fax'] = '';
		}
	
		// Company Name
		if (isset($this->request->post['company']))
		{
			$data['company'] = $this->request->post['company'];
		}
		else
		{
			$data['company'] = '';
		}
	
		// Adresse Line 1
		if (isset($this->request->post['address_1']))
		{
			$data['address_1'] = $this->request->post['address_1'];
		}
		else
		{
			$data['address_1'] = '';
		}
		
		// Adresse Line 2
		if (isset($this->request->post['address_2']))
		{
			$data['address_2'] = $this->request->post['address_2'];
		}
		else
		{
			$data['address_2'] = '';
		}
	
		// Postal Code
		if (isset($this->request->post['postcode']))
		{
			$data['postcode'] = $this->request->post['postcode'];
		} 
		elseif (isset($this->session->data['shipping_address']['postcode']))
		{
			$data['postcode'] = $this->session->data['shipping_address']['postcode'];
		}
		else
		{
			$data['postcode'] = '';
		}
	
		// City
		if (isset($this->request->post['city']))
		{
			$data['city'] = $this->request->post['city'];
		}
		else
		{
			$data['city'] = '';
		}
	
		// Country
		if (isset($this->request->post['country_id']))
		{
			$data['country_id'] = $this->request->post['country_id'];
		} 
		elseif (isset($this->session->data['shipping_address']['country_id']))
		{
			$data['country_id'] = $this->session->data['shipping_address']['country_id'];
		}
		else
		{
			$data['country_id'] = $this->config->get('config_country_id');
		}
	
		// Zone
		if (isset($this->request->post['zone_id']))
		{
			$data['zone_id'] = $this->request->post['zone_id'];
		}
		elseif (isset($this->session->data['shipping_address']['zone_id']))
		{
			$data['zone_id'] = $this->session->data['shipping_address']['zone_id'];
		}
		else
		{
			$data['zone_id'] = '';
		}
		
		// Redirect
		if (isset($this->request->post['oa_redirect']))
		{
			$data['oa_redirect'] = $this->request->post['oa_redirect'];
		}
		else
		{		
			if (isset ($this->request->get['oa_redirect']))
			{
				$data['oa_redirect'] = $this->request->get['oa_redirect'];
			}
			else
			{
				$data['oa_redirect'] = '';
			}
		}
	
		// Country List
		$this->load->model('localisation/country');	
		$data['countries'] = $this->model_localisation_country->getCountries();
	
		// Custom Fields
		$this->load->model('account/custom_field');	
		$data['custom_fields'] = $this->model_account_custom_field->getCustomFields();
	
		if (isset($this->request->post['custom_field']))
		{
			if (isset($this->request->post['custom_field']['account']))
			{
				$account_custom_field = $this->request->post['custom_field']['account'];
			}
			else
			{
				$account_custom_field = array();
			}
	
			if (isset($this->request->post['custom_field']['address']))
			{
				$address_custom_field = $this->request->post['custom_field']['address'];
			}
			else
			{
				$address_custom_field = array();
			}
	
			$data['register_custom_field'] = $account_custom_field + $address_custom_field;
		}
		else
		{
			$data['register_custom_field'] = array();
		}
	
		// Newsletter	
		if (isset($this->request->post['newsletter']))
		{
			$data['newsletter'] = $this->request->post['newsletter'];
		}
		else
		{
			$data['newsletter'] = '';
		}
		
		
		
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
				
		// Display Template
		$this->response->setOutput ($this->load->view ('account/socialregister', $data));


		
	}



private function validate()
	{
		if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32))
		{
			$this->error['firstname'] = $this->language->get('error_firstname');
		}
	
		if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32))
		{
			$this->error['lastname'] = $this->language->get('error_lastname');
		}
	
		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email']))
		{
			$this->error['email'] = $this->language->get('error_email');
		}
	
		if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email']))
		{
			$this->error['warning'] = $this->language->get('error_exists');
		}
	
		if ((utf8_strlen($this->request->post['telephone']) < 9) )
		{
			$this->error['telephone'] = 'Contact number should be of 10 characters';
		}
	
		// Check Address?
		if ($this->config->get ('oneall_ask_address') <> 0)
		{		
			if ((utf8_strlen(trim($this->request->post['address_1'])) < 3) || (utf8_strlen(trim($this->request->post['address_1'])) > 128))
			{
				$this->error['address_1'] = $this->language->get('error_address_1');
			}
	
			if ((utf8_strlen(trim($this->request->post['city'])) < 2) || (utf8_strlen(trim($this->request->post['city'])) > 128))
			{
				$this->error['city'] = $this->language->get('error_city');
			}
	
			$this->load->model('localisation/country');
	
			$country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);
	
			if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10))
			{
				$this->error['postcode'] = $this->language->get('error_postcode');
			}
	
			if ($this->request->post['country_id'] == '')
			{
				$this->error['country'] = $this->language->get('error_country');
			}
	
			if (!isset($this->request->post['zone_id']) || $this->request->post['zone_id'] == '')
			{
				$this->error['zone'] = $this->language->get('error_zone');
			}
		}
	
		// Default Group
		if ($this->is_default_group_behaviour())
		{
			if (isset($this->request->post['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->post['customer_group_id'], $this->config->get('config_customer_group_display')))
			{
				$customer_group_id = $this->request->post['customer_group_id'];
			}
			else
			{
				$customer_group_id = $this->config->get('config_customer_group_id');
			}
		}
		// Custom Group
		else 
		{
			$customer_group_id = $this->config->get('oneall_customer_group');
		}
	
		// Custom field validation
		$this->load->model('account/custom_field');	
		$custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);
	
		foreach ($custom_fields as $custom_field)
		{
			if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']]))
			{
				$this->error['custom_field'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
			}
		}
	
		// Done
		return !$this->error;
	}	


	protected function is_default_group_behaviour ()
	{
		// Read Group
		$oneall_customer_group = trim (strval ($this->config->get('oneall_customer_group')));
		
		// Default Group
		if (empty ($oneall_customer_group) || strtolower ($oneall_customer_group) == 'store_config')
		{
			return true;
		}
		
		// Custom Group
		return false;
	}


	// Login a customer
	protected function login_customer($customer_id)
	{
		// Retrieve the customer
		$result = $this->db->query ("SELECT email FROM `" . DB_PREFIX . "customer` WHERE customer_id = '" . intval ($customer_id) . "'")->row;
		if (is_array ($result) && ! empty ($result['email']))
		{
			// Login		
			if ($this->customer->login($result['email'], '', true))
			{
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
		
				// Add to activity log
				$this->load->model('account/activity');
		
				$activity_data = array(
					'customer_id' => $this->customer->getId(),
					'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
				);
	
				$this->model_account_activity->addActivity('login', $activity_data);
			
				// Logged in
				return true;
			}
		}
		
		// Not logged in
		return false;		
	}
	
		// Counts a login for the identity token	
	public function count_login_identity_token ($identity_token)
	{
		$sql = "UPDATE `" . DB_PREFIX . "oasl_identity` SET num_logins=num_logins+1, date_updated=NOW() WHERE identity_token = '" .  $this->db->escape ($identity_token) . "' LIMIT 1";
		$query =$this->db->query ($sql);
	}

// Generates a random hash of the given length
	protected function generate_hash ($length)
	{
		$hash = '';
	
		for($i = 0; $i < $length; $i ++)
		{
			do
			{
				$char = chr (mt_rand (48, 122));
			}
			while ( !preg_match ('/[a-zA-Z0-9]/', $char) );
			
			$hash .= $char;
		}
	
		// Done
		return $hash;
	}

}

?>
