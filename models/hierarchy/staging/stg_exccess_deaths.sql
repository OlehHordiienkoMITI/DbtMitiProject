{{
  config(
    materialized="table",
    schema="staging"
  )
}}

with open_data as(
    select country, 
    year,
    frequency,
    deaths
from covid19_open_data.excess_deaths
)

select * from open_data