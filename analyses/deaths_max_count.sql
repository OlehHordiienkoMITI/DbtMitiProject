with max_deaths_white as (
    select max(deaths_white) as mx_dths_wht
    from covid19.city_level_cases_and_deaths
)

select * from max_deaths_white