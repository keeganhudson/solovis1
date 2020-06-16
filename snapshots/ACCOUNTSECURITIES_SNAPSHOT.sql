{% snapshot accountsecurities_snapshot %}

{{
    config(
      unique_key="ENTITY_CODE||'-'||UNIQUE_SECURITY_ID",
      updated_at='INGESTION_TIME',
    )
}}

select * from {{ source('CURRENT_RAW', 'ACCOUNTSECURITIES') }}

{% endsnapshot %}