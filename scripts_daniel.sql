USE Kumar_Jilek_Logan_Database;
SET SQL_SAFE_UPDATES = 0;

-- Passenger operations

DELIMITER //
DROP procedure if exists create_passenger //
CREATE PROCEDURE create_passenger
(
    full_name        VARCHAR(200),
    gender           VARCHAR(20),
    date_of_birth    DATE,
    nationality      VARCHAR(100),
    status           VARCHAR(50),
    passport_number  VARCHAR(50)
)
BEGIN
	INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) 
		VALUES (full_name, gender, date_of_birth, nationality, status, passport_number);
END //
DELIMITER ;

call create_passenger('John Doe', 'Male', '1998-05-14', 'USA', 'Checked-In', 'P98451232');
select * from passenger;

DELIMITER //
DROP procedure if exists read_passenger //
CREATE PROCEDURE read_passenger
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    CASE
		WHEN attribute = 'passenger_id' THEN 
			PREPARE stmt from 'SELECT * FROM passenger where passenger.passenger_id = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'full_name' THEN 
			PREPARE stmt from 'SELECT * FROM passenger where passenger.full_name = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'gender' THEN 
			PREPARE stmt from 'SELECT * FROM passenger where passenger.gender = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'date_of_birth' THEN 
			PREPARE stmt from 'SELECT * FROM passenger where passenger.date_of_birth = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'nationality' THEN 
			PREPARE stmt from 'SELECT * FROM passenger where passenger.nationality = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'status' THEN 
			PREPARE stmt from 'SELECT * FROM passenger where passenger.status = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'passport_number' THEN 
			PREPARE stmt from 'SELECT * FROM passenger where passenger.passport_number = ?';    
			EXECUTE stmt USING @a;
	end case;
END //
DELIMITER ;

call read_passenger('gender', 'Male');

