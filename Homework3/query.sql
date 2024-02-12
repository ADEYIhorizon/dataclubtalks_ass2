-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `datatalks-411609.ny_taxi.external_green_tripdatav2`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-horizon/green_taxi_data_2022.parquet']
  );

-- Scanning data
SELECT COUNT(*) FROM `datatalks-411609.ny_taxi.external_green_tripdatav2`;


SELECT COUNT(DISTINCT PULocationID) FROM `datatalks-411609.ny_taxi.external_green_tripdatav2`;

-- Fare_amount = zero , fare_amount_zero
SELECT COUNT(fare_amount) AS fare_amount_zero 
FROM `datatalks-411609.ny_taxi.external_green_tripdatav2`
WHERE fare_amount = 0;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE `datatalks-411609.ny_taxi.external_green_tripdatav2_partitoned_clustered`
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PULocationID AS
SELECT * FROM `datatalks-411609.ny_taxi.external_green_tripdatav2`;