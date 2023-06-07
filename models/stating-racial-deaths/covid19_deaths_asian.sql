select date, state, sum(cases_asian) as positive_cases_asian, sum(deaths_asian) as deaths_asian
from covid19.city_level_cases_and_deaths
where deaths_asian is not null 
AND cases_asian is not null
AND state is not null

group by date, state
order by date, state
limit 2000