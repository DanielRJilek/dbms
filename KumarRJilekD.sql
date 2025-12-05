
DROP DATABASE IF EXISTS Kumar_Jilek_Logan_Database;
CREATE DATABASE Kumar_Jilek_Logan_Database;
USE Kumar_Jilek_Logan_Database;

CREATE TABLE Airport (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    airport_name    VARCHAR(100) UNIQUE,
    city            VARCHAR(100),
    country         VARCHAR(100)
);


-- Create Statements for Airport 
INSERT INTO Airport (airport_name, city, country) VALUES 
('Logan International Airport', 'Boston', 'USA'),
('John F. Kennedy International Airport', 'New York', 'USA'),
('Los Angeles International Airport', 'Los Angeles', 'USA'),
('Chicago O\'Hare International Airport', 'Chicago', 'USA'),
('Miami International Airport', 'Miami', 'USA'),
('Dallas/Fort Worth International Airport', 'Dallas', 'USA'),
('Hartsfield–Jackson Atlanta International Airport', 'Atlanta', 'USA'),
('Seattle–Tacoma International Airport', 'Seattle', 'USA'),
('San Francisco International Airport', 'San Francisco', 'USA'),
('Denver International Airport', 'Denver', 'USA'),
('Heathrow Airport', 'London', 'UK'),
('Gatwick Airport', 'London', 'UK'),
('Charles de Gaulle Airport', 'Paris', 'France'),
('Frankfurt Airport', 'Frankfurt', 'Germany'),
('Keflavik International Airport', 'Reykjavik', 'Iceland'),
('Istanbul Airport', 'Istanbul', 'Turkey'),
('Amsterdam Schiphol Airport', 'Amsterdam', 'Netherlands'),
('Dubai International Airport', 'Dubai', 'UAE'),
('Tokyo Haneda Airport', 'Tokyo', 'Japan'),
('Singapore Changi Airport', 'Singapore', 'Singapore'),
('Toronto Pearson International Airport', 'Toronto', 'Canada'),
('Doha International Airport', 'Doha', 'Qatar');



