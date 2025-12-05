USE Kumar_Jilek_Logan_Database;

/* ============================================================
   A I R P O R T   C R U D
   ============================================================ */

-- CREATE Airport
DROP PROCEDURE IF EXISTS create_Airport;
DELIMITER $$
CREATE PROCEDURE ceate_Airport(
    IN airport_name_input VARCHAR(100),
    IN city_input         VARCHAR(100),
    IN country_input      VARCHAR(100)
)
BEGIN
    DECLARE airport_count INT DEFAULT 0;

    SELECT COUNT(*) INTO airport_count
    FROM Airport
    WHERE airport_name = airport_name_input;

    IF airport_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Airport already exists!';
    ELSE
        INSERT INTO Airport (airport_name, city, country)
        VALUES (airport_name_input, city_input, country_input);
    END IF;
END $$
DELIMITER ;


-- READ – total airports
DROP PROCEDURE IF EXISTS read_Airport;
DELIMITER $$

CREATE PROCEDURE read_Airport(
    IN attr VARCHAR(50),
    IN val  VARCHAR(100)
)
main_block: BEGIN

    IF attr IS NULL AND val IS NULL THEN
        SELECT * FROM Airport;
        LEAVE main_block;
    END IF;

    IF attr IS NULL AND val IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Attribute cannot be NULL when value is provided';
    END IF;

    IF attr NOT IN ('city', 'country') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid attribute. Use ''city'' or ''country''';
    END IF;

    IF attr = 'city' THEN

        IF val IS NULL THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'City value cannot be NULL';
        END IF;

        IF (SELECT COUNT(*) FROM Airport WHERE city = val) = 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'No airports found for this city';
        ELSE
            SELECT * FROM Airport WHERE city = val;
        END IF;

    ELSEIF attr = 'country' THEN

        IF val IS NULL THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Country value cannot be NULL';
        END IF;

        IF (SELECT COUNT(*) FROM Airport WHERE country = val) = 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'No airports found for this country';
        ELSE
            SELECT * FROM Airport WHERE country = val;
        END IF;

    END IF;

END main_block $$

DELIMITER ;



-- FUNCTION – total airports
DROP FUNCTION IF EXISTS total_Airport;
DELIMITER $$

CREATE FUNCTION total_Airport(
    user_attr VARCHAR(50),
    user_val  VARCHAR(100)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT DEFAULT 0;

    IF user_attr IS NULL AND user_val IS NULL THEN
        SELECT COUNT(*) INTO total FROM Airport;
        RETURN total;
    END IF;

    IF user_attr NOT IN ('city', 'country', 'airport_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid attribute. Allowed: city, country, airport_id';
    END IF;

    IF user_val IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Value cannot be NULL when attribute is provided';
    END IF;

    IF user_attr = 'city' THEN
        SELECT COUNT(*) INTO total FROM Airport WHERE city = user_val;

    ELSEIF user_attr = 'country' THEN
        SELECT COUNT(*) INTO total FROM Airport WHERE country = user_val;

    ELSEIF user_attr = 'airport_id' THEN
        SELECT COUNT(*) INTO total FROM Airport WHERE airport_id = user_val;
    END IF;

    IF total = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching airports found';
    END IF;

    RETURN total;
END $$

DELIMITER ;




DROP PROCEDURE IF EXISTS update_Airport;
DELIMITER $$

CREATE PROCEDURE update_Airport(
    IN update_attr  VARCHAR(50),
    IN update_value VARCHAR(100),
    IN match_attr   VARCHAR(50),
    IN match_value  VARCHAR(100)
)
BEGIN

    IF match_attr NOT IN ('city', 'country', 'airport_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid match attribute';
    END IF;

    IF update_attr NOT IN ('city', 'country', 'airport_name') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid update attribute';
    END IF;

    IF match_attr = 'city' AND (SELECT COUNT(*) FROM Airport WHERE city = match_value) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No airport found to update';
    END IF;

    IF match_attr = 'country' AND (SELECT COUNT(*) FROM Airport WHERE country = match_value) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No airport found to update';
    END IF;

    IF match_attr = 'airport_id' AND (SELECT COUNT(*) FROM Airport WHERE airport_id = match_value) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No airport found to update';
    END IF;

    SET @val_update = update_value;
    SET @val_match  = match_value;

    SET @sql = CONCAT(
        'UPDATE Airport SET ', update_attr, ' = ? WHERE ', match_attr, ' = ?'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @val_update, @val_match;
    DEALLOCATE PREPARE stmt;

END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS delete_Airport;
DELIMITER $$

CREATE PROCEDURE delete_Airport(
    IN airport_id INT
)
BEGIN
    IF airport_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Airport ID cannot be NULL';
    END IF;

    IF (SELECT COUNT(*) FROM Airport WHERE id = airport_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching airport found to delete';
    END IF;

    DELETE FROM Airport
    WHERE id = airport_id;
END $$
DELIMITER ;





/* ============================================================
   A I R L I N E   C R U D
   ============================================================ */

-- CREATE Airline
DROP PROCEDURE IF EXISTS create_Airline;
DELIMITER $$

CREATE PROCEDURE create_Airline(
    IN airline_name_input VARCHAR(100),
    IN country_input      VARCHAR(100),
    IN airport_input      VARCHAR(100)
)
BEGIN
    DECLARE airline_count INT DEFAULT 0;

    SELECT COUNT(*) INTO airline_count
    FROM Airline
    WHERE airline_name = airline_name_input;

    IF airline_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Airline already exists!';
    END IF;

    INSERT INTO Airline (airline_name, country, airport_name)
    VALUES (airline_name_input, country_input, airport_input);
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS read_Airline;
DELIMITER $$

CREATE PROCEDURE read_Airline(
    IN attr VARCHAR(50),
    IN val  VARCHAR(100)
)
main_block: BEGIN

    IF attr IS NULL AND val IS NULL THEN
        SELECT * FROM Airline;
        LEAVE main_block;
    END IF;

    IF attr IS NULL AND val IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Attribute cannot be NULL when value is provided';
    END IF;

    IF attr NOT IN ('airline_name', 'country', 'airport_name', 'airline_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid attribute. Allowed: airline_name, country, airport_name, airline_id';
    END IF;

    IF val IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Value cannot be NULL when attribute is provided';
    END IF;
    SET @v = val;
    SET @sql = CONCAT('SELECT * FROM Airline WHERE ', attr, ' = ?');

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @v;
    DEALLOCATE PREPARE stmt;

END main_block $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_Airline;
DELIMITER $$

CREATE PROCEDURE update_Airline(
    IN update_attr  VARCHAR(50),
    IN update_value VARCHAR(100),
    IN match_attr   VARCHAR(50),
    IN match_value  VARCHAR(100)
)
main_block: BEGIN

    IF match_attr NOT IN ('airline_name', 'country', 'airport_name', 'airline_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid match attribute. Allowed: airline_name, country, airport_name, airline_id';
    END IF;

    IF update_attr NOT IN ('airline_name', 'country', 'airport_name') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid update attribute. Allowed: airline_name, country, airport_name';
    END IF;

    IF match_value IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Match value cannot be NULL';
    END IF;

    IF update_value IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Update value cannot be NULL';
    END IF;

    IF (SELECT COUNT(*) FROM Airline WHERE
        (match_attr = 'airline_name' AND airline_name = match_value) OR
        (match_attr = 'country' AND country = match_value) OR
        (match_attr = 'airport_name' AND airport_name = match_value) OR
        (match_attr = 'airline_id' AND airline_id = match_value)
    ) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching airline found to update';
    END IF;

    SET @u = update_value;
    SET @m = match_value;

    SET @sql = CONCAT(
        'UPDATE Airline SET ', update_attr, ' = ? WHERE ', match_attr, ' = ?'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @u, @m;
    DEALLOCATE PREPARE stmt;

END main_block $$

DELIMITER ;

DROP PROCEDURE IF EXISTS delete_Airline;
DELIMITER $$

CREATE PROCEDURE delete_Airline(
    IN airline_id INT
)
BEGIN
    IF airline_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Airline ID cannot be NULL';
    END IF;

    IF (SELECT COUNT(*) FROM Airline WHERE id = airline_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching airline found to delete';
    END IF;

    DELETE FROM Airline
    WHERE id = airline_id;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS total_Airlines;
DELIMITER $$

CREATE FUNCTION total_Airlines()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM Airline;

    RETURN total;
END$$

DELIMITER ;



/* ============================================================
   T E R M I N A L   C R U D
   ============================================================ */

DROP PROCEDURE IF EXISTS add_Terminal;
DELIMITER $$

CREATE PROCEDURE add_Terminal(
    IN input_terminal_name VARCHAR(50),
    IN input_num_gates INT,
    IN input_airport_name VARCHAR(100)
)
BEGIN
    DECLARE terminal_count INT DEFAULT 0;

    SELECT COUNT(*) INTO terminal_count
    FROM Terminal
    WHERE terminal_name = input_terminal_name
      AND airport_name = input_airport_name;

    IF terminal_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Terminal already exists at this airport!';
    END IF;

    INSERT INTO Terminal (terminal_name, num_gates, airport_name)
    VALUES (input_terminal_name, input_num_gates, input_airport_name);
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS read_Terminal;
DELIMITER $$

CREATE PROCEDURE read_terminal(
    IN attr VARCHAR(50),
    IN val  VARCHAR(100)
)
main_block: BEGIN

    IF attr IS NULL AND val IS NULL THEN
        SELECT * FROM Terminal;
        LEAVE main_block;
    END IF;

    IF attr IS NULL AND val IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Attribute cannot be NULL when value is provided';
    END IF;

    IF attr NOT IN ('terminal_name','airport_name','num_gates','terminal_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid attribute';
    END IF;

    IF val IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Value cannot be NULL';
    END IF;

    SET @v = val;
    SET @sql = CONCAT('SELECT * FROM Terminal WHERE ', attr, ' = ?');

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @v;
    DEALLOCATE PREPARE stmt;

END main_block $$
DELIMITER ;


DROP PROCEDURE IF EXISTS update_Terminal;
DELIMITER $$

CREATE PROCEDURE update_Terminal(
    IN update_attr  VARCHAR(50),
    IN update_value VARCHAR(100),
    IN match_attr   VARCHAR(50),
    IN match_value  VARCHAR(100)
)
main_block: BEGIN

    IF match_attr NOT IN ('terminal_name','airport_name','num_gates','terminal_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid match attribute';
    END IF;

    IF update_attr NOT IN ('terminal_name','airport_name','num_gates') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid update attribute';
    END IF;

    IF match_value IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Match value cannot be NULL';
    END IF;

    IF update_value IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Update value cannot be NULL';
    END IF;

    IF (SELECT COUNT(*) FROM Terminal WHERE
        (match_attr='terminal_name' AND terminal_name=match_value) OR
        (match_attr='airport_name' AND airport_name=match_value) OR
        (match_attr='num_gates' AND num_gates=match_value) OR
        (match_attr='terminal_id' AND terminal_id=match_value)
    ) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching terminal found';
    END IF;

    SET @u = update_value;
    SET @m = match_value;

    SET @sql = CONCAT(
        'UPDATE Terminal SET ', update_attr, ' = ? WHERE ', match_attr, ' = ?'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @u, @m;
    DEALLOCATE PREPARE stmt;

END main_block $$
DELIMITER ;

DROP PROCEDURE IF EXISTS delete_Terminal;
DELIMITER $$

CREATE PROCEDURE delete_Terminal(
    IN terminal_id INT
)
BEGIN
    IF terminal_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Terminal ID cannot be NULL';
    END IF;

    IF (SELECT COUNT(*) FROM Terminal WHERE id = terminal_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching terminal found to delete';
    END IF;

    DELETE FROM Terminal
    WHERE id = terminal_id;
END $$
DELIMITER ;


/* ============================================================
   G A T E  C R U D
   ============================================================ */

DROP PROCEDURE IF EXISTS create_Gate;
DELIMITER $$

CREATE PROCEDURE create_Gate(
    IN input_gate_name VARCHAR(20),
    IN input_status VARCHAR(50),
    IN input_terminal_id INT
)
BEGIN
    DECLARE exists_terminal INT DEFAULT 0;
    DECLARE exists_gate INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_terminal
    FROM Terminal
    WHERE terminal_id = input_terminal_id;

    IF exists_terminal = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Terminal does not exist';
    END IF;

    SELECT COUNT(*) INTO exists_gate
    FROM Gate
    WHERE gate_name = input_gate_name
      AND terminal_id = input_terminal_id;

    IF exists_gate > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Gate already exists in this terminal';
    END IF;

    INSERT INTO Gate (gate_name, status, terminal_id)
    VALUES (input_gate_name, input_status, input_terminal_id);
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS read_Gate;
DELIMITER $$

CREATE PROCEDURE read_Gate(
    IN attr VARCHAR(50),
    IN val  VARCHAR(100)
)
main_block: BEGIN

    IF attr IS NULL AND val IS NULL THEN
        SELECT * FROM Gate;
        LEAVE main_block;
    END IF;

    IF attr IS NULL AND val IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Attribute cannot be NULL when value is provided';
    END IF;

    IF attr NOT IN ('gate_id','gate_name','status','terminal_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid attribute';
    END IF;

    IF val IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Value cannot be NULL';
    END IF;

    SET @v = val;
    SET @sql = CONCAT('SELECT * FROM Gate WHERE ', attr, ' = ?');

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @v;
    DEALLOCATE PREPARE stmt;

END main_block $$

DELIMITER ;

DROP PROCEDURE IF EXISTS update_Gate;
DELIMITER $$

CREATE PROCEDURE update_Gate(
    IN update_attr  VARCHAR(50),
    IN update_value VARCHAR(100),
    IN match_attr   VARCHAR(50),
    IN match_value  VARCHAR(100)
)
main_block: BEGIN

    IF match_attr NOT IN ('gate_id','gate_name','status','terminal_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid match attribute';
    END IF;

    IF update_attr NOT IN ('gate_name','status','terminal_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid update attribute';
    END IF;

    IF match_value IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Match value cannot be NULL';
    END IF;

    IF update_value IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Update value cannot be NULL';
    END IF;

    IF (SELECT COUNT(*) FROM Gate WHERE
        (match_attr='gate_id' AND gate_id=match_value) OR
        (match_attr='gate_name' AND gate_name=match_value) OR
        (match_attr='status' AND status=match_value) OR
        (match_attr='terminal_id' AND terminal_id=match_value)
    ) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching gate found to update';
    END IF;

    SET @u = update_value;
    SET @m = match_value;

    SET @sql = CONCAT(
        'UPDATE Gate SET ', update_attr, ' = ? WHERE ', match_attr, ' = ?'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @u, @m;
    DEALLOCATE PREPARE stmt;

END main_block $$

DELIMITER ;

DROP PROCEDURE IF EXISTS delete_Gate;
DELIMITER $$

CREATE PROCEDURE delete_Gate(
    IN gate_id INT
)
BEGIN
    IF gate_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Gate ID cannot be NULL';
    END IF;

    IF (SELECT COUNT(*) FROM Gate WHERE id = gate_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching gate found to delete';
    END IF;

    DELETE FROM Gate
    WHERE id = gate_id;
END $$
DELIMITER ;



/* ============================================
                AIRCRAFT CRUD OPERATIONS
   ============================================ */

DROP PROCEDURE IF EXISTS add_Aircraft;
DELIMITER $$

CREATE PROCEDURE add_Aircraft(
    IN input_model VARCHAR(100),
    IN input_capacity INT
)
BEGIN
    IF input_capacity <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Capacity must be greater than zero';
    END IF;

    INSERT INTO Aircraft (model, capacity)
    VALUES (input_model, input_capacity);
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS read_Aircraft;
DELIMITER $$

CREATE PROCEDURE read_Aircraft(
    IN attr VARCHAR(50),
    IN val  VARCHAR(100)
)
main_block: BEGIN

    IF attr IS NULL AND val IS NULL THEN
        SELECT * FROM Aircraft;
        LEAVE main_block;
    END IF;

    IF attr IS NULL AND val IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Attribute cannot be NULL when value is provided';
    END IF;

    IF attr NOT IN ('aircraft_id','model','capacity') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid attribute';
    END IF;

    IF val IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Value cannot be NULL';
    END IF;

    SET @v = val;

    SET @sql = CONCAT('SELECT * FROM Aircraft WHERE ', attr, ' = ?');

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @v;
    DEALLOCATE PREPARE stmt;

END main_block $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_Aircraft;
DELIMITER $$

CREATE PROCEDURE update_Aircraft(
    IN update_attr  VARCHAR(50),
    IN update_value VARCHAR(100),
    IN match_attr   VARCHAR(50),
    IN match_value  VARCHAR(100)
)
main_block: BEGIN

    IF match_attr NOT IN ('aircraft_id','model','capacity') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid match attribute';
    END IF;

    IF update_attr NOT IN ('model','capacity') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid update attribute';
    END IF;

    IF match_value IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Match value cannot be NULL';
    END IF;

    IF update_value IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Update value cannot be NULL';
    END IF;

    IF update_attr = 'capacity' AND update_value <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Capacity must be greater than zero';
    END IF;

    IF (SELECT COUNT(*) FROM Aircraft WHERE
        (match_attr='aircraft_id' AND aircraft_id=match_value) OR
        (match_attr='model' AND model=match_value) OR
        (match_attr='capacity' AND capacity=match_value)
    ) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching aircraft found';
    END IF;

    SET @u = update_value;
    SET @m = match_value;

    SET @sql = CONCAT(
        'UPDATE Aircraft SET ', update_attr, ' = ? WHERE ', match_attr, ' = ?'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @u, @m;
    DEALLOCATE PREPARE stmt;

END main_block $$

DELIMITER ;

DROP PROCEDURE IF EXISTS delete_Aircraft;
DELIMITER $$

CREATE PROCEDURE delete_Aircraft(
    IN aircraft_id INT
)
BEGIN
    IF aircraft_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Aircraft ID cannot be NULL';
    END IF;

    IF (SELECT COUNT(*) FROM Aircraft WHERE id = aircraft_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching aircraft found to delete';
    END IF;

    DELETE FROM Aircraft
    WHERE id = aircraft_id;
END $$
DELIMITER ;

/* ============================================
               FLIGHT CRUD OPERATIONS
============================================ */

DROP PROCEDURE IF EXISTS create_Flight;
DELIMITER $$

CREATE PROCEDURE create_Flight(
    IN p_flight_number VARCHAR(20),
    IN p_flight_type VARCHAR(50),
    IN p_status VARCHAR(50),
    IN p_departure_time DATETIME,
    IN p_arrival_time DATETIME,
    IN p_aircraft_id INT,
    IN p_gate_id INT,
    IN p_airline_name VARCHAR(100),
    IN p_arrival_airport VARCHAR(100),
    IN p_destination_airport VARCHAR(100)
)
main_block: BEGIN

    IF p_aircraft_id IS NULL OR p_gate_id IS NULL OR p_airline_name IS NULL THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Required values missing';
    END IF;

    IF p_arrival_airport = p_destination_airport THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Arrival and destination cannot match';
    END IF;

    IF (SELECT COUNT(*) FROM Aircraft WHERE aircraft_id=p_aircraft_id)=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Aircraft does not exist';
    END IF;

    IF (SELECT COUNT(*) FROM Gate WHERE gate_id=p_gate_id)=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Gate does not exist';
    END IF;

    IF (SELECT status FROM Gate WHERE gate_id=p_gate_id) <> 'Available' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Gate not available';
    END IF;

    IF (SELECT COUNT(*) FROM Airline WHERE airline_name=p_airline_name)=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Airline does not exist';
    END IF;

    IF (SELECT COUNT(*) FROM Airport WHERE airport_name=p_arrival_airport)=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Arrival airport invalid';
    END IF;

    IF (SELECT COUNT(*) FROM Airport WHERE airport_name=p_destination_airport)=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Destination airport invalid';
    END IF;

    IF (SELECT COUNT(*) FROM Flight WHERE flight_number=p_flight_number AND airline_name=p_airline_name)>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Duplicate flight number for this airline';
    END IF;

    INSERT INTO Flight (
        flight_number, flight_type, status,
        departure_time, arrival_time,
        aircraft_id, gate_id, airline_name,
        arrival_airport_name, destination_airport_name
    ) VALUES (
        p_flight_number, p_flight_type, p_status,
        p_departure_time, p_arrival_time,
        p_aircraft_id, p_gate_id, p_airline_name,
        p_arrival_airport, p_destination_airport
    );

END main_block $$
DELIMITER ;

DROP FUNCTION IF EXISTS total_Flights;
DELIMITER $$

CREATE FUNCTION total_Flights()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM Flight;

    RETURN total;
END$$

DELIMITER ;


DROP PROCEDURE IF EXISTS read_Flight;
DELIMITER $$

CREATE PROCEDURE read_Flight(
    IN attr VARCHAR(50),
    IN val VARCHAR(200)
)
main_block: BEGIN

    IF attr IS NULL AND val IS NULL THEN
        SELECT * FROM Flight;
        LEAVE main_block;
    END IF;

    IF attr IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Attribute cannot be NULL';
    END IF;

    IF attr NOT IN (
        'flight_id','flight_number','flight_type','status','departure_time',
        'arrival_time','aircraft_id','gate_id','airline_name',
        'arrival_airport_name','destination_airport_name'
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid attribute';
    END IF;

    IF val IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Value cannot be NULL';
    END IF;

    SET @v = val;
    SET @sql = CONCAT('SELECT * FROM Flight WHERE ', attr, ' = ?');

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @v;
    DEALLOCATE PREPARE stmt;

END main_block $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_Flight;
DELIMITER $$

CREATE PROCEDURE update_Flight(
    IN update_attr VARCHAR(50),
    IN update_val VARCHAR(200),
    IN match_attr VARCHAR(50),
    IN match_val VARCHAR(200)
)
main_block: BEGIN

    IF match_attr NOT IN (
        'flight_id','flight_number','flight_type','status','departure_time',
        'arrival_time','aircraft_id','gate_id','airline_name',
        'arrival_airport_name','destination_airport_name'
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid match attribute';
    END IF;

    IF update_attr NOT IN (
        'flight_number','flight_type','status','departure_time','arrival_time',
        'aircraft_id','gate_id','airline_name',
        'arrival_airport_name','destination_airport_name'
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid update attribute';
    END IF;

    IF match_val IS NULL OR update_val IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='NULL values not allowed';
    END IF;

    IF (SELECT COUNT(*) FROM Flight WHERE
        (match_attr='flight_id' AND flight_id=match_val) OR
        (match_attr='flight_number' AND flight_number=match_val) OR
        (match_attr='airline_name' AND airline_name=match_val)
    ) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No matching flight';
    END IF;

    SET @u = update_val;
    SET @m = match_val;

    SET @sql = CONCAT('UPDATE Flight SET ', update_attr, ' = ? WHERE ', match_attr, ' = ?');

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @u, @m;
    DEALLOCATE PREPARE stmt;

END main_block $$
DELIMITER ;


DROP PROCEDURE IF EXISTS delete_Flight;
DELIMITER $$

CREATE PROCEDURE delete_Flight(
    IN flight_id INT
)
BEGIN
    IF flight_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Flight ID cannot be NULL';
    END IF;

    IF (SELECT COUNT(*) FROM Flight WHERE id = flight_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching flight found to delete';
    END IF;

    DELETE FROM Flight
    WHERE id = flight_id;
END $$
DELIMITER ;

/* ============================================
               SEAT CRUD OPERATIONS
============================================ */

DROP PROCEDURE IF EXISTS create_Seat;
DELIMITER $$

CREATE PROCEDURE create_Seat(
    IN input_seat_number VARCHAR(10),
    IN input_class VARCHAR(20),
    IN input_status VARCHAR(50),
    IN input_flight_id INT
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight
    FROM Flight
    WHERE flight_id = input_flight_id;

    IF exists_flight = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Flight does not exist';
    END IF;

    INSERT INTO Seat(seat_number, class, status, flight_id)
    VALUES(input_seat_number, input_class, input_status, input_flight_id);
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS read_Seat;
DELIMITER $$

CREATE PROCEDURE read_Seat(
    IN attr VARCHAR(50),
    IN val  VARCHAR(100)
)
main_block: BEGIN

    IF attr IS NULL AND val IS NULL THEN
        SELECT * FROM Seat;
        LEAVE main_block;
    END IF;

    IF attr IS NULL AND val IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Attribute cannot be NULL when value is provided';
    END IF;

    IF attr NOT IN ('seat_id','seat_number','class','status','flight_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid seat attribute';
    END IF;

    IF val IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Value cannot be NULL';
    END IF;

    SET @v = val;
    SET @sql = CONCAT('SELECT * FROM Seat WHERE ', attr, ' = ?');

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @v;
    DEALLOCATE PREPARE stmt;

END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS update_Seat;
DELIMITER $$

CREATE PROCEDURE update_Seat(
    IN input_seat_id INT,
    IN update_attr VARCHAR(50),
    IN update_val  VARCHAR(100)
)
BEGIN
    DECLARE exists_seat INT DEFAULT 0;
    DECLARE exists_flight INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_seat
    FROM Seat
    WHERE seat_id = input_seat_id;

    IF exists_seat = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Seat does not exist';
    END IF;

    IF update_attr NOT IN ('seat_number','class','status','flight_id') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid seat update attribute';
    END IF;

    IF update_attr = 'flight_id' THEN
        SELECT COUNT(*) INTO exists_flight
        FROM Flight
        WHERE flight_id = update_val;

        IF exists_flight = 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Flight does not exist';
        END IF;
    END IF;

    SET @id = input_seat_id;
    SET @val = update_val;
    SET @sql = CONCAT('UPDATE Seat SET ', update_attr, ' = ? WHERE seat_id = ?');

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @val, @id;
    DEALLOCATE PREPARE stmt;

END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS delete_Seat;
DELIMITER $$

CREATE PROCEDURE delete_Seat(
    IN seat_id INT
)
BEGIN
    IF seat_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Seat ID cannot be NULL';
    END IF;

    IF (SELECT COUNT(*) FROM Seat WHERE id = seat_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No matching seat found to delete';
    END IF;

    DELETE FROM Seat
    WHERE id = seat_id;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS seat_mark_occupied;
DELIMITER $$

CREATE TRIGGER seat_mark_occupied
AFTER INSERT ON Passenger_Flight
FOR EACH ROW
BEGIN
    IF NEW.seat_id IS NOT NULL THEN
        UPDATE Seat
        SET status = 'Occupied'
        WHERE id = NEW.seat_id;
    END IF;
END$$

DELIMITER ;


