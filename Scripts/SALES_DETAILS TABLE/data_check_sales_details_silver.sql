SELECT *
FROM bronze.crm_sales_details;
GO


--CHECK FOR INVALID DATES
SELECT sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0;
GO--THIS CAN BE A PROBLEM ,THERE ARE ALOT OF 0S
--This query retrieves all order dates (sls_order_dt) from the bronze.crm_sales_details table that are less than 0. This can be useful for identifying any invalid or erroneous order dates in the sales details data.


--THIS QUERY REPLACES 0s WITH NULLS IN THE sls_order_dt COLUMN, WHICH CAN HELP TO CLEAN THE DATA AND MAKE IT MORE ACCURATE FOR ANALYSIS. NULL VALUES CAN BE HANDLED MORE EFFECTIVELY IN SQL QUERIES AND ANALYTICS TO AVOID INCORRECT CALCULATIONS OR MISINTERPRETATIONS OF THE DATA.
SELECT 
NULLIF(sls_order_dt,0)
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 
OR LEN(sls_order_dt)!=8--this also checks if any date is < or > 8 digits which is also invalid as this is a date yyyymmdd
OR sls_order_dt >20500101
OR sls_order_dt <19000101;
GO

SELECT 
NULLIF(sls_ship_dt,0)
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0 
OR LEN(sls_ship_dt)!=8--this also checks if any date is < or > 8 digits which is also invalid as this is a date yyyymmdd
OR sls_ship_dt >20500101
OR sls_ship_dt <19000101;
GO

SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_order_dt OR sls_order_dt>sls_ship_dt;
GO

SELECT DISTINCT 
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales,sls_quantity,sls_price;
GO
