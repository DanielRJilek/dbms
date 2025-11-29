USE Kumar_Jilek_Logan_Database;
SET SQL_SAFE_UPDATES = 0;

-- Passenger operations

DELIMITER //
DROP PROCEDURE IF EXISTS create_passenger //
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
    IF full_name IS NULL OR full_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: full_name cannot be empty.';
    END IF;

    IF gender NOT IN ('Male', 'Female', 'Other') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: gender must be Male, Female, or Other.';
    END IF;

    IF date_of_birth IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: date_of_birth cannot be NULL.';
    END IF;

    IF nationality IS NULL OR nationality = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: nationality cannot be empty.';
    END IF;

    IF status NOT IN ('Checked-In', 'Boarded', 'Delayed') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: status must be Checked-In, Boarded, or Delayed.';
    END IF;

    IF (SELECT COUNT(*) FROM passenger WHERE passport_number = passport_number) > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: passport_number already exists.';
    END IF;

	INSERT INTO Passenger (full_name, gender, date_of_birth, nationality, status, passport_number) 
		VALUES (full_name, gender, date_of_birth, nationality, status, passport_number);
END //
DELIMITER ;


call create_passenger('Cristiano Sharma', 'Female', '1996-12-05', 'India', 'Boarded', '123');
call create_passenger('Leonardo Silva', 'Male', '1992-03-18', 'Brazil', 'Delayed', 'P2');


DELIMITER //
DROP procedure if exists read_passenger //
CREATE PROCEDURE read_passenger
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN

	IF attribute NOT IN ('passenger_id', 'full_name', 'gender', 'date_of_birth',
                         'nationality', 'status', 'passport_number') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Invalid attribute name.';
    END IF;
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

call read_passenger('food_choice', 'emale');

