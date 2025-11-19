DROP DATABASE IF EXISTS Kumar_Jilek_Logan_Database;
CREATE DATABASE Kumar_Jilek_Logan_Database;
USE Kumar_Jilek_Logan_Database;

CREATE TABLE Airport (
    airport_name    VARCHAR(100) PRIMARY KEY,
    city            VARCHAR(100),
    country         VARCHAR(100)
);

-- Create Statements for Airport 
INSERT INTO Airport (airport_name, city, country) VALUES ('Logan International Airport', 'Boston', 'USA');
INSERT INTO Airport (airport_name, city, country) VALUES ('John F. Kennedy International Airport', 'New York', 'USA');
INSERT INTO Airport (airport_name, city, country) VALUES ('Los Angeles International Airport', 'Los Angeles', 'USA');
INSERT INTO Airport (airport_name, city, country) VALUES ('Chicago O\'Hare International Airport', 'Chicago', 'USA');
INSERT INTO Airport (airport_name, city, country) VALUES ('Miami International Airport', 'Miami', 'USA');
INSERT INTO Airport (airport_name, city, country) VALUES ('Dallas/Fort Worth International Airport', 'Dallas', 'USA');
INSERT INTO Airport (airport_name, city, country) VALUES ('Hartsfield–Jackson Atlanta International Airport', 'Atlanta', 'USA');
INSERT INTO Airport (airport_name, city, country) VALUES ('Seattle–Tacoma International Airport', 'Seattle', 'USA');
INSERT INTO Airport (airport_name, city, country) VALUES ('San Francisco International Airport', 'San Francisco', 'USA');
INSERT INTO Airport (airport_name, city, country) VALUES ('Denver International Airport', 'Denver', 'USA');
INSERT INTO Airport (airport_name, city, country) VALUES ('Heathrow Airport', 'London', 'UK');
INSERT INTO Airport (airport_name, city, country) VALUES ('Gatwick Airport', 'London', 'UK');
INSERT INTO Airport (airport_name, city, country) VALUES ('Charles de Gaulle Airport', 'Paris', 'France');
INSERT INTO Airport (airport_name, city, country) VALUES ('Frankfurt Airport', 'Frankfurt', 'Germany');
INSERT INTO Airport (airport_name, city, country) VALUES ('Keflavik International Airport', 'Reykjavik', 'Iceland');
INSERT INTO Airport (airport_name, city, country)VALUES  ('Istanbul Airport', 'Istanbul', 'Turkey');
INSERT INTO Airport (airport_name, city, country) VALUES ('Amsterdam Schiphol Airport', 'Amsterdam', 'Netherlands');
INSERT INTO Airport (airport_name, city, country) VALUES ('Dubai International Airport', 'Dubai', 'UAE');
INSERT INTO Airport (airport_name, city, country) VALUES ('Tokyo Haneda Airport', 'Tokyo', 'Japan');
INSERT INTO Airport (airport_name, city, country) VALUES ('Singapore Changi Airport', 'Singapore', 'Singapore');
INSERT INTO Airport (airport_name, city, country) VALUES ('Toronto Pearson International Airport', 'Toronto', 'Canada');


CREATE TABLE Airline (
    airline_name    VARCHAR(100) PRIMARY KEY,
    country         VARCHAR(100),
    airport_name    VARCHAR(100),
    FOREIGN KEY (airport_name) REFERENCES Airport(airport_name)
);

INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Delta Air Lines', 'USA', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('American Airlines', 'USA', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('United Airlines', 'USA', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('JetBlue Airways', 'USA', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Southwest Airlines', 'USA', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Alaska Airlines', 'USA', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Spirit Airlines', 'USA', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Frontier Airlines', 'USA', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Hawaiian Airlines', 'USA', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Sun Country Airlines', 'USA', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('British Airways', 'UK', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Virgin Atlantic', 'UK', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Air France', 'France', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Lufthansa', 'Germany', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('KLM Royal Dutch Airlines', 'Netherlands', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Qatar Airways', 'Qatar', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Emirates', 'UAE', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Etihad Airways', 'UAE', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Singapore Airlines', 'Singapore', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Cathay Pacific', 'Hong Kong', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Air Canada', 'Canada', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Japan Airlines', 'Japan', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('ANA All Nippon Airways', 'Japan', 'Logan International Airport');
INSERT INTO Airline (airline_name, country, airport_name) VALUES ('Turkish Airlines', 'Turkey', 'Logan International Airport');



CREATE TABLE Terminal (
    terminal_id     INT AUTO_INCREMENT PRIMARY KEY,
    terminal_name   VARCHAR(50),
    num_gates       INT,
    airport_name    VARCHAR(100) NOT NULL,
    FOREIGN KEY (airport_name) REFERENCES Airport(airport_name)
);

INSERT INTO Terminal (terminal_name, num_gates, airport_name) VALUES ('Terminal A', 8, 'Logan International Airport');
INSERT INTO Terminal (terminal_name, num_gates, airport_name) VALUES ('Terminal B', 8, 'Logan International Airport');
INSERT INTO Terminal (terminal_name, num_gates, airport_name) VALUES ('Terminal C', 8, 'Logan International Airport');
INSERT INTO Terminal (terminal_name, num_gates, airport_name) VALUES ('Terminal E', 6, 'Logan International Airport');

CREATE TABLE Gate (
    gate_id         INT AUTO_INCREMENT PRIMARY KEY,
    gate_name       VARCHAR(20),
    status          VARCHAR(50),
    terminal_id     INT NOT NULL,
    FOREIGN KEY (terminal_id) REFERENCES Terminal(terminal_id)
);

INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (1, 'A1', 'Available', 1);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (2, 'A2', 'Occupied', 1);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (3, 'A3', 'Available', 1);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (4, 'A4', 'Under Maintenance', 1);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (5, 'A5', 'Available', 1);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (6, 'A6', 'Available', 1);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (7, 'A7', 'Occupied', 1);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (8, 'A8', 'Available', 1);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (9,  'B1', 'Available', 2);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (10, 'B2', 'Available', 2);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (11, 'B3', 'Occupied', 2);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (12, 'B4', 'Available', 2);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (13, 'B5', 'Under Maintenance', 2);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (14, 'B6', 'Available', 2);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (15, 'B7', 'Occupied', 2);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (16, 'B8', 'Available', 2);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (17, 'C1', 'Available', 3);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (18, 'C2', 'Available', 3);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (19, 'C3', 'Occupied', 3);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (20, 'C4', 'Available', 3);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (21, 'C5', 'Available', 3);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (22, 'C6', 'Under Maintenance', 3);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (23, 'C7', 'Available', 3);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (24, 'C8', 'Available', 3);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (25, 'E1', 'Available', 4);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (26, 'E2', 'Occupied', 4);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (27, 'E3', 'Available', 4);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (28, 'E4', 'Available', 4);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (29, 'E5', 'Under Maintenance', 4);
INSERT INTO Gate (gate_id, gate_name, status, terminal_id) VALUES (30, 'E6', 'Available', 4);

CREATE TABLE Aircraft (
    aircraft_id     INT AUTO_INCREMENT PRIMARY KEY,
    model           VARCHAR(100),
    capacity        INT
);
INSERT INTO Aircraft (aircraft_id, model, capacity) VALUES (1, 'Boeing 737-800', 160);
INSERT INTO Aircraft (aircraft_id, model, capacity) VALUES (2, 'Airbus A320', 150);
INSERT INTO Aircraft (aircraft_id, model, capacity) VALUES (3, 'Boeing 777-300ER', 396);
INSERT INTO Aircraft (aircraft_id, model, capacity) VALUES (4, 'Airbus A350-900', 325);
INSERT INTO Aircraft (aircraft_id, model, capacity) VALUES (5, 'Boeing 787-9 Dreamliner', 290);
INSERT INTO Aircraft (aircraft_id, model, capacity) VALUES (6, 'Airbus A321neo', 185);
INSERT INTO Aircraft (aircraft_id, model, capacity) VALUES (7, 'Boeing 767-300', 216);
INSERT INTO Aircraft (aircraft_id, model, capacity) VALUES (8, 'Airbus A330-300', 277);
INSERT INTO Aircraft (aircraft_id, model, capacity) VALUES (9, 'Boeing 757-200', 180);
INSERT INTO Aircraft (aircraft_id, model, capacity) VALUES (10, 'Airbus A319', 140);



CREATE TABLE Flight (
    flight_id                   INT AUTO_INCREMENT PRIMARY KEY,
    flight_number               VARCHAR(20),
    flight_type                 VARCHAR(50),
    status                      VARCHAR(50),
    departure_time              DATETIME,
    arrival_time                DATETIME,
    aircraft_id                 INT,
    gate_id                     INT,
    airline_name                VARCHAR(100),
    arrival_airport_name        VARCHAR(100) NOT NULL,
    destination_airport_name    VARCHAR(100) NOT NULL,
    FOREIGN KEY (aircraft_id) REFERENCES Aircraft(aircraft_id),
    FOREIGN KEY (gate_id) REFERENCES Gate(gate_id),
    FOREIGN KEY (airline_name) REFERENCES Airline(airline_name),
    FOREIGN KEY (arrival_airport_name) REFERENCES Airport(airport_name),
    FOREIGN KEY (destination_airport_name) REFERENCES Airport(airport_name)
);

INSERT INTO Flight VALUES (1,'DL1182','Domestic','On Time','2025-11-18 06:20','2025-11-18 08:05',1,3,'Delta Air Lines','Logan International Airport','John F. Kennedy International Airport');
INSERT INTO Flight VALUES (2,'AA240','Domestic','Boarding','2025-11-18 07:55','2025-11-18 10:40',2,9,'American Airlines','Logan International Airport','Chicago O\'Hare International Airport');
INSERT INTO Flight VALUES (3,'UA881','Domestic','On Time','2025-11-18 09:10','2025-11-18 12:25',3,11,'United Airlines','Logan International Airport','Denver International Airport');
INSERT INTO Flight VALUES (4,'B6321','Domestic','On Time','2025-11-18 08:45','2025-11-18 11:20',4,8,'JetBlue Airways','Logan International Airport','Miami International Airport');
INSERT INTO Flight VALUES (5,'WN705','Domestic','Delayed','2025-11-18 12:10','2025-11-18 15:55',5,7,'Southwest Airlines','Logan International Airport','Dallas/Fort Worth International Airport');
INSERT INTO Flight VALUES (6,'AS11','Domestic','On Time','2025-11-18 13:20','2025-11-18 17:05',6,18,'Alaska Airlines','Logan International Airport','Seattle–Tacoma International Airport');
INSERT INTO Flight VALUES (7,'NK902','Domestic','On Time','2025-11-18 14:35','2025-11-18 18:00',7,21,'Spirit Airlines','Logan International Airport','San Francisco International Airport');
INSERT INTO Flight VALUES (8,'F9120','Domestic','On Time','2025-11-18 15:10','2025-11-18 17:00',8,12,'Frontier Airlines','Logan International Airport','Hartsfield–Jackson Atlanta International Airport');
INSERT INTO Flight VALUES (9,'HA33','Domestic','Boarding','2025-11-18 16:25','2025-11-18 22:00',9,25,'Hawaiian Airlines','Logan International Airport','Los Angeles International Airport');
INSERT INTO Flight VALUES (10,'SY505','Domestic','On Time','2025-11-18 17:40','2025-11-18 20:35',10,14,'Sun Country Airlines','Logan International Airport','Denver International Airport');
INSERT INTO Flight VALUES (11,'BA212','International','On Time','2025-11-18 18:50','2025-11-19 06:30',3,27,'British Airways','Logan International Airport','Heathrow Airport');
INSERT INTO Flight VALUES (12,'VS10','International','Delayed','2025-11-18 20:15','2025-11-19 08:05',4,28,'Virgin Atlantic','Logan International Airport','Gatwick Airport');
INSERT INTO Flight VALUES (13,'AF333','International','On Time','2025-11-18 21:30','2025-11-19 09:55',5,29,'Air France','Logan International Airport','Charles de Gaulle Airport');
INSERT INTO Flight VALUES (14,'LH421','International','On Time','2025-11-18 22:20','2025-11-19 10:40',6,30,'Lufthansa','Logan International Airport','Frankfurt Airport');
INSERT INTO Flight VALUES (15,'KL644','International','Boarding','2025-11-18 23:05','2025-11-19 11:15',7,19,'KLM Royal Dutch Airlines','Logan International Airport','Amsterdam Schiphol Airport');
INSERT INTO Flight VALUES (16,'QR744','International','On Time','2025-11-18 21:45','2025-11-19 13:20',8,20,'Qatar Airways','Logan International Airport','Doha International Airport');
INSERT INTO Flight VALUES (17,'EK238','International','On Time','2025-11-18 22:55','2025-11-19 16:30',9,26,'Emirates','Logan International Airport','Dubai International Airport');
INSERT INTO Flight VALUES (18,'EY152','International','On Time','2025-11-18 20:40','2025-11-19 14:10',10,5,'Etihad Airways','Logan International Airport','Dubai International Airport');
INSERT INTO Flight VALUES (19,'SQ23','International','On Time','2025-11-18 09:00','2025-11-19 05:40',1,16,'Singapore Airlines','Logan International Airport','Singapore Changi Airport');
INSERT INTO Flight VALUES (20,'CX811','International','On Time','2025-11-18 13:10','2025-11-19 09:20',2,24,'Cathay Pacific','Tokyo Haneda Airport','Logan International Airport');
INSERT INTO Flight VALUES (21,'AC769','International','On Time','2025-11-18 10:25','2025-11-18 13:05',3,23,'Air Canada','Toronto Pearson International Airport','Logan International Airport');
INSERT INTO Flight VALUES (22,'BA203','International','On Time','2025-11-18 01:10','2025-11-18 07:45',4,6,'British Airways','Heathrow Airport','Logan International Airport');
INSERT INTO Flight VALUES (23,'JL808','International','On Time','2025-11-18 02:30','2025-11-18 13:00',5,2,'Japan Airlines','Tokyo Haneda Airport','Logan International Airport');
INSERT INTO Flight VALUES (24,'AK501','International','On Time','2025-11-18 04:15','2025-11-18 11:55',6,10,'ANA All Nippon Airways','Tokyo Haneda Airport','Logan International Airport');
INSERT INTO Flight VALUES (25,'TK82','International','Delayed','2025-11-18 03:25','2025-11-18 12:35',7,22,'Turkish Airlines','Istanbul Airport','Logan International Airport');

CREATE TABLE Seat (
    seat_id         INT AUTO_INCREMENT PRIMARY KEY,
    seat_number     VARCHAR(10),
    class           VARCHAR(20),
    status          VARCHAR(50),
    flight_id       INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (1,'1A','Economy','Available',1);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (2,'1B','Business','Available',1);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (3,'2A','Economy','Available',2);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (4,'2B','Business','Available',2);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (5,'3A','Economy','Available',3);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (6,'3B','Business','Available',3);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (7,'4A','Economy','Available',4);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (8,'4B','Business','Available',4);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (9,'5A','Economy','Available',5);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (10,'5B','Business','Available',5);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (11,'6A','Economy','Available',6);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (12,'6B','Business','Available',6);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (13,'7A','Economy','Available',7);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (14,'7B','Business','Available',7);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (15,'8A','Economy','Available',8);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (16,'8B','Business','Available',8);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (17,'9A','Economy','Available',9);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (18,'9B','Business','Available',9);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (19,'10A','Economy','Available',10);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (20,'10B','Business','Available',10);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (21,'11A','Economy','Available',11);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (22,'11B','Business','Available',11);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (23,'12A','Economy','Available',12);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (24,'12B','Business','Available',12);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (25,'13A','Economy','Available',13);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (26,'13B','Business','Available',13);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (27,'14A','Economy','Available',14);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (28,'14B','Business','Available',14);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (29,'15A','Economy','Available',15);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (30,'15B','Business','Available',15);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (31,'16A','Economy','Available',16);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (32,'16B','Business','Available',16);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (33,'17A','Economy','Available',17);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (34,'17B','Business','Available',17);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (35,'18A','Economy','Available',18);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (36,'18B','Business','Available',18);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (37,'19A','Economy','Available',19);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (38,'19B','Business','Available',19);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (39,'20A','Economy','Available',20);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (40,'20B','Business','Available',20);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (41,'21A','Economy','Available',21);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (42,'21B','Business','Available',21);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (43,'22A','Economy','Available',22);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (44,'22B','Business','Available',22);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (45,'23A','Economy','Available',23);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (46,'23B','Business','Available',23);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (47,'24A','Economy','Available',24);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (48,'24B','Business','Available',24);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (49,'25A','Economy','Available',25);
INSERT INTO Seat (seat_id, seat_number, class, status, flight_id) VALUES (50,'25B','Business','Available',25);


CREATE TABLE Passenger (
    passenger_id     INT AUTO_INCREMENT PRIMARY KEY,
    full_name        VARCHAR(200),
    gender           VARCHAR(20),
    date_of_birth    DATE,
    nationality      VARCHAR(100),
    status           VARCHAR(50),
    passport_number  VARCHAR(50)
);

INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Tony Hsu', 'Male', '1998-05-14', 'USA', 'Checked-In', 'P98451231');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Harrison Pham', 'Male', '1999-11-22', 'USA', 'Checked-In', 'P77182944');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Maria Lopez', 'Female', '1992-02-07', 'Mexico', 'Booked', 'P55218039');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('James Carter', 'Male', '1987-07-18', 'USA', 'Available', 'P99844120');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Sophie Nguyen', 'Female', '1995-10-29', 'Vietnam', 'Checked-In', 'P66120947');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Daniel Kim', 'Male', '1996-03-12', 'South Korea', 'Checked-In', 'P72911458');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Emily Rogers', 'Female', '1990-09-03', 'USA', 'Available', 'P39011822');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Michael Patel', 'Male', '1989-12-30', 'India', 'Booked', 'P80019334');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Aisha Malik', 'Female', '1993-08-15', 'Pakistan', 'Booked', 'P44920319');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Robert Chen', 'Male', '1994-04-27', 'China', 'Checked-In', 'P31908462');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Liam Brown', 'Male', '1997-01-10', 'USA', 'Available', 'P63321984');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Isabella Gomez', 'Female', '1998-05-01', 'Colombia', 'Booked', 'P10028477');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('David Singh', 'Male', '1991-09-20', 'India', 'Checked-In', 'P59103348');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Olivia Martinez', 'Female', '1994-11-11', 'USA', 'Booked', 'P88200451');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('William Turner', 'Male', '1988-06-12', 'USA', 'Available', 'P71905512');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Chloe Park', 'Female', '1997-03-03', 'South Korea', 'Booked', 'P55193227');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Ethan Wright', 'Male', '1995-07-19', 'USA', 'Available', 'P20018754');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Grace Thompson', 'Female', '1993-02-14', 'Canada', 'Checked-In', 'P44481721');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Lucas Hernandez', 'Male', '1996-12-08', 'Spain', 'Booked', 'P88122934');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Nina Patel', 'Female', '1999-04-26', 'India', 'Available', 'P33784219');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Jackson Lee', 'Male', '1998-03-17', 'USA', 'Booked', 'P51877210');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Ava Richardson', 'Female', '1997-10-02', 'USA', 'Booked', 'P99011433');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Marcus Silva', 'Male', '1992-05-23', 'Brazil', 'Checked-In', 'P22590441');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Sophia Alvarez', 'Female', '1994-01-29', 'Mexico', 'Available', 'P71120880');
INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES ('Benjamin Hall', 'Male', '1986-09-14', 'USA', 'Booked', 'P60018832');

