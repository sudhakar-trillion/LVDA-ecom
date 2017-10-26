<!--<a href="sociallogin.php?media=Facebook">Facebook</a> | <a href="sociallogin.php?media=Google">Google+</a>-->

<?PHP

include('hybridauth/src/autoload.php');
	
if(isset($_GET['media']))	
{
	$socialMedia = $_GET['media'];	
}
	


//$socialMedia = 'Google';

use Hybridauth\Hybridauth;
use Hybridauth\HttpClient;

$config = [
'callback' => HttpClient\Util::getCurrentUrl(),

'providers' => [

/*        'GitHub' => [ 
'enabled' => true,
'keys'    => [ 'id' => '', 'secret' => '' ], 
],

*/
'Google' => [ 
'enabled' => true,
'keys'    => [ 'id' => '996955024402-dlissk2g6t81rrk72u8nmakt7gqrdkek.apps.googleusercontent.com', 'secret' => 'YUyF2IfeW9TK6uuup4KOApef' ],
],

'Facebook' => [ 
'enabled' => true,
'keys'    => [ 'id' => '1949789691960849', 'secret' => '694b858da3bb9e3431a78849db52ffa0' ],
],
/*
'Twitter' => [ 
'enabled' => true,
'keys'    => [ 'key' => '', 'secret' => '' ],
]
*/
],

/* optional : set debug mode
'debug_mode' => true,
// Path to file writeable by the web server. Required if 'debug_mode' is not false
'debug_file' => __FILE__ . '.log', */

/* optional : customize Curl settings
// for more information on curl, refer to: http://www.php.net/manual/fr/function.curl-setopt.php  
'curl_options' => [
// setting custom certificates
CURLOPT_SSL_VERIFYPEER => true,
CURLOPT_CAINFO         => '/path/to/your/certificate.crt',

// set a valid proxy ip address
CURLOPT_PROXY => '*.*.*.*:*',

// set a custom user agent
CURLOPT_USERAGENT      => ''
] */
];

try {    
$hybridauth = new Hybridauth( $config );

//$adapter = $hybridauth->authenticate( 'GitHub' );

//$adapter = $hybridauth->authenticate( 'Google' );
$adapter = $hybridauth->authenticate($socialMedia);
// $adapter = $hybridauth->authenticate( 'Twitter' );

$tokens = $adapter->getAccessToken();
$userProfile = $adapter->getUserProfile();

//print_r( $tokens );
echo "<Pre>";     print_r( $userProfile );

echo "</pre>";
$adapter->disconnect();
}
catch (\Exception $e) {
echo $e->getMessage();
}
			
	
?>