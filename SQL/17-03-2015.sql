ALTER TABLE `member_profile` ADD `facebooklink` VARCHAR( 250 ) NOT NULL AFTER `google_id` ,
ADD `twitterlink` VARCHAR( 250 ) NOT NULL AFTER `facebooklink` ,
ADD `instagramlink` VARCHAR( 250 ) NOT NULL AFTER `twitterlink` 
