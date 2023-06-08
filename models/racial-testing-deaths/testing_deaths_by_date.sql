{{ config(materialized="view") }}

with
    deaths_racial as (select * from {{ ref("covid19_all_deaths") }}),

    testing as (select * from {{ ref("national_testing") }}),

    states as (
        select *
        from covid19.state_screenshots
        order by state_name
    )
select
    deaths_racial.date,
    deaths_racial.state, 
    states.state_name,
    positive_cases_white,
    deaths_white,
    positive_cases_black,
    deaths_black,
    positive_cases_asian,
    deaths_asian,
    death as death_general,
    death_increase,
    hospitalized_currently,
    negative,
    negative_increase,
    positive,
    positive_increase
from deaths_racial
inner join testing on deaths_racial.date = testing.date
inner join states on deaths_racial.state = states.state
order by date
