/*
	ASSIGNMENT: 	subquery_assignment
    AUTHOR: 		Ryan Paradee
    DATE CREATED:	2022-10-24
	DESCRIPTION: Provide solutions for Exercises 1 through 2 in chapter 8 on page 255. Use stored procedures.
*/

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_8_Exercise_1$$
CREATE PROCEDURE sp_Chapter_8_Exercise_1()
COMMENT 'chapter 8 exercise 1'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		Write a SELECT statement that returns these columns from the Invoices table:
		
		--The invoice_total column 
		-A column that uses the FORMAT function to return the invoice_total column
		with 1 digit to the right of the decimal point 
		
		-A column that uses the CONVERT function to return the invoice_total column as an integer
		
		-A column that uses the CAST function to return the invoice_total column as an integer


		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT invoice_total
		, FORMAT(invoice_total, 1) AS 'formatted'
        , CONVERT(invoice_total,SIGNED INTEGER) AS 'converted'
        , CAST(invoice_total AS SIGNED INTEGER) AS 'cast'
	FROM invoices
	;
	
END$$
DELIMITER ;

CALL sp_Chapter_8_Exercise_1();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_8_Exercise_2$$
CREATE PROCEDURE sp_Chapter_8_Exercise_2()
COMMENT 'chapter 8 exercise 2'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		Write a SELECT statement that returns these columns from the Invoices table:

		--The invoice_date column
		
		-A column that uses the CAST function to return the invoice_date column with its full date and time
		-A column that uses the CAST function to return the invoice_date column with just the year and the month

		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT invoice_date 
		, CAST(invoice_date AS DATETIME) AS 'full_date_and_time'
		, CAST(invoice_date AS CHAR(7)) AS 'year_and_month'
	FROM invoices
	;
	
END$$
DELIMITER ;

CALL sp_Chapter_8_Exercise_2();
