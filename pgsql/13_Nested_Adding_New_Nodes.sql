-- If we wanted to add a new node between the TELEVISIONS and PORTABLE ELECTRONICS nodes, the new node would have lft and rgt values of 10 and 11, and all nodes to its right would have their lft and rgt values increased by two. 
-- We would then add the new node with the appropriate lft and rgt values.
-- FUNCTION: public.tree_add_node(integer, character varying)
-- DROP FUNCTION public.tree_add_node(integer, character varying);
CREATE OR REPLACE FUNCTION public.tree_add_node_next_to_sibling(
	__sibling_id integer,
	__name character varying)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$

DECLARE
	_right integer;
	_new_id integer := -1;
BEGIN
	SELECT rht INTO _right FROM nested_category
	WHERE category_id = __sibling_id;

	UPDATE nested_category SET rgt = rgt + 2 WHERE rgt > _right;
	UPDATE nested_category SET lft = lft + 2 WHERE lft > _right;

	INSERT INTO nested_category(name, lft, rgt) VALUES(__name, _right + 1, _right + 2)
	RETURNING category_id INTO _new_id;
	RETURN _new_id;
END;

$BODY$;

ALTER FUNCTION public.tree_add_node(integer, character varying)
    OWNER TO postgres;

-- EXECUTE
select tree_add_node(2, 'GAME CONSOLES');

-- VERIFY
SELECT CONCAT( REPEAT(' ', CAST((COUNT(parent.name) - 1) AS INTEGER)), node.name) AS name
FROM nested_category AS node,
        nested_category AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt
GROUP BY node.name, node.lft
ORDER BY node.lft;

