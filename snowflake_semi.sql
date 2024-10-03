SELECT
  name,
  categories,
  -- Select WheelchairAccessible from attributes converting it to STRING
  attributes:WheelchairAccessible::STRING AS wheelchair_accessible,
  -- Select Saturday, Sunday from hours converting it to STRING
  (hours:Saturday::STRING IS NOT NULL OR hours:Sunday::STRING IS NOT NULL) AS open_on_weekend
FROM
  yelp_business_data
WHERE
  	-- Filter where wheelchair_accessible is 'True' and open_on_weekend is 'true'
    wheelchair_accessible = 'True' AND open_on_weekend = 'true'
    -- Filter further where categories is having Italian in it
    AND categories LIKE '%Italian%'



WITH dogs_allowed AS (
  SELECT * 
  FROM yelp_business_data
  WHERE attributes:DogsAllowed::STRING  NOT ILIKE '%None%'
  AND attributes:DogsAllowed::STRING = 'True' 
)

, touristy_places AS (
  SELECT *
  FROM yelp_business_data
  WHERE attributes:Ambience NOT ILIKE '%None%'
    AND attributes:Ambience IS NOT NULL
    AND attributes:Ambience NOT ILIKE '%u''%'
  	-- Convert Ambience attribute in the attributes columns into valid JSON using PARSE_JSON.
    -- From Valid JSON, fetch the touristy attribute and check if it is true when casted to BOOLEAN.
    AND PARSE_JSON(attributes:Ambience):touristy IS NOT NULL
    AND PARSE_JSON(attributes:Ambience):touristy::BOOLEAN = true
)

SELECT
	d.business_id,
    d.name
FROM dogs_allowed d
JOIN touristy_places t
	ON d.business_id = t.business_id