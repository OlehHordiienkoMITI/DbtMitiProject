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

open_data as (
    select general_deaths
    from {{ref("open_data")}}
),

cases_deaths_all as (
    select white.date,
        coalesce(white.state, black.state, asian.state) as state,
        white.positive_cases_white,
        deaths_white,
        black.positive_cases_black,
        deaths_black,
        IFNULL(asian.positive_cases_asian, 0) as positive_cases_asian,
        IFNULL(deaths_asian, 0) as deaths_asian,
        general_deaths
    from white, open_data
    left join black on white.date = black.date and white.state = black.state
    left join asian on white.date = asian.date and white.state = asian.state
    where white.state = 'CA'
    order by white.date
)

select * from cases_deaths_all
limit 2000