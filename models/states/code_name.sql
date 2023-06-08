{{
  config(
    materialized='table'
  )
}}

select state, state_name
from covid19.state_screenshots
group by state, state_name