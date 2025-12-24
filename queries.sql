-- creating the users table
create table users(
  user_id int primary key,
  name varchar(100),
  email varchar(50) unique not null,
  phone varchar(50),
  role varchar(30)
)


--creating the vehicles table
create table vehicles (
  vehicle_id int primary key,
  name varchar(100),
  type varchar(50),
  model varchar(50),
  registration_number varchar(50) unique,
  rental_price varchar(50),
  status varchar(50)
  )


--creating the bookings table
create table bookings (
  booking_id int primary key,
  user_id int references users(user_id),
  vehicle_id int references vehicles(vehicle_id),
  start_date date,
  end_date date,
  status varchar(50),
  total_cost varchar(50)
)  


-- First quearies
select bookings.booking_id,
        users.name as customer_name,
        vehicles.name as vehicle_name,
        start_date,
        end_date,
        bookings.status  from bookings

join users on bookings.user_id=users.user_id
join vehicles on bookings.vehicle_id=vehicles.vehicle_id




select vehicle_id,
  name,
  type,
  model,
  registration_number,
  rental_price,
  status
  from vehicles where not exists(
  select * from bookings
  where bookings.user_id = vehicles.vehicle_id
  )



select vehicle_id,
  name,
  type,
  model,
  registration_number,
  rental_price,
  status
  from vehicles where status='available' and type='car'



select
  vehicles.name as vehicle_name,
  COUNT(bookings.booking_id) as total_bookings
from bookings
join vehicles
  on bookings.vehicle_id = vehicles.vehicle_id
group by
  vehicles.vehicle_id, 
  vehicle_name
having
  COUNT(bookings.booking_id) > 2;
