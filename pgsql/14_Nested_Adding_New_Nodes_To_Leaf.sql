-- add a node as a child of a node that has no existing children
CREATE OR REPLACE FUNCTION public.tree_add_node(
	__parent_id integer,
	__name character varying)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$

DECLARE
	_left integer;
	_new_id integer := -1;
BEGIN
	SELECT lft INTO _left FROM nested_category
	WHERE category_id = __parent_id;

	UPDATE nested_category SET rgt = rgt + 2 WHERE rgt > _left;
	UPDATE nested_category SET lft = lft + 2 WHERE lft > _left;

	INSERT INTO nested_category(name, lft, rgt) VALUES(__name, _left + 1, _left + 2)
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