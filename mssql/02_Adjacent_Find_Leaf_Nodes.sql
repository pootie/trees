-- We can find all the leaf nodes in our tree (those with no children) by using a LEFT JOIN query
SELECT t1.name 
FROM category AS t1 LEFT JOIN category as t2
	ON t1.category_id = t2.parent
WHERE t2.category_id IS NULL;