<?php
include_once ('classes/config.php');
include_once ('classes/sessions.php');
include_once ('includes/reserved_names.php');

// define access for loading non display php files
define('access',true);

$ahah			= 1;
$error_message  = ""; 

if(isset($_SESSION['google_user_profile']['google_user_id']) && $_SESSION['google_user_profile']['google_user_id'] > 0 ) {
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
            $google_user_id = $_SESSION['google_user_profile']['google_user_id'];
            $google_user_email = $_SESSION['google_user_profile']['google_user_email'];
            $google_user_first_name = $_SESSION['google_user_profile']['google_user_first_name'];
            $google_user_last_name = $_SESSION['google_user_profile']['google_user_last_name'];
            $google_user_gender = ucfirst($_SESSION['google_user_profile']['google_user_gender']);
            $user_name = $_POST['user_name'];
            
            $random_code	= randomcode();
            $password_email	= generate_random_password();
            $password		= md5($password_email);
            $passwordSalt 	= substr(md5(rand()), 0, 4);    
            
            $send_confirm_email = $config['enabled_features_confirmation_email'];
            
            // Insert new user record
			$sql = "INSERT into member_profile (email_address, user_name, password, passwordSalt, first_name, last_name, user_ip, account_status, account_type, date_created, random_code, gender, google_id)
    				  VALUES ('$google_user_email', '$user_name', '$password', '$passwordSalt', '$google_user_first_name', '$google_user_last_name', '$user_ip', 'active', 'standard', NOW(), '$random_code', '$gender', $google_user_id)";

    			@mysql_query($sql) or die($config['error_26']);//error

    			// get new user_id
    			$sql = "SELECT user_id, email_address, random_code FROM member_profile WHERE random_code = '$random_code' AND email_address = '$google_user_email'";
    			$query 	= @mysql_query($sql);

    			while ($result = @mysql_fetch_array($query)) $user_id = $result['user_id'];

			// set new user default privacy settings
    			$sql = "INSERT INTO privacy (videocomments, profilecomments, privatemessage, friendsinvite, newsletter, user_id, publicfavorites, publicplaylists) VALUES ('yes', 'yes', 'yes', 'yes', 'yes', '$user_id', 'yes', 'yes')";
	    		$query 	= @mysql_query($sql);

			// send email
      		$email_template	= 'email_templates/newmembersocial.htm';
      		$subject 		= $config['email_welcome'];
      		$to 			= "linish@localmail.altd.in"; //$google_user_email;
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
    $google_id = $_SESSION['google_user_profile']['google_user_id'];;
    $sql = "SELECT user_id FROM member_profile WHERE facebook_id=".$google_id;
    $query = @mysql_query($sql);
    if(@mysql_num_rows($query) == 1) {        
        // Set the session and redirect
        
        $user_sql = "SELECT user_id, user_name, user_group, password, passwordSalt, account_status FROM member_profile WHERE google_id=".$google_id;
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
        // Check with google email
        $google_user_email = $_SESSION['google_user_profile']['google_user_email'];
        $sql = "SELECT user_id FROM member_profile WHERE email_address='".$google_user_email."'";
        $query = @mysql_query($sql);
        if(@mysql_num_rows($query) == 1) {        
            // Set the session and redirect
            
            $user_sql = "SELECT user_id, user_name, user_group, password, passwordSalt, account_status FROM member_profile WHERE email_address='".$google_user_email."'";
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
    
    $which_page = "google_login_extra_details.htm";
    
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
    
} else {
    // Redirecto to home page
    header("Location:".$config['site_base_url']);
}
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