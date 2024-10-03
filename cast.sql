-- Convert request_id to VARCHAR using CAST method and alias to request_id_string
SELECT CAST(request_id AS VARCHAR) AS request_id_string, 
-- Convert request_timestamp to DATE using TO_DATE and alias as request_date
	   TO_DATE(request_timestamp) AS request_date,
-- Convert drop_timestamp column to TIME using :: operator and alias to drop_time
       drop_timestamp::TIME AS drop_time
FROM uber_request_data
-- Filter the records where request_date is greater than '2016-06-01' and drop_time is less than 6 AM.
WHERE request_date > '2016-06-01' 
       AND drop_time < '06:00:00'
