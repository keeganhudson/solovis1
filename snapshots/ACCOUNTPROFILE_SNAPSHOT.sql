{% snapshot accountprofile_snapshot %}

{{
    config(
      unique_key='ENTITY_CODE',
      updated_at='INGESTION_TIME',
    )
}}

select * from {{ source('CURRENT_RAW', 'ACCOUNTPROFILE') }}

{% endsnapshot %}