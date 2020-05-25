
select r1.departure_city as city1, r2.departure_city as city2
from bookings.routes r1
cross join bookings.routes r2
where r1.departure_city <> r2.departure_city
group by 1, 2
except
select r.departure_city, r.arrival_city
from bookings.routes r