<?php
@session_start();
if (isset($_POST['access_code'])) {
  include_once ('google_login_general.php');    
  $client->authenticate($_POST['access_code']);
  $_SESSION['google_access_token'] = $client->getAccessToken();
}
echo 1;
exit;