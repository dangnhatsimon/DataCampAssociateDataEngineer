/*Imagine that you love running and data. It's only natural that you begin collecting data on your weekly running routine. 
You're most concerned with tracking how long you are running each week. You also record the route and the distances of your runs. 
You gather this data and put it into one table called Runs with the following schema:*/

-- Create a route dimension table
CREATE TABLE route(
	route_id INTEGER PRIMARY KEY,
    route_name VARCHAR(160) NOT NULL,
    park_name  VARCHAR(160) NOT NULL,
    distance_km FLOAT NOT NULL,
    city_name  VARCHAR(160) NOT NULL
);
-- Create a week dimension table
CREATE TABLE week(
	week_id INTEGER PRIMARY KEY,
    week INTEGER NOT NULL,
    month  VARCHAR(160) NOT NULL,
    year INTEGER NOT NULL
);