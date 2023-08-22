/*
	ASSIGNMENT: 	transaction_assignment
    AUTHOR: 		Ryan Paradee
    DATE CREATED:	2022-11-07
	DESCRIPTION: Write a single SQL file that performs the tasks for Exercises 1 and 2 on page 444 of the Murach text (at the end of Chapter 14).
*/

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_14_Exercise_1$$
CREATE PROCEDURE sp_Chapter_14_Exercise_1()
COMMENT 'chapter 14 exercise 1'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 11
		DESCRIPTION:
		
		--
		Write a script that creates and calls a stored procedure named test.
		This procedure should include a set of three SQL statements coded as
		a transaction to reflect the following change: United Parcel Service
		has been purchased by Federal Express Corporation and the new company
		is named FedUP. Rename one of the vendors and delete the other after
		updating the vendor_id column in the Invoices table.

		If these statements execute successfully, commit the changes.
		Otherwise, roll back the changes.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-11-02	Ryan Paradee			Initial Creation
		
	*/
	DECLARE var_1 TINYINT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET var_1 = TRUE;
    START TRANSACTION;
    
    UPDATE VENDORS
    SET vendor_name = 'FedUP'
    WHERE vendor_id = 123;
    
    UPDATE invoices
    SET vendor_id = 123
    WHERE vendor_id = 122;
    
    DELETE FROM vendors
    WHERE vendor_id = 122;
    
    IF var_1 = FALSE
    THEN COMMIT;
    SELECT 'Transaction Committed.' AS 'message';
	
    ELSE
    ROLLBACK;
    SELECT 'Transaction rollbacked due to an error.' AS 'message';
    END IF;
END$$
DELIMITER ;

CALL sp_Chapter_14_Exercise_1();

/*'Transaction Committed.'*/

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_14_Exercise_2$$
CREATE PROCEDURE sp_Chapter_14_Exercise_2()
COMMENT 'chapter 14 exercise 2'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 11
		DESCRIPTION:
		
		--
		 Write a script that creates and calls a stored procedure named test.
		 This procedure should include a set of two SQL statements coded as a
		 transaction to delete the row with an invoice ID of 114 from the
		 Invoices table. To do this, you must first delete all line items
		 for that invoice from the Invoice_Line_Items table. If these statements
		 execute successfully, commit the changes.
		 
		 Otherwise, roll back the changes
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-11-02	Ryan Paradee			Initial Creation
		
	*/
    
	DECLARE var_2 TINYINT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET var_2 = TRUE;
    
    START TRANSACTION;
    
    DELETE FROM invoice_line_items
    WHERE invoice_id = 114;
    
    DELETE FROM invoices
    WHERE invoice_id = 114;
    
    IF var_2 = FALSE 
    THEN COMMIT;
    SELECT 'Transaction Committed' AS 'message';
    
    ELSE 
    ROLLBACK;
	SELECT 'Transaction rollbacked due to an error.' AS 'message';
    
    END IF;
	
	
END$$
DELIMITER ;

CALL sp_Chapter_14_Exercise_2();

/*'Transaction Committed'*/
