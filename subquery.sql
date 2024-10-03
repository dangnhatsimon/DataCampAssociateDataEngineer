SELECT DISTINCT name
FROM languages
-- Add syntax to use bracketed subquery below as a filter
WHERE code IN
    (SELECT code
    FROM countries
    WHERE region = 'Middle East')
ORDER BY name;

SELECT code, name
FROM countries
WHERE continent = 'Oceania'
-- Filter for countries not included in the bracketed subquery
  AND code NOT IN
    (SELECT code
    FROM currencies);

SELECT *
FROM populations
-- Filter for only those populations where life expectancy is 1.15 times higher than average
WHERE life_expectancy > 1.15*
  (SELECT AVG(life_expectancy)
   FROM populations
   WHERE year = 2015) 
    AND year = 2015;



-- Select relevant fields from cities table
SELECT name, country_code, urbanarea_pop
FROM cities 
-- Filter using a subquery on the countries table
WHERE name IN (
    SELECT capital
    FROM countries
    WHERE countries.capital=cities.name
)
ORDER BY urbanarea_pop DESC;


-- Find top nine countries with the most cities
SELECT t1.name AS country, COUNT(t2.*) AS cities_num
FROM countries AS t1
LEFT JOIN cities AS t2
ON t1.code = t2.country_code
GROUP BY country
-- Order by count of cities as cities_num
ORDER BY cities_num DESC, country ASC
LIMIT 9;


SELECT countries.name AS country,
-- Subquery that provides the count of cities   
  (SELECT COUNT(*)
   FROM cities
   WHERE cities.country_code=countries.code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;



-- Select local_name and lang_num from appropriate tables
SELECT countries.local_name, sub.lang_num
FROM countries,
  (SELECT code, COUNT(*) AS lang_num
  FROM languages
  GROUP BY code) AS sub
-- Where codes match
WHERE sub.code = countries.code
ORDER BY lang_num DESC;


-- Select relevant fields
SELECT code, inflation_rate, unemployment_rate
FROM economies
WHERE year = 2015 
  AND code NOT IN
-- Subquery returning country codes filtered on gov_form
	(SELECT code
  FROM countries
  WHERE gov_form LIKE '%Republic%' OR gov_form LIKE '%Monarchy%')
ORDER BY inflation_rate;


-- Select fields from cities
SELECT name, country_code, city_proper_pop, metroarea_pop, (city_proper_pop / metroarea_pop * 100) AS city_perc
FROM cities
-- Use subquery to filter city name
WHERE name IN (
    SELECT capital
    FROM countries
    WHERE continent = 'Europe' OR continent LIKE '%America'
)
-- Add filter condition such that metroarea_pop does not have null values
AND metroarea_pop IS NOT NULL
-- Sort and limit the result
ORDER BY city_perc DESC
LIMIT 10;