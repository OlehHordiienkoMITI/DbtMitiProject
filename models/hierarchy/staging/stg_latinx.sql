{{ config(
    materialized="table",
    schema="staging"
) }}

with latinx as (
    select date,
        state, 
        cases_latinx, 
        deaths_latinx
    from covid19.city_level_cases_and_deaths
    where deaths_latinx is not null 
    AND cases_latinx is not null
)

select * from latinx