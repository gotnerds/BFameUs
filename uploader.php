<?php
///////////////////////////////////////////////////////////////////////////////////////
// PHPmotion                                                http://www.phpmotion.com //
///////////////////////////////////////////////////////////////////////////////////////
// License: You are not to sell or distribute this software without permission       //
// Help and support please visit http://www.phpmotion.com                            //
// Copyright reserved                                                                //
///////////////////////////////////////////////////////////////////////////////////////

include_once ('classes/config.php');
include_once ('classes/sessions.php');
include 'uploader_conlib.php';

// load required javascripts used in main_1.htm
$swfobject 			= 1;
$ahah				= 1;
$codes_internal		= '';
$codes			= '';
$page_title			= $config['site_name'];
$tag_cloud 			= make_tag_cloud('videos');
$tag_cloud_block		= $tag_cloud[0];
$proceed 			= true;
$enable_promoted 		= true;
$limit			= $config['see_more_limits'];
$featured_display 	= $config['admin_order_by'];
$default_album_pic	= $config['default_album_pic'];
$enabled_stats		= $config['enabled_features_stats'];
$tpl_ajax_height		= 166;
$ajax_mutiplier		= $limit / 4; 						//default template has 4 views accross the row - so limit = 8 / 4 = 2 rows
$ajax_height		= $tpl_ajax_height * $ajax_mutiplier;
$show_vid_channels	= $config['show_home_page_categories'];
$theme_thumbnail_width	= $config['theme_thumbnail_width'];
$theme_thumbnail_height	= $config['theme_thumbnail_height'];
$auto_play_index 		= $config['auto_play_index'];
$show_stats			= $config["enabled_features_stats"];

$config['notification_error'] = $lang_error;

$page_title = $lang_upload_video;

if ($_SESSION['user_id'] == "") {
	header("Location: $login_out_link");
	die();
}


//if fan redirect to profile page
if($_SESSION['user_group'] == 'member') {
	header("Location: fantoartist.php?id=".$_SESSION['user_id']);
}


/*
if ( $_SESSION['user_group'] == 'member' ) {
      $message 		= "Only Admins and Mods can upload Videos" ;
      $procede 		= false;
      $template 		= "themes/$user_theme/templates/main_1.htm";
    	$inner_template1 	= "themes/$user_theme/templates/inner_notification.htm";
    	$TBS 			= new clsTinyButStrong;
    	$TBS->NoErr 	= true;
    	$TBS->LoadTemplate("$template");
    	$TBS->Render 	= TBS_OUTPUT;
    	$TBS->Show();
	@mysql_close();
    	die();
}
*/

$load_javascript	= 1;
$ahah			= 1;
$thickbox		= 1;

///////////////////////////////////////////////////////////////////////////////////////
// ADDED SPAMMER UPLOAD TRACKING LOGING
//

$member_uploading		= $_SESSION['user_name'];
$tracking_log_file	= 'logs/uploader_log.txt';
$admin_email		= $config['admin_notify_email'];
$user_ip			= mysql_escape_string($_SERVER['REMOTE_ADDR']);
$referer			= mysql_real_escape_string($_SERVER['HTTP_REFERER']);

if ( $referer == '' ) die_spammer_alerts();
if ( !ereg ($_SERVER['SERVER_NAME'], $referer) ) die_spammer_alerts();

///////////////////////////////////////////////////////////////////////////////////////

//echo $debugmodex;

//get channel data, create "select" form fields to load into form
//$sql			= "SELECT channel_id, channel_name FROM channels";
$sql			= "SELECT channel_id, channel_name FROM channels ORDER BY channel_name ASC";
$result1 		= @mysql_query($sql);
$count_cats 	= @mysql_num_rows($result1);
$fields_all 	= '';
$sub_fields_all	= '';
$show_fields	= '';

$fields_all .= '<option value="99999">Select One</option>';

while ($result = @mysql_fetch_array($result1)) {
    	$fields_all .= '<option value="'.$result['channel_id'].'">'.$result['channel_name'].'</option>';
}

$sub_cat_choice = (int) mysql_real_escape_string( $_GET['sub_cat'] );

