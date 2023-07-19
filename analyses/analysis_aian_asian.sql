with aian as (
    select * from {{ref("stg_aian")}}
),

asian as (
    select * 
    from {{ref('stg_asian')}}
)

select  sum(cases_aian) as sm_css_ai, 
        sum(cases_asian) as sum_css_as,
        max(deaths_aian) as mx_dths_ai,
        max(deaths_asian) as mx_dths_as
from asian, aian