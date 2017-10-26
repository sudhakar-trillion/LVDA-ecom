<?php
class ModelAccountCustomer extends Model {
	public function addCustomer($data) 
	{
		/* 
		if (isset($data['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($data['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $data['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$this->load->model('account/customer_group');

		$customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);

		$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET customer_group_id = '" . (int)$customer_group_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', custom_field = '" . $this->db->escape(isset($data['custom_field']['account']) ? json_encode($data['custom_field']['account']) : '') . "', salt = '" . $this->db->escape($salt = token(9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', newsletter = '" . (isset($data['newsletter']) ? (int)$data['newsletter'] : 0) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', status = '1', approved = '" . (int)!$customer_group_info['approval'] . "', date_added = NOW()");

		$customer_id = $this->db->getLastId();

		$this->db->query("INSERT INTO " . DB_PREFIX . "address SET customer_id = '" . (int)$customer_id . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', company = '" . $this->db->escape($data['company']) . "', address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int)$data['country_id'] . "', zone_id = '" . (int)$data['zone_id'] . "', custom_field = '" . $this->db->escape(isset($data['custom_field']['address']) ? json_encode($data['custom_field']['address']) : '') . "'");

		$address_id = $this->db->getLastId();

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$customer_id . "'");

		$this->load->language('mail/customer');

		$subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

		$message = sprintf($this->language->get('text_welcome'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8')) . "\n\n";

		if (!$customer_group_info['approval']) {
			$message .= $this->language->get('text_login') . "\n";
		} else {
			$message .= $this->language->get('text_approval') . "\n";
		}

		$message .= $this->url->link('account/login', '', true) . "\n\n";
		$message .= $this->language->get('text_services') . "\n\n";
		$message .= $this->language->get('text_thanks') . "\n";
		$message .= html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8');

		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
		$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

		$mail->setTo($data['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
		$mail->setSubject($subject);
		$mail->setText($message);
		$mail->send();

		// Send to main admin email if new account email is enabled
		if ($this->config->get('config_account_mail')) {
			$message  = $this->language->get('text_signup') . "\n\n";
			$message .= $this->language->get('text_website') . ' ' . html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8') . "\n";
			$message .= $this->language->get('text_firstname') . ' ' . $data['firstname'] . "\n";
			$message .= $this->language->get('text_lastname') . ' ' . $data['lastname'] . "\n";
			$message .= $this->language->get('text_customer_group') . ' ' . $customer_group_info['name'] . "\n";
			$message .= $this->language->get('text_email') . ' '  .  $data['email'] . "\n";
			$message .= $this->language->get('text_telephone') . ' ' . $data['telephone'] . "\n";

			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode($this->language->get('text_new_customer'), ENT_QUOTES, 'UTF-8'));
			$mail->setText($message);
			$mail->send();

			// Send to additional alert emails if new account email is enabled
			$emails = explode(',', $this->config->get('config_mail_alert'));

			foreach ($emails as $email) {
				if (utf8_strlen($email) > 0 && filter_var($email, FILTER_VALIDATE_EMAIL)) {
					$mail->setTo($email);
					$mail->send();
				}
			}
		}

		return $customer_id;
	 */
	 
		if (isset($data['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($data['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $data['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$this->load->model('account/customer_group');

		$customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);

		
		
		if(isset($data['socilalogin']))
		{
			$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET customer_group_id = '" . (int)$customer_group_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "',  salt = '" . $this->db->escape($salt = token(9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', status = '1', approved = '1', date_added = NOW()");
		}
		elseif(isset($data['Ajax']))
		{
			$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET customer_group_id = '" . (int)$customer_group_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "',  firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "',  custom_field = '" . $this->db->escape(isset($data['custom_field']['account']) ? json_encode($data['custom_field']['account']) : '') . "', salt = '" . $this->db->escape($salt = token(9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', newsletter = '" . (isset($data['newsletter']) ? (int)$data['newsletter'] : 0) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', status = '1', approved = '" . (int)!$customer_group_info['approval'] . "', date_added = NOW()");
		}
		else
		{
			
			$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET customer_group_id = '" . (int)$customer_group_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', custom_field = '" . $this->db->escape(isset($data['custom_field']['account']) ? json_encode($data['custom_field']['account']) : '') . "', salt = '" . $this->db->escape($salt = token(9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', newsletter = '" . (isset($data['newsletter']) ? (int)$data['newsletter'] : 0) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', status = '0', approved = '" . (int)!$customer_group_info['approval'] . "', date_added = NOW()");
			
		}
		

		$customer_id = $this->db->getLastId();


$this->db->query("INSERT INTO " . DB_PREFIX . "address SET customer_id = '" . (int)$customer_id . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "',  address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int)$data['country_id'] . "', zone_id = '" . (int)$data['zone_id'] . "', custom_field = '" . $this->db->escape(isset($data['custom_field']['address']) ? json_encode($data['custom_field']['address']) : '') . "'");

		$address_id = $this->db->getLastId();

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$customer_id . "'");

		$this->load->language('mail/customer');

		$subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));


	$message="<div style='width:700px;  margin:auto; background:#393939; padding:30px 0px 30px 0px; '><div style='width:638px;     padding: 15px 0px 16px 0px;  margin:auto; background: #fff;'><div style='width:300px; margin-left:20px; float:left;'> <img src='http://www.trillionit.in/lvda/image/catalog/Lvda Logo.png' style='width:148px;'  /> </div><div style='width:190px; float:right; margin-top:0px; margin-right:20px;'>      <p style='font-family:calibri; float:right; font-size:16px; font-style:italic; color:#122856;'><a href='#' style='text-decoration:none; color:#a3238e;'>www.lvda.com</a></p></div>     <div style='clear:both'></div></div><div style='width:590px;     padding: 20px 26px 16px 20px;  margin:auto; background: #fff; border:1px solid #d6d5d6;  '>";
	
	$message.="<div style='font-size:14px;word-spacing:1px;letter-spacing:0.1px;color:rgb(51,51,51); text-align:center;'>";

	$message.="<h2 style='font-size:15px; text-transform:uppercase;font-weight:600;margin:13px 0px 0px;  margin-bottom:10px;color:#f00;line-height:20px;font-family:Sans-Serif'> Registration Success</h2>";


	$message.="<p style='margin-bottom:10px;'>Account successfully registered, once you clicks on the below activation link your account activation process will completes and you can login, kindly click on the below link to get activate your registration</p>";
	
	$message.="<a href='".$this->config->get('config_url')."activate-now/".$customer_id."' style='color:#f58220; text-decoration:none;'>Click here to Activation </a></div></div><div style='width:590px; background:#fff;color:#222; padding: 26px 23px 16px; margin:auto;  border:1px solid #d6d5d6; border-top:none; '><p style='color:#fff; font-size:13px; text-align:center;  margin-bottom:5px; '>Love Value Desire Ambition&ensp; &ensp; Email : <a href='mailto:info@lvda.com' style='text-decoration:none; color:#fff;'>info@lvda.com</p></div></div>";
	


//$message .= html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8');
		


		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
		$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
		$mail->smtp_Auth = TRUE;

		$mail->setTo($data['email']);
		//$mail->setTo('phpadmin@trillionit.com');

		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
		$mail->setSubject($subject);
		$mail->setHtml( html_entity_decode($message, ENT_QUOTES, 'UTF-8') );
		
	/*	echo "<pre>";
		print_r($mail);
		exit;*/
		if(isset($data['socilalogin']))
		{
			
		}
		else
			$mail->send();

		// Send to main admin email if new account email is enabled
		if (in_array('account', (array)$this->config->get('config_mail_alert'))) {
	
	/*
	
			$message  = $this->language->get('text_signup') . "\n\n";
			$message .= $this->language->get('text_website') . ' ' . html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8') . "\n";
			$message .= $this->language->get('text_firstname') . ' ' . $data['firstname'] . "\n";
			$message .= $this->language->get('text_lastname') . ' ' . $data['lastname'] . "\n";
			$message .= $this->language->get('text_customer_group') . ' ' . $customer_group_info['name'] . "\n";
			$message .= $this->language->get('text_email') . ' '  .  $data['email'] . "\n";
			$message .= $this->language->get('text_telephone') . ' ' . $data['telephone'] . "\n";

	
*/

$message="<body><div style='width:700px;  margin:auto; background:#393939; padding:30px 0px 30px 0px; '><div style='width:638px;     padding: 15px 0px 16px 0px;  margin:auto; background: #fff;   '><div style='width:300px; margin-left:20px; float:left;'> <img src='http://www.trillionit.in/lvda/image/catalog/Lvda Logo.png' style='width:148px;'  /> </div><div style='width:190px; float:right; margin-top:0px; margin-right:20px;'><p style='font-family:calibri; color:#122856;'><a href='#' style='text-decoration:none; color:#a3238e;'>www.lvda.com</a></p></div><div style='clear:both'></div></div><div style='width:590px;     padding: 20px 26px 16px 20px;  margin:auto; background: #fff; border:1px solid #d6d5d6;  '><div style='font-size:14px;word-spacing:1px;letter-spacing:0.1px;color:#f00; text-align:center;'> <h2 style='Sans-Serif'>New Customer Registered</h2> <p style='margin-top:10px; margin-bottom:10px;'><a style='color:#f58220; cursor:pointer; text-decoration:none;'>";

if(isset($data['socilalogin']))
	$message.="Status:Social Medial Account Activated</a></p>";
else
	$message.="Status:Activation Pending</a></p>";

$message.="<table style='width:60%; border=1px solid #eee' border='1' align='center' cellpadding='0' cellspacing='0'><tr style='border-bottom:1px solid #eee'><td style='padding-top:5px; padding-bottom:10px;'>".$this->language->get('text_website')."</td><td style='padding-top:5px; padding-bottom:10px;'>".$this->config->get('config_name')."</td></tr>";

$message.="<tr style='border-bottom:1px solid #eee'><td style='padding-top:5px; padding-bottom:10px;'>".$this->language->get('text_firstname')."</td><td style='padding-top:5px; padding-bottom:10px;'>".$data['firstname']."</td></tr>";

$message.="<tr style='border-bottom:1px solid #eee'><td style='padding-top:5px; padding-bottom:10px;'>".$this->language->get('text_lastname')."</td><td style='padding-top:5px; padding-bottom:10px;'>".$data['lastname']."</td></tr>";

/*
$message.="<tr style='border-bottom:1px solid #eee'><td style='padding-top:5px; padding-bottom:10px;'>".$this->language->get('text_customer_group')."</td><td style='padding-top:5px; padding-bottom:10px;'>".$customer_group_info['name']."</td></tr>";*/

$message.="<tr style='border-bottom:1px solid #eee'><td style='padding-top:5px; padding-bottom:10px;'>".$this->language->get('text_email')."</td><td style='padding-top:5px; padding-bottom:10px;'>".$data['email']."</td></tr>";

$message.="<tr style='border-bottom:1px solid #eee'><td style='padding-top:5px; padding-bottom:10px;'>".$this->language->get('text_telephone')."</td><td style='padding-top:5px; padding-bottom:10px;'>".$data['telephone']."</td></tr></table>";

$message.="</div></div><div style='width:590px; background:#fff;color:#222;     padding: 26px 23px 16px; margin:auto;  border:1px solid #d6d5d6; border-top:none;'><p style='color:#fff; font-size:13px; text-align:center;  margin-bottom:5px;'>Love Value Desire Ambition&ensp; &ensp; Email : <a href='mailto:info@lvda.com' style='text-decoration:none; color:#fff;'>info@lvda.com</p></div></div></body>";



			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode($this->language->get('text_new_customer'), ENT_QUOTES, 'UTF-8'));
			//$mail->setText($message);
			
			$mail->setHtml( html_entity_decode($message, ENT_QUOTES, 'UTF-8') );
			
			$mail->send();

			// Send to additional alert emails if new account email is enabled
			$emails = explode(',', $this->config->get('config_alert_email'));

			foreach ($emails as $email) {
				if (utf8_strlen($email) > 0 && filter_var($email, FILTER_VALIDATE_EMAIL)) {
					$mail->setTo($email);
					$mail->send();
				}
			}
		}

		return $customer_id;
	
	}

	public function editCustomer($data) {
		$customer_id = $this->customer->getId();

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', custom_field = '" . $this->db->escape(isset($data['custom_field']) ? json_encode($data['custom_field']) : '') . "' WHERE customer_id = '" . (int)$customer_id . "'");
	}



	public function editCode($email, $code) {
		$this->db->query("UPDATE `" . DB_PREFIX . "customer` SET code = '" . $this->db->escape($code) . "' WHERE LCASE(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
	}

	public function editNewsletter($newsletter) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET newsletter = '" . (int)$newsletter . "' WHERE customer_id = '" . (int)$this->customer->getId() . "'");
	}

	public function getCustomer($customer_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->row;
	}

	public function getCustomerByEmail($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}

	public function getCustomerByCode($code) {
		$query = $this->db->query("SELECT customer_id, firstname, lastname FROM `" . DB_PREFIX . "customer` WHERE code = '" . $this->db->escape($code) . "' AND code != ''");

		return $query->row;
	}

	public function getCustomerByToken($token) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE token = '" . $this->db->escape($token) . "' AND token != ''");

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET token = ''");

		return $query->row;
	}

