select date, state, sum(cases_white) as positive_cases_white, sum(deaths_white) as deaths_white
from covid19.city_level_cases_and_deaths
where deaths_white is not null 
AND cases_white is not null
AND state is not null

group by date, state
order by date, state
limit 2000