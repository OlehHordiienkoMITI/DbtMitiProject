{{ config(
    materialized="table",
    schema="staging",
     tags=["tag1", "tag2"]
) }}

with aian as (
    select  date,
        state, 
        cases_aian, 
        deaths_aian
    from covid19.city_level_cases_and_deaths
    where deaths_aian is not null
)

select * from aian