
select f.flight_no, (f.actual_departure - f.scheduled_departure) as time_wait
from bookings.flights f
where f.actual_departure is not null
order by time_wait desc
limit 1