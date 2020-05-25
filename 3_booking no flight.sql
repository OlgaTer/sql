
select t.book_ref as book_num, t.ticket_no as ticket_num, bp.boarding_no as board_num, f.status 
from bookings.tickets t
join bookings.ticket_flights tf using (ticket_no)
join bookings.flights f using (flight_id)
left join bookings.boarding_passes bp on tf.ticket_no = bp.ticket_no and tf.flight_id = bp.flight_id 
where bp.boarding_no is null 
and f.status in ('Arrived','Departed')