/*
	ASSIGNMENT: 	stored_procedures_and_functions_assignment
    AUTHOR: 		Ryan Paradee
    DATE CREATED:	2022-11-09
	DESCRIPTION: 	Perform Exercises 1 through 4 on page 475 of the Murach text (at the end of Chapter 15).  Place the scripts in a single file.
*/

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insert_glaccount $$
CREATE PROCEDURE sp_insert_glaccount(p_account_number INT, p_account_description VARCHAR(50))
COMMENT 'chapter 15 exercise 1'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 12
		DESCRIPTION:
		
		--
		 Write a script that creates and calls a stored procedure named insert_glaccount.
															
		 First, code a statement that creates a procedure that adds a new row to the
		 General_Ledger_Accounts table in the AP schema. To do that, this procedure 
		 should have two parameters, one for each of the two columns in this table.
		 Then, code a CALL statement that tests this procedure.

		 (Note that this table doesn’t allow duplicate account descriptions.)
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-11-09	Ryan Paradee			Initial Creation
		
	*/
	INSERT INTO general_ledger_accounts
    (account_number
    , account_description)
    VALUES
    (p_account_number
    , p_account_description)
    ;
END$$
DELIMITER ;

CALL sp_insert_glaccount(5, 'hello');

SELECT account_number
	, account_description
    FROM general_ledger_accounts
    WHERE account_number = 5;

-- 


USE ap;

DELIMITER $$
DROP FUNCTION IF EXISTS f_test_glaccounts_description$$
CREATE FUNCTION f_test_glaccounts_description(p_account_description VARCHAR(50))
RETURNS INT
DETERMINISTIC READS SQL DATA
COMMENT 'chapter 15 exercise 2'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 12
		DESCRIPTION:
		
		--
		 Write a script that creates and calls a stored function named f_test_glaccounts_description.
         First, create a function that tests whether an account description is already in the General_Ledger_Accounts table.
         To do that, this function should accept one parameter for the account description, and it should return a value of 1
         if the account description is in the table or 0 if it isn’t. 
		 
		 (Note: If a SELECT statement doesn’t return any data, it raises a NOT FOUND condition that your function can handle.)
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-11-09	Ryan Paradee			Initial Creation
		
	*/
DECLARE var_name_count INT DEFAULT 0;

SELECT COUNT(*)
INTO var_name_count
FROM general_ledger_accounts
WHERE account_description = p_account_description
;
RETURN var_name_count;

END$$
DELIMITER ;

SELECT f_test_glaccounts_description('hello') AS 'good'
, f_test_glaccounts_description('this doesnt exist') AS 'bad';

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insert_glaccount_with_test$$
CREATE PROCEDURE sp_insert_glaccount_with_test(p_account_number INT, p_account_description VARCHAR(50))
COMMENT 'chapter 15 exercise 3'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 12
		DESCRIPTION:
		
		--
		 Modify the script that you created in exercise 1 so it creates
		 and calls a stored procedure named sp_insert_glaccount_with_test.
		 
		 This procedure should use the function that you created in
		 exercise 2 to test whether the account description is a 
		 duplicate before it issues the INSERT statement. 
		 
		 If the account descrip-tion is a duplicate, this procedure 
		 should raise an error with a SQLSTATE code of 23000, a MySQL
		 code of 1062, and a message that says:
		 “Duplicate account description.”
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-11-09	Ryan Paradee			Initial Creation
		
	*/
	DECLARE var_test INT;
    
    SELECT f_test_glaccounts_description(p_account_description)
    INTO var_test
    ;
    
    IF var_test = 1 THEN
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'DUPLICATE ACCOUNT DESCRIPTION'
        , MYSQL_ERRNO = 1062;
	END IF;
    
    INSERT INTO general_ledger_accounts
    (account_number
    , account_description)
	VALUES
    (p_account_number
    , p_account_description);
	
	
END$$
DELIMITER ;

CALL sp_insert_glaccount_with_test(6, 'hello2');
SELECT account_number
	, account_description
    FROM general_ledger_accounts
    WHERE account_number = 6;
--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insert_terms$$
CREATE PROCEDURE sp_insert_terms(p_terms_description VARCHAR(50)
				, p_terms_due_days INT)
COMMENT 'chapter 15 exercise 4'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 12
		DESCRIPTION:
		
		--
		 Write a script that creates and calls a stored procedure named sp_insert_terms.
		 First, code a statement that creates a procedure that adds a new row to the
		 Terms table in the AP schema. To do that, this procedure should have two parameters:
		 one for the terms_due_days column and another for the terms_description column. 
		 
		 If the value for the description column is null, the stored procedure should be
		 able to create a default value for the description column based on the value of
		 the due days column. For example, for a due days column of 120, the descrip-tion
		 column should have a default value of “Net due 120 days”.
		 Then, code a CALL statement that tests this procedure.

		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-11-09	Ryan Paradee			Initial Creation
		
	*/

IF p_terms_description IS NULL THEN
SET p_terms_description = CONCAT('Net due ', p_terms_due_days, ' days');
END IF;
INSERT INTO terms(terms_description, terms_due_days)
VALUES(p_terms_description, p_terms_due_days);

SELECT LAST_INSERT_ID() AS 'terms_id';
	
END$$
DELIMITER ;

CALL sp_insert_terms('Net due 500 days', 500);
CALL sp_insert_terms(NULL, 550);

SELECT *
FROM TERMS;