if ( $sub_cat_choice ) {
	if ( $sub_cat_choice == '99999' ) {
		$sub_fields_all  .= '<select class="image_form" style="width:160px;" size="1" name="sub_cat">';
		$sub_fields_all  .= '<option value="99999">'.$lang_no_sub_categories.'</option>';
		$sub_fields_all .= '</select>&nbsp;('.$lang_select.')';
		echo $sub_fields_all;
		die();
	} else {
		$sql2			= "SELECT * from sub_channels WHERE parent_channel_id = $sub_cat_choice";
      	$query		= @mysql_query($sql2);
		$sub_fields_all  .= '<select class="image_form" style="width:160px;" size="1" name="sub_cat">';
		$sub_fields_all .= '<option value="99999">Select One</option>';
      	while ($result2 = @mysql_fetch_array($query)) {
    			$count_subs		= @mysql_num_rows($query);
    			$sub_fields_all  .= '<option value="'.$result2['sub_channel_id'].'">'.$result2['sub_channel_name'].'</option>';
     		}

     		if ( $count_subs == '' ) {
     			$sub_fields_all  .= '<option value="99999">'.$lang_no_sub_categories.'</option>';
		}

     		$sub_fields_all .= '</select>&nbsp;('.$lang_select.')';

     		echo $sub_fields_all;
	     	die();
	}
}

// grab values from form if any
$form_submitted		= $_POST['form_submitted'];
$title 			= $_POST['title'];
$description 		= $_POST['description'];
$tags 			= $_POST['tags'];
$location_recorded	= $_POST['location_recorded'];
$allow_comments 		= $_POST['allow_comments'];
$allow_embedding 		= $_POST['allow_embedding'];
$public_private 		= $_POST['public_private'];
$channel 			= $_POST['channel'];
$sub_cat			= $_POST['sub_cat'];
$procede 			= true;

$row = mysql_query("SELECT channel_name FROM channels WHERE channel_id = '$channel'");

while( $result = mysql_fetch_assoc($row) ) $channel_name = $result['channel_name'];

// validate form
if ($form_submitted == 'yes') {

	$post_vid_upload_token	= mysql_real_escape_string( $_POST['vid_upload_token'] );

	if ( $post_vid_upload_token != $_SESSION['vid_upload_token'] ) {

		//$spammer_msg = 'Spammer Bot detected!';
		//die($spammer_msg);

		die_spammer_alerts($referer);
	}

	foreach ($_POST as $key => $value) {
      	if ($key == 'title' || $key == 'description' || $key == 'tags' || $key == '$channel') {
            	if (!isset($value) || ($value == '')) {
                		$display_key	= @str_replace('_', ' ', $key);
                		$error_message	= $config['notification_error'];
                		$blk_notification = 1;
                		$error_message 	= $error_message . " - " . $display_key . "  - $lang_required ";
                		$procede 		= false;
            	}
        	}
    	}

    	if ( $channel == '99999' ) {

    		$error_message	= $config['notification_error'];
     		$blk_notification = 1;
     		$error_message 	= $error_message . " - $lang_select_channel";
    		$procede 		= false;
    	}
} else {

	$procede = false;
}

// display page with form error
if ($procede == false && $form_submitted == 'yes') {

	unset($_SESSION['vid_upload_token']);
	$_SESSION['vid_upload_token'] = NULL;
	$vid_upload_token			= randomcode();
	$_SESSION['vid_upload_token']	= $vid_upload_token;

	$template 		= "themes/$user_theme/templates/main_1.htm";
    	$inner_template1 	= "themes/$user_theme/templates/inner_upload_video_form.htm";      
    	$TBS 			= new clsTinyButStrong;
    	$TBS->NoErr 	= true;
    	$TBS->LoadTemplate("$template");
    	$TBS->Render 	= TBS_OUTPUT;
    	$TBS->Show();
	@mysql_close();
    	die();
}

