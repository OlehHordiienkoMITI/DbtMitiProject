{{
  config(
    materialized="view",
    schema="distribute"
  )
}}

select * from {{ref("dst_black_white")}}