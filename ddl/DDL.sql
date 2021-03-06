-- Roles
USE ROLE SECURITYADMIN;
CREATE ROLE SS_DBA;
CREATE ROLE SS_INGESTION_SA;
CREATE ROLE SS_TRANSFORMATION_SA;
CREATE ROLE SS_READER_SA;

GRANT ROLE SS_DBA TO ROLE SYSADMIN;
GRANT ROLE SS_INGESTION_SA TO ROLE SYSADMIN;
GRANT ROLE SS_TRANSFORMATION_SA TO ROLE SYSADMIN;
GRANT ROLE SS_READER_SA TO ROLE SYSADMIN;

GRANT ROLE SS_INGESTION_SA TO ROLE SS_DBA;
GRANT ROLE SS_TRANSFORMATION_SA TO ROLE SS_DBA;
GRANT ROLE SS_READER_SA TO ROLE SS_DBA;

USE ROLE ACCOUTNADMIN;
GRANT CREATE INTEGRATION ON ACCOUNT TO ROLE SS_DBA;

USE ROLE SYSADMIN;
GRANT CREATE DATABASE ON ACCOUNT TO ROLE SS_DBA;

-- Warehouses
USE ROLE SYSADMIN;
CREATE WAREHOUSE SS_DBA_WH WITH WAREHOUSE_SIZE=XSMALL AUTO_SUSPEND=60 INITIALLY_SUSPENDED=TRUE;
GRANT OPERATE, USAGE ON WAREHOUSE SS_DBA_WH TO ROLE SS_DBA;

CREATE WAREHOUSE SS_INGESTION_WH WITH WAREHOUSE_SIZE=XSMALL AUTO_SUSPEND=60 INITIALLY_SUSPENDED=TRUE;
GRANT OPERATE, USAGE ON WAREHOUSE SS_INGESTION_WH TO ROLE SS_INGESTION_SA;

CREATE WAREHOUSE SS_TRANSFORM_WH WITH WAREHOUSE_SIZE=XSMALL AUTO_SUSPEND=60 INITIALLY_SUSPENDED=TRUE;
GRANT OPERATE, USAGE ON WAREHOUSE SS_TRANSFORM_WH TO ROLE SS_TRANSFORMATION_SA;

CREATE WAREHOUSE SS_READER_WH WITH WAREHOUSE_SIZE=XSMALL AUTO_SUSPEND=60 INITIALLY_SUSPENDED=TRUE;
GRANT OPERATE, USAGE ON WAREHOUSE SS_READER_WH TO ROLE SS_READER_SA;

-- Database and Schemas
USE ROLE SS_DBA;
CREATE OR REPLACE DATABASE SS_DEV;

USE DATABASE SS_DEV;
CREATE OR REPLACE SCHEMA RAW;
CREATE OR REPLACE SCHEMA SNAPSHOTS;
CREATE OR REPLACE SCHEMA CURRENT_RAW;
CREATE OR REPLACE SCHEMA CURATED_DIMENSIONS;
CREATE OR REPLACE SCHEMA CURATED_FACTS;
CREATE OR REPLACE SCHEMA CURATED_MISC;

CREATE OR REPLACE DATABASE SS_PROD;

USE DATABASE SS_PROD;
CREATE OR REPLACE SCHEMA RAW;
CREATE OR REPLACE SCHEMA SNAPSHOTS;
CREATE OR REPLACE SCHEMA CURRENT_RAW;
CREATE OR REPLACE SCHEMA CURATED_DIMENSIONS;
CREATE OR REPLACE SCHEMA CURATED_FACTS;
CREATE OR REPLACE SCHEMA CURATED_MISC;

-- Access Roles
USE ROLE SECURITYADMIN;

-- DEV
CREATE ROLE SS_DEV_READ;
CREATE ROLE SS_DEV_WRITE;

