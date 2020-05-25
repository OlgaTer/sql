
-- просмотр парка самолетов
select * from bookings.aircrafts_data ad
order by ad."range" desc

-- максимальная дальность полета у Боинг 777-300, код 773

-- просмотр всех данных в bookings.routes r 
select * from bookings.routes r 

-- основной запрос
select r.departure_airport as code_airport, r.departure_airport_name as name_airport, 
r.departure_city as city
from bookings.routes r
where r.aircraft_code = '773'
group by 1, 2, 3
order by city