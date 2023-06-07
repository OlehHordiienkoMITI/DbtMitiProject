{{
  config(
    materialized='table'
  )
}}

with white as (

    select * from {{ ref('covid19_deaths_white') }}

),

asian as (

    select * from {{ ref('covid19_deaths_asian') }}

),

black as (

    select * from {{ ref('covid19_deaths_black') }}

),

cases_deaths_all as (
    select white.date, white.state, white.positive_cases_white, deaths_white,
        black.positive_cases_black, deaths_black,
        IFNULL(asian.positive_cases_asian, 0) as positive_cases_asian, IFNULL(deaths_asian, 0) as deaths_asian
    from white
    left join black on white.date = black.date and white.state = black.state
    left join asian on white.date = asian.date and white.state = asian.state
    order by white.date
)

select * from cases_deaths_all
limit 2000