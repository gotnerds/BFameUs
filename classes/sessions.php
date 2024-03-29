<?php

///////////////////////////////////////////////////////////////////////////////////////
// PHPmotion                                                http://www.phpmotion.com //
///////////////////////////////////////////////////////////////////////////////////////
// License: You are not to sell or distribute this software without permission       //
// Help and support please visit http://www.phpmotion.com                            //
// Copyright reserved                                                                //
///////////////////////////////////////////////////////////////////////////////////////

validate_user($_COOKIE['user']);

// set user vars for passing around each php page
$user_id	= $_SESSION['user_id'];
$user_name	= $_SESSION['user_name'];
$user_group = $_SESSION['user_group'];

if ( $user_id != '' ) {

	$sql		= "SELECT * FROM member_profile WHERE user_id = '$user_id'";
	$query	= @mysql_query($sql);
    	$outcome	= @mysql_fetch_array($query);
    	$result	= $outcome['account_status'];

	if ($result == 'suspended') {
    		$user_id				= '';
		$user_name				= '';
		$_SESSION['user_id'] 		= NULL;
		$_SESSION['user_name'] 		= NULL;
		$_SESSION['user_group'] 	= NULL;
		@session_start();
		@session_destroy();

		foreach ( $_COOKIE as $key => $value ) {
     			$logout = '';
    			setcookie($key, $logout);
    		}
    		foreach ($_SESSION as $key => $value) {
   			$_SESSION[$key] 	= NULL;
			unset($_SESSION[$key]);
		}

    		$notification_type	= $config['notification_error'];
        	$error_message 		= $config['account_suspended'];
        	$blk_notification 	= 1;
        	$template 			= "themes/$user_theme/templates/main_1.htm";
        	$inner_template1		= "themes/$user_theme/templates/inner_notification.htm";
        	$TBS 				= new clsTinyButStrong;
        	$TBS->NoErr 		= true;
        	$TBS->LoadTemplate("$template");
        	$TBS->Render 		= TBS_OUTPUT;
        	$TBS->Show();
		@mysql_close();
        	die();
   	}

	if ( defined('SMF_INSTALLED') ) {
		$loggedin 			= 1;
		$login_out 			= $config['logout_text'];
		$login_out_link 		= 'logout.php';
		$register_menu		= $config['fav_menu'];
	} else {
		$loggedin 			= 1;
		$login_out 			= $config['logout_text'];
		$login_out_link 		= 'logout.php';
		$register_menu		= $config['fav_menu'];
	}

	//email inbox
	$sql				= "SELECT indexer FROM messages WHERE to_id = '$user_id' AND email_read = 'no'";
	$number_of_emails 	= @mysql_num_rows(mysql_query($sql));
	$show_email_count 	= 1;

	//Friend Invites
	$sql 				= "SELECT * FROM friends WHERE friends_id = '$user_id' AND invitation_status ='pending'";
	$number_of_invites	= @mysql_num_rows(mysql_query($sql));
	$show_invites_count 	= 1;

	//show My favs link
	$show_my_favs 		= 1;

	//show My account link
	$show_my_account 		= 1;

	//do not show signup link
	$show_register 		= '';

} else {

	$show_register 		= 1;
}

?>