GRANT ROLE SS_DEV_READ TO ROLE SYSADMIN;
GRANT ROLE SS_DEV_WRITE TO ROLE SYSADMIN;

GRANT ROLE SS_DEV_READ TO ROLE SS_INGESTION_SA;
GRANT ROLE SS_DEV_WRITE TO ROLE SS_INGESTION_SA;

GRANT ROLE SS_DEV_READ TO ROLE SS_TRANSFORMATION_SA;
GRANT ROLE SS_DEV_WRITE TO ROLE SS_TRANSFORMATION_SA;

GRANT ROLE SS_DEV_READ TO ROLE SS_READER_SA;

GRANT USAGE ON DATABASE SS_DEV TO ROLE SS_DEV_READ;
GRANT USAGE ON ALL SCHEMAS IN DATABASE SS_DEV TO ROLE SS_DEV_READ;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE SS_DEV TO ROLE SS_DEV_READ;

GRANT SELECT ON ALL TABLES IN SCHEMA SS_DEV.RAW TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_DEV.RAW TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA SS_DEV.SNAPSHOTS TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_DEV.SNAPSHOTS TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA SS_DEV.CURRENT_RAW TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_DEV.CURRENT_RAW TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA SS_DEV.CURATED_DIMENSIONS TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_DEV.CURATED_DIMENSIONS TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA SS_DEV.CURATED_FACTS TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_DEV.CURATED_FACTS TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA SS_DEV.CURATED_MISC TO ROLE SS_DEV_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_DEV.CURATED_MISC TO ROLE SS_DEV_READ;
GRANT SELECT ON FUTURE TABLES IN DATABASE SS_DEV TO ROLE SS_DEV_READ;
GRANT SELECT ON FUTURE VIEWS IN DATABASE SS_DEV TO ROLE SS_DEV_READ;
GRANT SELECT ON FUTURE MATERIALIZED VIEWS IN DATABASE SS_DEV TO ROLE SS_DEV_READ;

GRANT USAGE ON DATABASE SS_DEV TO ROLE SS_DEV_WRITE;
GRANT USAGE ON ALL SCHEMAS IN DATABASE SS_DEV TO ROLE SS_DEV_WRITE;
-- Fine tune these privileges later
GRANT ALL PRIVILEGES ON ALL SCHEMAS IN DATABASE SS_DEV TO ROLE SS_DEV_WRITE;
GRANT ALL PRIVILEGES ON FUTURE SCHEMAS IN DATABASE SS_DEV TO ROLE SS_DEV_WRITE;

GRANT ALL ON ALL TABLES IN SCHEMA SS_DEV.RAW TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_DEV.RAW TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_DEV.RAW TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_DEV.SNAPSHOTS TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_DEV.SNAPSHOTS TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_DEV.SNAPSHOTS TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_DEV.CURRENT_RAW TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_DEV.CURRENT_RAW TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_DEV.CURRENT_RAW TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_DEV.CURATED_DIMENSIONS TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_DEV.CURATED_DIMENSIONS TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_DEV.CURATED_DIMENSIONS TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_DEV.CURATED_FACTS TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_DEV.CURATED_FACTS TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_DEV.CURATED_FACTS TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_DEV.CURATED_MISC TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_DEV.CURATED_MISC TO ROLE SS_DEV_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_DEV.CURATED_MISC TO ROLE SS_DEV_WRITE;
GRANT ALL ON FUTURE TABLES IN DATABASE SS_DEV TO ROLE SS_DEV_WRITE;
GRANT ALL ON FUTURE VIEWS IN DATABASE SS_DEV TO ROLE SS_DEV_WRITE;
GRANT ALL ON FUTURE MATERIALIZED VIEWS IN DATABASE SS_DEV TO ROLE SS_DEV_WRITE;

-- PROD

-- Access Roles
USE ROLE SECURITYADMIN;

CREATE ROLE SS_PROD_READ;
CREATE ROLE SS_PROD_WRITE;

