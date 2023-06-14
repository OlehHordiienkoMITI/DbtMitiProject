{{
  config(
    materialized="table",
    schema="transform"
  )
}}

with white as (
    select  date,
        state, 
        cases_white, 
        deaths_white
    from {{ ref('stg_white') }}
),

states as (
    select state,
     state_name
    from {{ ref('stg_states') }}
)

select
    white.date,
    concat(white.state, '-', states.state_name) as state,
    white.cases_white,
    white.deaths_white,
    white.cases_white + white.deaths_white as sum_white,
    case
        when white.deaths_white < 1000 then "green"
        when white.deaths_white > 1000 and white.deaths_white < 5000 then "yellow"
        else "red"
    end as color_zone
from
    white
inner join
    states on states.state = white.state
where
    white.cases_white > 300
    and white.deaths_white > 400