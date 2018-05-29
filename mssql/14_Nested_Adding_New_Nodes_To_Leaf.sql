-- add a node as a child of a node that has no existing children
BEGIN TRANSACTION;  

DECLARE @myLeft AS INT

SELECT @myLeft = lft FROM nested_category
WHERE name = '2 WAY RADIOS';

UPDATE nested_category SET rgt = rgt + 2 WHERE rgt > @myLeft;
UPDATE nested_category SET lft = lft + 2 WHERE lft > @myLeft;

INSERT INTO nested_category(name, lft, rgt) VALUES('FRS', @myLeft + 1, @myLeft + 2);

COMMIT;