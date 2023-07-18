-- create salesperson table
create table salesperson(
	salesperson SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

insert into salesperson(
	salesperson,
	first_name,
	last_name
) values (
	11111,
	'Abraham',
	'Ahlstrom'
);

-- create customer table
create table customer(
	customer_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
)

insert into customer (
	customer_id,
	first_name,
	last_name
) values (
	99999,
	'Zachary',
	'Ziggler'
);

-- create car_part table
create table car_part(
	product_id SERIAL primary key,
	product_name VARCHAR(150),
	unit_price NUMERIC(9,2)
);

insert into car_part(
	product_id,
	product_name,
	unit_price
) values (
	1234,
	'Carburator',
	74.74
);

-- create mechanic table
create table mechanic(
	mechanic_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

insert into mechanic(
	mechanic_id,
	first_name,
	last_name
) values (
	55555,
	'Geoffery',
	'Gerkin'
);

-- create parts_order table
create table parts_order(
	order_id SERIAL primary key,
	product_id SERIAL,
	product_quantity INTEGER,
	unit_price NUMERIC(9,2),
	subtotal NUMERIC(9,2),
	foreign key (product_id) references car_part(product_id)
);

insert into parts_order(
	order_id,
	product_id,
	product_quantity,
	unit_price,
	subtotal
) values (
	98765,
	1234,
	1,
	74.74,
	74.74
);

-- create car table
create table car(
	car_serial SERIAL primary key,
	make VARCHAR(100),
	model VARCHAR(100),
	year_ INTEGER,
	salesperson SERIAL,
	customer_id SERIAL,
	foreign key (salesperson) references salesperson(salesperson),
	foreign key (customer_id) references customer(customer_id)
);

insert into car(
	car_serial,
	make,
	model,
	year_,
	salesperson,
	customer_id
) values (
	24682468,
	'Hyundai',
	'Elantra',
	2016,
	11111,
	99999
);

-- create service_ticket table
create table service_ticket(
	ticket_id SERIAL primary key,
	customer_id SERIAL,
	car_serial SERIAL,
	mechanic_id SERIAL,
	date_of_service DATE,
	order_id SERIAL,
	foreign key (customer_id) references customer(customer_id),
	foreign key (car_serial) references car(car_serial),
	foreign key (mechanic_id) references mechanic(mechanic_id),
	foreign key (order_id) references parts_order(order_id)
);

insert into service_ticket(
	ticket_id,
	customer_id,
	car_serial,
	mechanic_id,
	date_of_service,
	order_id
) values (
	13579,
	99999,
	24682468,
	55555,
	TO_DATE('2023-07-13', 'YYYY-MM-DD'),
	98765
);

-- create invoice table
create table invoice (
	invoice_id SERIAL primary key,
	car_serial SERIAL,
	salesperson SERIAL,
	customer_id SERIAL,
	ticket_id SERIAL,
	total NUMERIC(9,2),
	invoice_date DATE,
	foreign key (car_serial) references car(car_serial),
	foreign key (salesperson) references salesperson(salesperson),
	foreign key (customer_id) references customer(customer_id),
	foreign key (ticket_id) references service_ticket(ticket_id)
);

insert into invoice(
	invoice_id,
	car_serial,
	salesperson,
	customer_id,
	ticket_id,
	total,
	invoice_date
) values (
	54321,
	24682468,
	11111,
	99999,
	13579,
	7000.70,
	TO_DATE('2023-07-13', 'YYYY-MM-DD')
);

create or replace function add_salesperson(_salesperson INTEGER, _first_name VARCHAR(100), _last_name VARCHAR(100))
returns void
language plpgsql
as $$
begin
	insert into salesperson(
	salesperson,
	first_name,
	last_name
) values (
	_salesperson,
	_first_name,
	_last_name
);
end;
$$;

create or replace function add_customer(_customer_id INTEGER, _first_name VARCHAR(100), _last_name VARCHAR(100))
returns void
language plpgsql
as $$
begin
	insert into customer (
	customer_id,
	first_name,
	last_name
) values (
	_customer_id,
	_first_name,
	_last_name
);
end;
$$;

create or replace function add_car_part(_product_id INTEGER, _product_name VARCHAR(150), _unit_price numeric(9,2))
returns void
language plpgsql
as $$
begin
	insert into car_part(
	product_id,
	product_name,
	unit_price
) values (
	_product_id,
	_product_name,
	_unit_price
);
end;
$$;

create or replace function add_mechanic(_mechanic_id INTEGER, _first_name VARCHAR(100), _last_name VARCHAR(100))
returns void
language plpgsql
as $$
begin
	insert into mechanic(
	mechanic_id,
	first_name,
	last_name
) values (
	_mechanic_id,
	_first_name,
	_last_name
);
end;
$$;

create or replace function add_parts_order(_order_id INTEGER, _product_id INTEGER, _product_quantity INTEGER, _unit_price NUMERIC(9,2), _subtotal NUMERIC(9,2))
returns void
language plpgsql
as $$
begin
	insert into parts_order(
	order_id,
	product_id,
	product_quantity,
	unit_price,
	subtotal
) values (
	_order_id,
	_product_id,
	_product_quantity,
	_unit_price,
	_subtotal
);
end;
$$;

create or replace function add_car(_car_serial INTEGER, _make VARCHAR(100), _model VARCHAR(100), _year_ INTEGER, _salesperson INTEGER, _customer_id INTEGER)
returns void
language plpgsql
as $$
begin
	insert into car(
	car_serial,
	make,
	model,
	year_,
	salesperson,
	customer_id
) values (
	_car_serial,
	_make,
	_model,
	_year_,
	_salesperson,
	_customer_id
);
end;
$$;

create or replace function add_service_ticket(_ticket_id INTEGER, _customer_id INTEGER, _car_serial INTEGER, _mechanic_id INTEGER, _date_of_service DATE, _order_id INTEGER)
returns void
language plpgsql
as $$
begin
	insert into service_ticket(
	ticket_id,
	customer_id,
	car_serial,
	mechanic_id,
	date_of_service,
	order_id
) values (
	_ticket_id,
	_customer_id,
	_car_serial,
	_mechanic_id,
	_date_of_service,
	_order_id
);
end;
$$;

create or replace function add_invoice(_invoice_id INTEGER, _car_serial INTEGER, _salesperson INTEGER, _customer_id INTEGER, _ticket_id INTEGER, _total NUMERIC(9,2), _invoice_date DATE)
returns void
language plpgsql
as $$
begin
	insert into invoice(
	invoice_id,
	car_serial,
	salesperson,
	customer_id,
	ticket_id,
	total,
	invoice_date
) values (
	_invoice_id,
	_car_serial,
	_salesperson,
	_customer_id,
	_ticket_id,
	_total,
	_invoice_date
);
end;
$$;

select add_salesperson(44444, 'Just', 'Me');
select add_customer(22222, 'Its', 'You');
select add_car_part(876, 'Stickshift', 47.47);
select add_mechanic(88888, 'Whos', 'That');
select add_parts_order(43434, 876, 78, 1.00, 78.00);
select add_car(70077, 'Mountain', 'Bike', 1874, 44444, 22222);
select add_service_ticket(24601, 22222, 70077, 88888, TO_DATE('1874-12-31', 'YYYY-MM-DD'), 43434);
select add_invoice(76767, 70077, 44444, 22222, 24601, 9000.99, TO_DATE('1874-12-31', 'YYYY-MM-DD'));


select * from salesperson;
select * from customer;
select * from car;
select * from invoice;
select * from service_ticket;
select * from car_part;
select * from parts_order;
select * from mechanic;