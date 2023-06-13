{{ config(
    materialized="table",
    schema="staging"
) }}

with white as (
    select date,
        state, 
        cases_white, 
        deaths_white
    from covid19.city_level_cases_and_deaths
    where deaths_white is not null 
    AND cases_white is not null
)

select * from white