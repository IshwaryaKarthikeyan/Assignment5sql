                                                   TASK 1
create database TicketBookingSystem;
use TicketBookingSystem ;
create table venutable
(venue_id int primary key,
 venue_name varchar(20) ,
 address varchar(20));
create table eventtable (event_id int Primary Key, 
event_name varchar(20), 
event_date DATE,  
event_time TIME, 
venue_id int,  
total_seats int,  
available_seats int, 
ticket_price DECIMAL (4,3), 
event_type ENUM('Movie', 'Sports', 'Concert') ,booking_id int);
create table customertable(customer_id int Primary key,
 customer_name varchar(20),
 email varchar(20),
 phone_number int, 
 booking_id int);
create table BookingTable (booking_id int Primary Key,
customer_id int, 
event_id int,
num_tickets int ,
total_cost decimal(4,3),
booking_date date );
insert into venutable values
(21, 'Convention Center', '123 Main St'),
(22, 'Stadium Arena', '456 Park Ave'),
(23, 'Community Hall', '789 Elm St'),
(24, 'Exhibition Hall', '101 Oak Ave'),
(25, 'Conference Center', '222 Maple St'),
(26, 'Event Space', '333 Pine St'),
(27, 'Ballroom Venue', '444 Cedar St'),
(28, 'Meeting Room', '555 Birch St'),
(29, 'Function Hall', '666 Walnut St'),
(30, 'Auditorium', '777 Cherry St');
INSERT INTO eventtable VALUES
 (1, 'Movie Night', '2024-05-15', '18:00:00', 21, 10000, 10000, 1000.00, 'Movie', 41),
(2, 'World Cup Soccer', '2024-06-10', '14:00:00', 22, 20000, 20000, 1500.50, 'Sports', 42),
(3, 'Concert in the Park', '2024-07-20', '10:30:00', 23, 18000, 18000, 3000.75, 'Concert', 43),
(4, 'Chess Cup Tournament', '2024-08-05', '12:00:00', 24, 12000, 12000, 2500.25, 'Sports', 44),
(5, 'Movie Marathon', '2024-06-30', '15:00:00', 25, 8000, 8000, 4000.00, 'Movie', 45),
(6, 'Cricket World Cup', '2024-07-15', '09:00:00', 26, 9000, 9000, 1800.75, 'Sports', 46),
(7, 'Rock Concert', '2024-09-05', '10:00:00', 27, 11000, 11000, 1200.50, 'Concert', 47),
(8, 'Tennis Championship', '2024-08-20', '16:30:00', 28, 7000, 7000, 3500.00, 'Sports', 48),
(9, 'Movie Premiere', '2024-07-05', '19:30:00', 29, 18000, 18000, 2200.50, 'Movie', 49),
(10, 'Music Festival', '2024-09-15', '11:00:00', 30, 13000, 13000, 2800.50, 'Concert', 50);
ALTER TABLE eventtable MODIFY COLUMN ticket_price DECIMAL(6,2);
insert into customertable values 
(11, 'John Doe', 'john@example.com', '1234567000', 41),
(12, 'Jane Smith', 'jane@example.com', '1236543210', 42),
(13, 'Alice Johnson', 'alice@example.com', '1237890123', 43),
(14, 'Bob Williams', 'bob@example.com', '1230124000', 44),
(15, 'Emily Brown', 'emily@example.com', '1236549870', 45),
(16, 'Michael Davis', 'michael@example.com', '1239873210', 46),
(17, 'Sarah Wilson', 'sarah@example.com', '1236541230', 47),
(18, 'David Martinez', 'david@example.com', '1233216000', 48),
(19, 'Jessica Taylor', 'jessica@example.com', '1237534680', 49),
(20, 'Christopher Lee', 'chris@example.com', '1238521470', 50);
insert into BookingTable values
(41,11,1,5,50.000,'2024-05-15'),
(42,12,2,6,75.123,'2024-06-10'),
(43,13,3,3,25.456,'2024-07-20'),
(44,14,4,6,100.789,'2024-08-05'),
(45,15,5,2,50.321,'2024-06-30'),
(46,16,6,1,25.678,'2024-07-15'),
(47,17,7,9,75.999,'2024-09-05'),
(48,18,8,5,50.111,'2024-08-20'),
(49,19,9,8,50.222,'2024-07-05'),
(50,20,10,2,25.333,'2024-09-15');
ALTER TABLE BookingTable MODIFY total_cost DECIMAL(6,3);
alter table eventtable add constraint event FOREIGN KEY (venue_id) REFERENCES venutable(venue_id);
alter table  BookingTable add constraint BookingTable foreign key (customer_id) references customertable(customer_id);
alter table  BookingTable add constraint fk_BookingTable foreign key (event_id) references eventtable(event_id);
alter table eventtable add constraint eventtable foreign key(booking_id) references BookingTable (booking_id);
alter table customertable add constraint customertable foreign key(booking_id) references BookingTable (booking_id);
											  TASK 2
