/*

Script Purpose :
	This script creates a new database names 'DataWarehouse' after checking if it already exists.if the database exists,
	it is dropped and recreated.Additionally,the script sets up three schemas within the database :bronxe,solver and gold

WARNING :
	Running this script will drop the entire DataWarehouse database if it exists
	All data in the database will be permanantly deleted,Proceed withcaution
	and ensure you have proper backups before running this script


*/




USE master;
GO

--DROP AND RECREATE THE 'DATAWAREHOUSE' DATABASE
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')

BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO




--CREATES THE 'DATAWAREHOUSE' DATABASE AND THE 'BRONZE', 'SILVER', AND 'GOLD' SCHEMAS
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
