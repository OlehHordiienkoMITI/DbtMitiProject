{{ config(
    materialized="table",
    schema="staging"
) }}

with black as (
    select date,
        state, 
        cases_black, 
        deaths_black
    from covid19.city_level_cases_and_deaths
    where deaths_black is not null 
    AND cases_black is not null
)

select * from black