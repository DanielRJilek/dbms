use harry_potter_book_v2025;

-- 1. Write a function num_spells_with_type(spell_type_p) that takes a spell type as a 
-- parameter and returns the number of spells with the spell type.

DELIMITER //
DROP function if exists num_spells_with_type;
CREATE FUNCTION num_spells_with_type 
(
spell_type_p VARCHAR(64)
)
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE num_spells INT;
    
    select count(distinct id) into num_spells
    from spell
    where spell_type = spell_type_p;
    RETURN(num_spells);
END//
DELIMITER ;

-- TEST
Select num_spells_with_type('Curse');
Select num_spells_with_type('adsjflk');

Select count(distinct id) 
	from spell
	where spell_type = 'Curse';

-- 2. Write a procedure get_role_in_book(book_number_p) that takes a book number as parameter and 
-- returns a result set of all role (characters) names and the corresponding book title. Order the 
-- results by the book title, followed by the character_name in ascending order.

DELIMITER //
DROP procedure if exists get_role_in_book //
CREATE PROCEDURE get_role_in_book
(
	book_number_p INT
)
BEGIN
	SELECT book.title, role_trimmed.name
		from book 
		inner join role_in_book on role_in_book.book_id = book.book_number
		inner join role_trimmed on role_in_book.role_id = role_trimmed.id
		where book.book_number = book_number_p
		order by role_trimmed.name asc;
END //
DELIMITER ;

-- TEST
CALL get_role_in_book(3);
CALL get_role_in_book(-1);

-- 3. Write a procedure  named get_spell_instance_details(spell_name_p)  that takes a spell name as an 
-- argument  and returns the role id, the role name, the spell name, the spell type, and the book title 
-- where the spell may have occurred. Order the results in ascending order by the character 
-- name and the spell name.

DELIMITER //
DROP procedure if exists get_spell_instance_details //
CREATE PROCEDURE get_spell_instance_details
(
	spell_name_p VARCHAR(64)
)
BEGIN
	SELECT role_trimmed.id, role_trimmed.name as role_name, spell.name as spell_name, spell.spell_type, book.title
		from spell
			inner join role_to_spell on spell.id = role_to_spell.spell_id
            inner join role_trimmed on role_to_spell.role_id = role_trimmed.id
            inner join role_in_book on role_trimmed.id = role_in_book.role_id
            inner join book on role_in_book.book_id = book.book_number
            where spell.name = spell_name_p
            order by role_trimmed.name, spell.name asc;
END //
DELIMITER ;

-- TEST
CALL get_spell_instance_details("Lumos");
CALL get_spell_instance_details("Hot-air charm");

-- 4. Write a function named more_books(role1_p, role2_p). It takes 2 role names as parameters and returns 1 
-- if role1_p has appeared in more books than role2, 0 if they appear in the same number of books , 
-- and -1 if role2_p appears in more books than  role1. If the procedure is given an  unknown role 
-- name (one not found in the role_trimmed table) , use SIGNAL with error number 45000, to mark the error.

DELIMITER //
DROP function if exists more_books//
CREATE FUNCTION more_books 
(
role1_p VARCHAR(64), role2_p VARCHAR(64)
)
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE sum1 INT;
    DECLARE sum2 INT;
    
    IF role1_p not in(select name from role_trimmed) then SIGNAL SQLSTATE '45000';
    elseif role2_p not in (select name from role_trimmed) then	SIGNAL SQLSTATE '45000';
    END IF;
    select count(distinct role_in_book.book_id) into sum1
    from role_trimmed
		inner join role_in_book on role_trimmed.id = role_in_book.role_id
		where role_trimmed.name = role1_p;
	
    select count(distinct role_in_book.book_id) into sum2
    from role_trimmed
		inner join role_in_book on role_trimmed.id = role_in_book.role_id
		where role_trimmed.name = role2_p;
    
    if sum1 > sum2 then return 1;
    elseif sum1 = sum2 then return 0;
    elseif sum2 > sum1 then return -1;
    END IF;
END //
DELIMITER ;

-- TEST
select more_books('Albus Dumbledore', 'Harry Potter');
select more_books('Ron Weasley', 'Harry Potter');
select more_books('John Smith', 'Harry Potter');

-- 5. Write a procedure named get_house_affiliation(house_name_p) that takes a house name as a parameter and  
-- returns the roles that are affiliated with the house. The four house names you are matching are: 
-- “Gryffindor”, “Ravenclaw”, “HufflePuff”, and “Slytherin”. The result should contain the role id, 
-- role name, gender, eye color,  hair color from the role_trimmed table as well as a derived column 
-- named confidence_level that represents the confidence that the person is associated with the house. 
-- The confidence level field should contain the value “Definitely” if the house name is an exact match for 
-- one of the four  Hogwarts houses; the value “Highly likely” if the house name contains likely; and 
-- “Possibly” if the house name contains the term possibly or any other house name.  If the procedure is 
-- given an  unknown house name (one other than “Gryffindor”, “Ravenclaw”, “HufflePuff”, and “Slytherin”) , 
-- use SIGNAL with error number 45000, to mark the error.

DELIMITER //
DROP procedure if exists get_house_affiliation //
CREATE PROCEDURE get_house_affiliation
(
	house_name_p VARCHAR(64)
)
BEGIN
	IF house_name_p not in (select house from role_trimmed) then SIGNAL SQLSTATE '45000';
    END IF;
	SELECT role_trimmed.id, role_trimmed.name, role_trimmed.gender, role_trimmed.eye_color, 
		role_trimmed.hair_color, 
			CASE
				when role_trimmed.house = house_name_p then 'Definitely'
				when role_trimmed.house regexp 'likely' then 'Highly likely'
                when role_trimmed.house regexp 'possibly' then 'Possibly'
                ELSE 'Possibly'
			END as confidence_level
        from role_trimmed
        where role_trimmed.house regexp house_name_p;
