SELECT IFNULL (resource_tags_user_team, 'Untagged') FROM cur_data; -- for mysql 
SELECT COALESCE (resource_tags_user_team, 'Untagged') FROM cur_data; --FOR ANSI
