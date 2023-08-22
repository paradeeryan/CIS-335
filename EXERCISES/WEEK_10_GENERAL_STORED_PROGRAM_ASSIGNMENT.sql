/*
	ASSIGNMENT: 	general_stored_program_assignment
    AUTHOR: 		Ryan Paradee
    DATE CREATED:	2022-11-02
	DESCRIPTION: Provide solutions for Exercises 1, 2, and 4 on pages 426 and 427 of the Murach text.
*/

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_13_Exercise_1$$
CREATE PROCEDURE sp_Chapter_13_Exercise_1()
COMMENT 'chapter 13 exercise 1'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 10
		DESCRIPTION:
		
		--
		Write a script that creates and calls a stored procedure named test.
		This stored procedure should declare a variable and set it to the count
		of all rows in the Invoices table that have a balance due that’s greater
		than or equal to $5,000. Then, the stored procedure should display a result
		set that displays the variable in a message like this:

		3 invoices exceed $5,000.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-11-02	Ryan Paradee			Initial Creation
		
	*/
-- declaration start
DECLARE invoices_count INT;
-- declaration end

SELECT COUNT(*) 
INTO invoices_count
FROM invoices
WHERE (invoice_total - payment_total - credit_total) >= 5000
;	

SELECT CONCAT(invoices_count, ' invoices exceed $5,000.') AS 'message'
;

END$$
DELIMITER ;

CALL sp_Chapter_13_Exercise_1();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_13_Exercise_2$$
CREATE PROCEDURE sp_Chapter_13_Exercise_2()
COMMENT 'chapter 13 exercise 2'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 10
		DESCRIPTION:
		
		--
		Write a script that creates and calls a stored procedure named test.
		This stored procedure should use two variables to store (1) the count
		of all of the invoices in the Invoices table that have a balance due
		and (2) the sum of the balances due for all of those invoices.
		If that total balance due is greater than or equal to $30,000,
		the stored procedure should display a result set that displays
		the values of both variables. Otherwise, the procedure should
		display a result set that displays a message like this:
		
		Total balance due is less than $30,000.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-11-02	Ryan Paradee			Initial Creation
		
	*/
  
-- declaration start
DECLARE invoices_count INT;
DECLARE balances_due DECIMAL(11,2);
-- declaration end

SELECT COUNT(*) INTO invoices_count
FROM invoices
WHERE (invoice_total - payment_total - credit_total) >= 5000
;
SELECT SUM((invoice_total - payment_total - credit_total))
INTO balances_due
FROM invoices
WHERE (invoice_total - payment_total - credit_total) >= 5000
;
IF
 balances_due < 30000
THEN
 SELECT 'Total balance due is less than $30,000.' AS 'message';
ELSE
 SELECT CONCAT(invoices_count, '  invoices are due with a total amount of $', balances_due) AS 'message';
END IF;

 
END$$
DELIMITER ;

CALL sp_Chapter_13_Exercise_2();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_13_Exercise_4$$
CREATE PROCEDURE sp_Chapter_13_Exercise_4()
COMMENT 'chapter 13 exercise 4'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 10
		DESCRIPTION:
		
		--
		Write a script that creates and calls a stored procedure named test.
		This proce-dure should create a cursor for a result set that consists
		of the vendor_name, invoice_number, and balance_due columns for each
		invoice with a balance due that’s greater than or equal to $5,000.
		The rows in this result set should be sorted in descending sequence
		by balance due. Then, the procedure should display a string variable
		that includes the balance due, invoice number, and vendor name for
		each invoice so it looks something like this:

		16896.06|P-0608|Malloy Lithographing Inc//9878.45|0-2436|Malloy Lithographing Inc//
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-11-02	Ryan Paradee			Initial Creation
		
	*/
-- declaration start
DECLARE var_nam VARCHAR(100);
DECLARE var_num VARCHAR(100);
DECLARE var_bal DECIMAL(11,2);
DECLARE result TEXT DEFAULT TRUE;
DECLARE no_rows TINYINT DEFAULT FALSE;
-- begin cursor declaration
DECLARE cur CURSOR 
	FOR 
		SELECT v.vendor_var_name
				, i.invoice_var_number
				, (invoice_total - payment_total - credit_total) AS 'var_balance_due'
		FROM invoices i
        LEFT JOIN vendors v 
        ON v.vendor_id = i.vendor_id
        WHERE (invoice_total - payment_total - credit_total) >= 5000
; 
-- end cursor declaration

DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_rows = TRUE;
-- declaration end

-- start of cursor and while work
OPEN cur;
	WHILE no_rows = FALSE
    DO FETCH cur INTO var_nam, var_num, var_bal;
	SET result = CONCAT(result, var_bal, '|', var_num, '|', var_nam, '//');
	END WHILE;
CLOSE cur;
-- end of cursor and while work
SELECT result AS 'message';
	
END$$
DELIMITER ;

CALL sp_Chapter_13_Exercise_4();