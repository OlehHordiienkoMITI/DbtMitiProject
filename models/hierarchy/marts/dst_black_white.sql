{{
  config(
    materialized="view",
    schema="marts"
  )
}}

with white as (
    select date,
        state,
        cases_white,
        deaths_white,
        sum_white
    from {{ref("trf_white")}}
),

black as (
    select date,
        state,
        cases_black,
        deaths_black,
        sum_black
    from {{ref("trf_black")}}
)

select white.date,
    white.state,
    max(cases_white) as max_cases_white,
    min(deaths_white) as deaths_white,
    sum(coalesce(cases_white, deaths_white, cases_black, deaths_black)) as sum,
    avg(sum_white) as average,
    min(cases_black) as min_cases_black,
    max(deaths_black) as max_deaths_black,
    avg(deaths_white + deaths_black) as deaths_gen
from white
inner join black on white.date = black.date
    and white.state = black.state
group by date, state