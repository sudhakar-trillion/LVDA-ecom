<?php
if( $_SERVER['SERVER_ADDR'] == "192.168.0.4" )
{
// HTTP
define('HTTP_SERVER', 'http://192.168.0.4/pav-vigoss/admin/');
define('HTTP_CATALOG', 'http://192.168.0.4/pav-vigoss/');

// HTTPS
define('HTTPS_SERVER', 'http://192.168.0.4/pav-vigoss/admin/');
define('HTTPS_CATALOG', 'http://192.168.0.4/pav-vigoss/');


// DIR
define('DIR_APPLICATION', 'C:/xampp/htdocs/pav-vigoss/admin/');
define('DIR_SYSTEM', 'C:/xampp/htdocs/pav-vigoss/system/');
define('DIR_IMAGE', 'C:/xampp/htdocs/pav-vigoss/image/');
define('DIR_LANGUAGE', 'C:/xampp/htdocs/pav-vigoss/admin/language/');
define('DIR_TEMPLATE', 'C:/xampp/htdocs/pav-vigoss/admin/view/template/');
define('DIR_CONFIG', 'C:/xampp/htdocs/pav-vigoss/system/config/');
define('DIR_CACHE', 'C:/xampp/htdocs/pav-vigoss/system/storage/cache/');
define('DIR_DOWNLOAD', 'C:/xampp/htdocs/pav-vigoss/system/storage/download/');
define('DIR_LOGS', 'C:/xampp/htdocs/pav-vigoss/system/storage/logs/');
define('DIR_MODIFICATION', 'C:/xampp/htdocs/pav-vigoss/system/storage/modification/');
define('DIR_UPLOAD', 'C:/xampp/htdocs/pav-vigoss/system/storage/upload/');
define('DIR_CATALOG', 'C:/xampp/htdocs/pav-vigoss/catalog/');

// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_DATABASE', 'pavvigoss');
define('DB_PORT', '3306');
define('DB_PREFIX', 'oc_');
}
else
{
	
// HTTP
define('HTTP_SERVER', 'http://www.trillionit.in/lvda-ver-II/admin/');
define('HTTP_CATALOG', 'http://www.trillionit.in/lvda-ver-II/');

// HTTPS
define('HTTPS_SERVER', 'http://www.trillionit.in/lvda-ver-II/admin/');
define('HTTPS_CATALOG', 'http://www.trillionit.in/lvda-ver-II/');


// DIR
define('DIR_APPLICATION', '/home3/vsksamsu/public_html/lvda-ver-II/admin/');
define('DIR_SYSTEM', '/home3/vsksamsu/public_html/lvda-ver-II/system/');
define('DIR_IMAGE', '/home3/vsksamsu/public_html/lvda-ver-II/image/');
define('DIR_LANGUAGE', '/home3/vsksamsu/public_html/lvda-ver-II/admin/language/');
define('DIR_TEMPLATE', '/home3/vsksamsu/public_html/lvda-ver-II/admin/view/template/');
define('DIR_CONFIG', '/home3/vsksamsu/public_html/lvda-ver-II/system/config/');
define('DIR_CACHE', '/home3/vsksamsu/public_html/lvda-ver-II/system/storage/cache/');
define('DIR_DOWNLOAD', '/home3/vsksamsu/public_html/lvda-ver-II/system/storage/download/');
define('DIR_LOGS', '/home3/vsksamsu/public_html/lvda-ver-II/system/storage/logs/');
define('DIR_MODIFICATION', '/home3/vsksamsu/public_html/lvda-ver-II/system/storage/modification/');
define('DIR_UPLOAD', '/home3/vsksamsu/public_html/lvda-ver-II/system/storage/upload/');
define('DIR_CATALOG', '/home3/vsksamsu/public_html/lvda-ver-II/catalog/');

// DB

define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'vsksamsu_lvda2');
define('DB_PASSWORD', 'vTeR^W$V#P)O');
define('DB_DATABASE', 'vsksamsu_lvdaver2');
define('DB_PORT', '3306');
define('DB_PREFIX', 'oc_');
	
}
