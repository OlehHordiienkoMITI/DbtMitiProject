{{
  config(
    name="ASIIIAN",
    materialized="table",
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
),
 
aian as (
    select
    date,
    state,
    cases_aian,
    deaths_aian,
    country,
    year,
    frequency,
    deaths
    from {{ref("trf_aian_exccess")}}
)

select latinx.date,
    latinx.state,
    max(cases_latinx) as max_cases_latinx,
    min(deaths_latinx) as deaths_latinx,
    sum(coalesce(cases_latinx, deaths_latinx)) as sum,
    avg(sum_latinx + cases_aian + deaths_aian) as average,
    frequency,
    year
from latinx
inner join aian on aian.date = latinx.date 
    and aian.state = latinx.state
group by latinx.date, latinx.state, frequency, year