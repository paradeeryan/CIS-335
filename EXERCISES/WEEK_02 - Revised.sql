USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_3_Exercise_8$$
CREATE PROCEDURE sp_Chapter_3_Exercise_8()
COMMENT 'Get vendors and get vendor contact'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
			 Write a SELECT statement that returns three columns from the Vendors
             table: vendor_name, vendor_contact_last_name, and vendor_contact_first_name.
             Then, run this statement to make sure it works correctly. Add an ORDER BY clause to this statement that
             sorts the result set by last name and then first name, both in ascending sequence.
             Then, run this state‐ment again to make sure it works correctly.
             This is a good way to build and test a statement, one clause at a time.
		
		Modification History
		Date modified - Who did it - what was modified
		2022-08-31	Ryan Paradee			Initial Creation
		
	*/
	SELECT 
		vendor_name
        , vendor_contact_last_name
        , vendor_contact_first_name
        FROM vendors
	ORDER BY vendor_contact_last_name
			, vendor_contact_first_name
	;
	
END$$
DELIMITER ;

CALL sp_Chapter_3_Exercise_8();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_3_Exercise_9$$
CREATE PROCEDURE sp_Chapter_3_Exercise_9()
COMMENT 'Create separate column and list names specifically as asked in the description'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
Write a SELECT statement that returns one column from the Vendors table named full_name that 
joins the vendor_contact_last_name and vendor_contact_first_name columns. 
Format this column with the last name, a comma, a space, and the first name like this:
Doe, John
Sort the result set by last name and then first name in ascending sequence. 
Return only the contacts whose last name begins with the letter A, B, C, or E. This should retrieve 41 rows.		
		Modification History
		Date modified - Who did it - what was modified
		2022-08-31	Ryan Paradee			Initial Creation
		
	*/
	SELECT 
          CONCAT(vendor_contact_last_name, + ', ', + vendor_contact_first_name) AS 'full_name'
          /* 
          I learned about the CONCAT funtion at https://learnsql.com/cookbook/how-to-concatenate-strings-in-sql/#:~:text=To%20append%20a%20string%20to,text%2C%20enclose%20it%20in%20quotes.
          */
	FROM vendors
    WHERE vendor_contact_last_name LIKE 'A%' 
    OR vendor_contact_last_name LIKE 'B%' 
    OR vendor_contact_last_name LIKE 'C%' 
    OR vendor_contact_last_name LIKE 'E%'
   ORDER BY 
	vendor_contact_last_name
    , vendor_contact_first_name
    ;

	
END$$
DELIMITER ;

CALL sp_Chapter_3_Exercise_9();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_3_Exercise_10$$
CREATE PROCEDURE sp_Champter_3_Exercise_10()
COMMENT 'Return invoice totals greater than or equal to 500 and less than or equal to 1000'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
			Write a SELECT statement that returns these column names
			and data from the Invoices table: 
			Due Date		The invoice_due_date column
			Invoice Total 	The invoice_total column
			10%				10% of the value of invoice_total
			Plus 10%		The value of invoice_total plus 10%
 
			Return only the rows with an invoice total that’s
			greater than or equal to 500 and less than or equal to 1000.

			This should retrieve 12 rows. 
 
			Sort the result set in descending sequence by invoice_due_date.
		
		Modification History
		Date modified - Who did it - what was modified
		2022-08-31	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT 
		(invoice_due_date) AS 'Due Date'
        , (invoice_total) AS 'Invoice Total'
        , (invoice_total/10) AS '10%'
        , (invoice_total*1.1) AS 'Plus 10%'
	FROM invoices
	WHERE invoice_total <= 1000 AND invoice_total >= 500
    ORDER BY invoice_due_date
;
	
END$$
DELIMITER ;

CALL sp_Champter_3_Exercise_10()


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_3_Exercise_11$$
CREATE PROCEDURE sp_Champter_3_Exercise_11()
COMMENT 'return specific invoices that are over $50'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
	Write a SELECT statement that returns these columns from the Invoices table:
			invoice_number			The invoice_number column
			invoice_total			The invoice_total column
			payment_credit_total	Sum of the payment_total and credit_total columns
			balance_due				The invoice_total column minus the payment_total and credit_total columns

			Return only invoices that have a balance due that’s greater than $50.

			Sort the result set by balance due in descending sequence.
 
			Use the LIMIT clause so the result set contains only
			the rows with the 5 largest balances.

		Modification History
		Date modified - Who did it - what was modified
		2022-08-31	Ryan Paradee			Initial Creation
		
	*/
	
SELECT
	invoice_number
    , invoice_total
    , (payment_total + credit_total) AS 'payment_credit_total'
	, (invoice_total-(payment_total + credit_total)) AS 'balance_due'
    
    FROM invoices
	WHERE (invoice_total-(payment_total + credit_total)) > 50
    
    ORDER BY (invoice_total-(payment_total + credit_total)) DESC
    LIMIT 5
;
	
END$$
DELIMITER ;

CALL sp_Champter_3_Exercise_11()

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_3_Exercise_12$$
CREATE PROCEDURE sp_Champter_3_Exercise_12()
COMMENT 'Return payment_date columns that are NULL'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		Write a SELECT statement that returns
		these columns from the Invoices table:
		
		invoice_number		The invoice_number column
		invoice_date 		The invoice_date column
		balance_due			The invoice_total column minus the payment_total and credit_total columns
		payment_date		The payment_date column
 
		Return only the rows where the payment_date column contains a null
		value. This should retrieve 11 rows.

		Modification History
		Date modified - Who did it - what was modified
		2022-08-31	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT
		invoice_number
        , invoice_date
        , (invoice_total-(payment_total + credit_total)) AS 'balance_due'
        , payment_date
    
    FROM invoices
    
    WHERE payment_date IS NULL
;
	
END$$
DELIMITER ;

CALL sp_Champter_3_Exercise_12()

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_3_Exercise_13$$
CREATE PROCEDURE sp_Champter_3_Exercise_13()
COMMENT 'Print current date using DATE_FORMAT'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
			Write a SELECT statement without a FROM clause that uses the
			CURRENT_DATE function to return the current date
			in its default format.

			Use the DATE_FORMAT function to format the current date in this
			format: mm-dd-yyyy
			
			This displays the month, day, and four‐digit year of the current date.
			Give this column an alias of current_date.
 
			To do that, you must enclose the alias in quotes since that name is
			already used by the CURRENT_DATE function.

		
		Modification History
		Date modified - Who did it - what was modified
		2022-09-06	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT DATE_FORMAT(CURRENT_DATE, '%m/%d/%Y') AS 'current_date'; /* got help from https://itprospt.com/qa/294105/13-write-a-select-statement-without-a-from-clause*/
	
END$$
DELIMITER ;

CALL sp_Champter_3_Exercise_13()

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_3_Exercise_14$$
CREATE PROCEDURE sp_Champter_3_Exercise_14()
COMMENT 'Briefly describe the procedure here.'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
			 Write a SELECT statement without a FROM clause that creates
			 a row with these columns:
			 
			 starting_principal				Starting principal of $50,000
			 interest 						6.5% of the principal
			 principal_plus_interest		The principal plus the interest
 
				To calculate the third column,
				add the expressions you used for the first two columns

		
		Modification History
		Date modified - Who did it - what was modified
		2022-09-06	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT 50000 AS 'starting_principal'
    , (50000 * 0.065) AS 'interest'
    , ((50000 * 0.065) +50000) AS 'principal_plus_interest'
	;
END$$
DELIMITER ;

CALL sp_Champter_3_Exercise_14()