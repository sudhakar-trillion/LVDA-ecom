<?php
class ControllerCatalogproductcrosssale extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/product_crosssale');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product');
		$url = '';
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('cross_sale_title'),
			'href' => $this->url->link('catalog/product_crosssale', 'token=' . $this->session->data['token'] . $url, true)
		);


		$data['heading_title'] 	=	$this->language->get('cross_sale_title');
		$data['text_add']		=	$this->language->get('text_add');
		$data['heading_title'] 	= 	$this->language->get('heading_title');
		$data['text_list']		=	$this->language->get('text_list');
		
		$data['product_label']	=	$this->language->get('product_label');
		$data['products_cross_sale_label']	=	$this->language->get('products_cross_sale_label');
		$data['product_placeholder'] 		=	$this->language->get('product_placeholder');
		
		$data['cross_product'] 		=	$this->language->get('cross_product');
		$data['cross_sale_product_label']	= $this->language->get('cross_sale_product_label');
		$data['cross_sale_product_price'] = $this->language->get('cross_sale_product_price');
		
		$data['add']			=	$this->url->link('catalog/add_upsell', 'token=' . $this->session->data['token'], true);
		

		$data['text_list'] = $this->language->get('text_list');
		

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

	//get the products list
	
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/product_crosssell', $data));
	
	}


	}
