{{ config(
    materialized="table",
    schema="staging"
) }}

with asian as (
    select  date,
        state, 
        cases_asian, 
        deaths_asian
    from covid19.city_level_cases_and_deaths
    where deaths_asian is not null
)

select * from asian