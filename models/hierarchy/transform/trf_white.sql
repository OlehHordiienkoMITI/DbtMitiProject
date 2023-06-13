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

select white.date,
        concat(white.state, '-',states.state_name) as state,
        white.cases_white,
        white.deaths_white,
        white.cases_white + white.deaths_white as sum_white
from white
inner join states on states.state = white.state
limit 5000