DELIMITER //
DROP procedure if exists update_passenger //
CREATE PROCEDURE update_passenger
(
	id int,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN

    IF attribute NOT IN ('passenger_id', 'full_name', 'gender', 'date_of_birth',
                         'nationality', 'status', 'passport_number') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Invalid attribute name.';
    END IF;
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

call update_passenger(1, 'food_name', 'John Doe');
select * from passenger;

DELIMITER //
DROP procedure if exists delete_passenger //
CREATE PROCEDURE delete_passenger
(
    
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
DROP PROCEDURE IF EXISTS delete_passenger_flight //
CREATE PROCEDURE delete_passenger_flight
(
    full_name VARCHAR(200)
)
BEGIN
    IF (SELECT COUNT(*) FROM passenger WHERE full_name = full_name) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Passenger name does not exist.';
    END IF;

    SET @pid = (SELECT passenger_id FROM passenger WHERE full_name = full_name LIMIT 1);

    DELETE FROM passenger_flight
    WHERE passenger_id = @pid;
END //
DELIMITER ;


-- Crew operations

DELIMITER //
DROP PROCEDURE IF EXISTS create_crew //
CREATE PROCEDURE create_crew
(
    crew_id     INT,
    crew_name   VARCHAR(100),
    first_name  VARCHAR(100),
    last_name   VARCHAR(100),
    role        VARCHAR(50),
    city_base   VARCHAR(100)
)
BEGIN
    IF crew_name IS NULL OR crew_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: crew_name cannot be empty.';
    END IF;

    IF crew_id IS NULL OR crew_id = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: crew_id cannot be empty.';
    END IF;
   
    IF first_name IS NULL OR first_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: first_name cannot be empty.';
    END IF;

    IF last_name IS NULL OR last_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: last_name cannot be empty.';
    END IF;

    IF role IS NULL OR role = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: role cannot be empty.';
    END IF;

    IF city_base IS NULL OR city_base = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: city_base cannot be empty.';
    END IF;

	INSERT INTO crew (crew_name, first_name, last_name, role, city_base) 
	VALUES (crew_name, first_name, last_name, role, city_base);
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS read_crew //
CREATE PROCEDURE read_crew
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
    IF attribute NOT IN ('crew_name', 'first_name', 'last_name', 'role', 'city_base') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid attribute name.';
    END IF;

    SET @a = value;

    CASE
        WHEN attribute = 'crew_name' THEN
            PREPARE stmt FROM 'SELECT * FROM crew WHERE crew_name = ?';
            EXECUTE stmt USING @a;

        WHEN attribute = 'first_name' THEN
            PREPARE stmt FROM 'SELECT * FROM crew WHERE first_name = ?';
            EXECUTE stmt USING @a;

        WHEN attribute = 'last_name' THEN
            PREPARE stmt FROM 'SELECT * FROM crew WHERE last_name = ?';
            EXECUTE stmt USING @a;

        WHEN attribute = 'role' THEN
            PREPARE stmt FROM 'SELECT * FROM crew WHERE role = ?';
            EXECUTE stmt USING @a;

        WHEN attribute = 'city_base' THEN
            PREPARE stmt FROM 'SELECT * FROM crew WHERE city_base = ?';
            EXECUTE stmt USING @a;
    END CASE;
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS update_crew //
CREATE PROCEDURE update_crew
(
    id INT,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
    IF (SELECT COUNT(*) FROM crew WHERE crew_id = id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: crew_id does not exist.';
    END IF;

    IF attribute NOT IN ('crew_name', 'first_name', 'last_name', 'role', 'city_base') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid attribute.';
    END IF;

    SET @val = value;
    SET @idval = id;

    SET @sql = CONCAT('UPDATE crew SET ', attribute, ' = ? WHERE crew_id = ?');
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @val, @idval;
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS delete_crew //
CREATE PROCEDURE delete_crew
(
    id INT
)
BEGIN
    IF (SELECT COUNT(*) FROM crew WHERE crew_id = id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: crew_id does not exist.';
    END IF;

    DELETE FROM crew WHERE crew_id = id;
END //
DELIMITER ;


-- Flight_crew operations

DELIMITER //
DROP PROCEDURE IF EXISTS create_flight_crew //
CREATE PROCEDURE create_flight_crew
(
    flight_id  INT,
    crew_id    INT
)
BEGIN
    IF (SELECT COUNT(*) FROM flight WHERE flight_id = flight_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: flight_id does not exist.';
    END IF;

    IF (SELECT COUNT(*) FROM crew WHERE crew_id = crew_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: crew_id does not exist.';
    END IF;

	INSERT INTO flight_crew (flight_id, crew_id) 
	VALUES (flight_id, crew_id);
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS read_flight_crew //
CREATE PROCEDURE read_flight_crew
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
    IF attribute NOT IN ('flight_id', 'crew_id') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid attribute.';
    END IF;

	SET @val = value;

    CASE
        WHEN attribute = 'flight_id' THEN
            PREPARE stmt FROM 'SELECT * FROM flight_crew WHERE flight_id = ?';
            EXECUTE stmt USING @val;

        WHEN attribute = 'crew_id' THEN
            PREPARE stmt FROM 'SELECT * FROM flight_crew WHERE crew_id = ?';
            EXECUTE stmt USING @val;
    END CASE;
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS update_flight_crew //
CREATE PROCEDURE update_flight_crew
(
    id INT,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
    IF (SELECT COUNT(*) FROM flight_crew WHERE fc_id = id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: fc_id does not exist.';
    END IF;

    IF attribute NOT IN ('flight_id', 'crew_id') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid attribute.';
    END IF;

    IF attribute = 'flight_id' AND (SELECT COUNT(*) FROM flight WHERE flight_id = value) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: flight_id does not exist.';
    END IF;

    IF attribute = 'crew_id' AND (SELECT COUNT(*) FROM crew WHERE crew_id = value) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: crew_id does not exist.';
    END IF;

    SET @val = value;
    SET @idval = id;

    SET @sql = CONCAT('UPDATE flight_crew SET ', attribute, ' = ? WHERE fc_id = ?');
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @val, @idval;
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS delete_flight_crew //
CREATE PROCEDURE delete_flight_crew
(
    id INT
)
BEGIN
    IF (SELECT COUNT(*) FROM flight_crew WHERE fc_id = id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: fc_id does not exist.';
    END IF;

    DELETE FROM flight_crew WHERE fc_id = id;
END //
DELIMITER ;


-- Meal operations

DELIMITER //
DROP PROCEDURE IF EXISTS create_meal //
CREATE PROCEDURE create_meal
(
    meal_name   VARCHAR(100),
    cuisine     VARCHAR(50),
    quantity    INT,
    flight_id   INT
)
BEGIN
    IF meal_name IS NULL OR meal_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: meal_name cannot be empty.';
    END IF;

    IF cuisine IS NULL OR cuisine = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: cuisine cannot be empty.';
    END IF;

    IF quantity IS NULL OR quantity <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: quantity must be greater than 0.';
    END IF;

    IF (SELECT COUNT(*) FROM flight WHERE flight_id = flight_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: flight_id does not exist.';
    END IF;

    INSERT INTO meal (meal_name, cuisine, quantity, flight_id)
    VALUES (meal_name, cuisine, quantity, flight_id);
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS read_meal //
CREATE PROCEDURE read_meal
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
    IF attribute NOT IN ('meal_name', 'cuisine', 'quantity', 'flight_id') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid attribute.';
    END IF;

    SET @v = value;

    CASE
        WHEN attribute = 'meal_name' THEN
            PREPARE stmt FROM 'SELECT * FROM meal WHERE meal_name = ?';
            EXECUTE stmt USING @v;

        WHEN attribute = 'cuisine' THEN
            PREPARE stmt FROM 'SELECT * FROM meal WHERE cuisine = ?';
            EXECUTE stmt USING @v;

        WHEN attribute = 'quantity' THEN
            PREPARE stmt FROM 'SELECT * FROM meal WHERE quantity = ?';
            EXECUTE stmt USING @v;

        WHEN attribute = 'flight_id' THEN
            PREPARE stmt FROM 'SELECT * FROM meal WHERE flight_id = ?';
            EXECUTE stmt USING @v;
    END CASE;
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS update_meal //
CREATE PROCEDURE update_meal
(
    id INT,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
    IF (SELECT COUNT(*) FROM meal WHERE meal_id = id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: meal_id does not exist.';
    END IF;

    IF attribute NOT IN ('meal_name', 'cuisine', 'quantity', 'flight_id') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid attribute.';
    END IF;

    IF attribute = 'flight_id' AND (SELECT COUNT(*) FROM flight WHERE flight_id = value) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: flight_id does not exist.';
    END IF;

    SET @val = value;
    SET @idval = id;

    SET @sql = CONCAT('UPDATE meal SET ', attribute, ' = ? WHERE meal_id = ?');
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @val, @idval;
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS delete_meal //
CREATE PROCEDURE delete_meal
(
    id INT
)
BEGIN
    IF (SELECT COUNT(*) FROM meal WHERE meal_id = id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: meal_id does not exist.';
    END IF;

    DELETE FROM meal WHERE meal_id = id;
END //
DELIMITER ;



-- Baggage operations

DELIMITER //
DROP PROCEDURE IF EXISTS create_baggage //
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
    IF ticket_num IS NULL OR ticket_num = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: ticket_num cannot be empty.';
    END IF;

    IF weight IS NULL OR weight <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: weight must be greater than 0.';
    END IF;

    IF tag_number IS NULL OR tag_number = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: tag_number cannot be empty.';
    END IF;

    IF destination IS NULL OR destination = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: destination cannot be empty.';
    END IF;

    IF status NOT IN ('Checked-In', 'Boarding', 'Delayed') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid baggage status.';
    END IF;

    IF (SELECT COUNT(*) FROM passenger WHERE passenger_id = passenger_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: passenger_id does not exist.';
    END IF;

    IF (SELECT COUNT(*) FROM flight WHERE flight_id = flight_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: flight_id does not exist.';
    END IF;

    INSERT INTO baggage (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id)
    VALUES (ticket_num, weight, tag_number, destination, status, passenger_id, flight_id);
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS read_baggage //
CREATE PROCEDURE read_baggage
(
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
    IF attribute NOT IN ('ticket_num','weight','tag_number','destination','status','passenger_id','flight_id') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid attribute.';
    END IF;

    SET @a = value;

    CASE
        WHEN attribute = 'ticket_num' THEN
            PREPARE stmt FROM 'SELECT * FROM baggage WHERE ticket_num = ?';
            EXECUTE stmt USING @a;

        WHEN attribute = 'weight' THEN
            PREPARE stmt FROM 'SELECT * FROM baggage WHERE weight = ?';
            EXECUTE stmt USING @a;

        WHEN attribute = 'tag_number' THEN
            PREPARE stmt FROM 'SELECT * FROM baggage WHERE tag_number = ?';
            EXECUTE stmt USING @a;

        WHEN attribute = 'destination' THEN
            PREPARE stmt FROM 'SELECT * FROM baggage WHERE destination = ?';
            EXECUTE stmt USING @a;

        WHEN attribute = 'status' THEN
            PREPARE stmt FROM 'SELECT * FROM baggage WHERE status = ?';
            EXECUTE stmt USING @a;

        WHEN attribute = 'passenger_id' THEN
            PREPARE stmt FROM 'SELECT * FROM baggage WHERE passenger_id = ?';
            EXECUTE stmt USING @a;

        WHEN attribute = 'flight_id' THEN
            PREPARE stmt FROM 'SELECT * FROM baggage WHERE flight_id = ?';
            EXECUTE stmt USING @a;
    END CASE;
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS update_baggage //
CREATE PROCEDURE update_baggage
(
    id INT,
    attribute VARCHAR(64),
    value VARCHAR(64)
)
BEGIN
    IF (SELECT COUNT(*) FROM baggage WHERE bag_id = id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: bag_id does not exist.';
    END IF;

    IF attribute NOT IN ('ticket_num','weight','tag_number','destination','status','passenger_id','flight_id') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid attribute.';
    END IF;

    IF attribute = 'passenger_id' AND (SELECT COUNT(*) FROM passenger WHERE passenger_id = value) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: passenger_id does not exist.';
    END IF;

    IF attribute = 'flight_id' AND (SELECT COUNT(*) FROM flight WHERE flight_id = value) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: flight_id does not exist.';
    END IF;

    SET @val = value;
    SET @idval = id;

    SET @sql = CONCAT('UPDATE baggage SET ', attribute, ' = ? WHERE bag_id = ?');
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @val, @idval;
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS delete_baggage //
CREATE PROCEDURE delete_baggage
(
    id INT
)
BEGIN
    IF (SELECT COUNT(*) FROM baggage WHERE bag_id = id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: bag_id does not exist.';
    END IF;

    DELETE FROM baggage WHERE bag_id = id;
END //
DELIMITER ;
