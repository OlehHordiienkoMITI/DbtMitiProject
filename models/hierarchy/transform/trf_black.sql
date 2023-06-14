{{
  config(
    materialized="table",
    schema="transform"
  )
}}

with black as (
    select  date,
        state, 
        cases_black, 
        deaths_black
    from {{ ref('stg_black') }}
),

states as (
    select state,
     state_name
    from {{ ref('stg_states') }}
)

select black.date,
        concat(black.state, '-',states.state_name) as state,
        black.cases_black,
        black.deaths_black,
        case 
            when deaths_black < 1000 then 'low'
            when deaths_black > 1000 and deaths_black < 10000 then 'medium'
            else 'hight'
        end
        as level_deaths,
        black.cases_black + black.deaths_black as sum_black
from black
inner join states on states.state = black.state