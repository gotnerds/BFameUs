<?php
$path = $_SERVER['DOCUMENT_ROOT'];
//$client_id, $client_secret, $demo_redirect_uri, $demo_scope defined in this file
// make inc/vars.inc not browsable on the server
$path .= "/googlelogin/google_config.php"; 
include_once($path);

//so session vars can be used
session_start(); 

//Oauth 2.0: exchange token for session token so multiple calls can be made to api
if(isset($_REQUEST['google_access_code'])){
	$_SESSION['accessToken'] = get_oauth2_token($_REQUEST['google_access_code']);
}

//returns session token for calls to API using oauth 2.0
function get_oauth2_token($code) {
	global $google_login_client_id;
	global $google_login_client_secret;
	global $google_login_redirect_uri;
	
	$oauth2token_url = "https://accounts.google.com/o/oauth2/token";
	$clienttoken_post = array(
	"code" => $code,
	"client_id" => $google_login_client_id,
	"client_secret" => $google_login_client_secret,
	"redirect_uri" => $google_login_redirect_uri,
	"grant_type" => "authorization_code"
	);
	
	$curl = curl_init($oauth2token_url);

	curl_setopt($curl, CURLOPT_POST, true);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $clienttoken_post);
	curl_setopt($curl, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

	$json_response = curl_exec($curl);
	curl_close($curl);

	$authObj = json_decode($json_response);
	
	if (isset($authObj->refresh_token)){
		global $refreshToken;
		$refreshToken = $authObj->refresh_token;
	}
	$accessToken = $authObj->access_token;
	return $accessToken;
}
//calls api and gets the data
function call_api($accessToken,$url){
	$curl = curl_init($url);
 
	curl_setopt($curl, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, true);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);	
	$curlheader[0] = "Authorization: Bearer " . $accessToken;
	curl_setopt($curl, CURLOPT_HTTPHEADER, $curlheader);

	$json_response = curl_exec($curl);
	curl_close($curl);
		
	$responseObj = json_decode($json_response);
	return $responseObj;	    
}

$loginUrl = sprintf("https://accounts.google.com/o/oauth2/auth?scope=%s&state=%s&redirect_uri=%s&response_type=code&client_id=%s",$google_login_scope,$google_login_state,$google_login_redirect_uri,$google_login_client_id);
?>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>OAuth 2.0 Demo Page</title>
<link rel="stylesheet" type="text/css" href="css/960.css" media="screen" />
<link rel="stylesheet" type="text/css" href="css/style.css" media="screen" />
</head>

<body>
<div id="wrapper">
	
	<div id="header" class="container_16">
		<h1><span>Google API</span> with OAuth 2 Demo <span>PHP</span></h1>
	</div>
    
<div id="content-wrap" class="container_16">   
<div class="grid_8 prefix_4 suffix_4"> 
	<h2>Authorize</h2>
	<p><a class="button" href="<?php echo $loginUrl ?>">Grant access with Google account for basic user info</a></p>
    <p>Demo will return the name on your Google account. It does not ask for offline access.</p>
    <p>You can revoke access by:</p> 
    <ol>
    <li>going to your Google Account Settings</li>
    <li>click "Edit" next to Authorizing applications &amp; sites</li>
    <li>click "Revoke Access" next to the app</li>
    </ol>
    </p>
 <?php
	if (isset($_SESSION['accessToken'])){
		$accountObj = call_api($_SESSION['accessToken'],"https://www.googleapis.com/oauth2/v1/userinfo");
		$your_name =  $accountObj->name;
		echo "<p class='successMessage'>The name on your Google account is: " . $your_name . "</p>";
		session_unset();
	}
	if(isset($_REQUEST['error'])){
		echo "<p class='errorMessage'>Error: " . $_REQUEST['error'] . "</p>";
	}
