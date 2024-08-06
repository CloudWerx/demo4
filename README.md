# demo4
This repository contains SQL scripts used for data preparation and model training within the Google Cloud Platform environment, utilizing BigQuery and Vertex AI. The scripts are designed to handle taxi trip data from the Chicago Taxi Trips dataset and include steps for feature engineering, data cleaning, and model creation.

Scripts Overview

1. Data Preparation Script (feature_engineering_final.sql):
  - Description: This script creates the final_pred_dataset table by processing and preparing the Chicago Taxi Trips data.
  - Key Features:
    - Time-based Features: Extracts year, month, day, and hour from the trip start timestamp.
    - Fare-related Features: Includes columns for base fare, extras, tolls, and tips.
    - Geographic Features: Includes latitude and longitude for pickup and dropoff locations.
    - One-hot Encoding for Payment Types: Converts payment type into multiple binary columns.
    - Company Encoding: Assigns a unique numerical identifier to each taxi company.
    - Data Filtering: Filters out trips with missing or extreme values to ensure data quality.

2. Model Training Script (base_fare_training.sql):
  - Description: This script trains a linear regression model using the final_pred_dataset to predict taxi fares.
  - Model Details:
    - Model Type: Linear Regression (LINEAR_REG).
    - Target Variable: base_fare.
    - Features: Includes relevant columns such as time-based features, trip miles, trip duration, payment type, and geographic coordinates.
    - Deployment: The model is registered with Vertex AI for further use and deployment.

Usage

1. Data Preparation:
  - Run the feature_engineering_final.sql script to generate the final_pred_dataset table in your BigQuery project.
2. Model Training:
  - Use the train_base_fare_prediction_model.sql script to train a linear regression model and register it with Vertex AI.

Configuration
- BigQuery Project: Replace project and dataset names as needed.
- Vertex AI Integration: Ensure Vertex AI is set up and configured in your Google Cloud project for model registration and deployment.

Notes
- The scripts assume access to the public Chicago Taxi Trips dataset in BigQuery.
- Further customization may be required based on specific project needs and data availability.
- Feel free to clone the repository and modify the scripts to suit your data analysis and machine learning workflows. For any issues or contributions, please open a pull request or an issue on the GitHub repository.
