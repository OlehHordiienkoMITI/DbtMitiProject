{{
  config(
    materialized='view'
  )
}}

select concat(country, ' ',  year) as country_year,
    frequency,
    sum(deaths) as general_deaths,
    max(deaths) as max_deaths_per_month
from covid19_open_data.excess_deaths
group by country_year, frequency