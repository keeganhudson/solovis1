USE SCHEMA CURRENT_RAW;

CREATE OR REPLACE VIEW FXRATES 
COMMENT = 'VIEW TO FETCH THE MOST RECENT RECORDS' 
AS
SELECT
EXCHANGE_SOURCE_CODE,
CURRENCY_PAIR_CODE,
EFFECTIVE_DATE,
SPOT_RATE,
SOURCE_FILENAME,
INGESTION_TIME
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER(
                PARTITION BY 
                EXCHANGE_SOURCE_CODE, -- check the correctness of column used
                CURRENCY_PAIR_CODE, -- check the correctness of column used
                EFFECTIVE_DATE -- check the correctness of column used
                ORDER BY
                    INGESTION_TIME DESC
            ) AS RN
        FROM
            RAW.FXRATES
    )
WHERE
    RN = 1
ORDER BY
    EXCHANGE_SOURCE_CODE,
    CURRENCY_PAIR_CODE,
    EFFECTIVE_DATE,
    INGESTION_TIME;