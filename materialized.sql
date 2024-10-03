/* Instead of storing a query, a materialized view stores the query results. These query results are stored on disk. 
This means the query becomes precomputed via the view. When you query a materialized view, 
it accesses the stored query results on the disk, rather than running the query like a non-materialized view and creating a virtual table. 
Materialized views are refreshed or rematerialized when prompted. By refreshed or rematerialized, 
mean that the query is run and the stored query results are updated. 
This can be scheduled depending on how often you expect the underlying query results are changing.*/

-- Create a materialized view called genre_count 
CREATE MATERIALIZED VIEW genre_count AS
SELECT genre, COUNT(*) 
FROM genres
GROUP BY genre;

INSERT INTO genres
VALUES (50000, 'classical');

-- Refresh genre_count
REFRESH MATERIALIZED VIEW  genre_count ;

SELECT * FROM genre_count;
