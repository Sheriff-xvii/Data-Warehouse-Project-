--after transforming the data, we can insert it into the silver layer for further use in the data warehouse.
INSERT INTO silver.crm_cust_info (
cst_id, cst_key, 
cst_firstname, 
cst_lastname, 
cst_marital_status, 
cst_gndr, 
cst_create_date)

--performing the transformation in order to clean up the columns after exploring what the issues are
SELECT 
	cst_id,
	cst_key,

	TRIM(cst_firstname) AS cst_firstname,
	TRIM(cst_lastname) AS cst_lastname,
	
	CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		 WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		 ELSE 'unknown'
	END cst_marital_status,

	CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		 WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		 ELSE 'unknown'
	END cst_gndr,

	cst_create_date
FROM(SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
WHERE cst_id IS NOT NULL) 
t WHERE flag_last= 1;
  
