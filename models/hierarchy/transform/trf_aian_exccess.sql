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
),

open_data as(
    select country, 
    year,
    frequency,
    deaths
    from 
    {{ ref('stg_exccess_deaths') }}
)

select
    a.date,
    concat(a.state, '-',s.state_name) as state,
    a.cases_aian,
    a.deaths_aian,
    o.country,
    extract(year from a.date) as year,
    o.frequency,
    o.deaths
from
    aian a
inner join
    states s ON a.state = s.state
join
    open_data o on year = o.year