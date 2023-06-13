{{ config(materialized="table") }}

with states as (select * from covid19.state_screenshots order by state_name)

select
    t.date,
    t.state,
    states.state_name,
    hospitalized,
    negative,
    positive,
    total_tests_people_viral
from covid19.state_testing_and_outcomes_copy t
inner join states on states.state = t.state
group by
    t.date,
    t.state,
    states.state_name,
    hospitalized,
    negative,
    positive,
    total_tests_people_viral
