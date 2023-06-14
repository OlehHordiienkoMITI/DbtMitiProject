{{
  config(
    materialized="table",
    schema="transform"
  )
}}

with asian as (
    select  date,
        state, 
        cases_asian, 
        deaths_asian
    from {{ ref('stg_asian') }}
),

states as (
    select state,
     state_name
    from {{ ref('stg_states') }}
)

select asian.date,
        concat(asian.state, '-',states.state_name) as state,
        asian.cases_asian,
        asian.deaths_asian,
        asian.cases_asian + asian.deaths_asian as sum_asian
        
from asian
inner join states on states.state = asian.state
where asian.state = 'NY'