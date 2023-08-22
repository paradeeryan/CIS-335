USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_5_Exercise_1$$
CREATE PROCEDURE sp_Chapter_5_Exercise_1()
COMMENT 'chapter 5 exercise 1'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		--
		 Write an INSERT statement that adds this row to the Terms table:
			terms_id:					6
			terms_description:			Net due 120 days 
			terms_due_days:				120
 
Use MySQL Workbench to review the column definitions for the Terms table,
 and include a column list with the required columns in the INSERT statement.
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-19	Ryan Paradee			Initial Creation
		
	*/
    
     SELECT *
    FROM terms
    ;
	
INSERT 
INTO terms(terms_id, terms_description, terms_due_days)
VALUES ('6', 'Net due 120 days', '120')
;
/*1 row(s) affected*/
   
    
END$$
DELIMITER ;

CALL sp_Chapter_5_Exercise_1();



USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_5_Exercise_2$$
CREATE PROCEDURE sp_Chapter_5_Exercise_2()
COMMENT 'chapter 5 exercise 2'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		--
			Write an UPDATE statement that modifies the row you just added
			to the Terms table. This statement should change the
			terms_description column to “Net due 125 days”, and it should
			change the terms_due_days column to 125.
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-19	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT *
    FROM terms
    ;
    
    UPDATE terms 
    SET terms_description = 'Net due 125 days'
		, terms_due_days = 125
    WHERE terms_id = 6
    ;
	/*1 row(s) affected Rows matched: 1  Changed: 1  Warnings: 0*/
END$$
DELIMITER ;

CALL sp_Chapter_5_Exercise_2();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_5_Exercise_3$$
CREATE PROCEDURE sp_Chapter_5_Exercise_3()
COMMENT 'chapter 5 exercise 3'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		--
			Write a DELETE statement that deletes the row you
			added to the Terms table in exercise 1.
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-19	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT *
    FROM terms
    WHERE terms_id = 6
	;
    
    DELETE
    FROM terms
    WHERE terms_id = 6
	;
    /*1 row(s) affected*/
END$$
DELIMITER ;

CALL sp_Chapter_5_Exercise_3();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_5_Exercise_4$$
CREATE PROCEDURE sp_Chapter_5_Exercise_4()
COMMENT 'chapter 5 exercise 4'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		--
		Write an INSERT statement that adds
		this row to the Invoices table:
		
			invoice_id:			The next automatically generated ID
			vendor_id:			32
			invoice_number:		AX-014-027
			invoice_date:		8/1/2018
			invoice_total:		$434.58
			payment_total:		$0.00
			credit_total:		$0.00
			terms_id:			2
			invoice_due_date:	8/31/2018
			payment_date:		null
     
 
		Write this statement without using a column list.
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-19	Ryan Paradee			Initial Creation
		
	*/
	SELECT *
    FROM invoices
    ORDER BY invoice_id
    ;
    
	INSERT 
    INTO invoices
    VALUES (NULL, 32, 'AX-014-027', '2018-08-01', 434.58, 0.00, 0.00, 2, '2018-08-31', NULL)
    ;
	/*1 row(s) affected*/
END$$
DELIMITER ;

CALL sp_Chapter_5_Exercise_4();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_5_Exercise_5$$
CREATE PROCEDURE sp_Chapter_5_Exercise_5()
COMMENT 'chapter 5 exercise 5'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		--
		Write an INSERT statement that adds these rows to the
		Invoice_Line_Items table:
		
			invoice_sequence:		1				2
			account_number:			160				527
			line_item_amount:		$180.23			$254.35
			line_item_description: 	Hard drive    	Exchange Server update
		
		Set the invoice_id column of these two rows to the invoice ID 
		that was gener-ated by MySQL for the invoice you added
		in exercise 4.
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-19	Ryan Paradee			Initial Creation
		
	*/
    SELECT invoice_sequence,
    account_number,
    line_item_amount,
    line_item_description
    FROM invoice_line_items
    ORDER BY invoice_sequence
	;
    
    
	INSERT 
    INTO invoice_line_items(invoice_id, invoice_sequence, account_number, line_item_amount, line_item_description)
    VALUES (115, 1, 160, 180.23, 'Hard drive')
    ;
    INSERT 
    INTO invoice_line_items(invoice_id, invoice_sequence, account_number, line_item_amount, line_item_description)
    VALUES (115, 2, 527, 254.35, 'Exchange Server update')
	;
    /*1 row(s) affected*/
