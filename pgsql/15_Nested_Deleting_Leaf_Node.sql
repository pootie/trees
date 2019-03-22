-- When deleting a node, the process is just the opposite of adding a new node, we delete the node and its width from every node to its right.
CREATE OR REPLACE FUNCTION public.tree_delete_node(
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

	DELETE FROM nested_category WHERE lft BETWEEN _left AND _right;

	UPDATE nested_category SET rgt = rgt - _width WHERE rgt > _right;
	UPDATE nested_category SET lft = lft - _width WHERE lft > _right;
END;

$BODY$;

ALTER FUNCTION public.tree_delete_node(integer)
    OWNER TO postgres;


-- EXECUTE
select tree_delete_node(12);

-- VERIFY
SELECT CONCAT( REPEAT(' ', CAST((COUNT(parent.name) - 1) AS INTEGER)), node.name) AS name
FROM nested_category AS node,
        nested_category AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt
GROUP BY node.name, node.lft
ORDER BY node.lft;