GRANT ROLE SS_PROD_READ TO ROLE SYSADMIN;
GRANT ROLE SS_PROD_WRITE TO ROLE SYSADMIN;

GRANT ROLE SS_PROD_READ TO ROLE SS_INGESTION_SA;
GRANT ROLE SS_PROD_WRITE TO ROLE SS_INGESTION_SA;

GRANT ROLE SS_PROD_READ TO ROLE SS_TRANSFORMATION_SA;
GRANT ROLE SS_PROD_WRITE TO ROLE SS_TRANSFORMATION_SA;

GRANT ROLE SS_PROD_READ TO ROLE SS_READER_SA;

GRANT USAGE ON DATABASE SS_PROD TO ROLE SS_PROD_READ;
GRANT USAGE ON ALL SCHEMAS IN DATABASE SS_PROD TO ROLE SS_PROD_READ;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE SS_PROD TO ROLE SS_PROD_READ;

GRANT SELECT ON ALL TABLES IN SCHEMA SS_PROD.RAW TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_PROD.RAW TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA SS_PROD.SNAPSHOTS TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_PROD.SNAPSHOTS TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA SS_PROD.CURRENT_RAW TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_PROD.CURRENT_RAW TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA SS_PROD.CURATED_DIMENSIONS TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_PROD.CURATED_DIMENSIONS TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA SS_PROD.CURATED_FACTS TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_PROD.CURATED_FACTS TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA SS_PROD.CURATED_MISC TO ROLE SS_PROD_READ;
GRANT SELECT ON ALL VIEWS IN SCHEMA SS_PROD.CURATED_MISC TO ROLE SS_PROD_READ;
GRANT SELECT ON FUTURE TABLES IN DATABASE SS_PROD TO ROLE SS_PROD_READ;
GRANT SELECT ON FUTURE VIEWS IN DATABASE SS_PROD TO ROLE SS_PROD_READ;
GRANT SELECT ON FUTURE MATERIALIZED VIEWS IN DATABASE SS_PROD TO ROLE SS_PROD_READ;

GRANT USAGE ON DATABASE SS_PROD TO ROLE SS_PROD_WRITE;
GRANT USAGE ON ALL SCHEMAS IN DATABASE SS_PROD TO ROLE SS_PROD_WRITE;
-- Fine tune these privileges later
GRANT ALL PRIVILEGES ON ALL SCHEMAS IN DATABASE SS_PROD TO ROLE SS_PROD_WRITE;
GRANT ALL PRIVILEGES ON FUTURE SCHEMAS IN DATABASE SS_PROD TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_PROD.RAW TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_PROD.RAW TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_PROD.RAW TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_PROD.SNAPSHOTS TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_PROD.SNAPSHOTS TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_PROD.SNAPSHOTS TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_PROD.CURRENT_RAW TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_PROD.CURRENT_RAW TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_PROD.CURRENT_RAW TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_PROD.CURATED_DIMENSIONS TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_PROD.CURATED_DIMENSIONS TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_PROD.CURATED_DIMENSIONS TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_PROD.CURATED_FACTS TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_PROD.CURATED_FACTS TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_PROD.CURATED_FACTS TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL TABLES IN SCHEMA SS_PROD.CURATED_MISC TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL VIEWS IN SCHEMA SS_PROD.CURATED_MISC TO ROLE SS_PROD_WRITE;
GRANT ALL ON ALL MATERIALIZED VIEWS IN SCHEMA SS_PROD.CURATED_MISC TO ROLE SS_PROD_WRITE;
GRANT ALL ON FUTURE TABLES IN DATABASE SS_PROD TO ROLE SS_PROD_WRITE;
GRANT ALL ON FUTURE VIEWS IN DATABASE SS_PROD TO ROLE SS_PROD_WRITE;
GRANT ALL ON FUTURE MATERIALIZED VIEWS IN DATABASE SS_PROD TO ROLE SS_PROD_WRITE;

--Users