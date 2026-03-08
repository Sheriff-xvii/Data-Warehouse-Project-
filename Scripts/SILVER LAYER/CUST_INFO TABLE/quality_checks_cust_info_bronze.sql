
--This query will show all records for cst_id 29466 and assign a row number to each record based on the creation date, with the latest record getting a row number of 1. This will help us identify if there are duplicates for this specific cst_id and which one is the latest record.
SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
WHERE cst_id = 29466;
GO

--This query will show all records for cst_id 29466 and assign a row number to each record based on the creation date, with the latest record getting a row number of 1. This will help us identify if there are duplicates for this specific cst_id and which one is the latest record.
SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info;
GO

--shoqing where flag_last != 1 to show all duplicates except the latest record
SELECT*
FROM(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info)
t WHERE flag_last != 1;
GO

--shoqing where flag_last = 1 to show only the latest record for each cst_id
SELECT*
FROM(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info)
t WHERE flag_last= 1;
GO

--
SELECT*
FROM(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info)
t WHERE flag_last= 1 AND cst_id =29466 ;
GO

--Quality Check - Check for unwanted spaces in string values
--This query will show all records where the cst_firstname has leading or trailing spaces, which is a common data quality issue. The TRIM function is used to remove any leading or trailing spaces from the cst_firstname, and if the original cst_firstname is not equal to the trimmed version, it indicates that there are unwanted spaces.
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);
GO

--Quality Check - Check for unwanted spaces in string values
--This query will show all records where the cst_lastname has leading or trailing spaces, which is a common data quality issue. The TRIM function is used to remove any leading or trailing spaces from the cst_lastname, and if the original cst_lastname is not equal to the trimmed version, it indicates that there are unwanted spaces.
SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);
GO


--Quality Check - Check for unwanted spaces in string values
--This query will show all records where the cst_gndr has leading or trailing spaces, which is a common data quality issue. The TRIM function is used to remove any leading or trailing spaces from the cst_marital_status, and if the original cst_ is not equal gndrto the trimmed version, it indicates that there are unwanted spaces.
SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);
GO

--Quality Check - Check the consistency of values in low cardinality columns
--Data Standardization and Consistency 
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info;
GO
-- THIS SHOWS HOW I AM FIXING THE PROBLEM OF INCONSISTENT VALUES IN THE cst_gndr COLUMN BY USING A CASE STATEMENT TO STANDARDIZE THE VALUES
-- USING THE UPPER FUNCTION TO CONVERT THE VALUES TO UPPERCASE(INCASE OTHER DATA COMES IN THAT LOWER) AND THE TRIM FUNCTION(INCASE DATA COMES IN WITH SPACES) TO REMOVE ANY LEADING OR TRAILING SPACES BEFORE CHECKING THE VALUE OF cst_gndr. IF THE VALUE IS 'F', IT WILL BE STANDARD
/*CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		 WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		 ELSE 'unknown'
	END cst_gndr,*/




SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info;
GO
-- THIS SHOWS HOW I AM FIXING THE PROBLEM OF INCONSISTENT VALUES IN THE cst_marital_status COLUMN BY USING A CASE STATEMENT TO STANDARDIZE THE VALUES
-- USING THE UPPER FUNCTION TO CONVERT THE VALUES TO UPPERCASE(INCASE OTHER DATA COMES IN THAT LOWER) AND THE TRIM FUNCTION(INCASE DATA COMES IN WITH SPACES) TO REMOVE ANY LEADING OR TRAILING SPACES BEFORE CHECKING THE VALUE OF cst_marital_status. IF THE VALUE IS 'S', IT WILL BE STANDARDIZED TO 'Single', IF THE VALUE IS 'M', IT WILL BE STANDARDIZED TO 'Married', OTHERWISE IT WILL BE STANDARDIZED TO 'unknown'.
/*
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		 WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		 ELSE 'unknown'
	END cst_marital_status,
*/