select event_name from eventtable;
select event_name ,available_seats from eventtable;
select event_name from eventtable where event_name like "%cup%";
select event_name from eventtable where ticket_price between 1000 AND 2500;
select event_name,event_date from eventtable where event_date between '2024-05-15'AND'2024-09-15';
select event_name,available_seats from eventtable where event_name like "%concert%";
select * from BookingTable where num_tickets>4;
select*from customertable where phone_number like"%000";
select event_name from eventtable where total_seats>15000;
select event_name from eventtable where event_name not in  ("x","y","z");
												TASK 3
select event_name, avg(ticket_price) from eventtable group by event_name;
select sum(ticket_price)from eventtable;
select event_name,max(num_tickets) from eventtable, BookingTable where eventtable.event_id= BookingTable.event_id group by event_name order by Max(num_tickets) desc limit 1;
select num_tickets,event_name from eventtable,BookingTable where eventtable.event_id=BookingTable.event_id;
select num_tickets,event_name from eventtable,BookingTable where eventtable.event_id=BookingTable.event_id and num_tickets=0;
select customer_name,max( num_tickets) from customertable,BookingTable where customertable.customer_id=BookingTable.customer_id group by customer_name order by Max(num_tickets) desc limit 1;
SELECT eventtable.event_name, DATE_FORMAT(BookingTable.booking_date, '%Y-%m') AS month_year,SUM(BookingTable.num_tickets) AS total_tickets_sold FROM eventtable JOIN BookingTable ON eventtable.event_id = BookingTable.event_id GROUP BY eventtable.event_id, month_year ORDER BY month_year;
select avg(ticket_price), venue_name from eventtable,venutable where eventtable.venue_id=venutable.venue_id group by venue_name;
select sum(num_tickets),event_name from eventtable,BookingTable where eventtable.event_id=BookingTable.event_id group by event_name;
SELECT YEAR(booking_date) AS Year, SUM(total_cost) AS TotalRevenue, event_name FROM BookingTable JOIN eventtable ON BookingTable.event_id = eventtable.event_id GROUP BY YEAR(booking_date), event_name LIMIT 0, 1000;
select c.customer_id, c.customer_name, COUNT(b.event_id) as num_total_events from customertable c join BookingTable b on c.customer_id=b.customer_id group by customer_id, customer_name having count(b.event_id) >1;
select total_cost,customer_id , event_name from BookingTable,eventtable where eventtable.event_id=BookingTable.event_id;
select avg(ticket_price),event_name,venue_name from eventtable join venutable ON eventtable.venue_id=venutable.venue_id JOIN BookingTable ON eventtable.booking_id=BookingTable.booking_id group by event_name,venue_name;
SELECT customertable.customer_name, COUNT(BookingTable.num_tickets) AS num_tickets FROM customertable JOIN BookingTable ON customertable.customer_id = BookingTable.customer_id WHERE BookingTable.booking_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) GROUP BY customertable.customer_name;
                                                     TASK 4   
select avg(ticket_price),event_name,venue_name from eventtable JOIN venutable ON eventtable.venue_id=venutable.venue_id where venue_name IN(Select DISTINCT venue_name from venutable) group by event_name,venue_name;
select event_name, (total_seats - available_seats) from eventtable where (select(total_seats - available_seats) from eventtable e where e.event_id=eventtable.event_id)>0.5*total_seats;
select sum(num_tickets),event_name from BookingTable,eventtable where eventtable.event_id=BookingTable.event_id group by event_name;
select customer_name,num_tickets from customertable JOIN BookingTable ON customertable.customer_id=BookingTable.customer_id where NOT EXISTS (select customer_name from customertable);
select event_name , num_tickets from eventtable JOIN BookingTable ON eventtable.event_id=BookingTable.event_id where num_tickets NOT IN(select num_tickets from BookingTable where num_tickets<>0);
select sum(num_tickets ),event_type from eventtable JOIN BookingTable ON eventtable.event_id= BookingTable.event_id group by event_type;
select event_name,ticket_price from eventtable where ticket_price>(select avg(ticket_price) from eventtable);
select sum(total_cost),customer_name,event_name from customertable JOIN eventtable ON customertable.booking_id=eventtable.booking_id JOIN BookingTable ON BookingTable.event_id=eventtable.event_id group by customer_name,event_name;
select customer_name,event_name,num_tickets,venue_name from eventtable JOIN customertable ON eventtable.booking_id=customertable.booking_id JOIN BookingTable ON customer_table.booking_id=BookingTable.booking_id JOIN venutable ON venutable.venue_id=eventtable.venue_id where venue_name=(select venue_name from venutable where venue_name="Auditorium");
select customer_id, customer_name from customertable where exists (select 1 from BookingTable join eventtable on BookingTable.event_id = eventtable.event_id where venue_id = 23 and BookingTable.customer_id = customertable.customer_id);
select sum(num_tickets),event_name from BookingTable JOIN eventtable ON BookingTable.booking_id=eventtable.booking_id group by event_name;
select customer_name, month(booking_date) from customertable c join BookingTable b on b.customer_id=c.customer_id where month(booking_date) = (select month(booking_date) from BookingTable b limit 1);
 select avg(ticket_price),event_name,venue_name from eventtable JOIN venutable ON eventtable.venue_id=venutable.venue_id group by venue_name,event_name;