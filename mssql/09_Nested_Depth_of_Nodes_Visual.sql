-- We can use the depth value to indent our category names with the CONCAT and REPLICATE string functions
SELECT CONCAT(REPLICATE('  ', COUNT(parent.name) - 1), node.name) AS name
FROM nested_category AS node,
        nested_category AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt
GROUP BY node.name, node.lft
ORDER BY node.lft;