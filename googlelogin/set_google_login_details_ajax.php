<?php
@session_start();

$google_profile_data = json_decode($_POST['google_profile_data'], true);
$user_email_array = json_decode($google_profile_data['emails'], true);
$google_profile_details['google_user_email'] = $user_email_array[0]['value'];
$google_profile_details['google_user_gender'] = (!empty($google_profile_data['gender'])) ? $google_profile_data['gender'] : 'male';
$google_profile_details['google_user_id'] = $google_profile_data['id'];
$google_profile_details['google_user_first_name'] = $google_profile_data['name']['givenName'];
$google_profile_details['google_user_last_name'] = $google_profile_data['name']['familyName'];

// Settting these value to session
$_SESSION['google_user_profile'] = $google_profile_details;

echo 1;
exit;