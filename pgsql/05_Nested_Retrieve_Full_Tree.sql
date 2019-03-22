-- We can retrieve the full tree through the use of a self-join that links parents with nodes on the basis that a node’s lft value will always appear between its parent’s lft and rgt values
SELECT node.name
FROM nested_category AS node,
        nested_category AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt
        AND parent.name = 'ELECTRONICS'
ORDER BY node.lft;