// disply clean page
if (!isset($form_submitted) || ($form_submitted == '')) {

	unset($_SESSION['vid_upload_token']);
	$_SESSION['vid_upload_token'] = NULL;
	$vid_upload_token			= randomcode();
	$_SESSION['vid_upload_token']	= $vid_upload_token;

	$template 		= "themes/$user_theme/templates/main_1.htm";
    	$inner_template1 	= "themes/$user_theme/templates/inner_upload_video_form.htm";
    	$TBS 			= new clsTinyButStrong;
    	$TBS->NoErr 	= true;
    	$TBS->LoadTemplate("$template");
    	$TBS->Render 	= TBS_OUTPUT;
    	$TBS->Show();
    	@mysql_close();
    	die();
}

if ($procede == true && $form_submitted == 'yes') {

    //=================================START OF UPLOAD=================================
    $THIS_VERSION = '2.0';
    if (isset($_GET['cmd']) && $_GET['cmd'] == 'about') {
        kak("<u><b>UBER UPLOADER FILE UPLOAD</b></u><br>UBER UPLOADER VERSION =  <b>" .
            $UBER_VERSION . "</b><br>UU_FILE_UPLOAD = <b>" . $THIS_VERSION . "<b><br>\n");
    }
    $tmp_sid = md5(uniqid(mt_rand(), true));
    ///////////////////////////////////////////////////////////////////////
    // This is where you might set your config file eg.                  //
    // if($_SESSION['user'] == "tom"){ $config_file = 'uu_tom_config'; } //
    ///////////////////////////////////////////////////////////////////////
    $config_file = $default_config_file;
    $path_to_upload_script .= '?tmp_sid=' . $tmp_sid;
    $path_to_ini_status_script .= '?tmp_sid=' . $tmp_sid;

    if ($MULTI_CONFIGS_ENABLED) {
        $path_to_upload_script .= "&config_file=$config_file";
        $path_to_ini_status_script .= "&config_file=$config_file";
    }

    //allow form to be refilled on error
    foreach($_POST as $key=>$value) {
         $$key = $value;
    }

    $template = "themes/$user_theme/templates/main_1.htm";
    $inner_template1 = "themes/$user_theme/templates/inner_upload_video.htm";
    //$inner_template1  = "themes/$user_theme/templates/inner_see_more.htm";
    
 


    $TBS = new clsTinyButStrong;
    $TBS->NoErr = true;// no more error message displayed.
    $TBS->LoadTemplate("$template");
   //===========================================CUSTOM CODE STARTS HERE=================================================
    $TBS->MergeBlock('videos','mysql',"SELECT * FROM videos WHERE approved='yes' $sql_public_private ORDER BY indexer DESC LIMIT 0,11");
    //=================================================CUSTOM CODE ENDS HERE ========================================================
    $TBS->Render = TBS_OUTPUT;
    $TBS->Show();

    @mysql_close();
    die();
    //===============================================================END OF UPLOADER================================================================
}

function die_spammer_alerts($referer) {

global $member_uploading, $user_ip, $admin_email, $site_name;

	$subject	= 'Possible Video Spamming !!';
	$message	= "The following member uploaded a possible spam video: => " . $member_uploading . "\n\n" . "The IP used: " . $user_ip . "\n";
	$to		= $admin_email;
      $from 	= $site_name;

      mail($to, $subject, $message, "From: Video demo site");

      if ( $referer > '' ) $CONFIG_AUTO_BAN_SPAMMERS == 'YES';

      if ( $CONFIG_AUTO_BAN_SPAMMERS == 'YES' ) {

      	$deny_ip	= "deny from $user_ip\n" ;
		$ban_file	= '.htaccess';
		$fo = fopen($ban_file,'a');

        	fwrite($fo,$deny_ip);
       	fclose($fo);
    	}

      write_log($message);
}

function write_log($message) {
	global $tracking_log_file;

	if (@file_exists($tracking_log_file)) {
    		$fo = @fopen($tracking_log_file, 'a');
        	@fwrite($fo, $message);
        	@fclose($fo);

    	} else {
      	$fo = @fopen($tracking_log_file, 'w');
        	@fwrite($fo, $message);
        	@fclose($fo);
    	}

exit();
}


?>