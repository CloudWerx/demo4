CREATE OR REPLACE MODEL `genai-demo-387615.genai_demo.base_fare_prediction_v2`
OPTIONS(
  MODEL_TYPE="LINEAR_REG",
  INPUT_LABEL_COLS=['base_fare'],
  MODEL_REGISTRY="VERTEX_AI",
  VERTEX_AI_MODEL_VERSION_ALIASES=['linear_reg', 'fare_prediction']
) AS

SELECT
  start_year,
  trip_miles,
  trip_duration_min,
  base_fare,
  fare_extras,
  tip_amount,
  payment_type_cash,
  payment_type_credit_card,
  payment_type_dispute,
  payment_type_mobile,
  payment_type_no_charge,
  payment_type_pcard,
  payment_type_prcard,
  payment_type_prepaid,
  payment_type_split,
  payment_type_unknown,
  payment_type_way2ride,
  pickup_latitude,
  pickup_longitude,
  dropoff_latitude,
  dropoff_longitude
FROM
  `genai-demo-387615.genai_demo.final_pred_dataset`