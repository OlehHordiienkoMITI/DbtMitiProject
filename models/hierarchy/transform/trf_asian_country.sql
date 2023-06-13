{{
  config(
    materialized="table",
    schema="transform"
  )
}}

with asian as (

    select * from {{ ref('stg_asian') }}

)

select * from asian