CREATE TABLE Passenger_Flight (
    pf_id          INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id   INT NOT NULL,
    flight_id      INT NOT NULL,
    seat_id        INT,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
    FOREIGN KEY (seat_id) REFERENCES Seat(seat_id)
);

INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (1, 1, 1);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (1, 5, 9);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (2, 2, 3);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (2, 6, 11);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (3, 3, 5);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (4, 4, 7);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (5, 5, 9);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (6, 6, 11);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (7, 7, 13);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (8, 8, 15);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (9, 9, 17);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (10, 10, 19);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (11, 11, 21);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (12, 12, 23);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (13, 13, 25);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (14, 14, 27);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (15, 15, 29);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (16, 16, 31);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (17, 17, 33);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (18, 18, 35);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (19, 19, 37);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (20, 20, 39);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (21, 21, 41);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (22, 22, 43);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (23, 23, 45);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (24, 24, 47);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (25, 25, 49);
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (3, 7, 13);    
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (6, 10, 19);    
INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES (14, 3, 6);     



CREATE TABLE Crew (
    crew_id     INT AUTO_INCREMENT PRIMARY KEY,
    crew_name   VARCHAR(100),
    first_name  VARCHAR(100),
    last_name   VARCHAR(100),
    role        VARCHAR(50),
    city_base   VARCHAR(100)
);

INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (1, 'Captain John Smith', 'John', 'Smith', 'Pilot', 'Boston');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (2, 'First Officer Emily Clark', 'Emily', 'Clark', 'Co-Pilot', 'Boston');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (3, 'FA Olivia Perez', 'Olivia', 'Perez', 'Flight Attendant', 'Boston');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (4, 'FA Daniel Rivera', 'Daniel', 'Rivera', 'Flight Attendant', 'Boston');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (5, 'Captain Sarah Johnson', 'Sarah', 'Johnson', 'Pilot', 'New York');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (6, 'First Officer Kevin Lee', 'Kevin', 'Lee', 'Co-Pilot', 'New York');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (7, 'FA Rachel Kim', 'Rachel', 'Kim', 'Flight Attendant', 'New York');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (8, 'FA Jonathan Price', 'Jonathan', 'Price', 'Flight Attendant', 'New York');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (9, 'Captain Anthony Morris', 'Anthony', 'Morris', 'Pilot', 'New York');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (10, 'Captain Michael Adams', 'Michael', 'Adams', 'Pilot', 'Chicago');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (11, 'First Officer Karen White', 'Karen', 'White', 'Co-Pilot', 'Chicago');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (12, 'FA Jennifer Walsh', 'Jennifer', 'Walsh', 'Flight Attendant', 'Chicago');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (13, 'FA Brian Foster', 'Brian', 'Foster', 'Flight Attendant', 'Chicago');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (14, 'Captain Marcus Brown', 'Marcus', 'Brown', 'Pilot', 'London');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (15, 'First Officer Hannah Lewis', 'Hannah', 'Lewis', 'Co-Pilot', 'London');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (16, 'FA Aiden Scott', 'Aiden', 'Scott', 'Flight Attendant', 'London');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (17, 'FA Charlotte Green', 'Charlotte', 'Green', 'Flight Attendant', 'London');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (18, 'Captain Oliver Hughes', 'Oliver', 'Hughes', 'Pilot', 'London');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (19, 'Captain Yusuf Demir', 'Yusuf', 'Demir', 'Pilot', 'Istanbul');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (20, 'First Officer Leyla Kaya', 'Leyla', 'Kaya', 'Co-Pilot', 'Istanbul');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (21, 'Captain Ahmed Khan', 'Ahmed', 'Khan', 'Pilot', 'Dubai');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (22, 'FA Zara Malik', 'Zara', 'Malik', 'Flight Attendant', 'Dubai');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (23, 'Captain Hiro Tanaka', 'Hiro', 'Tanaka', 'Pilot', 'Tokyo');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (24, 'FA Mei Chen', 'Mei', 'Chen', 'Flight Attendant', 'Tokyo');
INSERT INTO Crew (crew_id, crew_name, first_name, last_name, role, city_base) VALUES (25, 'FA Priya Desai', 'Priya', 'Desai', 'Flight Attendant', 'Toronto');

