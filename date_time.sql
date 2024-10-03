-- Select the current date, current time
SELECT CURRENT_DATE, CURRENT_TIME

-- Select the current date, current time
-- Concatenate and convert it to TIMESTAMP
SELECT CONCAT(CURRENT_DATE, ' ', CURRENT_TIME)::TIMESTAMP

-- Select the current date, current time
-- Concatenate and convert it to TIMESTAMP
SELECT *,
-- Extract month and alias to concat_month
	EXTRACT(MONTH FROM CONCAT(CURRENT_DATE, ' ', CURRENT_TIME)::TIMESTAMP) AS concat_month
-- Use table uber_request_data where request_timestamp's month is greater than or equal to concat_month
FROM uber_request_data
WHERE EXTRACT(month FROM request_timestamp) >= concat_month