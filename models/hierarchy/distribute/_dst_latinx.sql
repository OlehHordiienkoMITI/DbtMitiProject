{{
  config(
    materialized="view",
    schema="distribute"
  )
}}

select * from {{ref("dst_latinx")}}