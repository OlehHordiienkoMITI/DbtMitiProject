select date, death, death_increase, hospitalized_currently, negative, negative_increase, positive, positive_increase, states as count_states
from covid19.national_testing_and_outcomes
where date is not null
  and death is not null
  and death_increase is not null
  and hospitalized_currently is not null
  and negative is not null
  and negative_increase is not null
  and positive is not null
  and positive_increase is not null
  and states is not null
order by date