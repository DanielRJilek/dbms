USE Kumar_Jilek_Logan_Database;

/* ============================================================
   A I R P O R T   C R U D
   ============================================================ */

-- CREATE Airport
DROP PROCEDURE IF EXISTS add_new_airport;
DELIMITER $$
CREATE PROCEDURE add_new_airport(
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
DROP PROCEDURE IF EXISTS all_airports;
DELIMITER $$
CREATE PROCEDURE all_airports()
BEGIN
    SELECT COUNT(*) AS total_airports
    FROM Airport;
END $$
DELIMITER ;


-- READ – airports by country
DROP PROCEDURE IF EXISTS all_airports_country;
DELIMITER $$
CREATE PROCEDURE all_airports_country(
    IN input_country VARCHAR(100)
)
BEGIN
    DECLARE country_count INT DEFAULT 0;

    SELECT COUNT(*) INTO country_count
    FROM Airport
    WHERE country = input_country;

    IF country_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No airports in this country';
    ELSE
        SELECT * FROM Airport
        WHERE country = input_country;
    END IF;
END $$
DELIMITER ;


-- READ – airports by city
DROP PROCEDURE IF EXISTS all_airports_city;
DELIMITER $$
CREATE PROCEDURE all_airports_city(
    IN input_city VARCHAR(100)
)
BEGIN
    DECLARE city_count INT DEFAULT 0;

    SELECT COUNT(*) INTO city_count
    FROM Airport
    WHERE city = input_city;

    IF city_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No airports in this city';
    ELSE
        SELECT * FROM Airport
        WHERE city = input_city;
    END IF;
END $$
DELIMITER ;


-- FUNCTION – total airports
DROP FUNCTION IF EXISTS total_airports;
DELIMITER $$
CREATE FUNCTION total_airports()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT DEFAULT 0;

    SELECT COUNT(*) INTO total
    FROM Airport;

    RETURN total;
END $$
DELIMITER ;


-- FUNCTION – total airports in country
DROP FUNCTION IF EXISTS total_airports_in_country;
DELIMITER $$
CREATE FUNCTION total_airports_in_country(user_country VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE country_count INT DEFAULT 0;

    SELECT COUNT(*) INTO country_count
    FROM Airport
    WHERE country = user_country;

    IF country_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No airports found in this country';
    END IF;

    RETURN country_count;
END $$
DELIMITER ;


-- FUNCTION – total airports in city
DROP FUNCTION IF EXISTS total_airports_in_city;
DELIMITER $$
CREATE FUNCTION total_airports_in_city(user_city VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE city_count INT DEFAULT 0;

    SELECT COUNT(*) INTO city_count
    FROM Airport
    WHERE city = user_city;

    IF city_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No airports found in this city';
    END IF;

    RETURN city_count;
END $$
DELIMITER ;




/* ============================================================
   A I R L I N E   C R U D
   ============================================================ */

-- CREATE Airline
DROP PROCEDURE IF EXISTS add_new_airline;
DELIMITER $$
CREATE PROCEDURE add_new_airline(
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
    ELSE
        INSERT INTO Airline (airline_name, country, airport_name)
        VALUES (airline_name_input, country_input, airport_input);
    END IF;
END $$
DELIMITER ;


-- READ – total airlines
DROP PROCEDURE IF EXISTS all_airlines;
DELIMITER $$
CREATE PROCEDURE all_airlines()
BEGIN
    SELECT COUNT(*) AS total_airlines
    FROM Airline;
END $$
DELIMITER ;


-- READ – airlines by country
DROP PROCEDURE IF EXISTS all_airlines_country;
DELIMITER $$
CREATE PROCEDURE all_airlines_country(
    IN input_country VARCHAR(100)
)
BEGIN
    DECLARE country_count INT DEFAULT 0;

    SELECT COUNT(*) INTO country_count
    FROM Airline
    WHERE country = input_country;

    IF country_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No airlines in this country';
    ELSE
        SELECT * FROM Airline
        WHERE country = input_country;
    END IF;
END $$
DELIMITER ;


-- READ – airlines at airport
DROP PROCEDURE IF EXISTS all_airlines_at_airport;
DELIMITER $$
CREATE PROCEDURE all_airlines_at_airport(
    IN input_airport VARCHAR(100)
)
BEGIN
    DECLARE airline_count INT DEFAULT 0;

    SELECT COUNT(*) INTO airline_count
    FROM Airline
    WHERE airport_name = input_airport;

    IF airline_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No airlines operate at this airport';
    ELSE
        SELECT * FROM Airline
        WHERE airport_name = input_airport;
    END IF;
END $$
DELIMITER ;


-- FUNCTION – total airlines
DROP FUNCTION IF EXISTS total_airlines;
DELIMITER $$
CREATE FUNCTION total_airlines()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT DEFAULT 0;

    SELECT COUNT(*) INTO total
    FROM Airline;

    RETURN total;
END $$
DELIMITER ;


-- FUNCTION – total airlines in country
DROP FUNCTION IF EXISTS total_airlines_in_country;
DELIMITER $$
CREATE FUNCTION total_airlines_in_country(user_country VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE country_count INT DEFAULT 0;

    SELECT COUNT(*) INTO country_count
    FROM Airline
    WHERE country = user_country;

    IF country_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No airlines found in this country';
    END IF;

    RETURN country_count;
END $$
DELIMITER ;





/* ============================================================
   T E R M I N A L   C R U D
   ============================================================ */

-- CREATE Terminal
DROP PROCEDURE IF EXISTS add_terminal;
DELIMITER $$
CREATE PROCEDURE add_terminal(
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
    ELSE
        INSERT INTO Terminal (terminal_name, num_gates, airport_name)
        VALUES (input_terminal_name, input_num_gates, input_airport_name);
    END IF;
END $$
DELIMITER ;


-- READ – total gates in airport
DROP PROCEDURE IF EXISTS total_gates;
DELIMITER $$
CREATE PROCEDURE total_gates()
BEGIN
    SELECT SUM(num_gates) AS total_gates
    FROM Terminal
    WHERE airport_name = 'Logan International Airport';
END $$
DELIMITER ;


-- READ – total terminals in airport
DROP PROCEDURE IF EXISTS total_terminals;
DELIMITER $$
CREATE PROCEDURE total_terminals()
BEGIN
    SELECT COUNT(*) AS total_terminals
    FROM Terminal
    WHERE airport_name = 'Logan International Airport';
END $$
DELIMITER ;


-- READ – total gates in terminal
DROP PROCEDURE IF EXISTS total_gates_in_terminal;
DELIMITER $$
CREATE PROCEDURE total_gates_in_terminal(
    IN input_terminal_name VARCHAR(50)
)
BEGIN
    DECLARE counts INT DEFAULT 0;

    SELECT COUNT(*) INTO counts
    FROM Terminal
    WHERE terminal_name = input_terminal_name
      AND airport_name = 'Logan International Airport';

    IF counts = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Terminal does not exist at Logan International Airport.';
    ELSE
        SELECT num_gates AS total_gates_in_terminal
        FROM Terminal
        WHERE terminal_name = input_terminal_name
          AND airport_name = 'Logan International Airport';
    END IF;
END $$
DELIMITER ;


-- UPDATE – terminal name
DROP PROCEDURE IF EXISTS update_terminal_name;
DELIMITER $$
CREATE PROCEDURE update_terminal_name(
    IN old_terminal_name VARCHAR(50),
    IN new_terminal_name VARCHAR(50)
)
BEGIN
    DECLARE checks INT DEFAULT 0;

    SELECT COUNT(*) INTO checks
    FROM Terminal
    WHERE terminal_name = old_terminal_name
      AND airport_name = 'Logan International Airport';

    IF checks = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Terminal does not exist at Logan.';
    ELSE
        UPDATE Terminal
        SET terminal_name = new_terminal_name
        WHERE terminal_name = old_terminal_name
          AND airport_name = 'Logan International Airport';
    END IF;
END $$
DELIMITER ;


-- UPDATE – terminal gates
DROP PROCEDURE IF EXISTS update_terminal_gates;
DELIMITER $$
CREATE PROCEDURE update_terminal_gates(
    IN input_terminal_name VARCHAR(50),
    IN new_num_gates INT
)
BEGIN
    DECLARE checks INT DEFAULT 0;

    SELECT COUNT(*) INTO checks
    FROM Terminal
    WHERE terminal_name = input_terminal_name
      AND airport_name = 'Logan International Airport';

    IF checks = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Terminal does not exist at Logan.';
    ELSE
        UPDATE Terminal
        SET num_gates = new_num_gates
        WHERE terminal_name = input_terminal_name
          AND airport_name = 'Logan International Airport';
    END IF;
END $$
DELIMITER ;


-- DELETE – terminal
DROP PROCEDURE IF EXISTS delete_terminal;
DELIMITER $$
CREATE PROCEDURE delete_terminal(
    IN input_terminal_name VARCHAR(50)
)
BEGIN
    Declare checks INT DEFAULT 0;

    SELECT COUNT(*) INTO checks
    FROM Terminal
    WHERE terminal_name = input_terminal_name
      AND airport_name = 'Logan International Airport';

    IF checks = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Cannot delete — terminal does not exist at Logan.';
    ELSE
        DELETE FROM Terminal
        WHERE terminal_name = input_terminal_name
          AND airport_name = 'Logan International Airport';
    END IF;
END $$
DELIMITER ;

/* ============================================================
   G A T E  C R U D
   ============================================================ */

DROP PROCEDURE IF EXISTS add_gate;
DELIMITER $$
CREATE PROCEDURE add_gate(
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
            SET MESSAGE_TEXT = 'Error: Terminal does not exist.';
    END IF;

    SELECT COUNT(*) INTO exists_gate
    FROM Gate
    WHERE gate_name = input_gate_name
      AND terminal_id = input_terminal_id;

    IF exists_gate > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Gate already exists in this terminal.';
    ELSE
        INSERT INTO Gate (gate_name, status, terminal_id)
        VALUES (input_gate_name, input_status, input_terminal_id);
    END IF;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS get_gate;
DELIMITER $$
CREATE PROCEDURE get_gate(
    IN input_gate_name VARCHAR(20)
)
BEGIN
    DECLARE exists_gate INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_gate
    FROM Gate
    WHERE gate_name = input_gate_name;

    IF exists_gate = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Gate not found.';
    ELSE
        SELECT *
        FROM Gate
        WHERE gate_name = input_gate_name;
    END IF;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS all_gates_in_terminal;
DELIMITER $$
CREATE PROCEDURE all_gates_in_terminal(
    IN input_terminal_id INT
)
BEGIN
    DECLARE exists_terminal INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_terminal
    FROM Terminal
    WHERE terminal_id = input_terminal_id;

    IF exists_terminal = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Terminal does not exist.';
    ELSE
        SELECT *
        FROM Gate
        WHERE terminal_id = input_terminal_id;
    END IF;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS update_gate_status;
DELIMITER $$
CREATE PROCEDURE update_gate_status(
    IN input_gate_name VARCHAR(20),
    IN new_status VARCHAR(50)
)
BEGIN
    DECLARE exists_gate INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_gate
    FROM Gate
    WHERE gate_name = input_gate_name;

    IF exists_gate = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Gate does not exist.';
    ELSE
        UPDATE Gate
        SET status = new_status
        WHERE gate_name = input_gate_name;
    END IF;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS delete_gate;
DELIMITER $$
CREATE PROCEDURE delete_gate(
    IN input_gate_name VARCHAR(20)
)
BEGIN
    DECLARE exists_gate INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_gate
    FROM Gate
    WHERE gate_name = input_gate_name;

    IF exists_gate = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Gate does not exist — cannot delete.';
    ELSE
        DELETE FROM Gate
        WHERE gate_name = input_gate_name;
    END IF;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS total_available_gates;
DELIMITER $$
CREATE PROCEDURE total_available_gates()
BEGIN
    SELECT COUNT(*) AS total_available_gates
    FROM Gate
    WHERE status = 'Available';
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS total_occupied_gates;
DELIMITER $$
CREATE PROCEDURE total_occupied_gates()
BEGIN
    SELECT COUNT(*) AS total_occupied_gates
    FROM Gate
    WHERE status = 'Occupied';
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS total_maintenance_gates;
DELIMITER $$
CREATE PROCEDURE total_maintenance_gates()
BEGIN
    SELECT COUNT(*) AS total_under_maintenance
    FROM Gate
    WHERE status = 'Under Maintenance';
END $$
DELIMITER ;

/* ============================================
                AIRCRAFT CRUD OPERATIONS
   ============================================ */

DROP PROCEDURE IF EXISTS add_aircraft;
DELIMITER $$
CREATE PROCEDURE add_aircraft(
    IN input_model VARCHAR(100),
    IN input_capacity INT
)
BEGIN
    IF input_capacity <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Capacity must be greater than zero.';
    END IF;

    INSERT INTO Aircraft (model, capacity)
    VALUES (input_model, input_capacity);
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS get_aircraft;
DELIMITER $$
CREATE PROCEDURE get_aircraft(
    IN input_aircraft_id INT
)
BEGIN
    DECLARE exists_aircraft INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_aircraft
    FROM Aircraft
    WHERE aircraft_id = input_aircraft_id;

    IF exists_aircraft = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Aircraft not found.';
    ELSE
        SELECT *
        FROM Aircraft
        WHERE aircraft_id = input_aircraft_id;
    END IF;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS get_aircraft_by_model;
DELIMITER $$
CREATE PROCEDURE get_aircraft_by_model(
    IN input_model VARCHAR(100)
)
BEGIN
    DECLARE exists_model INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_model
    FROM Aircraft
    WHERE model = input_model;

    IF exists_model = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Aircraft model not found.';
    ELSE
        SELECT *
        FROM Aircraft
        WHERE model = input_model;
    END IF;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS add_aircraft_by_model;
DELIMITER $$
CREATE PROCEDURE add_aircraft_by_model(
    IN input_model VARCHAR(100),
    IN input_capacity INT
)
BEGIN
    IF input_capacity <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Capacity must be greater than zero.';
    END IF;

    INSERT INTO Aircraft (model, capacity)
    VALUES (input_model, input_capacity);
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS all_aircraft;
DELIMITER $$
CREATE PROCEDURE all_aircraft()
BEGIN
    SELECT *
    FROM Aircraft;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS update_aircraft;
DELIMITER $$
CREATE PROCEDURE update_aircraft(
    IN input_aircraft_id INT,
    IN new_model VARCHAR(100),
    IN new_capacity INT
)
BEGIN
    DECLARE exists_aircraft INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_aircraft
    FROM Aircraft
    WHERE aircraft_id = input_aircraft_id;

    IF exists_aircraft = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Aircraft does not exist.';
    END IF;

    IF new_capacity <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Capacity must be greater than zero.';
    END IF;

    UPDATE Aircraft
    SET model = new_model,
        capacity = new_capacity
    WHERE aircraft_id = input_aircraft_id;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS update_aircraft_by_model;
DELIMITER $$
CREATE PROCEDURE update_aircraft_by_model(
    IN input_model VARCHAR(100),
    IN updated_model VARCHAR(100),
    IN updated_capacity INT
)
BEGIN
    DECLARE exists_model INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_model
    FROM Aircraft
    WHERE model = input_model;

    IF exists_model = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Aircraft model does not exist.';
    END IF;

    IF updated_capacity <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Updated capacity must be greater than zero.';
    END IF;

    UPDATE Aircraft
    SET model = updated_model,
        capacity = updated_capacity
    WHERE model = input_model;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS delete_aircraft;
DELIMITER $$
CREATE PROCEDURE delete_aircraft(
    IN input_aircraft_id INT
)
BEGIN
    DECLARE exists_aircraft INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_aircraft
    FROM Aircraft
    WHERE aircraft_id = input_aircraft_id;

    IF exists_aircraft = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Aircraft does not exist — cannot delete.';
    ELSE
        DELETE FROM Aircraft
        WHERE aircraft_id = input_aircraft_id;
    END IF;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS delete_aircraft_by_model;
DELIMITER $$
CREATE PROCEDURE delete_aircraft_by_model(
    IN input_model VARCHAR(100)
)
BEGIN
    DECLARE exists_model INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_model
    FROM Aircraft
    WHERE model = input_model;

    IF exists_model = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Aircraft model does not exist — cannot delete.';
    ELSE
        DELETE FROM Aircraft
        WHERE model = input_model;
    END IF;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS total_aircraft;
DELIMITER $$
CREATE PROCEDURE total_aircraft()
BEGIN
    SELECT COUNT(*) AS total_aircraft
    FROM Aircraft;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS largest_aircraft;
DELIMITER $$
CREATE PROCEDURE largest_aircraft()
BEGIN
    SELECT *
    FROM Aircraft
    ORDER BY capacity DESC
    LIMIT 1;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS smallest_aircraft;
DELIMITER $$
CREATE PROCEDURE smallest_aircraft()
BEGIN
    SELECT *
    FROM Aircraft
    ORDER BY capacity ASC
    LIMIT 1;
END $$
DELIMITER ;

/* ============================================
               FLIGHT CRUD OPERATIONS
============================================ */

/* ============================================
               FLIGHT CRUD OPERATIONS
============================================ */

DROP PROCEDURE IF EXISTS add_incoming_flight;
DELIMITER $$
CREATE PROCEDURE add_incoming_flight(
    IN input_flight_number VARCHAR(20),
    IN input_flight_type VARCHAR(50),
    IN input_status VARCHAR(50),
    IN input_departure_time DATETIME,
    IN input_arrival_time DATETIME,
    IN input_aircraft_id INT,
    IN input_gate_id INT,
    IN input_airline_name VARCHAR(100),
    IN input_departure_airport VARCHAR(100)
)
BEGIN
    DECLARE exists_aircraft INT DEFAULT 0;
    DECLARE exists_gate INT DEFAULT 0;
    DECLARE exists_airline INT DEFAULT 0;
    DECLARE exists_departure_airport INT DEFAULT 0;
    DECLARE exists_logan INT DEFAULT 0;
    DECLARE gate_status VARCHAR(50);
    DECLARE exists_flight_num INT DEFAULT 0;
    SET @logan := 'Logan International Airport';

    SELECT COUNT(*) INTO exists_aircraft FROM Aircraft WHERE aircraft_id = input_aircraft_id;
    IF exists_aircraft = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Aircraft does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_gate FROM Gate WHERE gate_id = input_gate_id;
    IF exists_gate = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Gate does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_airline FROM Airline WHERE airline_name = input_airline_name;
    IF exists_airline = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Airline does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_departure_airport FROM Airport WHERE airport_name = input_departure_airport;
    IF exists_departure_airport = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Departure airport does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_logan FROM Airport WHERE airport_name = @logan;
    IF exists_logan = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Logan airport record missing.'; END IF;

    IF input_departure_airport = @logan THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Departure airport cannot be same as arrival airport.'; END IF;

    SELECT status INTO gate_status FROM Gate WHERE gate_id = input_gate_id;
    IF gate_status <> 'Available' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Gate is not available.'; END IF;

    SELECT COUNT(*) INTO exists_flight_num FROM Flight WHERE flight_number = input_flight_number AND airline_name = input_airline_name;
    IF exists_flight_num > 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Duplicate flight number for this airline.'; END IF;

    INSERT INTO Flight(
        flight_number, flight_type, status,
        departure_time, arrival_time,
        aircraft_id, gate_id, airline_name,
        arrival_airport_name, destination_airport_name
    ) VALUES (
        input_flight_number, input_flight_type, input_status,
        input_departure_time, input_arrival_time,
        input_aircraft_id, input_gate_id, input_airline_name,
        @logan, input_departure_airport
    );
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS add_departing_flight;
DELIMITER $$
CREATE PROCEDURE add_departing_flight(
    IN input_flight_number VARCHAR(20),
    IN input_flight_type VARCHAR(50),
    IN input_status VARCHAR(50),
    IN input_departure_time DATETIME,
    IN input_arrival_time DATETIME,
    IN input_aircraft_id INT,
    IN input_gate_id INT,
    IN input_airline_name VARCHAR(100),
    IN input_arrival_airport VARCHAR(100)
)
BEGIN
    DECLARE exists_aircraft INT DEFAULT 0;
    DECLARE exists_gate INT DEFAULT 0;
    DECLARE exists_airline INT DEFAULT 0;
    DECLARE exists_arrival_airport INT DEFAULT 0;
    DECLARE exists_logan INT DEFAULT 0;
    DECLARE gate_status VARCHAR(50);
    DECLARE exists_flight_num INT DEFAULT 0;
    SET @logan := 'Logan International Airport';

    SELECT COUNT(*) INTO exists_aircraft FROM Aircraft WHERE aircraft_id = input_aircraft_id;
    IF exists_aircraft = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Aircraft does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_gate FROM Gate WHERE gate_id = input_gate_id;
    IF exists_gate = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Gate does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_airline FROM Airline WHERE airline_name = input_airline_name;
    IF exists_airline = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Airline does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_arrival_airport FROM Airport WHERE airport_name = input_arrival_airport;
    IF exists_arrival_airport = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Arrival airport does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_logan FROM Airport WHERE airport_name = @logan;
    IF exists_logan = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Logan airport record missing.'; END IF;

    IF input_arrival_airport = @logan THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Arrival airport cannot be same as departure airport.'; END IF;

    SELECT status INTO gate_status FROM Gate WHERE gate_id = input_gate_id;
    IF gate_status <> 'Available' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Gate is not available.'; END IF;

    SELECT COUNT(*) INTO exists_flight_num FROM Flight WHERE flight_number = input_flight_number AND airline_name = input_airline_name;
    IF exists_flight_num > 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Duplicate flight number for this airline.'; END IF;

    INSERT INTO Flight(
        flight_number, flight_type, status,
        departure_time, arrival_time,
        aircraft_id, gate_id, airline_name,
        arrival_airport_name, destination_airport_name
    ) VALUES (
        input_flight_number, input_flight_type, input_status,
        input_departure_time, input_arrival_time,
        input_aircraft_id, input_gate_id, input_airline_name,
        input_arrival_airport, @logan
    );
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS move_flight_to_gate;
DELIMITER $$
CREATE PROCEDURE move_flight_to_gate(
    IN input_flight_id INT,
    IN input_gate_id INT
)
BEGIN
    DECLARE exists_gate INT DEFAULT 0;
    DECLARE gate_status VARCHAR(50);

    SELECT COUNT(*) INTO exists_gate FROM Gate WHERE gate_id = input_gate_id;
    IF exists_gate = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Gate does not exist.'; END IF;

    SELECT status INTO gate_status FROM Gate WHERE gate_id = input_gate_id;
    IF gate_status <> 'Available' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Gate is occupied or unavailable.'; END IF;

    UPDATE Flight SET gate_id = input_gate_id WHERE flight_id = input_flight_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS lookup_flight;
DELIMITER $$
CREATE PROCEDURE lookup_flight(
    IN input_attribute VARCHAR(50),
    IN input_value VARCHAR(200)
)
BEGIN
    DECLARE sql_query TEXT;
    DECLARE existence_check TEXT;
    DECLARE value_exists INT DEFAULT 0;

    IF input_attribute NOT IN (
        'flight_id',
        'flight_number',
        'flight_type',
        'status',
        'departure_time',
        'arrival_time',
        'aircraft_id',
        'gate_id',
        'airline_name',
        'arrival_airport_name',
        'destination_airport_name'
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Invalid flight attribute.';
    END IF;

    SET existence_check = CONCAT(
        'SELECT COUNT(*) FROM Flight WHERE ', input_attribute, ' = ?'
    );

    PREPARE stmt1 FROM existence_check;
    EXECUTE stmt1 USING input_value INTO value_exists;
    DEALLOCATE PREPARE stmt1;

    IF value_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: No matching flight found for given attribute/value.';
    END IF;

    SET sql_query = CONCAT(
        'SELECT * FROM Flight WHERE ', input_attribute, ' = ?'
    );

    PREPARE stmt2 FROM sql_query;
    EXECUTE stmt2 USING input_value;
    DEALLOCATE PREPARE stmt2;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_flight_arrival_time;
DELIMITER $$
CREATE PROCEDURE update_flight_arrival_time(
    IN input_flight_id INT,
    IN input_new_arrival_time DATETIME
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight FROM Flight WHERE flight_id = input_flight_id;
    IF exists_flight = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.'; END IF;

    UPDATE Flight SET arrival_time = input_new_arrival_time WHERE flight_id = input_flight_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_flight_departure_time;
DELIMITER $$
CREATE PROCEDURE update_flight_departure_time(
    IN input_flight_id INT,
    IN input_new_departure_time DATETIME
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight FROM Flight WHERE flight_id = input_flight_id;
    IF exists_flight = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.'; END IF;

    UPDATE Flight SET departure_time = input_new_departure_time WHERE flight_id = input_flight_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_flight_status;
DELIMITER $$
CREATE PROCEDURE update_flight_status(
    IN input_flight_id INT,
    IN input_new_status VARCHAR(50)
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight FROM Flight WHERE flight_id = input_flight_id;
    IF exists_flight = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.'; END IF;

    IF input_new_status NOT IN ('Boarding','Delayed','On Time') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Invalid status.';
    END IF;

    UPDATE Flight SET status = input_new_status WHERE flight_id = input_flight_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_flight_airline;
DELIMITER $$
CREATE PROCEDURE update_flight_airline(
    IN input_flight_id INT,
    IN input_new_airline VARCHAR(100)
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;
    DECLARE exists_airline INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight FROM Flight WHERE flight_id = input_flight_id;
    IF exists_flight = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_airline FROM Airline WHERE airline_name = input_new_airline;
    IF exists_airline = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Airline does not exist.'; END IF;

    UPDATE Flight SET airline_name = input_new_airline WHERE flight_id = input_flight_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_flight_aircraft;
DELIMITER $$
CREATE PROCEDURE update_flight_aircraft(
    IN input_flight_id INT,
    IN input_new_aircraft_id INT
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;
    DECLARE exists_aircraft INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight FROM Flight WHERE flight_id = input_flight_id;
    IF exists_flight = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_aircraft FROM Aircraft WHERE aircraft_id = input_new_aircraft_id;
    IF exists_aircraft = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Aircraft does not exist.'; END IF;

    UPDATE Flight SET aircraft_id = input_new_aircraft_id WHERE flight_id = input_flight_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_flight_arrival_airport;
DELIMITER $$
CREATE PROCEDURE update_flight_arrival_airport(
    IN input_flight_id INT,
    IN input_new_arrival VARCHAR(100)
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;
    DECLARE exists_airport INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight FROM Flight WHERE flight_id = input_flight_id;
    IF exists_flight = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_airport FROM Airport WHERE airport_name = input_new_arrival;
    IF exists_airport = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Arrival airport does not exist.'; END IF;

    UPDATE Flight SET arrival_airport_name = input_new_arrival WHERE flight_id = input_flight_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_flight_destination_airport;
DELIMITER $$
CREATE PROCEDURE update_flight_destination_airport(
    IN input_flight_id INT,
    IN input_new_destination VARCHAR(100)
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;
    DECLARE exists_airport INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight FROM Flight WHERE flight_id = input_flight_id;
    IF exists_flight = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.'; END IF;

    SELECT COUNT(*) INTO exists_airport FROM Airport WHERE airport_name = input_new_destination;
    IF exists_airport = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Destination airport does not exist.'; END IF;

    UPDATE Flight SET destination_airport_name = input_new_destination WHERE flight_id = input_flight_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS cancel_flight;
DELIMITER $$
CREATE PROCEDURE cancel_flight(
    IN input_flight_id INT
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight FROM Flight WHERE flight_id = input_flight_id;
    IF exists_flight = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.'; END IF;

    UPDATE Flight SET status = 'Cancelled' WHERE flight_id = input_flight_id;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS total_flights_to_city;
DELIMITER $$
CREATE FUNCTION total_flights_to_city(
    input_city VARCHAR(100)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE result INT DEFAULT 0;
    DECLARE exists_city INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_city FROM Airport WHERE city = input_city;
    IF exists_city = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: City does not exist.'; END IF;

    SELECT COUNT(*) INTO result
    FROM Flight F
    JOIN Airport A ON F.arrival_airport_name = A.airport_name
    WHERE A.city = input_city;

    RETURN result;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS total_flights_to_country;
DELIMITER $$
CREATE FUNCTION total_flights_to_country(
    input_country VARCHAR(100)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE result INT DEFAULT 0;
    DECLARE exists_country INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_country FROM Airport WHERE country = input_country;
    IF exists_country = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Country does not exist.'; END IF;

    SELECT COUNT(*) INTO result
    FROM Flight F
    JOIN Airport A ON F.arrival_airport_name = A.airport_name
    WHERE A.country = input_country;

    RETURN result;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS total_international_flights;
DELIMITER $$
CREATE FUNCTION total_international_flights()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE result INT DEFAULT 0;

    SELECT COUNT(*) INTO result FROM Flight WHERE flight_type = 'International';
    RETURN result;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS total_domestic_flights;
DELIMITER $$
CREATE FUNCTION total_domestic_flights()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE result INT DEFAULT 0;

    SELECT COUNT(*) INTO result FROM Flight WHERE flight_type = 'Domestic';
    RETURN result;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS total_flights_per_airline;
DELIMITER $$
CREATE FUNCTION total_flights_per_airline(
    input_airline VARCHAR(100)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE result INT DEFAULT 0;
    DECLARE exists_airline INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_airline FROM Airline WHERE airline_name = input_airline;
    IF exists_airline = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Airline does not exist.'; END IF;

    SELECT COUNT(*) INTO result FROM Flight WHERE airline_name = input_airline;
    RETURN result;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS add_seat;
DELIMITER $$
CREATE PROCEDURE add_seat(
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.';
    END IF;

    INSERT INTO Seat(seat_number, class, status, flight_id)
    VALUES(input_seat_number, input_class, input_status, input_flight_id);
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS get_seat;
DELIMITER $$
CREATE PROCEDURE get_seat(
    IN input_seat_id INT
)
BEGIN
    DECLARE exists_seat INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_seat
    FROM Seat
    WHERE seat_id = input_seat_id;

    IF exists_seat = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Seat does not exist.';
    ELSE
        SELECT * FROM Seat WHERE seat_id = input_seat_id;
    END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS get_seats_by_flight;
DELIMITER $$
CREATE PROCEDURE get_seats_by_flight(
    IN input_flight_id INT
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight
    FROM Flight
    WHERE flight_id = input_flight_id;

    IF exists_flight = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.';
    ELSE
        SELECT * FROM Seat WHERE flight_id = input_flight_id;
    END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_seat_status;
DELIMITER $$
CREATE PROCEDURE update_seat_status(
    IN input_seat_id INT,
    IN new_status VARCHAR(50)
)
BEGIN
    DECLARE exists_seat INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_seat
    FROM Seat
    WHERE seat_id = input_seat_id;

    IF exists_seat = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Seat does not exist.';
    END IF;

    UPDATE Seat
    SET status = new_status
    WHERE seat_id = input_seat_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_seat_class;
DELIMITER $$
CREATE PROCEDURE update_seat_class(
    IN input_seat_id INT,
    IN new_class VARCHAR(20)
)
BEGIN
    DECLARE exists_seat INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_seat
    FROM Seat
    WHERE seat_id = input_seat_id;

    IF exists_seat = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Seat does not exist.';
    END IF;

    UPDATE Seat
    SET class = new_class
    WHERE seat_id = input_seat_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS delete_seat;
DELIMITER $$
CREATE PROCEDURE delete_seat(
    IN input_seat_id INT
)
BEGIN
    DECLARE exists_seat INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_seat
    FROM Seat
    WHERE seat_id = input_seat_id;

    IF exists_seat = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Seat does not exist.';
    ELSE
        DELETE FROM Seat WHERE seat_id = input_seat_id;
    END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS total_seats_in_flight;
DELIMITER $$
CREATE PROCEDURE total_seats_in_flight(
    IN input_flight_id INT
)
BEGIN
    DECLARE exists_flight INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_flight
    FROM Flight
    WHERE flight_id = input_flight_id;

    IF exists_flight = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Flight does not exist.';
    ELSE
        SELECT COUNT(*) AS total_seats
        FROM Seat
        WHERE flight_id = input_flight_id;
    END IF;
END $$
DELIMITER ;