END //
DELIMITER ;

-- TEST
CALL get_house_affiliation("Gryffindor");
CALL get_house_affiliation("adsgasd");

-- 6. Modify(ALTER)  the role_trimmed  table to contain a field called num_spells of type INTEGER and 
-- write a procedure called set_num_spell_count(role_p)  that accepts a role_trimmed  name and  initializes 
-- the num_spells field to the number of spells the role has performed. If the procedure is given an  
-- unknown role  name (one not found in the role_trimmed  table) , use SIGNAL with error number 45000, to 
-- mark the error. The role_trimmed table modification can occur outside or inside of the procedure but must 
-- be executed only once.
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE role_trimmed ADD num_spells INT;
DELIMITER //
DROP procedure if exists set_num_spell_count //
CREATE PROCEDURE set_num_spell_count
(
	role_p VARCHAR(64)
)
BEGIN
	IF role_p not in(select name from role_trimmed) then SIGNAL SQLSTATE '45000';
    END IF;
	UPDATE role_trimmed SET num_spells = (SELECT count(distinct spell_id) from (select * from role_trimmed 
		inner join role_to_spell on role_to_spell.role_id = role_trimmed.id where role_trimmed.name = role_p) as dummy)
        where role_trimmed.name = role_p;
END //
DELIMITER ;

-- TEST
CALL set_num_spell_count('Harry Potter');
select * from role_trimmed where role_trimmed.name = 'Harry Potter';
select * from role_trimmed where role_trimmed.name = 'Albus Dumbledore';
CALL set_num_spell_count('asdhfd');

-- 7. Create a procedure named update_all_roles_num_spells( ) that assigns the role_trimmed.num_spells  
-- to the correct value. The correct value is determined by the number of spells performed by the character 
-- role. Use the procedure from problem 6 to complete this procedure. You will need a cursor and a handler 
-- to complete this procedure

DELIMITER //
DROP procedure if exists update_all_roles_num_spells //
CREATE PROCEDURE update_all_roles_num_spells()
BEGIN
	DECLARE role_p VARCHAR(64);
    DECLARE row_not_found TINYINT DEFAULT FALSE;
    DECLARE role_cursor CURSOR FOR select name from role_trimmed;
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;
    OPEN role_cursor;
    WHILE row_not_found = FALSE DO
		FETCH role_cursor into role_p;
        CALL set_num_spell_count(role_p);
	END WHILE;
    CLOSE role_cursor;
    
END //
DELIMITER ;

-- TEST
select * from role_trimmed where name = 'Albus Dumbledore';
select * from role_trimmed where name = 'Harry Potter';
CALL update_all_roles_num_spells();
select * from role_trimmed where name = 'Albus Dumbledore';
select * from role_trimmed where name = 'Harry Potter';
SET SQL_SAFE_UPDATES = 1;

-- 8. Write a trigger that updates the role_trimmed.num_spells field when a tuple is inserted into the 
-- role_to_spell table. The trigger will need to compute the correct value for the num_spells for the role 
-- associated with the inserted role_to_spell tuple. Name the trigger spell_cnt_update_after_role_to_spell_insert. 
-- Test the trigger by  inserting 2 instances of Tom Riddle performing the Avada Kedavra spell.  Create another 
-- test case involving any other character role performing any other spell.

DELIMITER //
DROP TRIGGER if exists spell_cnt_update_after_role_to_spell_insert //
CREATE TRIGGER spell_cnt_update_after_role_to_spell_insert after insert
	ON role_to_spell FOR EACH ROW
    BEGIN
		DECLARE name_t varchar(64);
        SET name_t = (select role_trimmed.name from role_to_spell 
			inner join role_trimmed on new.role_id = role_trimmed.id limit 1);
		CALL set_num_spell_count(name_t);
    END //
DELIMITER ;

-- TEST 
select * from role_trimmed where role_trimmed.name regexp 'Tom Riddle';
select * from role_trimmed where role_trimmed.id = 2;
INSERT INTO role_to_spell (role_id, spell_id)
	VALUES (350 , 23);
INSERT INTO role_to_spell (role_id, spell_id)
	VALUES (351 , 23);
select * from role_trimmed where role_trimmed.name regexp 'Tom Riddle';
INSERT INTO role_to_spell (role_id, spell_id)
	VALUES (2 , 2);
select * from role_trimmed where role_trimmed.id = 2;
DELETE from role_to_spell where role_id = 350 and spell_id = 23;
DELETE from role_to_spell where role_id = 351 and spell_id = 23;
DELETE from role_to_spell where role_id = 2 and spell_id = 2;

-- 9. Create and execute a prepared statement from the SQL workbench that calls the function 
-- num_spells_with_stype(spell_type_p) . Use a user session variable to pass the spell type name to 
-- the function. Pass the value  “Hex” as the spell type. Please provide at least 2 other test cases as well.

SET @s_type = 'Hex';
PREPARE stmt1 from 'select num_spells_with_type(?)';
EXECUTE stmt1 USING @s_type;	

-- TEST

SET @s_type = 'asdgsd';
EXECUTE stmt1 USING @s_type;

SET @s_type = 'Charm';
EXECUTE stmt1 USING @s_type;	

-- 
DELIMITER //
DROP procedure if exists spell_has_type //
CREATE PROCEDURE spell_has_type(
	type_p VARCHAR(64)
)
BEGIN
	IF type_p not in(select type_name from spell_type) then SIGNAL SQLSTATE '45000';
    END IF;
    select spell.id, spell.name, spell.alias
    from spell
    where spell.spell_type = type_p;
END //
DELIMITER ;