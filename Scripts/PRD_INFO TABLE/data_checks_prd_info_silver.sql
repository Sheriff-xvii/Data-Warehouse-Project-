--CHECKING FOR NULLS AND DUPLICATES IN PRD_ID COLUMN OF bronze.crm_prd_info TABLE

SELECT 
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;
GO

SELECT 
prd_key,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_key
HAVING COUNT(*) > 1 OR prd_key IS NULL;
GO

--CHECKING FOR LEADING AND TRAILING SPACES IN prd_nm COLUMN OF bronze.crm_prd_info TABLE
--Result = no leading or trailing spaces in prd_nm column of bronze.crm_prd_info table
SELECT
prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm !=TRIM(prd_nm);

--CHECKING FOR NEGATIVE AND NULL VALUES IN prd_cost COLUMN OF bronze.crm_prd_info TABLE
SELECT 
prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;
GO

--DATA STANDARDIZATION AND CONSISTENCY AND CHECKING COS IT HAS LOW CARDINALITY
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;
GO
/*CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
	     WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
		 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'other sales'
		 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
		 ELSE 'Unknown' 
	END AS prd_line,*/


--CHECK FOR INVLAID DATA ORDERS
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

--==============================================================================================
--SILVER QAULITY CHECKS
--===============================================================================================
--CHECKING FOR NULLS AND DUPLICATES IN PRD_ID COLUMN OF silver.crm_prd_info TABLE

SELECT 
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;
GO

SELECT 
prd_key,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_key
HAVING COUNT(*) > 1 OR prd_key IS NULL;
GO

--CHECKING FOR LEADING AND TRAILING SPACES IN prd_nm COLUMN OF silver.crm_prd_info TABLE
--Result = no leading or trailing spaces in prd_nm column of silver.crm_prd_info table
SELECT
prd_nm
FROM silver.crm_prd_info
WHERE prd_nm !=TRIM(prd_nm);

--CHECKING FOR NEGATIVE AND NULL VALUES IN prd_cost COLUMN OF silver.crm_prd_info TABLE
SELECT 
prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;
GO

--DATA STANDARDIZATION AND CONSISTENCY AND CHECKING COS IT HAS LOW CARDINALITY
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;
GO
/*CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
	     WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
		 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'other sales'
		 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
		 ELSE 'Unknown' 
	END AS prd_line,*/


--CHECK FOR INVLAID DATA ORDERS
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;