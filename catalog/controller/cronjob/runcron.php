<?php
class ControllerCronjobruncron extends Controller 
{
	
	public function index()
	{
		$mail = new Mail();


			$subject = "Cron here";
			
			$message = '<h2>Here come cron</h2>';
			$userdetails['email'] = 'sudhakar@trillionit.com';
			
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
			$mail->smtp_Auth = TRUE;
	
			$mail->setTo($userdetails['email']);
			//$mail->setTo('phpadmin@trillionit.com');
	
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
			$mail->setSubject($subject);
			$mail->setHtml( html_entity_decode($message, ENT_QUOTES, 'UTF-8') );
			
#			echo 'INSERT INTO oc_courier_tracks values ( "",'.$this->db->escape($orderid).',"'.$this->db->escape($courierid).'","'.$this->db->escape($couriername).'","'.date('Y-m-d').'","'.date('Y-m-d H:i:s').'")'; exit; 
			//$this->db->query('INSERT INTO oc_courier_tracks values ( "",'.$this->db->escape($orderid).',"'.$this->db->escape($courierid).'","'.$this->db->escape($couriername).'","'.date('Y-m-d').'","'.date('Y-m-d H:i:s').'")');
			
				$mail->send();
			
	}
	
}//requestdispatcher class ends here