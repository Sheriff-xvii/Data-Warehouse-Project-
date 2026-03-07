

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
		PRINT '==========================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '==========================';


		--MAKING SURE THE TABLE IS EMPTY BEFORE LOADING DATA,BECAUSE IF WE JUST HAVE BULK INSERT AND WE EXECUTE IT AGAIN ,IT WILL CREATE DUPLICATES
		-- MEANING INSTEAD OF HAVING 18 493 ROWS YOU WILL HAVE 36 986 ROWS BECAUSE THE SAME DATA WILL BE LOADED TWICE

		PRINT '---------------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '---------------------------';

		PRINT '>>TRUNCATING TABLE : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>>INSERTING DATA INTO : bronze.crm_cust_info ';

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\sideeq.sheriff\OneDrive - PBT Group\Desktop\SQL Notes\SQL Data Warehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);
		PRINT '>>TRUNCATING TABLE : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>>INSERTING DATA INTO : bronze.crm_prd_info ';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\sideeq.sheriff\OneDrive - PBT Group\Desktop\SQL Notes\SQL Data Warehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '>>TRUNCATING TABLE : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>>INSERTING DATA INTO : bronze.crm_sales_details ';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\sideeq.sheriff\OneDrive - PBT Group\Desktop\SQL Notes\SQL Data Warehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '---------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '---------------------------';

		PRINT '>>TRUNCATING TABLE : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>>INSERTING DATA INTO : bronze.erp_cust_az12 ';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\sideeq.sheriff\OneDrive - PBT Group\Desktop\SQL Notes\SQL Data Warehouse\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '>>TRUNCATING TABLE : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>>INSERTING DATA INTO : bronze.erp_loc_a101 ';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\sideeq.sheriff\OneDrive - PBT Group\Desktop\SQL Notes\SQL Data Warehouse\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '>>TRUNCATING TABLE : bronze.erp_px_cat_glv2';
		TRUNCATE TABLE bronze.erp_px_cat_glv2;
		PRINT '>>INSERTING DATA INTO : bronze.erp_px_cat_glv2 ';
		BULK INSERT bronze.erp_px_cat_glv2
		FROM 'C:\Users\sideeq.sheriff\OneDrive - PBT Group\Desktop\SQL Notes\SQL Data Warehouse\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

	END TRY
	BEGIN CATCH
	END CATCH
END

EXEC bronze.load_bronze;

/*SELECT * FROM bronze.crm_cust_info;
SELECT * FROM bronze.crm_prd_info;
SELECT * FROM bronze.crm_sales_details;
SELECT * FROM bronze.erp_cust_az12;
SELECT * FROM bronze.erp_loc_a101;
SELECT * FROM bronze.erp_px_cat_glv2;*/
