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
$hot_videos	= array();
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
$pagination = pagination("SELECT * FROM videos WHERE approved='yes' $sql_public_private ORDER BY number_of_views DESC", $limit);
$set_limit = $pagination[0]['set_limit'];
$total_pages = $pagination[0]['total_pages'];
$current_page = $pagination[0]['current_page'];
$total_records = $pagination[0]['total_records'];
$next_page = $pagination[0]['next_page'];//use in html navigation (src)
$prev_page = $pagination[0]['prev_page'];//use in html navigation (src)
$nl = $pagination[0]['nl'];//use in html navigation: next>>
$pl = $pagination[0]['pl'];//use in html navigation: <<previous

$sql = "SELECT * FROM videos WHERE approved='yes' $sql_public_private ORDER BY number_of_views DESC LIMIT $set_limit, $limit";
$query 	= @mysql_query($sql);
while ($result = @mysql_fetch_array($query)) {
		//get comments inforation
        $video_id = mysql_real_escape_string($result['indexer']);
        $sql2 = "SELECT * FROM videocomments WHERE video_id = $video_id";
        $query2 = @mysql_query($sql2);
        $comments_number = @mysql_num_rows($query2);
        $comments_array = array('comments' => $comments_number);

        //get star rating
        $stars_array = stars_array($video_id);//call the stars function (results returned as array)

        //merge comments array
        $result2 = @array_merge($result, $comments_array, $stars_array);
        $hot_videos[] = $result2;
  
}

$url = 'hot_videos.php';
$additional_url_variable = '?page=';

@include_once ($include_base . '/includes/pagination.inc.php');

//display results

$template		= "themes/$user_theme/templates/main_1.htm";
$inner_template1	= "themes/$user_theme/templates/inner_hot_videos.htm";
$TBS			= new clsTinyButStrong;
$TBS->NoErr 	= true;

$TBS->LoadTemplate("$template");

$TBS->MergeBlock('hot_videos', $hot_videos);
$TBS->MergeBlock('blk1', $count_categories);

$TBS->Render 	= TBS_OUTPUT;
$TBS->Show();

@mysql_close();
die();