	public function getTotalCustomersByEmail($email) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row['total'];
	}

	public function getRewardTotal($customer_id) {
		$query = $this->db->query("SELECT SUM(points) AS total FROM " . DB_PREFIX . "customer_reward WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->row['total'];
	}

	public function getIps($customer_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_ip` WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->rows;
	}

	public function addLoginAttempt($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_login WHERE email = '" . $this->db->escape(utf8_strtolower((string)$email)) . "' AND ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'");

		if (!$query->num_rows) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "customer_login SET email = '" . $this->db->escape(utf8_strtolower((string)$email)) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', total = 1, date_added = '" . $this->db->escape(date('Y-m-d H:i:s')) . "', date_modified = '" . $this->db->escape(date('Y-m-d H:i:s')) . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "customer_login SET total = (total + 1), date_modified = '" . $this->db->escape(date('Y-m-d H:i:s')) . "' WHERE customer_login_id = '" . (int)$query->row['customer_login_id'] . "'");
		}
	}

	public function getLoginAttempts($email) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_login` WHERE email = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}

	public function deleteLoginAttempts($email) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "customer_login` WHERE email = '" . $this->db->escape(utf8_strtolower($email)) . "'");
	}

	public function activateCustomer($customerId) {
		
		$customer_id = $customerId;
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET status = '1'  WHERE customer_id = '" . (int)$customer_id . "'");
		
		return $this->db->countAffected(); 
	}

