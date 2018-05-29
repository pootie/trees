-- Now let's produce a query that can retrieve our category tree, along with a product count for each category.
SELECT parent.name, COUNT(product.name)
FROM nested_category AS node ,
        nested_category AS parent,
        product
WHERE node.lft BETWEEN parent.lft AND parent.rgt
        AND node.category_id = product.category_id
GROUP BY parent.name
ORDER BY MIN(node.lft);