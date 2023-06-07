{{ config(materialized="view") }}

with
    deaths_racial as (select * from {{ ref("covid19_all_deaths") }}),

    testing as (select * from {{ ref("national_testing") }})

select
    deaths_racial.date,
    state,
    positive_cases_white,
    deaths_white,
    positive_cases_black,
    deaths_black,
    positive_cases_asian,
    deaths_asian,
    death,
    death_increase,
    hospitalized_currently,
    negative,
    negative_increase,
    positive,
    positive_increase,
    count_states
from deaths_racial
inner join testing on deaths_racial.date = testing.date