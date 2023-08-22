/*
	ASSIGNMENT: 	functions_assignment
    AUTHOR: 		Ryan Paradee
    DATE CREATED:	2022-10-31
	DESCRIPTION: Provide solutions for Exercises 1 through 6 on pages 300 and 301 of the Murach text.
*/

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_9_Exercise_1$$
CREATE PROCEDURE sp_Chapter_9_Exercise_1()
COMMENT 'chapter 9 exercise 1'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 09
		DESCRIPTION:
		
		--
		Write a SELECT statement that returns these columns from the Invoices table:
		
		-The invoice_total column
		-A column that uses the ROUND function to return
		the invoice_total column with 1 decimal digit
		-A column that uses the ROUND function to return
		the invoice_total column with no decimal digits
		-A column that uses the TRUNCATE function to return
		the invoice_total column with no decimal digits


		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-31	Ryan Paradee			Initial Creation
		
	*/
	
	
	SELECT invoice_total
			, ROUND(invoice_total, 1) AS 'one_digit'
            , ROUND(invoice_total, 0) AS 'zero_digit'
			, TRUNCATE(invoice_total, 0) AS 'zero_digit_truncate'
	FROM invoices
    ;
	
END$$
DELIMITER ;

CALL sp_Chapter_9_Exercise_1();

--

USE ex;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_9_Exercise_2$$
CREATE PROCEDURE sp_Chapter_9_Exercise_2()
COMMENT 'chapter 9 exercise 2'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 09
		DESCRIPTION:
		
		--
		Write a SELECT statement that returns these columns from the Date_Sample table in the EX database:
		
		-The start_date column A column that uses the DATE_FORMAT function to return the start_date
		column with its month name abbreviated and its month, day, and two-digit year separated by slashes
        --MMM - month name abbreviated
        --'MMM, MM-dd-yy'
        
		-A column that uses the DATE_FORMAT function to return the start_date column with its month
		and day returned as integers with no leading zeros, a two-digit year, and all date parts separated by slashes
        
		-A column that uses the DATE_FORMAT function to return the start_date column with only the
		hours and minutes on a 12-hour clock with an am/pm indicator

		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-31	Ryan Paradee			Initial Creation
		
	*/
	
SELECT DATE_FORMAT(start_date, '%b, %m/%d/%y') AS 'date_with_abrev'
		, DATE_FORMAT(start_date, '%c/%e/%y') AS 'date_no_zero'
        , DATE_FORMAT(start_date, '%l:%i %p') AS 'time'
FROM date_sample;


END$$
DELIMITER ;

CALL sp_Chapter_9_Exercise_2();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_9_Exercise_3$$
CREATE PROCEDURE sp_Chapter_9_Exercise_3()
COMMENT 'chapter 9 exercise 3'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 09
		DESCRIPTION:
		
		--
		Write a SELECT statement that returns these columns from the Vendors table:
		-The vendor_name column
		-The vendor_name column in all capital letters
		-The vendor_phone column
		-A column that displays the last four digits of each phone number
		
		
		When you get that working right, add the columns that follow to the result set.
		This is more difficult because these columns require the use of functions within functions.
		
		The vendor_phone column with the parts of the number separated by dots,
		as in 555.555.5555
		
		A column that displays the second word in each vendor name
		if there is one and blanks if there isn’t



		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-31	Ryan Paradee			Initial Creation
		
	*/
	
	
	SELECT vendor_name
			, UPPER(vendor_name) AS 'uppercase'
            , vendor_phone
            , RIGHT(vendor_phone, 4) AS 'last_4_of_phone'
	FROM vendors
	;
	
	
END$$
DELIMITER ;

CALL sp_Chapter_9_Exercise_3();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_9_Exercise_4$$
CREATE PROCEDURE sp_Chapter_9_Exercise_4()
COMMENT 'chapter 9 exercise 4'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 09
		DESCRIPTION:
		
		--
		Write a SELECT statement that returns these columns from the Invoices table:
		
		-The invoice_number column 
		-The invoice_date column 
		-The invoice_date column plus 30 days
		-The payment_date column 
		-A column named days_to_pay that shows the number
		of days between the invoice date and the payment date
		-The number of the invoice date’s month
		-The four-digit year of the invoice date
		
		When you have this working, add a WHERE clause that retrieves
		just the invoices for the month of May based on the invoice date,
		not the number of the invoice month



		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-31	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT invoice_number
			, invoice_date
            , invoice_date+30 AS 'plus_30_days'
            , payment_date
            , DATEDIFF(payment_date, invoice_date) AS 'days_to_pay'
            , MONTH(invoice_date) AS 'month'
            , YEAR(invoice_date) AS 'year'
	FROM invoices
    ;
	
	
	
END$$
DELIMITER ;

CALL sp_Chapter_9_Exercise_4();

--

USE ex;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_9_Exercise_5$$
CREATE PROCEDURE sp_Chapter_9_Exercise_5()
COMMENT 'chapter 9 exercise 5'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 09
		DESCRIPTION:
		
		--
		Write a SELECT statement that returns these columns from the String_Sample
		table of the EX database:
		
		The emp_name column
		A column that displays each employee’s first name
		A column that displays each employee’s last name
		
		Use regular expression functions to get the first and last name.
		If a name contains three parts, everything after the first part
		should be considered part of the last name. Be sure to provide 
		for last names with hypens and apostrophes.

		Hint: To include an apostrophe in a pattern, you can code
		a \ in front of it or you can enclose the pattern in double quotes.

		


		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-31	Ryan Paradee			Initial Creation
		
	*/
	
	
	SELECT emp_name
			, REGEXP_SUBSTR(emp_name, '[A-Z]*') AS 'first_name'
            
            , REGEXP_SUBSTR(emp_name, '[A-Z]*[A-Z]*|[A-Z]*[-|\'][A-Z]*|[A-Z]*', REGEXP_INSTR(emp_name, ' ')+ 1)  AS 'last_name'
            
    FROM string_sample
	;


    
END$$
DELIMITER ;

CALL sp_Chapter_9_Exercise_5();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_9_Exercise_6$$
CREATE PROCEDURE sp_Chapter_9_Exercise_6()
COMMENT 'chapter 9 exercise 6'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 09
		DESCRIPTION:
		
		--
		Write a SELECT statement that returns these columns from the
		Invoice table of the AP database:

		-The invoice_number column
		-The balance due for each invoice with a balance due greater than zero
		-A column that uses the RANK() function to rank the balance due in descending sequence




		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-31	Ryan Paradee			Initial Creation
		
	*/
	
	
	SELECT invoice_number
			, (invoice_total-payment_total-credit_total) AS 'balance_due'
            , RANK()OVER(ORDER BY invoice_total-payment_total-credit_total DESC) AS 'balance_rank'
	FROM invoices        
	WHERE invoice_total-payment_total-credit_total > 0
        
	;
	
END$$
DELIMITER ;

CALL sp_Chapter_9_Exercise_6();
