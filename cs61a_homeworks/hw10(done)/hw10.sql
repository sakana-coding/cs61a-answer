CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS

SELECT p.child AS name
FROM parents p
JOIN dogs parent_dog ON p.parent = parent_dog.name
ORDER BY parent_dog.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS

SELECT d.name AS name , s.size AS size
FROM dogs d
JOIN sizes s ON d.height > s.min AND d.height <= s.max;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child  AS sibling_pair1 , b.child AS sibling_pair2
  FROM parents a
  JOIN parents b ON a.parent = b.parent
  WHERE a.child < b.child ;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT DISTINCT 'The two siblings, ' || siblings.sibling_pair1 ||' and '||siblings.sibling_pair2 || ', have the same size: '
  ||s1.size as sentence
  FROM siblings , size_of_dogs s1,size_of_dogs s2
  WHERE s1.name = sibling_pair1 AND s2.name = sibling_pair2 AND s1.size = s2.size;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
SELECT
  fur,
  MAX(height) - MIN(height) AS distance
FROM dogs
GROUP BY fur
HAVING
  MIN(height) >= 0.7 * AVG(height)
  AND MAX(height) <= 1.3 * AVG(height);

