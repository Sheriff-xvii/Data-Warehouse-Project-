--Checking the quality of the silver.cust_info table after the transformation and loading into the silver layer.

--CHECK FOR NULLS OR DUPLICATES IN THE PRIMARY KEY OF THE silver.crm_cust_info TABLE
--EXPECTATION: THERE SHOULD BE NO DUPLICATES AND NO NULLS IN THE cst_id COLUMN OF THE silver.crm_cust_info
--RESULT: PASS
SELECT 
cst_id,
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;
GO

--CHECK FOR UNWANTED SPACES IN THE cst_firstname COLUMN OF THE silver.crm_cust_info TABLE
--EXPECTATION: THERE SHOULD BE NO UNWANTED SPACES IN THE cst_firstname COLUMN OF THE silver.crm_cust_info TABLE
--RESULT: PASS
SELECT 
cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);
GO

--CHECK FOR UNWANTED SPACES IN THE cst_lastname COLUMN OF THE silver.crm_cust_info TABLE
--EXPECTATION: THERE SHOULD BE NO UNWANTED SPACES IN THE cst_lastname COLUMN OF THE silver.crm_cust_info TABLE
--RESULT: PASS
SELECT 
cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);
GO

--DATA STANDARDIZATION AND CONSISTENCY CHECK FOR THE cst_gndr COLUMN OF THE silver.crm_cust_info TABLE
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;
GO

--DATA STANDARDIZATION AND CONSISTENCY CHECK FOR THE cst_marital_status COLUMN OF THE silver.crm_cust_info TABLE
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info;
GO

SELECT * FROM 
silver.crm_cust_info;
GO