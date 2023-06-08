{{
  config(
    materialized='table'
  )
}}

with final as (
    select
        oltc.date,
        oltc.state,
        sum(case when nursing_homes_resident_positives > 0 then nursing_homes_resident_positives else 0 end) as resident_positives,
        sum(case when nursing_homes_resident_deaths > 0 then nursing_homes_resident_deaths else 0 end) as resident_deaths,
        sum(case when nursing_homes_staff_positives > 0 then nursing_homes_staff_positives else 0 end) as staff_positives,
        sum(case when nursing_homes_staff_deaths > 0 then nursing_homes_staff_deaths else 0 end) as staff_deaths,
        MAX(case when other_care_facilities_resident_positives > 0 then other_care_facilities_resident_positives else 0 end) as max_other_positives,
        MAX(case when other_care_facilities_resident_deaths > 0 then other_care_facilities_resident_deaths else 0 end) as max_other_deaths
    from
        covid19.state_level_aggregate_long_term_care_copy oltc
    group by
        oltc.date, oltc.state
)
select
    date,
    state,
    resident_positives,
    resident_deaths,
    staff_positives,
    staff_deaths,
    max_other_positives,
    max_other_deaths
from
    final
where 
    resident_positives > 0 and
    resident_deaths > 0 and
    staff_positives > 0 and
    staff_deaths > 0 or
    max_other_positives > 0 or
    max_other_deaths > 0
order by
    date
limit 2000