END$$
DELIMITER ;

CALL sp_Chapter_5_Exercise_5();

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_5_Exercise_6$$
CREATE PROCEDURE sp_Chapter_5_Exercise_6()
COMMENT 'chapter 5 exercise 6'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		--
		 Write an UPDATE statement that modifies the invoice you added in exercise 4.
		 This statement should change the credit_total column so it’s 10% of the invoice_total column,
		 and it should change the payment_total column so the sum of the payment_total and credit_total columns
		 are equal to the invoice_total column.

		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-19	Ryan Paradee			Initial Creation
		
	*/
	SELECT * 
    FROM invoices
    WHERE invoice_id = 115
    ;
    
	UPDATE invoices
	SET credit_total = (credit_total + (invoice_total * 0.1))
	, payment_total = (payment_total +(invoice_total * 0.9))
    WHERE invoice_id = 115
	;	
/*1 row(s) affected*/
END$$
DELIMITER ;

CALL sp_Chapter_5_Exercise_6();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_5_Exercise_7$$
CREATE PROCEDURE sp_Chapter_5_Exercise_7()
COMMENT 'chapter 5 exercise 7'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		--
		Write an UPDATE statement that modifies the Vendors table.
		Change the default_account_number column to 403 for the vendor with an ID of 44.

		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-19	Ryan Paradee			Initial Creation
		
	*/
	SELECT vendor_id
			, default_account_number
	FROM vendors
    WHERE vendor_id = 44
    ;
    
	UPDATE vendors
    SET default_account_number = 403 
    WHERE vendor_id = 44
    ;
	/*0 row(s) affected Rows matched: 1  Changed: 0  Warnings: 0*/
END$$
DELIMITER ;

CALL sp_Chapter_5_Exercise_7();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_5_Exercise_8$$
CREATE PROCEDURE sp_Chapter_5_Exercise_8()
COMMENT 'chapter 5 exercise 8'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		--
		Write an UPDATE statement that modifies the Invoices table.
		Change the terms_id column to 2 for each invoice that’s for a vendor
		with a default_terms_id of 2.

		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-19	Ryan Paradee			Initial Creation
		
	*/
    SELECT terms_id
		, vendor_id
	FROM invoices
    ORDER BY terms_id
    ;
	UPDATE invoices
    SET terms_id = 2
    WHERE vendor_id IN (
    SELECT vendor_id
    FROM vendors
    WHERE default_terms_id = 2)
    ;
	/*0 row(s) affected Rows matched: 18  Changed: 0  Warnings: 0*/
END$$
DELIMITER ;

CALL sp_Chapter_5_Exercise_8();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_5_Exercise_9$$
CREATE PROCEDURE sp_Chapter_5_Exercise_9()
COMMENT 'chapter 5 exercise 9'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		--
		Write a DELETE statement that deletes the row that you added to the Invoices table in exercise 4.
		When you execute this statement, it will produce an error since the invoice has related rows in
		the Invoice_Line_Items table. To fix that, precede the DELETE statement with another DELETE
		statement that deletes the line items for this invoice. (Remember that to code two or more
		statements in a script, you must end each statement with a semicolon.)
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-19	Ryan Paradee			Initial Creation
		
	*/
    SELECT *
    FROM invoices
    WHERE invoice_id = 115
	;
    SELECT*
    FROM invoice_line_items
    WHERE invoice_id = 115
    ;
    
-- 

DELETE
FROM invoice_line_items
WHERE invoice_id = 115
;   
/*2 row(s) affected*/
DELETE 
FROM invoices
WHERE invoice_id = 115
;
/*1 row(s) affected*/
-- 

END$$
DELIMITER ;

CALL sp_Chapter_5_Exercise_9();