-- Deletion of a parent node but not the children
CREATE OR REPLACE FUNCTION public.tree_delete_node_promote_children(
	__id integer)
	RETURNS void
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$

DECLARE
	_left integer;
	_right integer;	
	_width integer;
BEGIN
	SELECT lft, rgt, (rgt - lft + 1) INTO _left, _right, _width
	FROM nested_category
	WHERE category_id = __id;

	DELETE FROM nested_category WHERE lft = _left;

	UPDATE nested_category SET rgt = rgt - 1, lft = lft - 1 WHERE lft BETWEEN _left AND _right;
	UPDATE nested_category SET rgt = rgt - 2 WHERE rgt > _right;
	UPDATE nested_category SET lft = lft - 2 WHERE lft > _right;
END;

$BODY$;

ALTER FUNCTION public.tree_delete_node_promote_children(integer)
    OWNER TO postgres;

 -- EXECUTE
select tree_delete_node_promote_children(12);

-- VERIFY
SELECT CONCAT( REPEAT(' ', CAST((COUNT(parent.name) - 1) AS INTEGER)), node.name) AS name
FROM nested_category AS node,
        nested_category AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt
GROUP BY node.name, node.lft
ORDER BY node.lft;