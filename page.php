<?php

///////////////////////////////////////////////////////////////////////////////////////
// PHPmotion                                                http://www.phpmotion.com //
///////////////////////////////////////////////////////////////////////////////////////
// License: You are not to sell or distribute this software without permission       //
// Help and support please visit http://www.phpmotion.com                            //
// Copyright reserved                                                                //
///////////////////////////////////////////////////////////////////////////////////////


//use this script to load various generic pages  (e.g. about us, terms etc)

include_once ('classes/config.php');
include_once ('classes/sessions.php');

$page 	= (int) mysql_real_escape_string( $_GET['page'] ); 

// Send contact mail
if($_POST['contactSubmit']){
	$name = trim(mysql_real_escape_string($_POST['name']));
	$email = trim(mysql_real_escape_string($_POST['email']));
	$txt_message = trim(mysql_real_escape_string($_POST['message'])); 
	if ( strtolower($_POST['captext']) != strtolower($_SESSION['security_code']) ) {	
		$error_message = "Security code not valid, please try again";
		$message_type = $config["notification_error"];
		$blk_notification = 1;				
	} else{
		if( $name == "" || $email == "" || $txt_message == "" ){	
			$error_message = "Fill in all required fields";
			$message_type = $config["notification_error"];
			$blk_notification = 1;	
		} else {
			// send email
			$email_template	= 'email_templates/newcontact.htm';
			$subject 		= "Recieved a contact message from $name";
			$to 			= $config["notifications_from_email"];
			$from 			= $email;
			//send email template to TBS for rendering of variable inside
			$template 		= $email_template;
			$TBS 			= new clsTinyButStrong;
			$TBS->NoErr 	= true;
			$TBS->LoadTemplate("$template");
			$TBS->tbs_show(TBS_NOTHING);
			$message 		= $TBS->Source;		
			//load postage.php
			define('access',true);
			include ('includes/postage.php');		
			$error_message = "Thank You. Mail sent successfully.";
			$message_type = $config["notification_success"];
			$blk_notification = 1;		
		}	
	}
}
switch ($page)

{

	/*
	case 1:
		$which_page = 'generic_aboutus.htm';
	break;
	*/

	case 2:
		$which_page = 'generic_contactus.htm';
	break;

	/*
	case 3:
		$which_page = 'generic_terms.htm';
	break;

	case 4:
		$which_page = 'generic_advertise.htm';
	break;
	*/

	// new pages v3 => start at >= 10
	
	/*
	case 10:
		$which_page = 'site_ranking_info.htm';
	break;
	*/
	
	default:
		$sql = "SELECT * FROM page_content WHERE `page_id` = '$page'";
		$query = mysql_query($sql);
		$result	= mysql_fetch_array($query);
		if( mysql_num_rows($query) > 0 ){
			$page_title = $result['page_title'];		 
			$page_content = html_entity_decode($result['page_content'],ENT_QUOTES);
			$page_content = str_replace('\"','"',str_replace("\'","'",$page_content));
			$page_content = str_replace('\\'.htmlspecialchars('"',ENT_QUOTES),htmlspecialchars('"',ENT_QUOTES),str_replace("\\".htmlspecialchars("'",ENT_QUOTES),htmlspecialchars("'",ENT_QUOTES),$page_content));
			$page_content = stripslashes($page_content);	
			$which_page = 'page.htm';					
		} else {		
			header( 'Location: index.php' ) ;
			exit;		
		} 	 
	break;
	
}

if ( $which_page == 'site_ranking_info.htm' ) {

	$template	= "themes/$user_theme/templates/$which_page";

	$TBS 		= new clsTinyButStrong;
	$TBS->NoErr = true;
	$TBS->LoadTemplate("$template");
	$TBS->Render	= TBS_OUTPUT;
	$TBS->Show();
	die();

} else {

	$template		= "themes/$user_theme/templates/main_1.htm";
	$inner_template1 	= "themes/$user_theme/templates/$which_page";//middle of page
	$TBS 			= new clsTinyButStrong;
	$TBS->NoErr 	= true;

	$TBS->LoadTemplate("$template");

	//$TBS->MergeBlock('mp', $recent);
	//$TBS->MergeBlock('blkfeatured', $result_featured);

	$TBS->Render	= TBS_OUTPUT;

	$TBS->Show();

	@mysql_close();
	die();
}

?>