-- When deleting a node, the process is just the opposite of adding a new node, we delete the node and its width from every node to its right.
BEGIN TRANSACTION;  

DECLARE @myLeft AS INT
DECLARE @myRight AS INT
DECLARE @myWidth AS INT

SELECT @myLeft = lft, @myRight = rgt, @myWidth = rgt - lft + 1
FROM nested_category
WHERE name = 'GAME CONSOLES';

DELETE FROM nested_category WHERE lft BETWEEN @myLeft AND @myRight;

UPDATE nested_category SET rgt = rgt - @myWidth WHERE rgt > @myRight;
UPDATE nested_category SET lft = lft - @myWidth WHERE lft > @myRight;

COMMIT;
