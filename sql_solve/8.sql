SELECT 
    COUNT(*) AS total_rows,
    COUNT(resource_tags_user_team) AS tagged_count,
    COUNT(*) - COUNT(resource_tags_user_team) AS untagged_count
FROM cur_data;