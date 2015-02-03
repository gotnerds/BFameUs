<?php
///////////////////////////////////////////////////////////////////////////////////////
// PHPmotion                                                http://www.phpmotion.com //
///////////////////////////////////////////////////////////////////////////////////////
// License: You are not to sell or distribute this software without permission       //
// Help and support please visit http://www.phpmotion.com                            //
// Copyright reserved                                                                //
///////////////////////////////////////////////////////////////////////////////////////

include_once('../classes/config.php');
include_once('../siteadmin/includes/inc.stats.php');
include_once('../classes/permissions.php');

$referer = mysql_real_escape_string($_SERVER['HTTP_REFERER']);
if ( $referer == "" ) header("Location: " . "../index.php");
if ( !ereg ( $_SERVER[HTTP_HOST], $referer . '/greybox/' ) ) header("Location: " . "../index.php");


//Get ID
$id = mysql_real_escape_string($_GET['id']);

/*
if (!empty($_POST)) {
	$id = mysql_real_escape_string($_POST['id']);
}
*/
// check if uid is in the requesting url
if ($id == '') {
	ErrorDisplay1($config["invalid_request"]);
    	die();
}
/*
//check permissions again 
/////////////////////////
$usercheck = new LoadPermissions('',$id,'member_profile');  //($user_id, $content_id, $content_type);
$usercheck->CheckPermissions();
$usercheck->ActionsCheck('edit'); //Can be ( edit, delete, both ) this returns error and dies if user does not have permissions
*/

// Some basic presets
$show_notification = 0;
$page_id = $id;
$base_path = installation_paths();

// retrieve members details
////////////////////////////
/*$sql = "SELECT * FROM page_content WHERE page_id = $page_id";
$query = mysql_query($sql); 

if (mysql_num_rows($query) == 0) {
	$config["error_21"];//error
}
*/
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> PROCESS SUBMITTED FORM >>>>>>>>>>>>>>>>>>

if (isset($_POST['submit'])) {	
	   
	$page_title   = $_REQUEST['page_title'];
	$page_content = $_REQUEST['page_content'];
	if(empty($page_title)):
		echo "<p style='color:red;'>Title cannot be empty</p>";
	endif;
	if(empty($page_content)):
		echo "<p style='color:red;'>Content cannot be empty</p>";		
	endif;
	if(!empty($page_title) &&!empty($page_content)):
		$sql = "UPDATE page_content SET `page_title` = '$page_title', `page_content` = '$page_content' WHERE page_id = $page_id";
		@mysql_query($sql);
		echo '<h2>Page has been Updated</h2>';
		//notifications
		$show_notification = 1;
		$message 		   = notifications(1);
	endif;
	
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> DISPLAY RESULT >>>>>>>>>>>>>>>>>>>>>>>>>

///////////////////
// get user details
///////////////////
$sql = "SELECT * FROM page_content WHERE page_id = $page_id";
$result1 = @mysql_query($sql);
$result_active = @mysql_fetch_array($result1);

// disply page
$template = "templates/inner_edit_page.htm";
$TBS = new clsTinyButStrong;
$TBS->NoErr = true;// no more error message displayed.
$TBS->LoadTemplate("$template");
$page_title   = $result_active['page_title'];
$page_content = $result_active['page_content'];
//$TBS->MergeBlock('blk', $result_active);
$TBS->Render = TBS_OUTPUT;
$TBS->tbs_show();
@mysql_close();
die();

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>display end>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

?>
