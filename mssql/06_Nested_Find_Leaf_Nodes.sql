-- To find the leaf nodes, we look for nodes where rgt = lft + 1
SELECT name
FROM nested_category
WHERE rgt = lft + 1;