
-- просмотр всех данных в bookings.ticket_flights tf
select * from bookings.ticket_flights tf

-- основной запрос
select max, min
from 
	(select tf.flight_id, max(tf.amount) from bookings.ticket_flights tf
	where tf.fare_conditions = 'Economy'
	group by 1) as ma
join 
	(select tf.flight_id, min(tf.amount) from bookings.ticket_flights tf
	where tf.fare_conditions = 'Business'
	group by 1) as mi
on ma.flight_id = mi.flight_id
where max > min

-- рейсов, на которых стоимость билетов Business меньше стоимости Economy, нет