public function checkcustomerExists($email)
	{
		
		$qry  =	$this->db->query("select customer_id from ".DB_PREFIX."customer where email='".$email."'");
		
		if($qry->num_rows>0)
		{
			$resetpassword = $this->randomPassword();
			$password = $resetpassword;
			
			if( $this->editPassword($email, $password) == "1")
			{
				$message="<div style='width:700px;  margin:auto; background:#393939; padding:30px 0px 30px 0px; '><div style='width:638px;     padding: 15px 0px 16px 0px;  margin:auto; background: #fff;'><div style='width:300px; margin-left:20px; float:left;'> <img src='http://www.trillionit.in/lvda/image/catalog/LvdaLogo.png' style='width:148px;'  /> </div><div style='width:190px; float:right; margin-top:0px; margin-right:20px;'>      <p style='font-family:calibri; float:right; font-size:16px; font-style:italic; color:#122856;'><a href='#' style='text-decoration:none; color:#a3238e;'>www.lvda.com</a></p></div>     <div style='clear:both'></div></div><div style='width:590px;     padding: 20px 26px 16px 20px;  margin:auto; background: #fff; border:1px solid #d6d5d6;  '>";
	
	$message.="<div style='font-size:14px;word-spacing:1px;letter-spacing:0.1px;color:rgb(51,51,51); text-align:center;'>";

	$message.="<h2 style='font-size:15px; text-transform:uppercase;font-weight:600;margin:13px 0px 0px;  margin-bottom:10px;color:#f00;line-height:20px;font-family:Sans-Serif'> Password Reset Success</h2>";

	$message.="<p style='margin-bottom:10px;'>Your new password is:<strong>".$password."</strong></p>";
	
	$message.="<a href='".$this->config->get('config_url')."login' style='color:#f58220; text-decoration:none;'>Click here to login </a></div></div><div style='width:590px; background:#fff;color:#222; padding: 26px 23px 16px; margin:auto;  border:1px solid #d6d5d6; border-top:none; '><p style='color:#fff; font-size:13px; text-align:center;  margin-bottom:5px; '>Love Value Desire Ambition  &ensp; &ensp; Email : <a href='mailto:info@lvda.com' style='text-decoration:none; color:#fff;'>info@lvda.com</p></div></div>";


//$message .= html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8');
		


		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
		$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
		$mail->smtp_Auth = TRUE;

		$mail->setTo($email);
		//$mail->setTo('phpadmin@trillionit.com');

		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
		$mail->setSubject('PAssword Reset Successfully');
		$mail->setHtml( html_entity_decode($message, ENT_QUOTES, 'UTF-8') );
		
	/*	echo "<pre>";
		print_r($mail);
		exit;*/
		
		$mail->send();
		
		return "1";
			}
			else
				return "-1";
		}
		else
			return "0";
	
	
	
	}
	
	public function editPassword($email, $password) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET salt = '" . $this->db->escape($salt = token(9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "', code = '' WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
		return $this->db->countAffected(); 
	}

	function randomPassword() 
	{
		
		$chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&*_";
		$password = substr( str_shuffle( $chars ), 0, 8 );	
		return $password;
	}
}