CREATE TABLE Flight_Crew (
    fc_id      INT AUTO_INCREMENT PRIMARY KEY,
    flight_id  INT NOT NULL,
    crew_id    INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
    FOREIGN KEY (crew_id) REFERENCES Crew(crew_id)
);

INSERT INTO Flight_Crew VALUES (1, 1, 1);
INSERT INTO Flight_Crew VALUES (2, 1, 5);
INSERT INTO Flight_Crew VALUES (3, 2, 2);
INSERT INTO Flight_Crew VALUES (4, 2, 6);
INSERT INTO Flight_Crew VALUES (5, 3, 3);
INSERT INTO Flight_Crew VALUES (6, 3, 7);
INSERT INTO Flight_Crew VALUES (7, 4, 4);
INSERT INTO Flight_Crew VALUES (8, 4, 8);
INSERT INTO Flight_Crew VALUES (9, 5, 9);
INSERT INTO Flight_Crew VALUES (10, 5, 13);
INSERT INTO Flight_Crew VALUES (11, 6, 10);
INSERT INTO Flight_Crew VALUES (12, 6, 14);
INSERT INTO Flight_Crew VALUES (13, 11, 11);
INSERT INTO Flight_Crew VALUES (14, 11, 15);
INSERT INTO Flight_Crew VALUES (15, 12, 12);
INSERT INTO Flight_Crew VALUES (16, 12, 16);
INSERT INTO Flight_Crew VALUES (17, 17, 17);
INSERT INTO Flight_Crew VALUES (18, 17, 1);
INSERT INTO Flight_Crew VALUES (19, 20, 20);
INSERT INTO Flight_Crew VALUES (20, 20, 4);

