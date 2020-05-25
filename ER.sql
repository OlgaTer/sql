
create table Ter_bookings(
	book_ref char(6)  not null primary key,
	book_date timestamptz not null,
	total_amount numeric(10,2) not null
	)
	
create table Ter_tickets(
	ticket_no char(13) not null primary key,
	book_ref char(6) not null references Ter_bookings(book_ref),
	passenger_id varchar(20) not null,
	passenger_name text not null,
	contact_data jsonb
	)
	
create table Ter_aircrafts(
	aircraft_code char(3) not null primary key,
	model text not null,
	"range" integer not null check("range" > 0)
	)

create table Ter_seats(
	aircraft_code char(3) not null references Ter_aircrafts(aircraft_code) on delete cascade,
	seat_no varchar(4) not null,
	fare_conditions varchar(10) not null,
	check(fare_conditions in ('Economy', 'Comfort', 'Business')),
	primary key (aircraft_code, seat_no)
	)
	
create table Ter_airports(
	airport_code char(3) not null primary key,
	airport_name text not null,
	city text not null,
	longitude float not null,
	latitude float not null,
	timezone text not null
	)
	
create table Ter_flights(
	flight_id serial not null primary key,
	flight_no char(6) not null,
	scheduled_departure timestamptz not null,
	scheduled_arrival timestamptz not null,
		check (scheduled_arrival > scheduled_departure),
	departure_airport char(3) not null references Ter_airports(airport_code),
	arrival_airport char(3) not null references Ter_airports(airport_code),
	status varchar(20) not null,
		check (status in ('On Time', 'Delayed', 'Departed', 'Arrived', 'Scheduled', 'Cancelled')),
	aircraft_code char(3) not null references Ter_aircrafts(aircraft_code),
	actual_departure timestamptz,
	actual_arrival timestamptz,
		check ((actual_arrival is null)
			or ((actual_departure is not null and actual_arrival is not null)
				and (actual_arrival > actual_departure)))
	)
	
create table Ter_ticket_flights(
	ticket_no char(13) not null references Ter_tickets(ticket_no), 
	flight_id integer not null references Ter_flights(flight_id),
	fare_conditions varchar(10) not null,
		check(fare_conditions in ('Economy', 'Comfort', 'Business')),
	amount numeric(10,2) not null check (amount >= 0),
	primary key (ticket_no, flight_id)
	)
	
create table Ter_boarding_passes(
	ticket_no char(13) not null,
	flight_id integer not null,
	boarding_no integer not null,
	seat_no varchar(4) not null,
	primary key (ticket_no, flight_id),
	foreign key (ticket_no, flight_id) references Ter_ticket_flights(ticket_no, flight_id)
	)