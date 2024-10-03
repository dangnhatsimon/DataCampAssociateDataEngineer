SELECT * FROM INFORMATION_SCHEMA.views;

SELECT * FROM INFORMATION_SCHEMA.views
WHERE table_schema not in ('pd_catalog','information_schema');

-- Create a view for reviews with a score above 9
CREATE VIEW high_scores AS
SELECT * FROM reviews
WHERE score > 9;

-- Create a view with the top artists in 2017
CREATE VIEW top_artists_2017 AS
-- with only one column holding the artist field
SELECT artist_title.artist FROM artist_title
INNER JOIN top_15_2017
ON artist_title.reviewId = top_15_2017.reviewId;

-- Output the new view
SELECT * FROM top_artists_2017;

/*The update privilege on an object called ratings is being granted to public. 
PUBLIC is a SQL term that encompasses all users. 
All users can now use the UPDATE command on the ratings object. In the second line, 
the user db_user will no longer be able to INSERT on the object films.*/
GRANT UPDATE ON ratings TO PUBLIC;
REVOKE INSERT ON films FROM db_user;

/*Dropping a view is straightforward with the DROP command. There are two useful parameters to know about: CASCADE and RESTRICT. 
Sometimes there are SQL objects that depend on views. For example, it's not unusual for views to build off of other views in larger databases. 
The RESTRICT parameter is the default and returns an error when you try to drop a view that other objects depend on. 
The CASCADE parameter will drop the view and any object that depends on that view.*/
DROP VIEW view_name [CASCADE|RESTRICT]

/*Redefining a view*/
CREATE OR REPLACE VIEW view_name AS new_query;

-- Redefine the artist_title view to have a label column
CREATE OR REPLACE VIEW artist_title AS
SELECT reviews.reviewid, reviews.title, artists.artist, labels.label
FROM reviews
INNER JOIN artists
ON artists.reviewid = reviews.reviewid
INNER JOIN labels
ON reviews.reviewid = labels.reviewid;

SELECT * FROM artist_title;