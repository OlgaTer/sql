
-- основной запрос
with cte_percent as (
select r.aircraft_code,
count(r.flight_no) over (partition by r.aircraft_code) as count_flight,
	(select count(r.flight_no)
	from bookings.routes r) as total_count
from bookings.routes r 
)
select cp.aircraft_code,
(cp.count_flight * 100 / cp.total_count) as percent_flights
from cte_percent cp
group by 1, 2
order by percent_flights desc
limit 1

-- модель самолета с кодом CR2
select ad.aircraft_code, ad.model->>'ru' as model
from bookings.aircrafts_data ad 
where ad.aircraft_code='CR2'

-- наибольший процент перелетов у Бомбардье CRJ-200