CREATE OR REPLACE TABLE `genai-demo-387615.genai_demo.final_pred_dataset` AS
WITH ranked_companies AS (
  SELECT
    company,
    DENSE_RANK() OVER (ORDER BY company) AS company_encoded
  FROM
    (SELECT DISTINCT company FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`)
)

SELECT
  -- Time-based features
  EXTRACT(YEAR FROM TIMESTAMP(t.trip_start_timestamp)) AS start_year,
  EXTRACT(MONTH FROM TIMESTAMP(t.trip_start_timestamp)) AS start_month,
  EXTRACT(DAY FROM TIMESTAMP(t.trip_start_timestamp)) AS start_day,
  EXTRACT(HOUR FROM TIMESTAMP(t.trip_start_timestamp)) AS start_hour,
  
  -- Other columns (including the target variable)
  t.trip_miles,
  SAFE_DIVIDE(t.trip_seconds, 60) AS trip_duration_min,

  -- Fare-related features
  t.fare AS base_fare,
  t.extras AS fare_extras,
  t.tolls,
  t.tips AS tip_amount,

  -- One-hot encoding for payment_type
  IF(t.payment_type = 'Cash', 1, 0) AS payment_type_cash,
  IF(t.payment_type = 'Credit Card', 1, 0) AS payment_type_credit_card,
  IF(t.payment_type = 'Dispute', 1, 0) AS payment_type_dispute,
  IF(t.payment_type = 'Mobile', 1, 0) AS payment_type_mobile,
  IF(t.payment_type = 'No Charge', 1, 0) AS payment_type_no_charge,
  IF(t.payment_type = 'Pcard', 1, 0) AS payment_type_pcard,
  IF(t.payment_type = 'Prcard', 1, 0) AS payment_type_prcard,
  IF(t.payment_type = 'Prepaid', 1, 0) AS payment_type_prepaid,
  IF(t.payment_type = 'Split', 1, 0) AS payment_type_split,
  IF(t.payment_type = 'Unknown', 1, 0) AS payment_type_unknown,
  IF(t.payment_type = 'Way2ride', 1, 0) AS payment_type_way2ride,
  
  -- Label encoding for company
  r.company_encoded,
  
  -- Geographic features
  t.pickup_latitude,
  t.pickup_longitude,
  t.dropoff_latitude,
  t.dropoff_longitude
  
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips` t
JOIN
  ranked_companies r
ON
  t.company = r.company

WHERE
  -- Only include trips from 2022 and beyond
  EXTRACT(YEAR FROM TIMESTAMP(t.trip_start_timestamp)) >= 2022

  -- Remove rows with null pickup or dropoff locations
  AND t.pickup_latitude IS NOT NULL
  AND t.pickup_longitude IS NOT NULL
  AND t.dropoff_latitude IS NOT NULL
  AND t.dropoff_longitude IS NOT NULL
  
  -- Remove rows with fare > 1000 and trip miles < 1
  AND NOT (t.fare > 1000 AND t.trip_miles < 1)
  
  -- Additional conditions
  AND t.trip_miles > 0
  AND t.trip_miles IS NOT NULL
  AND t.fare > 0
  AND t.fare IS NOT NULL
  AND t.trip_seconds < 10000
  AND t.trip_seconds IS NOT NULL

ORDER BY
  start_year;