DELIMITER //
DROP procedure if exists update_passenger //
CREATE PROCEDURE update_passenger
(
	id int,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    SET @b = id;
    CASE
		WHEN attribute = 'passenger_id' THEN 
			PREPARE stmt from 'UPDATE passenger set passenger.passenger_id = ? where passenger.passenger_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'full_name' THEN 
			PREPARE stmt from 'UPDATE passenger set passenger.full_name = ? where passenger.passenger_id = ?';
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'gender' THEN 
			PREPARE stmt from 'UPDATE passenger set passenger.gender = ? where passenger.passenger_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'date_of_birth' THEN 
			PREPARE stmt from 'UPDATE passenger set passenger.date_of_birth = ? where passenger.passenger_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'nationality' THEN 
			PREPARE stmt from 'UPDATE passenger set passenger.nationality = ? where passenger.passenger_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'status' THEN 
			PREPARE stmt from 'UPDATE passenger set passenger.status = ? where passenger.passenger_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'passport_number' THEN 
			PREPARE stmt from 'UPDATE passenger set passenger.passport_number = ? where passenger.passenger_id = ?';    
			EXECUTE stmt USING @a, @b;
	end case;
END //
DELIMITER ;

call update_passenger(1, 'full_name', 'John Doe');
select * from passenger;

DELIMITER //
DROP procedure if exists delete_passenger //
CREATE PROCEDURE delete_passenger
(
    id int
)
BEGIN
	DELETE FROM passenger
		where passenger.passenger_id = id;
END //
DELIMITER ;

call delete_passenger(26);
select * from passenger;

-- Passenger_flight operations

DELIMITER //
DROP procedure if exists create_passenger_flight //
CREATE PROCEDURE create_passenger_flight
(
    passenger_id   INT,
    flight_id      INT,
    seat_id        INT
)
BEGIN
	INSERT INTO Passenger_Flight (pf_id, passenger_id, flight_id, seat_id) 
		VALUES (pf_id, passenger_id, flight_id, seat_id);
END //
DELIMITER ;

call create_passenger_flight(1,1,2);
select * from passenger_flight;

DELIMITER //
DROP procedure if exists read_passenger_flight //
CREATE PROCEDURE read_passenger_flight
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    CASE
		WHEN attribute = 'passenger_id' THEN 
			PREPARE stmt from 'SELECT * FROM passenger_flight where passenger_flight.passenger_id = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'flight_id' THEN 
			PREPARE stmt from 'SELECT * FROM passenger_flight where passenger_flight.flight_id = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'seat_id' THEN 
			PREPARE stmt from 'SELECT * FROM passenger_flight where passenger_flight.seat_id = ?';    
			EXECUTE stmt USING @a;
	end case;
END //
DELIMITER ;

call read_passenger_flight('passenger_id', 1);

DELIMITER //
DROP procedure if exists update_passenger_flight //
CREATE PROCEDURE update_passenger_flight
(
	id int,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    SET @b = id;
    CASE
		WHEN attribute = 'passenger_id' THEN 
			PREPARE stmt from 'UPDATE passenger_flight set passenger_flight.passenger_id = ? where passenger.passenger_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'flight_id' THEN 
			PREPARE stmt from 'UPDATE passenger_flight set passenger_flight.flight_id = ? where passenger.passenger_id = ?';
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'seat_id' THEN 
			PREPARE stmt from 'UPDATE passenger_flight set passenger_flight.seat_id = ? where passenger.passenger_id = ?';    
			EXECUTE stmt USING @a, @b;
	end case;
END //
DELIMITER ;

call update_passenger_flight();
select * from passenger_flight;

DELIMITER //
DROP procedure if exists delete_passenger_flight //
CREATE PROCEDURE delete_passenger_flight
(
    id int
)
BEGIN
	DELETE FROM passenger_flight
		where passenger_flight.pf_id = id;
END //
DELIMITER ;

call delete_passenger_flight(1);
select * from passenger_flight;


-- Crew operations


DELIMITER //
DROP procedure if exists create_crew //
CREATE PROCEDURE create_crew
(
    crew_name   VARCHAR(100),
    first_name  VARCHAR(100),
    last_name   VARCHAR(100),
    role        VARCHAR(50),
    city_base   VARCHAR(100)
)
BEGIN
	INSERT INTO crew (crew_name, first_name, last_name, role, city_base) 
		VALUES (crew_name, first_name, last_name, role, city_base);
END //
DELIMITER ;

call create_crew();
select * from crew;

DELIMITER //
DROP procedure if exists read_crew //
CREATE PROCEDURE read_crew
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    CASE
		WHEN attribute = 'crew_name' THEN 
			PREPARE stmt from 'SELECT * FROM crew where crew.crew_name = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'first_name' THEN 
			PREPARE stmt from 'SELECT * FROM crew where crew.first_name = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'last_name' THEN 
			PREPARE stmt from 'SELECT * FROM crew where crew.last_name = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'role' THEN 
			PREPARE stmt from 'SELECT * FROM crew where crew.role = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'city_base' THEN 
			PREPARE stmt from 'SELECT * FROM crew where crew.city_base = ?';    
			EXECUTE stmt USING @a;
	end case;
END //
DELIMITER ;

call read_crew();

DELIMITER //
DROP procedure if exists update_crew //
CREATE PROCEDURE update_crew
(
	id int,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    SET @b = id;
    CASE
		WHEN attribute = 'crew_name' THEN 
			PREPARE stmt from 'UPDATE crew set crew.crew_name = ? where crew.crew_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'first_name' THEN 
			PREPARE stmt from 'UPDATE passenger_flight set crew.first_name = ? where crew.crew_id = ?';
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'last_name' THEN 
			PREPARE stmt from 'UPDATE passenger_flight set crew.last_name = ? where crew.crew_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'role' THEN 
			PREPARE stmt from 'UPDATE passenger_flight set crew.role = ? where crew.crew_id = ?';
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'city_base' THEN 
			PREPARE stmt from 'UPDATE passenger_flight set crew.city_base = ? where crew.crew_id = ?';    
			EXECUTE stmt USING @a, @b;
	end case;
END //
DELIMITER ;

call update_crew();
select * from crew;

DELIMITER //
DROP procedure if exists delete_crew //
CREATE PROCEDURE delete_crew
(
    id int
)
BEGIN
	DELETE FROM crew
		where crew.crew_id = id;
END //
DELIMITER ;

call delete_crew(1);
select * from crew;

-- Flight_crew operations


DELIMITER //
DROP procedure if exists create_flight_crew //
CREATE PROCEDURE create_flight_crew
(
    flight_id  INT,
    crew_id    INT
)
BEGIN
	INSERT INTO flight_crew (flight_id, crew_id) 
		VALUES (flight_id, crew_id);
END //
DELIMITER ;

call create_flight_crew();
select * from flight_crew;

DELIMITER //
DROP procedure if exists read_flight_crew //
CREATE PROCEDURE read_flight_crew
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    CASE
		WHEN attribute = 'flight_id' THEN 
			PREPARE stmt from 'SELECT * FROM flight_crew where flight_crew.flight_id = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'crew_id' THEN 
			PREPARE stmt from 'SELECT * FROM flight_crew where flight_crew.crew_id = ?';    
			EXECUTE stmt USING @a;
	end case;
END //
DELIMITER ;

call read_flight_crew();

DELIMITER //
DROP procedure if exists update_flight_crew //
CREATE PROCEDURE update_flight_crew
(
	id int,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    SET @b = id;
    CASE
		WHEN attribute = 'flight_id' THEN 
			PREPARE stmt from 'UPDATE flight_crew set flight_crew.flight_id = ? where flight_crew.fc_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'crew_id' THEN 
			PREPARE stmt from 'UPDATE flight_crew set flight_crew.crew_id = ? where flight_crew.fc_id = ?';
			EXECUTE stmt USING @a, @b;
	end case;
END //
DELIMITER ;

call update_flight_crew();
select * from flight_crew;

DELIMITER //
DROP procedure if exists delete_flight_crew //
CREATE PROCEDURE delete_flight_crew
(
    id int
)
BEGIN
	DELETE FROM flight_crew
		where flight_crew.fc_id = id;
END //
DELIMITER ;

call delete_flight_crew(1);
select * from flight_crew;

-- Meal operations


DELIMITER //
DROP procedure if exists create_meal //
CREATE PROCEDURE create_meal
(
    meal_name   VARCHAR(100),
    cuisine     VARCHAR(50),
    quantity    INT,
    flight_id   INT
)
BEGIN
	INSERT INTO meal (meal_name, cuisine, quantity, flight_id) 
		VALUES (meal_name, cuisine, quantity, flight_id);
END //
DELIMITER ;

call create_meal();
select * from meal;

DELIMITER //
DROP procedure if exists read_meal //
CREATE PROCEDURE read_meal
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    CASE
		WHEN attribute = 'meal_name' THEN 
			PREPARE stmt from 'SELECT * FROM meal where meal.meal_name = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'cuisine' THEN 
			PREPARE stmt from 'SELECT * FROM meal where meal.cuisine = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'quantity' THEN 
			PREPARE stmt from 'SELECT * FROM meal where meal.quantity = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'flight_id' THEN 
			PREPARE stmt from 'SELECT * FROM meal where meal.flight_id = ?';    
			EXECUTE stmt USING @a;
	end case;
END //
DELIMITER ;

call read_meal();

DELIMITER //
DROP procedure if exists update_meal //
CREATE PROCEDURE update_meal
(
	id int,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    SET @b = id;
    CASE
		WHEN attribute = 'meal_name' THEN 
			PREPARE stmt from 'UPDATE meal set meal.meal_name = ? where meal.meal_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'cuisine' THEN 
			PREPARE stmt from 'UPDATE meal set meal.cuisine = ? where meal.meal_id = ?';
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'quantity' THEN 
			PREPARE stmt from 'UPDATE meal set meal.quantity = ? where meal.meal_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'flight_id' THEN 
			PREPARE stmt from 'UPDATE meal set meal.flight_id = ? where meal.meal_id = ?';
			EXECUTE stmt USING @a, @b;
	end case;
END //
DELIMITER ;

call update_meal();
select * from meal;

DELIMITER //
DROP procedure if exists delete_meal //
CREATE PROCEDURE delete_meal
(
    id int
)
BEGIN
	DELETE FROM meal
		where meal.meal_id = id;
END //
DELIMITER ;

call delete_meal(1);
select * from meal;

-- Baggage operations

DELIMITER //
DROP procedure if exists create_baggage //
CREATE PROCEDURE create_baggage
(
    ticket_num    VARCHAR(50),
    weight        DECIMAL(5,2),
    tag_number    VARCHAR(50),
    destination   VARCHAR(100),
    status        VARCHAR(50),
    passenger_id  INT,
    flight_id     INT
)
BEGIN
	INSERT INTO baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id) 
		VALUES (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id);
END //
DELIMITER ;

call create_baggage();
select * from baggage;

DELIMITER //
DROP procedure if exists read_baggage //
CREATE PROCEDURE read_baggage
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    CASE
		WHEN attribute = 'ticket_num' THEN 
			PREPARE stmt from 'SELECT * FROM baggage where baggage.ticket_num = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'weight' THEN 
			PREPARE stmt from 'SELECT * FROM baggage where baggage.weight = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'tag_number' THEN 
			PREPARE stmt from 'SELECT * FROM baggage where baggage.tag_number = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'destination' THEN 
			PREPARE stmt from 'SELECT * FROM baggage where baggage.destination = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'status' THEN 
			PREPARE stmt from 'SELECT * FROM baggage where baggage.status = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'passenger_id' THEN 
			PREPARE stmt from 'SELECT * FROM baggage where baggage.passenger_id = ?';    
			EXECUTE stmt USING @a;
		WHEN attribute = 'flight_id' THEN 
			PREPARE stmt from 'SELECT * FROM baggage where baggage.flight_id = ?';    
			EXECUTE stmt USING @a;
	end case;
END //
DELIMITER ;

call read_baggage();

DELIMITER //
DROP procedure if exists update_baggage //
CREATE PROCEDURE update_baggage
(
	id int,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
	SET @a = value;
    SET @b = id;
    CASE
		WHEN attribute = 'ticket_num' THEN 
			PREPARE stmt from 'UPDATE baggage set baggage.meal_name = ? where baggage.bag_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'weight' THEN 
			PREPARE stmt from 'UPDATE baggage set baggage.weight = ? where baggage.bag_id = ?';
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'tag_number' THEN 
			PREPARE stmt from 'UPDATE baggage set baggage.tag_number = ? where baggage.bag_id = ?';    
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'destination' THEN 
			PREPARE stmt from 'UPDATE baggage set baggage.destination = ? where baggage.bag_id = ?';
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'status' THEN 
			PREPARE stmt from 'UPDATE baggage set baggage.status = ? where baggage.bag_id = ?';
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'passenger_id' THEN 
			PREPARE stmt from 'UPDATE baggage set baggage.passenger_id = ? where baggage.bag_id = ?';
			EXECUTE stmt USING @a, @b;
		WHEN attribute = 'flight_id' THEN 
			PREPARE stmt from 'UPDATE baggage set baggage.flight_id = ? where baggage.bag_id = ?';
			EXECUTE stmt USING @a, @b;
	end case;
END //
DELIMITER ;

call update_baggage();
select * from baggage;

DELIMITER //
DROP procedure if exists delete_baggage //
CREATE PROCEDURE delete_meal
(
    id int
)
BEGIN
	DELETE FROM baggage
		where baggage.bag_id = id;
END //
DELIMITER ;

call delete_baggage(1);
select * from baggage;