?> 
</div>   
</div>
</div>
</body>
</html>
<?php
/*
include_once ('classes/config.php');
include_once ('classes/sessions.php');
include_once ('includes/reserved_names.php');
include_once ('googlelogin/google_config.php');
session_start();

// define access for loading non display php files
define('access',true);

$ahah			= 1;
$error_message  = ""; 


exit;

$facebook = new Facebook(array(
  'appId'  => FACEBOOK_APP_ID,
  'secret' => FACEBOOK_APP_SECRET_KEY,
));


$user = $facebook->getUser();

if($user) {
    try {
        $user_profile = $facebook->api('/me');
        
        if(isset($_POST['registe_r']) && $_POST['registe_r'] == "Register now") {
            $procede = true;
            // check against reserved names e.g. -> admin etc... or adult words ban
            $user_name = $_POST['user_name'];
            if ( in_array( $user_name, $reserved_names ) ) {
                $display_key = @str_replace('_', ' ', $key);
                $error_message = $error_message . ' ' .$config['username_not_allowed'] . ' !';
                $procede = false;
                $error_message = ' '.$config['username_not_allowed'];
            }
            
            // checking if username and email is unique
            if ( $procede == true ) {    
            	$sql = "SELECT user_name FROM member_profile";
            	$query = @mysql_query($sql);
            
            	while ($result = (@mysql_fetch_array($query))) {    
                  	if ( !empty($result['user_name'])) {    
                  		// case insensitive login and registration
                		$reg_user_name	= strtolower($user_name);
                		$db_user_name 	= strtolower($result['user_name']);
        
                    	if ($db_user_name == $reg_user_name) {
                    		$error_message = ' '.$config['username_is taken'];
                    		$procede = false;
                    	}
                    }
                }
            }    
            
            if($procede == true) {
    
                //header("Location:facebook_redirect.php");            
                $facebook_user_id = $user_profile['id'];
                $facebook_user_email = $user_profile['email'];
                $facebook_user_first_name = $user_profile['first_name'];
                $facebook_user_last_name = $user_profile['last_name'];
                $gender = ucfirst($user_profile['gender']);
                $user_name = $_POST['user_name'];
                
                $random_code	= randomcode();
                $password_email	= generate_random_password();
                $password		= md5($password_email);
                $passwordSalt 	= substr(md5(rand()), 0, 4);    
                
                $send_confirm_email = $config['enabled_features_confirmation_email'] ;
                
                // Insert new user record
    			$sql = "INSERT into member_profile (email_address, user_name, password, passwordSalt, first_name, last_name, user_ip, account_status, account_type, date_created, random_code, gender, facebook_id)
        				  VALUES ('$facebook_user_email', '$user_name', '$password', '$passwordSalt', '$facebook_user_first_name', '$facebook_user_last_name', '$user_ip', 'active', 'standard', NOW(), '$random_code', '$gender', $facebook_user_id)";
    
        			@mysql_query($sql) or die($config['error_26']);//error
    
        			// get new user_id
        			$sql = "SELECT user_id, email_address, random_code FROM member_profile WHERE random_code = '$random_code' AND email_address = '$facebook_user_email'";
        			$query 	= @mysql_query($sql);
    
        			while ($result = @mysql_fetch_array($query)) $user_id = $result['user_id'];
    
    			// set new user default privacy settings
        			$sql = "INSERT INTO privacy (videocomments, profilecomments, privatemessage, friendsinvite, newsletter, user_id, publicfavorites, publicplaylists) VALUES ('yes', 'yes', 'yes', 'yes', 'yes', '$user_id', 'yes', 'yes')";
    	    		$query 	= @mysql_query($sql);
    
    			// send email
          		$email_template	= 'email_templates/newmembersocial.htm';
          		$subject 		= $config['email_welcome'];
          		$to 			= $facebook_user_email;
          		$from 		= $config['notifications_from_email'];
    
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
                
                // Set the session and redirect
                
                $user_sql = "SELECT user_id, user_name, user_group, password, passwordSalt, account_status FROM member_profile WHERE user_id=".$user_id;
                $result_user = @mysql_query($user_sql);
                $output_user = @mysql_fetch_array($result_user);
    			
        		@session_start();
            	@session_register('user_id');
            	@session_register('user_name');
            	@session_register('user_group');
            	$_SESSION['user_id']		= $output_user['user_id'];
            	$_SESSION['user_name']		= $output_user['user_name'];
            	$_SESSION['user_group']		= $output_user['user_group'];
            	$password				= $output_user['password'];
            	$passwordSalt			= $output_user['passwordSalt'];
            	$loggedin				= 1;
                
                @mysql_close();            
                
                header("Location: " . "myaccount.php");	//redirect to Myaccount page                            
            }
        }
        
        // Check whether user exist
        $facebook_id = $user_profile['id'];
        $sql = "SELECT user_id FROM member_profile WHERE facebook_id=".$facebook_id;
        $query = @mysql_query($sql);
        if(@mysql_num_rows($query) == 1) {        
            // Set the session and redirect
            
            $user_sql = "SELECT user_id, user_name, user_group, password, passwordSalt, account_status FROM member_profile WHERE facebook_id=".$facebook_id;
            $result_user = @mysql_query($user_sql);
            $output_user = @mysql_fetch_array($result_user);
        	
        	@session_start();
        	@session_register('user_id');
        	@session_register('user_name');
        	@session_register('user_group');
        	$_SESSION['user_id']		= $output_user['user_id'];
        	$_SESSION['user_name']		= $output_user['user_name'];
        	$_SESSION['user_group']		= $output_user['user_group'];
        	$password				= $output_user['password'];
        	$passwordSalt			= $output_user['passwordSalt'];
        	$loggedin				= 1;
            
            @mysql_close();            
            
            header("Location: " . "myaccount.php");	//redirect to Myaccount page         
        } else {
            // Check with facebook email
            $facebook_email = $user_profile['email'];
            $sql = "SELECT user_id FROM member_profile WHERE email_address='".$facebook_email."'";
            $query = @mysql_query($sql);
            if(@mysql_num_rows($query) == 1) {        
                // Set the session and redirect
                
                $user_sql = "SELECT user_id, user_name, user_group, password, passwordSalt, account_status FROM member_profile WHERE email_address='".$facebook_email."'";
                $result_user = @mysql_query($user_sql);
                $output_user = @mysql_fetch_array($result_user);
            	
            	@session_start();
            	@session_register('user_id');
            	@session_register('user_name');
            	@session_register('user_group');
            	$_SESSION['user_id']		= $output_user['user_id'];
            	$_SESSION['user_name']		= $output_user['user_name'];
            	$_SESSION['user_group']		= $output_user['user_group'];
            	$password				= $output_user['password'];
            	$passwordSalt			= $output_user['passwordSalt'];
            	$loggedin				= 1;
                
                @mysql_close();            
                
                header("Location: " . "myaccount.php");	//redirect to Myaccount page         
            }             
        }
        
        $which_page = "facebook_extra_details.htm";
        
        $template		= "themes/$user_theme/templates/main_1.htm";
        $inner_template1 = "themes/$user_theme/templates/$which_page";//middle of page
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
    catch (FacebookApiException $e) {
        $user = null;
        header("Location:".$config['site_base_url']);
    }
}*/