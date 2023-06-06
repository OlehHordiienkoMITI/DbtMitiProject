select date, state, location, cases_white, deaths_white, deaths_unknown
from covid19.city_level_cases_and_deaths
where deaths_white is not null 
AND cases_white is not null
order by date