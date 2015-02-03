<?php

//Menu Loaders
///////////////
$top_menu = 'members';
$side_menu = 'members';

@include_once ("../classes/config.php");
@include_once ("includes/inc.stats.php");
@include_once ("includes/functions.php");
@include_once ('includes/login_check.php');

//defaults settings /
/////////////////////
$show_hide = 1;
$show_notification = 0;
$todays_date = $config["date_format"];
$base_url = $config['site_base_url'];
$limit = $config["admin_maximum_display"];
$result_active = array();
$dashboard_header = $lang_members;
 
 
$sort = 'page_title';
$sort_order = 'ASC';
$order_by_title = 2;   
 
$pagination = pagination("SELECT * FROM page_content",$limit);

$set_limit		= $pagination[0]['set_limit'];
$total_pages 	= $pagination[0]['total_pages'];
$current_page 	= $pagination[0]['current_page'];
$total_records 	= $pagination[0]['total_records'];
$next_page 		= $pagination[0]['next_page'];//use in html navigation (src)
$prev_page 		= $pagination[0]['prev_page'];//use in html navigation (src)
$nl 			= $pagination[0]['nl'];//use in html navigation: next>>
$pl 			= $pagination[0]['pl'];//use in html navigation: <<previous

$result_sql	= "SELECT * FROM page_content LIMIT $set_limit, $limit";

$result_active = array();
$query = @mysql_query($result_sql);
while ($result1 = @mysql_fetch_array($query)) {
	$result_active[] = $result1;
} 

$result_active = arr_keys_multisort($result_active,$sort,$sort_order);

$url = 'list_pages.php';

$additional_url_variable = "?action=0&page=";


@include_once ($include_base . '/includes/pagination.inc.php');
//PAGINATION PLUS >> end

//Display Results >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//MENU LOADER
/////////////

include_once ("includes/menuloader.php");

//set condition for hidding navigation & 'no items found' block
if (empty($result_active)) {
    $show = 1;
}
else {
    $show = 2;
} 
////////////////////////////////
//display form with error message
////////////////////////////////
// $show_content_menu = 1;//display top tabs as set in /includes/menuloader
$template = "templates/main.html";
$inner_template1 = "templates/inner_pages.htm";//middle of page
$TBS = new clsTinyButStrong;
$TBS->NoErr = true;// no more error message displayed.
$TBS->LoadTemplate("$template");
$TBS->MergeBlock('blk1',$result_active);
$TBS->Render = TBS_OUTPUT;
$TBS->Show();
@mysql_close();
die();

?>