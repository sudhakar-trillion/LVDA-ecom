<?php
	$config  = $sconfig->get('themecontrol');

	$default = array(
	
		't_widgetid'  => "366766896986591232",
		't_username'  => "pavothemes",
		't_name'      => "000000",
		't_title'     => "000000",
		't_link'      => "000000",
		't_border'    => "000000",
		
	);
	$config = array_merge($default, $config);
?>
<div class="box-content">
	<div id="pav-twitter">
		<a class="twitter-timeline" data-dnt="true" data-chrome="noheader nofooter noborders transparent" data-theme="light" data-tweet-limit="1" data-show-replies="true" data-link-color="#<?php echo $config['t_link']; ?>" data-border-color="#<?php echo $config['t_border']; ?>" href="https://twitter.com/<?php echo $config['t_username']; ?>" data-widget-id="<?php echo $config['t_widgetid']; ?>">Tweets by @<?php echo $config['t_username'];?></a>
		<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
	</div>
</div>

<script type="text/javascript">
// Customize twitter feed
var hideTwitterAttempts = 0;
function hideTwitterBoxElements() {
	setTimeout( function() {
		if ( $('[id*=pav-twitter]').length ) {
			$('#pav-twitter iframe').each( function(){
				var ibody = $(this).contents().find( 'body' );
				if ( ibody.find( '.timeline .stream .h-feed li.tweet' ).length ) {
					ibody.find( '.header .p-nickname' ).css( 'color', '<?php echo $config["t_name"]; ?>' );
					ibody.find( '.p-name' ).css( 'color', '<?php echo $config["t_name"]; ?>' );
					ibody.find( '.e-entry-title' ).css( 'color', '<?php echo $config["t_title"]; ?>' );
				}
			});
		}
		hideTwitterAttempts++;
		if ( hideTwitterAttempts < 3 ) {
			hideTwitterBoxElements();
		}
	}, 1500);
}
// somewhere in your code after html page load
hideTwitterBoxElements();
</script>