<?php 
class Controllerextensionpaymentatompay extends Controller {
	private $error = array(); 

	public function index() {
		$this->load->language('extension/payment/atompay');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('atompay', $this->request->post);				
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/payment/atompay', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_sim'] = $this->language->get('text_sim');
		$data['text_test'] = $this->language->get('text_test');
		$data['text_live'] = $this->language->get('text_live');
		$data['text_payment'] = $this->language->get('text_payment');
		$data['text_defered'] = $this->language->get('text_defered');
		$data['text_authenticate'] = $this->language->get('text_authenticate');
		
		$data['entry_vendor'] = $this->language->get('entry_vendor');
		$data['entry_url'] = $this->language->get('entry_url');
		$data['entry_prodid'] = $this->language->get('entry_prodid');
		$data['entry_port'] = $this->language->get('entry_port');
		$data['entry_sslver'] = $this->language->get('entry_sslver');
		$data['entry_password'] = $this->language->get('entry_password');
		$data['entry_test'] = $this->language->get('entry_test');
		$data['entry_transaction'] = $this->language->get('entry_transaction');
		$data['entry_total'] = $this->language->get('entry_total');	
		$data['entry_order_status'] = $this->language->get('entry_order_status');		
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

 		if (isset($this->error['vendor'])) {
			$data['error_vendor'] = $this->error['vendor'];
		} else {
			$data['error_vendor'] = '';
		}

		if (isset($this->error['url'])) {
			$data['error_url'] = $this->error['url'];
		} else {
			$data['error_url'] = '';
		}

		if (isset($this->error['prodid'])) {
			$data['error_prodid'] = $this->error['prodid'];
		} else {
			$data['error_prodid'] = '';
		}

		if (isset($this->error['port'])) {
			$data['error_port'] = $this->error['port'];
		} else {
			$data['error_port'] = '';
		}
		
		if (isset($this->error['sslver'])) {
			$data['error_sslver'] = $this->error['sslver'];
		} else {
			$data['error_sslver'] = '';
		}
		
		
 		if (isset($this->error['password'])) {
			$data['error_password'] = $this->error['password'];
		} else {
			$data['error_password'] = '';
		}

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_payment'),
			'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),       		
      		'separator' => ' :: '
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('payment/atompay', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
				
		$data['action'] = $this->url->link('extension/payment/atompay', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->post['atompay_vendor'])) {
			$data['atompay_vendor'] = $this->request->post['atompay_vendor'];
		} else {
			$data['atompay_vendor'] = $this->config->get('atompay_vendor');
		}

		if (isset($this->request->post['atompay_url'])) {
			$data['atompay_url'] = $this->request->post['atompay_url'];
		} else {
			$data['atompay_url'] = $this->config->get('atompay_url');
		}

		if (isset($this->request->post['atompay_prodid'])) {
			$data['atompay_prodid'] = $this->request->post['atompay_prodid'];
		} else {
			$data['atompay_prodid'] = $this->config->get('atompay_prodid');
		}

		if (isset($this->request->post['atompay_port'])) {
			$data['atompay_port'] = $this->request->post['atompay_port'];
		} else {
			$data['atompay_port'] = $this->config->get('atompay_port');
		}
		
		if (isset($this->request->post['atompay_sslver'])) {
			$data['atompay_sslver'] = $this->request->post['atompay_sslver'];
		} else {
			$data['atompay_sslver'] = $this->config->get('atompay_sslver');
		}
		
		if (isset($this->request->post['atompay_password'])) {
			$data['atompay_password'] = $this->request->post['atompay_password'];
		} else {
			$data['atompay_password'] = $this->config->get('atompay_password');
		}

		if (isset($this->request->post['atompay_test'])) {
			$data['atompay_test'] = $this->request->post['atompay_test'];
		} else {
			$data['atompay_test'] = $this->config->get('atompay_test');
		}
		
		if (isset($this->request->post['atompay_transaction'])) {
			$data['atompay_transaction'] = $this->request->post['atompay_transaction'];
		} else {
			$data['atompay_transaction'] = $this->config->get('atompay_transaction');
		}
		
		if (isset($this->request->post['atompay_total'])) {
			$data['atompay_total'] = $this->request->post['atompay_total'];
		} else {
			$data['atompay_total'] = $this->config->get('atompay_total'); 
		} 
				
		if (isset($this->request->post['atompay_order_status_id'])) {
			$data['atompay_order_status_id'] = $this->request->post['atompay_order_status_id'];
		} else {
			$data['atompay_order_status_id'] = $this->config->get('atompay_order_status_id'); 
		} 

		$this->load->model('localisation/order_status');
		
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['atompay_geo_zone_id'])) {
			$data['atompay_geo_zone_id'] = $this->request->post['atompay_geo_zone_id'];
		} else {
			$data['atompay_geo_zone_id'] = $this->config->get('atompay_geo_zone_id'); 
		} 
		
		$this->load->model('localisation/geo_zone');
										
		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		
		if (isset($this->request->post['atompay_status'])) {
			$data['atompay_status'] = $this->request->post['atompay_status'];
		} else {
			$data['atompay_status'] = $this->config->get('atompay_status');
		}
		
		if (isset($this->request->post['atompay_sort_order'])) {
			$data['atompay_sort_order'] = $this->request->post['atompay_sort_order'];
		} else {
			$data['atompay_sort_order'] = $this->config->get('atompay_sort_order');
		}

		
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('extension/payment/atompay.tpl', $data));
		
		
	}

	private function validate() {
				
		//if (!$this->user->hasPermission('modify', 'payment/atompay')) {
		//	$this->error['warning'] = $this->language->get('error_permission');
		//}
		
		if (!$this->request->post['atompay_vendor']) {
			$this->error['vendor'] = $this->language->get('error_vendor');
		}

		if (!$this->request->post['atompay_password']) {
			$this->error['password'] = $this->language->get('error_password');
		}

		if (!$this->request->post['atompay_url']) {
			$this->error['url'] = $this->language->get('error_url');
		}

		if (!$this->request->post['atompay_prodid']) {
			$this->error['prodid'] = $this->language->get('error_prodid');
		}

		if (!$this->request->post['atompay_port']) {
			$this->error['port'] = $this->language->get('error_port');
		}

		if (!$this->request->post['atompay_sslver']) {
			$this->error['sslver'] = $this->language->get('error_sslver');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return true;
		}	
	}
}
?>