CREATE TABLE Meal (
    meal_id     INT AUTO_INCREMENT PRIMARY KEY,
    meal_name   VARCHAR(100),
    cuisine     VARCHAR(50),
    quantity    INT,
    flight_id   INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Chicken Alfredo', 'American', 120, 1);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Beef Chili Bowl', 'American', 110, 2);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Grilled Salmon Plate', 'American', 130, 3);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Turkey Club Sandwich', 'American', 140, 4);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('BBQ Chicken Rice Bowl', 'American', 100, 5);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Teriyaki Chicken', 'Japanese', 160, 6);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Spicy Tuna Donburi', 'Japanese', 150, 7);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Curry Udon', 'Japanese', 170, 8);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Hawaiian Pineapple Chicken', 'Hawaiian', 180, 9);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Island Veggie Plate', 'Hawaiian', 150, 10);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('English Breakfast Tray', 'British', 200, 11);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Shepherd’s Pie', 'British', 190, 12);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Coq au Vin', 'French', 210, 13);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Beef Bourguignon', 'French', 205, 14);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Dutch Stroopwafel Dessert', 'Dutch', 220, 15);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Chicken Kabsa', 'Middle Eastern', 230, 16);  
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Lamb Machboos', 'Middle Eastern', 240, 17); 
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Butter Chicken', 'Indian', 225, 18);        
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Hainanese Chicken Rice', 'Singaporean', 250, 19);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Dim Sum Assortment', 'Chinese', 260, 20);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Maple Glazed Chicken', 'Canadian', 130, 21);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Full English Roast', 'British', 210, 22);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Katsu Curry', 'Japanese', 180, 23);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Sushi Bento Box', 'Japanese', 175, 24);
INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES ('Turkish Doner Plate', 'Turkish', 240, 25);

