INSERT INTO silver.crm_sales_details (sls_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price)

SELECT
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	CASE WHEN sls_order_dt <0 OR LEN(sls_order_dt) !=8 THEN NULL
	     ELSE CAST(CAST(sls_order_dt AS VARCHAR)AS DATE)
	END AS sls_order_dt,

	CASE WHEN sls_ship_dt <0 OR LEN(sls_ship_dt) !=8 THEN NULL
	     ELSE CAST(CAST(sls_ship_dt AS VARCHAR)AS DATE)
	END AS sls_ship_dt,

	CASE WHEN sls_due_dt <0 OR LEN(sls_due_dt) !=8 THEN NULL
	     ELSE CAST(CAST(sls_due_dt AS VARCHAR)AS DATE)
	END AS sls_due_dt,

	CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price) 
	THEN sls_quantity * ABS(sls_price)
		 ELSE sls_sales
	END AS sls_sales,
	
	sls_quantity,

	CASE WHEN sls_price IS NULL OR sls_price <=0 
	THEN sls_sales / NULLIF(sls_quantity,0) --This calculates the price by dividing the sales amount by the quantity, while using NULLIF to avoid division by zero errors.
		 ELSE sls_price
	END AS sls_price

FROM bronze.crm_sales_details


/*WHERE sls_prd_key NOT IN(SELECT prd_key FROM silver.crm_prd_info); --This query retrieves all sales details from the bronze.crm_sales_details table where the product key (sls_prd_key) does not exist in the silver.crm_prd_info table. This can be useful for identifying sales records that are associated with products that have not yet been loaded into the silver layer of the data warehouse.*/