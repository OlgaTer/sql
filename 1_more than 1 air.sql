-- просмотр всех данных в таблице
select * from bookings.airports_data ad 

-- основной запрос
with cte_code as (
select ad.city->>'ru' as name_city,
ad.airport_name->>'ru' as name_air,
count(ad.airport_code) over (partition by ad.city->>'ru') as code_air
from bookings.airports_data ad
)
select cc.name_city, cc.name_air
from cte_code cc
where cc.code_air>1
order by cc.name_city