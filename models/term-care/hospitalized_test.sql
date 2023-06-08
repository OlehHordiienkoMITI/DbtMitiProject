{{ config(materialized="table") }}

with
    aggregate as (select * from {{ ref("state_level_aggregate_long_term_care") }}),

    cumulative as (select * from {{ ref("state_level_cumulative_long_term_care") }}),

    states as (select * from {{ ref("code_name") }}),

    testing as (select * from{{ ref("state_test") }}),

    final as (
        select
            t.date,
            t.state,
            states.state_name,
            max(hospitalized) as hospitalized,
            sum(case when negative > 0 then negative else 0 end) as negative,
            max(positive) as positive,
            max(aggregate.resident_positives) as aggregate_resident_positives,
            max(aggregate.resident_deaths) as aggregate_resident_deaths,
            min(aggregate.staff_positives) as aggregate_staff_positives,
            min(aggregate.staff_deaths) as aggregate_staff_deaths,
            max(aggregate.max_other_positives) as aggregate_max_other_positives,
            sum(aggregate.max_other_deaths) as aggregate_max_other_deaths,
            min(cumulative.resident_positives) as cumulative_resident_positives,
            max(cumulative.resident_deaths) as cumulative_resident_deaths,
            min(cumulative.staff_positives) as cumulative_staff_positives,
            max(cumulative.staff_deaths) as cumulative_staff_positives,
            sum(cumulative.max_other_positives) as cumulative_max_other_positives,
            sum(cumulative.max_other_deaths) as cumulative_max_other_deaths
        from testing t
        inner join aggregate on t.date = aggregate.date
        inner join cumulative on t.date = cumulative.date
        inner join states on t.state = states.state
        -- group by testing.date, testing.state, states.state_name
        group by t.date, t.state, states.state_name
    )

select *
from final
order by date