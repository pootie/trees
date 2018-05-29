-- Deletion of a parent node but not the children
BEGIN TRANSACTION;  

DECLARE @myLeft AS INT
DECLARE @myRight AS INT
DECLARE @myWidth AS INT

SELECT @myLeft = lft, @myRight = rgt, @myWidth = rgt - lft + 1
FROM nested_category
WHERE name = 'PORTABLE ELECTRONICS';

DELETE FROM nested_category WHERE lft = @myLeft;

UPDATE nested_category SET rgt = rgt - 1, lft = lft - 1 WHERE lft BETWEEN @myLeft AND @myRight;
UPDATE nested_category SET rgt = rgt - 2 WHERE rgt > @myRight;
UPDATE nested_category SET lft = lft - 2 WHERE lft > @myRight;

COMMIT;
