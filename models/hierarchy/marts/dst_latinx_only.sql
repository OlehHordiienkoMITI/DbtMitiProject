{{
  config(
    materialized="view",
    schema="marts"
  )
}}

with latinx as (
    select date,
        state,
        cases_latinx,
        deaths_latinx,
        sum_latinx
    from {{ref("trf_latinx")}}
)

select date,
    state,
    max(cases_latinx) as max_cases_latinx,
    min(deaths_latinx) as deaths_latinx,
    sum(coalesce(cases_latinx, deaths_latinx)) as sum,
    sum(sum_latinx) as gen_sum
from latinx
group by date, state