{{ config(
    materialized="table",
    schema="staging"
) }}

with states as (
    select state,
     state_name
    from covid19.state_screenshots
    where state is not null
    and state_name is not null
)

select * from states