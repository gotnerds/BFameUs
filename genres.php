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
include_once ('includes/enabled_features.php');

$page_title		= $lang_browse_videos . ' ' . $lang_on .  ' ' . $site_name;
$tag_cloud 		= make_tag_cloud('videos');
$tag_cloud_block	= $tag_cloud[1];

//get all categories
$all_categories	= array();
$count_categories	= array();
//get all categories
$all_categories	= array();
$sql 		= "SELECT channel_name, channel_name_seo, channel_id FROM channels ORDER BY channel_name ASC";
$query 	= @mysql_query($sql);
while ($result = @mysql_fetch_array($query)) {
	$channel_id	= $result['channel_id'];
	$sql0 		= "SELECT indexer FROM videos WHERE channel_id = '$channel_id' AND approved = 'yes' $sql_public_private ORDER BY indexer DESC";
	$query0 		= @mysql_query($sql0);
	$result0 		= @mysql_fetch_array($query0);
	$count_videos 	= @mysql_num_rows($query0);

	// dont push array if empty or is empty in private views
	if ( $count_videos == '' ) {
		$count_videos = 0;
		$result = '';
	} else {
		$vid_count	= array('vid_count' => $count_videos);
		$new_array	= @array_merge($result, $vid_count);
		$count_categories[] = $new_array;
	}

}


$limit 		= (int) mysql_real_escape_string($config['see_more_limits']);
$pagination = pagination("SELECT channel_name, channel_name_seo, channel_id FROM channels ORDER BY channel_name ASC", $limit);
$set_limit = $pagination[0]['set_limit'];
$total_pages = $pagination[0]['total_pages'];
$current_page = $pagination[0]['current_page'];
$total_records = $pagination[0]['total_records'];
$next_page = $pagination[0]['next_page'];//use in html navigation (src)
$prev_page = $pagination[0]['prev_page'];//use in html navigation (src)
$nl = $pagination[0]['nl'];//use in html navigation: next>>
$pl = $pagination[0]['pl'];//use in html navigation: <<previous

$sql 		= "SELECT channel_name, channel_name_seo, channel_id FROM channels ORDER BY channel_name ASC LIMIT $set_limit, $limit";
$query 	= @mysql_query($sql);
while ($result = @mysql_fetch_array($query)) {
	$channel_id	= $result['channel_id'];
    $sql_query 		= "SELECT * FROM videos WHERE channel_id = '$channel_id' AND approved = 'yes' $sql_public_private ORDER BY indexer DESC LIMIT 0,1";
    $query_data 		= @mysql_query($sql_query);    
    
    $video_data = @mysql_fetch_array($query_data);
    
    //get star rating
    $video_id = mysql_real_escape_string($video_data['indexer']);
    $stars_array = stars_array($video_id);//call the stars function (results returned as array)
    //merge comments array
    $result2 = @array_merge($video_data, $stars_array);
    
    $all_categories[] = $result2;
  
}

$url = 'genres.php';								
$additional_url_variable = '?page=';

@include_once ($include_base . '/includes/pagination.inc.php');

//echo "<pre>";print_r($all_categories);exit;

//display results

$template		= "themes/$user_theme/templates/main_1.htm";
$inner_template1	= "themes/$user_theme/templates/inner_generes.htm";
$TBS			= new clsTinyButStrong;
$TBS->NoErr 	= true;

$TBS->LoadTemplate("$template");

$TBS->MergeBlock('all_categories', $all_categories);
$TBS->MergeBlock('blk1', $count_categories);

$TBS->Render 	= TBS_OUTPUT;
$TBS->Show();

@mysql_close();
die();
