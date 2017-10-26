<?php
if( $_SERVER['SERVER_ADDR'] == "192.168.0.4" )
{ 

define('HTTP_SERVER', 'http://192.168.0.4/pav-vigoss/');
define('HTTPS_SERVER', 'http://192.168.0.4/pav-vigoss/');

/*

define('HTTP_SERVER', 'http://localhost/pav-vigoss/');
define('HTTPS_SERVER', 'http://localhost/pav-vigoss/');
*/

// DIR
define('DIR_APPLICATION', 'C:/xampp/htdocs/pav-vigoss/catalog/');
define('DIR_SYSTEM', 'C:/xampp/htdocs/pav-vigoss/system/');
define('DIR_IMAGE', 'C:/xampp/htdocs/pav-vigoss/image/');
define('DIR_LANGUAGE', 'C:/xampp/htdocs/pav-vigoss/catalog/language/');
define('DIR_TEMPLATE', 'C:/xampp/htdocs/pav-vigoss/catalog/view/theme/');
define('DIR_CONFIG', 'C:/xampp/htdocs/pav-vigoss/system/config/');
define('DIR_CACHE', 'C:/xampp/htdocs/pav-vigoss/system/storage/cache/');
define('DIR_DOWNLOAD', 'C:/xampp/htdocs/pav-vigoss/system/storage/download/');
define('DIR_LOGS', 'C:/xampp/htdocs/pav-vigoss/system/storage/logs/');
define('DIR_MODIFICATION', 'C:/xampp/htdocs/pav-vigoss/system/storage/modification/');
define('DIR_UPLOAD', 'C:/xampp/htdocs/pav-vigoss/system/storage/upload/');

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

define('HTTP_SERVER', 'http://www.trillionit.in/lvda-ver-II/');
define('HTTPS_SERVER', 'http://www.trillionit.in/lvda-ver-II/');


define('DIR_APPLICATION', '/home3/vsksamsu/public_html/lvda-ver-II/catalog/');
define('DIR_SYSTEM', '/home3/vsksamsu/public_html/lvda-ver-II/system/');
define('DIR_IMAGE', '/home3/vsksamsu/public_html/lvda-ver-II/image/');
define('DIR_LANGUAGE', '/home3/vsksamsu/public_html/lvda-ver-II/catalog/language/');
define('DIR_TEMPLATE', '/home3/vsksamsu/public_html/lvda-ver-II/catalog/view/theme/');
define('DIR_CONFIG', '/home3/vsksamsu/public_html/lvda-ver-II/system/config/');
define('DIR_CACHE', '/home3/vsksamsu/public_html/lvda-ver-II/system/storage/cache/');
define('DIR_DOWNLOAD', '/home3/vsksamsu/public_html/lvda-ver-II/system/storage/download/');
define('DIR_LOGS', '/home3/vsksamsu/public_html/lvda-ver-II/system/storage/logs/');
define('DIR_MODIFICATION', '/home3/vsksamsu/public_html/lvda-ver-II/system/storage/modification/');
define('DIR_UPLOAD', '/home3/vsksamsu/public_html/lvda-ver-II/system/storage/upload/');



define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'vsksamsu_lvda2');
define('DB_PASSWORD', 'vTeR^W$V#P)O');
define('DB_DATABASE', 'vsksamsu_lvdaver2');
define('DB_PORT', '3306');
define('DB_PREFIX', 'oc_');

}
