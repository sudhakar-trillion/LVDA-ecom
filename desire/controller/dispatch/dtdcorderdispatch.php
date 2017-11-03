<?php
class ControllerDispatchdtdcorderdispatch extends Controller 
{
	
	public function index()
	{
		$this->load->language('dispatch/dtdcorderdispatch');
		
	
		$this->document->setTitle($this->language->get('heading_title'));
		
		$data['heading_title']			=	$this->language->get('heading_title');
		$data['text_list']				=	$this->language->get('text_list');
		
		$data['element_orderId']		=	$this->language->get('element_orderId');
		$data['placeholder_orderId']	=	$this->language->get('placeholder_orderId');
		
		$data['element_courierid']		=	$this->language->get('element_courierid');
		$data['placeholder_courierid']	=	$this->language->get('placeholder_courierid');
		
		$data['element_assign']			=	$this->language->get('element_assign');

		
		
		
		
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('dispatch/dtdcdispatch', $data));
	}
	
}//dtdc class ends here