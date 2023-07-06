{{
  config(
    materialized="view",
    schema="marts"
  )
}}

with asian as (
    select date,
        state,
        cases_asian,
        deaths_asian,
        sum_asian
    from {{ref('trf_asian')}}
)

select date,
    state,
    max(cases_asian) as max_cases_asian,
    min(deaths_asian) as deaths_asian,
    sum(coalesce(cases_asian, deaths_asian)) as sum,
    avg(sum_asian) as average,
    {{ var('names') }} as hpp
from asian
group by date, state