CREATE TABLE Baggage (
    bag_id        INT AUTO_INCREMENT PRIMARY KEY,
    ticket_num    VARCHAR(50),
    weight        DECIMAL(5,2),
    tag_number    VARCHAR(50),
    destination   VARCHAR(100),
    status        VARCHAR(50),
    passenger_id  INT,
    flight_id     INT,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2001', 23.40, 'BG101', 'John F. Kennedy International Airport', 'Loaded', 1, 1);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2002', 18.90, 'BG102', 'John F. Kennedy International Airport', 'Loaded', 1, 1);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2003', 20.10, 'BG103', 'Chicago O\'Hare International Airport', 'Checked-In', 2, 2);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2004', 25.60, 'BG104', 'Chicago O\'Hare International Airport', 'Loaded', 2, 2);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2005', 21.75, 'BG105', 'Denver International Airport', 'Loaded', 3, 3);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2006', 27.40, 'BG106', 'Denver International Airport', 'Loaded', 3, 3);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2007', 17.10, 'BG107', 'Miami International Airport', 'In Transit', 4, 4);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2008', 19.65, 'BG108', 'Dallas/Fort Worth International Airport', 'Loaded', 5, 5);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2009', 24.30, 'BG109', 'Seattle–Tacoma International Airport', 'Loaded', 6, 6);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2010', 28.90, 'BG110', 'Seattle–Tacoma International Airport', 'Loaded', 6, 6);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2011', 23.95, 'BG111', 'San Francisco International Airport', 'Checked-In', 7, 7);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2012', 26.40, 'BG112', 'Hartsfield–Jackson Atlanta International Airport', 'Loaded', 8, 8);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2013', 15.20, 'BG113', 'Hartsfield–Jackson Atlanta International Airport', 'Loaded', 8, 8);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2014', 29.70, 'BG114', 'Los Angeles International Airport', 'In Transit', 9, 9);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2015', 22.40, 'BG115', 'Denver International Airport', 'Delivered', 10, 10);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2016', 17.85, 'BG116', 'Denver International Airport', 'Delivered', 10, 10);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2017', 24.70, 'BG117', 'Heathrow Airport', 'Loaded', 11, 11);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2018', 28.30, 'BG118', 'Gatwick Airport', 'Checked-In', 12, 12);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2019', 23.55, 'BG119', 'Charles de Gaulle Airport', 'Loaded', 13, 13);
INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
VALUES ('T2020', 26.10, 'BG120', 'Frankfurt Airport', 'Loaded', 14, 14);


