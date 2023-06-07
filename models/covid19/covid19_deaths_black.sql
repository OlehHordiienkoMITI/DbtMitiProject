select date, state, sum(cases_black) as positive_cases_black, sum(deaths_black) as deaths_black
from covid19.city_level_cases_and_deaths
where deaths_black is not null 
AND cases_black is not null

group by date, state
order by date, state
limit 2000