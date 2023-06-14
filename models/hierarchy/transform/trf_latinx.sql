{{
  config(
    materialized="table",
    schema="transform"
  )
}}

with latinx as (
    select  date,
        state, 
        cases_latinx, 
        deaths_latinx
    from {{ ref('stg_latinx') }}
),

states as (
    select state,
     state_name
    from {{ ref('stg_states') }}
)

select latinx.date,
        concat(latinx.state, '-',states.state_name) as state,
        latinx.cases_latinx,
        latinx.deaths_latinx,
        latinx.cases_latinx + latinx.deaths_latinx as sum_latinx
from latinx
inner join states on states.state = latinx.state
where states.state = 'california'