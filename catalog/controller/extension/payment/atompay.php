<?php

class ControllerExtensionPaymentAtompay extends Controller {
	public function index() {
		
		$this->load->language('extension/payment/atompay');
		
		$data['button_confirm'] = $this->language->get('button_confirm');		
		$data['url2'] = $this->url->link('extension/payment/atompay/dopayment', '', true);	
		$this->session->data['order_id'];		
	
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/atompay.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/atompay.tpl', $data);
				} else {
			//$this->template = 'default/template/payment/atompay.tpl';
			//$this->response->setOutput($this->load->view('payment/atompay.tpl', $data));
			return $this->load->view('extension/payment/atompay.tpl', $data);
		}	
		
		//$this->render();
		$this->response->setOutput($this->load->view('extension/payment/atompay.tpl', $data));	
	}
	public function dopayment() {
		
		$vendor = $this->config->get('atompay_vendor');
		$password = $this->config->get('atompay_password');		
		$data['action'] = $this->config->get('atompay_url');
		$data['port'] = $this->config->get('atompay_port'); 		
        $data['sslver'] = $this->config->get('atompay_sslver');
		
		$this->load->model('checkout/order');
		
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		$datenow 		= date("d/m/Y");
		$data['BillingCity']		   = $order_info['payment_city'];
       	$data['BillingPostCode']	   = $order_info['payment_postcode'];	
        $data['BillingCountry']      = $order_info['payment_iso_code_2'];

		$data['login']	       = $this->config->get('atompay_vendor');
		$data['pass']			   = $this->config->get('atompay_password');
		$data['ttype']		   = 'NBFundTransfer';
		$data['action']		   = $this->config->get('atompay_url');
		$data['prodid']		   = $this->config->get('atompay_prodid');
		$data['amt']			   = $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value'], false);
		$data['txnid']		   = $this->session->data['order_id'];
		$data['txndate']		   = $datenow;
		$data['CustomerName']    = html_entity_decode($order_info['payment_firstname'] . ' ' . $order_info['payment_lastname'], ENT_QUOTES, 'UTF-8');
		$data['CustomerEMail']   = $order_info['email'];
		$data['BillingPhone']    = $order_info['telephone'];
		$data['BillingAddress1'] = $order_info['payment_address_1']."|".$this->data['BillingCity']."|".$this->data['BillingCountry'];
		$data['ru']			   = $this->url->link('extension/payment/atompay/success');

		$postFields  = "";
		$postFields .= "&login=".$data['login'];
		$postFields .= "&pass=".$data['pass'];
		$postFields .= "&ttype=".$data['ttype'];
		$postFields .= "&prodid=".$data['prodid'];
		$postFields .= "&amt=".$data['amt'];
		$postFields .= "&txncurr=INR";
		$postFields .= "&txnscamt=0";
		$postFields .= "&clientcode=".urlencode(base64_encode('123'));
		$postFields .= "&txnid=".$data['txnid'];
		$postFields .= "&date=".$datenow;
		$postFields .= "&custacc=123456789012";
		$postFields .= "&udf1=".$data['CustomerName'];
		$postFields .= "&udf2=".$data['CustomerEMail'];
		$postFields .= "&udf3=".$data['BillingPhone'];
		$postFields .= "&udf4=".$data['BillingAddress1'];
		$postFields .= "&ru=".$data['ru'];


		$sendUrl = $data['action']."?".substr($postFields,1);
		
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL,$data['action']);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_PORT , $data['port']); 
		curl_setopt($ch, CURLOPT_SSLVERSION, $data['sslver']);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $postFields);
		$returnData = curl_exec($ch); 

		$parser = xml_parser_create('');
		xml_parser_set_option($parser, XML_OPTION_TARGET_ENCODING, "UTF-8"); 
		xml_parser_set_option($parser, XML_OPTION_CASE_FOLDING, 0);
		xml_parser_set_option($parser, XML_OPTION_SKIP_WHITE, 1);
		xml_parse_into_struct($parser, trim($returnData), $xml_values);
		xml_parser_free($parser);
	
		if(isset($xml_values[3]['value'])=='' || isset($xml_values[4]['value'])=='' || isset($xml_values[5]['value'])=='')
			{
				$this->response->redirect($this->url->link('checkout/atomfailure&msg=1'));
			}
	
		$returnArray['url'] 		= $xml_values[3]['value'];
		$returnArray['ttype'] 		= $xml_values[4]['value'];
		$returnArray['tempTxnId']	= $xml_values[5]['value'];
		$returnArray['token'] 		= $xml_values[6]['value'];		

		$url =$returnArray['url'] ;
		$postFields  = "";
		$postFields .= "&ttype=".$returnArray['ttype'] ;
		$postFields .= "&tempTxnId=".$returnArray['tempTxnId'];
		$postFields .= "&token=".$returnArray['token'] ;
		$postFields .= "&txnStage=1";
		$url = $url."?".$postFields;
		
		if($returnArray['tempTxnId']=='')
			{
				$this->response->redirect($this->url->link('checkout/atomfailure&msg=1'));
			}
		else
			{
				header("Location: ".$url);	
			}
	}
	public function success() {
		//print_R($_POST); exit;
		if ($this->request->post['f_code'] =='Ok') {
			$this->load->model('checkout/order');
			//$this->model_checkout_order->confirm($this->request->post['mer_txn'], $this->config->get('config_order_status_id'),"Payment Pending");
			//$this->model_checkout_order->update($this->request->post['mer_txn'], $this->config->get('atompay_order_status_id'), "Payment Received", false);
			$this->model_checkout_order->addOrderHistory($this->request->post['mer_txn'], $this->config->get('atompay_order_status_id'),"Payment Received");
			
			$this->response->redirect($this->url->link('checkout/success'));		
		}
		else
			{
			$message = "Payment failed";
			$this->load->model('checkout/order');
			//$this->model_checkout_order->confirm($this->request->post['mer_txn'], $this->config->get('config_order_status_id'),"Payment Pending");
			//$this->model_checkout_order->update($this->request->post['mer_txn'], $this->config->get('config_order_status_id'), $message, false);
			$this->error['warning'] = "Transaction Denied. Payment failed.";
			
			$this->model_checkout_order->addOrderHistory($this->request->post['mer_txn'], $this->config->get('config_order_status_id'),"Payment Pending");
			
			$this->response->redirect($this->url->link('checkout/failure'));

		}
	}	
}
?>