CREATE TABLE Airline (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    airline_name    VARCHAR(100) NOT NULL UNIQUE,
    country         VARCHAR(100) NOT NULL,
    airport_id      INT,
    FOREIGN KEY (airport_id) REFERENCES Airport(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


INSERT INTO Airline (airline_name, country, airport_id) VALUES
('Delta Air Lines', 'USA', 1),
('American Airlines', 'USA', 1),
('United Airlines', 'USA', 1),
('JetBlue Airways', 'USA', 1),
('Southwest Airlines', 'USA', 1),
('Alaska Airlines', 'USA', 1),
('Spirit Airlines', 'USA', 1),
('Frontier Airlines', 'USA', 1),
('Hawaiian Airlines', 'USA', 1),
('Sun Country Airlines', 'USA', 1),
('British Airways', 'UK', 1),
('Virgin Atlantic', 'UK', 1),
('Air France', 'France', 1),
('Lufthansa', 'Germany', 1),
('KLM Royal Dutch Airlines', 'Netherlands', 1),
('Qatar Airways', 'Qatar', 1),
('Emirates', 'UAE', 1),
('Etihad Airways', 'UAE', 1),
('Singapore Airlines', 'Singapore', 1),
('Cathay Pacific', 'Hong Kong', 1),
('Air Canada', 'Canada', 1),
('Japan Airlines', 'Japan', 1),
('ANA All Nippon Airways', 'Japan', 1),
('Turkish Airlines', 'Turkey', 1);




CREATE TABLE Terminal (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    terminal_name   VARCHAR(50) NOT NULL,
    num_gates       INT NOT NULL,
    airport_id      INT NOT NULL,
    FOREIGN KEY (airport_id) REFERENCES Airport(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO Terminal (terminal_name, num_gates, airport_id) VALUES
('Terminal A', 8, 1),
('Terminal B', 8, 1),
('Terminal C', 8, 1),
('Terminal E', 6, 1);

CREATE TABLE Gate (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    gate_name       VARCHAR(20) NOT NULL,
    status          VARCHAR(50) NOT NULL DEFAULT 'Available',
    terminal_id     INT NOT NULL,
    FOREIGN KEY (terminal_id) REFERENCES Terminal(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO Gate (gate_name, status, terminal_id) VALUES
('B1', 'Available', 2),
('B2', 'Available', 2),
('B3', 'Occupied', 2),
('B4', 'Available', 2),
('B5', 'Under Maintenance', 2),
('B6', 'Available', 2),
('B7', 'Occupied', 2),
('B8', 'Available', 2);


INSERT INTO Gate (gate_name, status, terminal_id) VALUES
('A1', 'Available', 1),
('A2', 'Occupied', 1),
('A3', 'Available', 1),
('A4', 'Under Maintenance', 1),
('A5', 'Available', 1),
('A6', 'Available', 1),
('A7', 'Occupied', 1),
('A8', 'Available', 1);

INSERT INTO Gate (gate_name, status, terminal_id) VALUES
('C1', 'Available', 3),
('C2', 'Available', 3),
('C3', 'Occupied', 3),
('C4', 'Available', 3),
('C5', 'Available', 3),
('C6', 'Under Maintenance', 3),
('C7', 'Available', 3),
('C8', 'Available', 3);

INSERT INTO Gate (gate_name, status, terminal_id) VALUES
('E1', 'Available', 4),
('E2', 'Occupied', 4),
('E3', 'Available', 4),
('E4', 'Available', 4),
('E5', 'Under Maintenance', 4),
('E6', 'Available', 4);


CREATE TABLE Aircraft (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    model           VARCHAR(100) UNIQUE,
    capacity        INT
);

INSERT INTO Aircraft (model, capacity) VALUES
('Boeing 737-800', 160),
('Airbus A320', 150),
('Boeing 777-300ER', 396),
('Airbus A350-900', 325),
('Boeing 787-9 Dreamliner', 290),
('Airbus A321neo', 185),
('Boeing 767-300', 216),
('Airbus A330-300', 277),
('Boeing 757-200', 180),
('Airbus A319', 140);


CREATE TABLE Flight (
    id                          INT AUTO_INCREMENT PRIMARY KEY,
    flight_number               VARCHAR(20) NOT NULL UNIQUE,
    flight_type                 VARCHAR(50) NOT NULL,
    status                      VARCHAR(50) NOT NULL DEFAULT 'On Time',
    departure_time              DATETIME NOT NULL,
    arrival_time                DATETIME NOT NULL,
    aircraft_id                 INT NOT NULL,
    gate_id                     INT,
    airline_id                  INT,
    arrival_airport_id          INT,
    destination_airport_id      INT,
    FOREIGN KEY (aircraft_id) REFERENCES Aircraft(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (gate_id) REFERENCES Gate(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (airline_id) REFERENCES Airline(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (arrival_airport_id) REFERENCES Airport(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (destination_airport_id) REFERENCES Airport(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


INSERT INTO Flight (
    flight_number, flight_type, status, departure_time, arrival_time,
    aircraft_id, gate_id, airline_id, arrival_airport_id, destination_airport_id
) VALUES
('DL1182','Domestic','On Time','2025-11-18 06:20','2025-11-18 08:05',1,3,1,1,2),
('AA240','Domestic','Boarding','2025-11-18 07:55','2025-11-18 10:40',2,9,2,1,4),
('UA881','Domestic','On Time','2025-11-18 09:10','2025-11-18 12:25',3,11,3,1,10),
('B6321','Domestic','On Time','2025-11-18 08:45','2025-11-18 11:20',4,8,4,1,5),
('WN705','Domestic','Delayed','2025-11-18 12:10','2025-11-18 15:55',5,7,5,1,6),
('AS11','Domestic','On Time','2025-11-18 13:20','2025-11-18 17:05',6,18,6,1,8),
('NK902','Domestic','On Time','2025-11-18 14:35','2025-11-18 18:00',7,21,7,1,9),
('F9120','Domestic','On Time','2025-11-18 15:10','2025-11-18 17:00',8,12,8,1,7),
('HA33','Domestic','Boarding','2025-11-18 16:25','2025-11-18 22:00',9,25,9,1,3),
('SY505','Domestic','On Time','2025-11-18 17:40','2025-11-18 20:35',10,14,10,1,10);
INSERT INTO Flight (
    flight_number, flight_type, status, departure_time, arrival_time,
    aircraft_id, gate_id, airline_id, arrival_airport_id, destination_airport_id
) VALUES
('BA212','International','On Time','2025-11-18 18:50','2025-11-19 06:30',3,27,11,1,11),
('VS10','International','Delayed','2025-11-18 20:15','2025-11-19 08:05',4,28,12,1,12),
('AF333','International','On Time','2025-11-18 21:30','2025-11-19 09:55',5,29,13,1,13),
('LH421','International','On Time','2025-11-18 22:20','2025-11-19 10:40',6,30,14,1,14),
('KL644','International','Boarding','2025-11-18 23:05','2025-11-19 11:15',7,19,15,1,17),
('QR744','International','On Time','2025-11-18 21:45','2025-11-19 13:20',8,20,16,1,22),
('EK238','International','On Time','2025-11-18 22:55','2025-11-19 16:30',9,26,17,1,18),
('EY152','International','On Time','2025-11-18 20:40','2025-11-19 14:10',10,5,18,1,18),
('SQ23','International','On Time','2025-11-18 09:00','2025-11-19 05:40',1,16,19,1,20);
INSERT INTO Flight (
    flight_number, flight_type, status, departure_time, arrival_time,
    aircraft_id, gate_id, airline_id, arrival_airport_id, destination_airport_id
) VALUES
('CX811','International','On Time','2025-11-18 13:10','2025-11-19 09:20',2,24,20,19,1),
('AC769','International','On Time','2025-11-18 10:25','2025-11-18 13:05',3,23,21,21,1),
('BA203','International','On Time','2025-11-18 01:10','2025-11-18 07:45',4,6,11,11,1),
('JL808','International','On Time','2025-11-18 02:30','2025-11-18 13:00',5,2,22,19,1),
('AK501','International','On Time','2025-11-18 04:15','2025-11-18 11:55',6,10,23,19,1),
('TK82','International','Delayed','2025-11-18 03:25','2025-11-18 12:35',7,22,24,16,1);




CREATE TABLE Seat (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    seat_number   VARCHAR(10) NOT NULL,
    class         VARCHAR(20) NOT NULL,
    status        VARCHAR(50) NOT NULL DEFAULT 'Available',
    flight_id     INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flight(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Seat (seat_number, class, status, flight_id) VALUES
('1A','Economy','Available',1),
('1B','Business','Available',1),
('2A','Economy','Available',2),
('2B','Business','Available',2),
('3A','Economy','Available',3),
('3B','Business','Available',3),
('4A','Economy','Available',4),
('4B','Business','Available',4),
('5A','Economy','Available',5),
('5B','Business','Available',5),
('6A','Economy','Available',6),
('6B','Business','Available',6),
('7A','Economy','Available',7),
('7B','Business','Available',7),
('8A','Economy','Available',8),
('8B','Business','Available',8),
('9A','Economy','Available',9),
('9B','Business','Available',9),
('10A','Economy','Available',10),
('10B','Business','Available',10),
('11A','Economy','Available',11),
('11B','Business','Available',11),
('12A','Economy','Available',12),
('12B','Business','Available',12),
('13A','Economy','Available',13),
('13B','Business','Available',13),
('14A','Economy','Available',14),
('14B','Business','Available',14),
('15A','Economy','Available',15),
('15B','Business','Available',15),
('16A','Economy','Available',16),
('16B','Business','Available',16),
('17A','Economy','Available',17),
('17B','Business','Available',17),
('18A','Economy','Available',18),
('18B','Business','Available',18),
('19A','Economy','Available',19),
('19B','Business','Available',19),
('20A','Economy','Available',20),
('20B','Business','Available',20),
('21A','Economy','Available',21),
('21B','Business','Available',21),
('22A','Economy','Available',22),
('22B','Business','Available',22),
('23A','Economy','Available',23),
('23B','Business','Available',23),
('24A','Economy','Available',24),
('24B','Business','Available',24),
('25A','Economy','Available',25),
('25B','Business','Available',25);



CREATE TABLE Passenger (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    full_name       VARCHAR(200) NOT NULL,
    gender          VARCHAR(20),
    date_of_birth   DATE,
    nationality     VARCHAR(100),
    status          VARCHAR(50) NOT NULL DEFAULT 'Booked',
    passport_number VARCHAR(50) UNIQUE
);



INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) VALUES
('Tony Hsu', 'Male', '1998-05-14', 'Uruguay', 'Checked-In', 'P98451231'),
('Harrison Pham', 'Male', '1999-11-22', 'USA', 'Checked-In', 'P77182944'),
('Maria Lopez', 'Female', '1992-02-07', 'Mexico', 'Booked', 'P55218039'),
('James Carter', 'Male', '1987-07-18', 'USA', 'Available', 'P99844120'),
('Sophie Nguyen', 'Female', '1995-10-29', 'Vietnam', 'Checked-In', 'P66120947'),
('Daniel Kim', 'Male', '1996-03-12', 'South Korea', 'Checked-In', 'P72911458'),
('Emily Rogers', 'Female', '1990-09-03', 'USA', 'Available', 'P39011822'),
('Michael Patel', 'Male', '1989-12-30', 'India', 'Booked', 'P80019334'),
('Aisha Malik', 'Female', '1993-08-15', 'Pakistan', 'Booked', 'P44920319'),
('Robert Chen', 'Male', '1994-04-27', 'China', 'Checked-In', 'P31908462'),
('Liam Brown', 'Male', '1997-01-10', 'USA', 'Available', 'P63321984'),
('Isabella Gomez', 'Female', '1998-05-01', 'Colombia', 'Booked', 'P10028477'),
('David Singh', 'Male', '1991-09-20', 'India', 'Checked-In', 'P59103348'),
('Olivia Martinez', 'Female', '1994-11-11', 'USA', 'Booked', 'P88200451'),
('William Turner', 'Male', '1988-06-12', 'USA', 'Available', 'P71905512'),
('Chloe Park', 'Female', '1997-03-03', 'South Korea', 'Booked', 'P55193227'),
('Ethan Wright', 'Male', '1995-07-19', 'USA', 'Available', 'P20018754'),
('Grace Thompson', 'Female', '1993-02-14', 'Canada', 'Checked-In', 'P44481721'),
('Lucas Hernandez', 'Male', '1996-12-08', 'Spain', 'Booked', 'P88122934'),
('Nina Patel', 'Female', '1999-04-26', 'India', 'Available', 'P33784219'),
('Jackson Lee', 'Male', '1998-03-17', 'USA', 'Booked', 'P51877210'),
('Ava Richardson', 'Female', '1997-10-02', 'USA', 'Booked', 'P99011433'),
('Marcus Silva', 'Male', '1992-05-23', 'Brazil', 'Checked-In', 'P22590441'),
('Sophia Alvarez', 'Female', '1994-01-29', 'Mexico', 'Available', 'P71120880'),
('Benjamin Hall', 'Male', '1986-09-14', 'USA', 'Booked', 'P60018832');

UPDATE Passenger 
SET status = 'Checked-In' 
WHERE status = 'On-Time';

UPDATE Passenger 
SET status = 'Boarded' 
WHERE status = 'Booked';

UPDATE Passenger 
SET status = 'Delayed' 
WHERE status = 'Available';

CREATE TABLE Passenger_Flight (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id  INT NOT NULL,
    flight_id     INT NOT NULL,
    seat_id       INT,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (flight_id) REFERENCES Flight(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (seat_id) REFERENCES Seat(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);




INSERT INTO Passenger_Flight (passenger_id, flight_id, seat_id) VALUES
(1, 1, 1),
(1, 5, 9),
(2, 2, 3),
(2, 6, 11),
(3, 3, 5),
(4, 4, 7),
(5, 5, 9),
(6, 6, 11),
(7, 7, 13),
(8, 8, 15),
(9, 9, 17),
(10, 10, 19),
(11, 11, 21),
(12, 12, 23),
(13, 13, 25),
(14, 14, 27),
(15, 15, 29),
(16, 16, 31),
(17, 17, 33),
(18, 18, 35),
(19, 19, 37),
(20, 20, 39),
(21, 21, 41),
(22, 22, 43),
(23, 23, 45),
(24, 24, 47),
(25, 25, 49),
(3, 7, 13),
(6, 10, 19),
(14, 3, 6);
  



CREATE TABLE Crew (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    crew_name   VARCHAR(100),
    first_name  VARCHAR(100),
    last_name   VARCHAR(100),
    role        VARCHAR(50),
    city_base   VARCHAR(100)
);

INSERT INTO Crew (crew_name, first_name, last_name, role, city_base) VALUES
('Captain John Smith', 'John', 'Smith', 'Pilot', 'Boston'),
('First Officer Emily Clark', 'Emily', 'Clark', 'Co-Pilot', 'Boston'),
('FA Olivia Perez', 'Olivia', 'Perez', 'Flight Attendant', 'Boston'),
('FA Daniel Rivera', 'Daniel', 'Rivera', 'Flight Attendant', 'Boston'),
('Captain Sarah Johnson', 'Sarah', 'Johnson', 'Pilot', 'New York'),
('First Officer Kevin Lee', 'Kevin', 'Lee', 'Co-Pilot', 'New York'),
('FA Rachel Kim', 'Rachel', 'Kim', 'Flight Attendant', 'New York'),
('FA Jonathan Price', 'Jonathan', 'Price', 'Flight Attendant', 'New York'),
('Captain Anthony Morris', 'Anthony', 'Morris', 'Pilot', 'New York'),
('Captain Michael Adams', 'Michael', 'Adams', 'Pilot', 'Chicago'),
('First Officer Karen White', 'Karen', 'White', 'Co-Pilot', 'Chicago'),
('FA Jennifer Walsh', 'Jennifer', 'Walsh', 'Flight Attendant', 'Chicago'),
('FA Brian Foster', 'Brian', 'Foster', 'Flight Attendant', 'Chicago'),
('Captain Marcus Brown', 'Marcus', 'Brown', 'Pilot', 'London'),
('First Officer Hannah Lewis', 'Hannah', 'Lewis', 'Co-Pilot', 'London'),
('FA Aiden Scott', 'Aiden', 'Scott', 'Flight Attendant', 'London'),
('FA Charlotte Green', 'Charlotte', 'Green', 'Flight Attendant', 'London'),
('Captain Oliver Hughes', 'Oliver', 'Hughes', 'Pilot', 'London'),
('Captain Yusuf Demir', 'Yusuf', 'Demir', 'Pilot', 'Istanbul'),
('First Officer Leyla Kaya', 'Leyla', 'Kaya', 'Co-Pilot', 'Istanbul'),
('Captain Ahmed Khan', 'Ahmed', 'Khan', 'Pilot', 'Dubai'),
('FA Zara Malik', 'Zara', 'Malik', 'Flight Attendant', 'Dubai'),
('Captain Hiro Tanaka', 'Hiro', 'Tanaka', 'Pilot', 'Tokyo'),
('FA Mei Chen', 'Mei', 'Chen', 'Flight Attendant', 'Tokyo'),
('FA Priya Desai', 'Priya', 'Desai', 'Flight Attendant', 'Toronto');

CREATE TABLE Flight_Crew (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    flight_id INT NOT NULL,
    crew_id   INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flight(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (crew_id) REFERENCES Crew(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO Flight_Crew (flight_id, crew_id) VALUES
(1, 1),
(1, 5),
(2, 2),
(2, 6),
(3, 3),
(3, 7),
(4, 4),
(4, 8),
(5, 9),
(5, 13),
(6, 10),
(6, 14),
(11, 11),
(11, 15),
(12, 12),
(12, 16),
(17, 17),
(17, 1),
(20, 20),
(20, 4);


CREATE TABLE Meal (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    meal_name VARCHAR(100) NOT NULL,
    cuisine   VARCHAR(50),
    quantity  INT NOT NULL,
    flight_id INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flight(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO Meal (meal_name, cuisine, quantity, flight_id) VALUES
('Chicken Alfredo', 'American', 120, 1),
('Beef Chili Bowl', 'American', 110, 2),
('Grilled Salmon Plate', 'American', 130, 3),
('Turkey Club Sandwich', 'American', 140, 4),
('BBQ Chicken Rice Bowl', 'American', 100, 5),
('Teriyaki Chicken', 'Japanese', 160, 6),
('Spicy Tuna Donburi', 'Japanese', 150, 7),
('Curry Udon', 'Japanese', 170, 8),
('Hawaiian Pineapple Chicken', 'Hawaiian', 180, 9),
('Island Veggie Plate', 'Hawaiian', 150, 10),
('English Breakfast Tray', 'British', 200, 11),
('Shepherd’s Pie', 'British', 190, 12),
('Coq au Vin', 'French', 210, 13),
('Beef Bourguignon', 'French', 205, 14),
('Dutch Stroopwafel Dessert', 'Dutch', 220, 15),
('Chicken Kabsa', 'Middle Eastern', 230, 16),
('Lamb Machboos', 'Middle Eastern', 240, 17),
('Butter Chicken', 'Indian', 225, 18),
('Hainanese Chicken Rice', 'Singaporean', 250, 19),
('Dim Sum Assortment', 'Chinese', 260, 20),
('Maple Glazed Chicken', 'Canadian', 130, 21),
('Full English Roast', 'British', 210, 22),
('Katsu Curry', 'Japanese', 180, 23),
('Sushi Bento Box', 'Japanese', 175, 24),
('Turkish Doner Plate', 'Turkish', 240, 25);



CREATE TABLE Baggage (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    ticket_num   VARCHAR(50),
    weight       DECIMAL(5,2),
    tag_number   VARCHAR(50),
    destination  VARCHAR(100),
    status       VARCHAR(50) NOT NULL DEFAULT 'Checked-In',
    passenger_id INT NOT NULL,
    flight_id    INT NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (flight_id) REFERENCES Flight(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



INSERT INTO Baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id) VALUES
('T2001', 23.40, 'BG101', 'John F. Kennedy International Airport', 'Loaded', 1, 1),
('T2002', 18.90, 'BG102', 'John F. Kennedy International Airport', 'Loaded', 1, 1),
('T2003', 20.10, 'BG103', 'Chicago O\'Hare International Airport', 'Checked-In', 2, 2),
('T2004', 25.60, 'BG104', 'Chicago O\'Hare International Airport', 'Loaded', 2, 2),
('T2005', 21.75, 'BG105', 'Denver International Airport', 'Loaded', 3, 3),
('T2006', 27.40, 'BG106', 'Denver International Airport', 'Loaded', 3, 3),
('T2007', 17.10, 'BG107', 'Miami International Airport', 'In Transit', 4, 4),
('T2008', 19.65, 'BG108', 'Dallas/Fort Worth International Airport', 'Loaded', 5, 5),
('T2009', 24.30, 'BG109', 'Seattle–Tacoma International Airport', 'Loaded', 6, 6),
('T2010', 28.90, 'BG110', 'Seattle–Tacoma International Airport', 'Loaded', 6, 6),
('T2011', 23.95, 'BG111', 'San Francisco International Airport', 'Checked-In', 7, 7),
('T2012', 26.40, 'BG112', 'Hartsfield–Jackson Atlanta International Airport', 'Loaded', 8, 8),
('T2013', 15.20, 'BG113', 'Hartsfield–Jackson Atlanta International Airport', 'Loaded', 8, 8),
('T2014', 29.70, 'BG114', 'Los Angeles International Airport', 'In Transit', 9, 9),
('T2015', 22.40, 'BG115', 'Denver International Airport', 'Delivered', 10, 10),
('T2016', 17.85, 'BG116', 'Denver International Airport', 'Delivered', 10, 10),
('T2017', 24.70, 'BG117', 'Heathrow Airport', 'Loaded', 11, 11),
('T2018', 28.30, 'BG118', 'Gatwick Airport', 'Checked-In', 12, 12),
('T2019', 23.55, 'BG119', 'Charles de Gaulle Airport', 'Loaded', 13, 13),
('T2020', 26.10, 'BG120', 'Frankfurt Airport', 'Loaded', 14, 14);

 
