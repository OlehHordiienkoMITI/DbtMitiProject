{{
  config(
    materialized="view",
    schema="transform"
  )
}}

with aian as (
    select  date,
        state, 
        cases_aian, 
        deaths_aian
    from 
    {{ ref('stg_aian') }}
),

states as (
    select state,
     state_name
    from
    {{ ref('stg_states') }}
)

select
    a.date,
    concat(a.state, '-',s.state_name) as state,
    a.cases_aian,
    a.deaths_aian,
    extract(year from a.date) as year
from
    aian a
inner join
    states s ON a.state = s.state