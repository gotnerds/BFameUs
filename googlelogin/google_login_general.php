<?php
include_once realpath(dirname(__FILE__) . '/google_config.php');

require_once realpath(dirname(__FILE__) . '/autoload.php');

/************************************************
  Make an API request on behalf of a user. In
  this case we need to have a valid OAuth 2.0
  token for the user, so we need to send them
  through a login flow. To do this we need some
  information from our API console project.
 ************************************************/
$client = new Google_Client();
$client->setClientId(GOOGLE_LOGIN_CLIENT_ID);
$client->setClientSecret(GOOGLE_LOGIN_CLIENT_SECRET);
$client->setRedirectUri(GOOGLE_LOGIN_REDIRECT_URI);
$client->addScope("https://www.googleapis.com/auth/plus.login");
$client->addScope("https://www.googleapis.com/auth/plus.profile.emails.read");