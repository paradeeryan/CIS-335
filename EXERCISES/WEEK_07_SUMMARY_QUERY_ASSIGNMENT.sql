/*
	ASSIGNMENT: 	summary_query_assignment
    AUTHOR: 		Ryan Paradee
    DATE CREATED:	2022-10-17
	DESCRIPTION: Provide solutions to Exercises 1 through 11 for Chapter 6 (pages 196 to 198 of the Murach text.)
*/

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_1$$
CREATE PROCEDURE sp_Chapter_6_Exercise_1()
COMMENT 'chapter 6 exercise 1'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		  Write a SELECT statement that returns one row for each vendor in the Invoices table that contains these columns:
		  
		  -The vendor_id column from the Invoices table 
		  -The sum of the invoice_total columns in the Invoices table for that vendor
		  
		  This should return 34 rows.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
SELECT vendors.vendor_id 
		,SUM(invoice_total)
FROM vendors
	, invoices
WHERE vendors.vendor_id =invoices.vendor_id
GROUP BY vendors.vendor_id
;
	
END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_1();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_2$$
CREATE PROCEDURE sp_Chapter_6_Exercise_2()
COMMENT 'chapter 6 exercise 2'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		  Write a SELECT statement that returns one row for each vendor that contains these columns:
		  
		  -The vendor_name column from the Vendors table 
		  -The sum of the payment_total columns in the Invoices table for that vendor
		  
		  Sort the result set in descending sequence by the payment total sum for each vendor.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
SELECT vendor_name
		, SUM(payment_total) AS 'payment_total_sum'
FROM vendors INNER JOIN invoices
ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
ORDER BY payment_total_sum DESC
;

END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_2();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_3$$
CREATE PROCEDURE sp_Chapter_6_Exercise_3()
COMMENT 'chapter 6 exercise 3'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		  Write a SELECT statement that returns one row for each vendor that contains three columns:

		  -The vendor_name column from the Vendors table
		  -The count of the invoices in the Invoices table for each vendor
		  -The sum of the invoice_total columns in the Invoices table for each vendor
		  
		  Sort the result set so the vendor with the most invoices appears first.

		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
SELECT vendor_name
		, COUNT(*) AS 'invoice_count'
        , SUM(invoice_total) AS 'invoice_total_sum'
FROM vendors 
INNER JOIN invoices 
ON vendors.vendor_id = invoices.vendor_id 
GROUP BY vendor_name 
ORDER BY invoice_total_sum DESC
;



END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_3();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_4$$
CREATE PROCEDURE sp_Chapter_6_Exercise_4()
COMMENT 'chapter 6 exercise 4'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		  Write a SELECT statement that returns one row for each general ledger account number that contains three columns:
		  
		  -The account_description column from the General_Ledger_Accounts table
		  -The count of the items in the Invoice_Line_Items table that have the same account_number
		  -The sum of the line_item_amount columns in the Invoice_Line_Items table that have the same account_number
		  
		  Return only those rows where the count of line items is greater than 1.
		  This should return 10 rows.
		  Group the result set by the account_description column.
		  Sort the result set in descending sequence by the sum of the line item amounts.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
SELECT account_description
		, COUNT(*) AS 'line_item_count'
        , SUM(line_item_amount) AS 'line_item_sum'
FROM general_ledger_accounts g 
INNER JOIN invoice_line_items l 
ON g.account_number = l.account_number
GROUP BY g.account_description HAVING COUNT(*) > 1
ORDER BY line_item_sum DESC
;

END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_4();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_5$$
CREATE PROCEDURE sp_Chapter_6_Exercise_5()
COMMENT 'chapter 6 exercise 5'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		 Modify the solution to exercise 4 so it returns only invoices dated in the second quarter of 2018 
         (April 1, 2018 to June 30, 2018).
         
		 This should still return 10 rows but with some different line item counts for each vendor.

		 Hint: Join to the Invoices table to code a search condition based on invoice_date.

		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
SELECT account_description
		, COUNT(*) AS 'line_item_count'
        , SUM(line_item_amount) AS 'line_item_sum'
FROM general_ledger_accounts g 
INNER JOIN invoice_line_items l 
ON g.account_number = l.account_number
INNER JOIN invoices i
ON l.invoice_id = i.invoice_id
WHERE invoice_date BETWEEN '2018-04-01' AND '2018-06-30'
GROUP BY account_description 
HAVING  line_item_count > 1
ORDER BY line_item_sum DESC
;

 
END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_5();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_6$$
CREATE PROCEDURE sp_Chapter_6_Exercise_6()
COMMENT 'chapter 6 exercise 6'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		Write a SELECT statement that answers this question:
		What is the total amount invoiced for each general ledger account number?
		
		
		Return these columns:
		
		-The account_number column from the Invoice_Line_Items table 
		-The sum of the line_item_amount columns from the Invoice_Line_Items table
		
		Use the WITH ROLLUP operator to include a row that gives the grand total. This should return 22 rows.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-24	Ryan Paradee			Initial Creation
		
	*/
	
    SELECT account_number
			,SUM(line_item_amount) AS 'line_item_amount_sum'
	FROM invoice_line_items 
    GROUP BY account_number WITH ROLLUP
    ;
    
END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_6();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_7$$
CREATE PROCEDURE sp_Chapter_6_Exercise_7()
COMMENT 'chapter 6 exercise 7'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		Write a SELECT statement that answers this question:
		Which vendors are being paid from more than one account?
		
		Return these columns:
		-The vendor_name column from the Vendors table 
		-The count of distinct general ledger accounts that apply to that vendor’s invoices

		This should return 2 rows.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-24	Ryan Paradee			Initial Creation
		
	*/
	
SELECT DISTINCT v.vendor_name AS 'vendor_name'
				 , COUNT( DISTINCT gl.account_number) AS 'num_of_distinct_general_ledger_accounts'
FROM general_ledger_accounts gl

INNER JOIN invoice_line_items li
ON gl.account_number = li.account_number

INNER JOIN invoices i
ON li.invoice_id = i.invoice_id

INNER JOIN vendors v                                          
ON i.vendor_id = v.vendor_id

GROUP BY v.vendor_id
HAVING COUNT(DISTINCT gl.account_number) > 1
;

END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_7();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_8$$
CREATE PROCEDURE sp_Chapter_6_Exercise_8()
COMMENT 'chapter 6 exercise 8'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		Write a SELECT statement that answers this question:

		What are the last payment date and total amount due for each vendor with each terms id?

		Return these columns:

		-The terms_id column from the Invoices table
		-The vendor_id column from the Invoices table
		-The last payment date for each combination of terms id and vendor id in the Invoices table
		-The sum of the balance due (invoice_total - payment_total - credit_total)
		for each combination of terms id and vendor id in the Invoices table
		
		Use the WITH ROLLUP operator to include rows that give a summary for each terms id
		as well as a row that gives the grand total.

		This should return 40 rows.
		
		Use the IF and GROUPING functions to replace the null values in the terms_id and vendor_id columns with literal
		values if they’re for summary rows.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-24	Ryan Paradee			Initial Creation
		
	*/
	SELECT IF(GROUPING(terms_id) = 1, 'Grand Totals', terms_id) AS 'terms_id'
    
			, IF(GROUPING(vendor_id) = 1, 'Terms id Totals', vendor_id) AS 'vendor_id'
            
            , MAX(payment_date) AS 'max_payment_date'
            
            , SUM(invoice_total-payment_total-credit_total) AS 'balance_due'
            
    FROM invoices
    GROUP BY terms_id
			, vendor_id 		WITH ROLLUP
    ;
    

	
END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_8();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_9$$
CREATE PROCEDURE sp_Chapter_6_Exercise_9()
COMMENT 'chapter 6 exercise 9'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		 Write a SELECT statement that uses aggregate window functions to calculate the total due for all vendors
		 and the total due for each vendor. 
		 Return these columns:
		 
		 -The vendor id from the Invoices table
		 -The balance due (invoice_total - payment_total - credit_total)
		 for each invoice in the Invoices table with a balance due greater than 0 
		 -The total balance due for all vendors in the Invoices table
		 -The total balance due for each vendor in the Invoices table
		 
		 Modify the column that contains the balance due for each vendor so it contains a 
		 cumulative total by balance due.

		 This should return 11 rows.

		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-24	Ryan Paradee			Initial Creation
		
	*/
	
SELECT vendor_id

		, (invoice_total-payment_total-credit_total) AS 'balance due'
        
        , SUM(invoice_total-payment_total-credit_total) OVER() AS 'total_due'
        
        , SUM(invoice_total-payment_total-credit_total) OVER(PARTITION BY vendor_id
			ORDER BY (invoice_total-payment_total-credit_total)) AS 'vendor_due'  
            
FROM invoices
WHERE (invoice_total-payment_total-credit_total) > 0
;
	
END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_9();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_10$$
CREATE PROCEDURE sp_Chapter_6_Exercise_10()
COMMENT 'chapter 6 exercise 10'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		 Modify the solution to exercise 9 so it includes a column that calculates the average balance due
		 for each vendor in the Invoices table. This column should contain a cumulative average by balance due.

		 Modify the SELECT statement so it uses a named window for the last two aggregate window functions

		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-24	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT vendor_id
		, (invoice_total-payment_total-credit_total) AS 'balance due'
        
        , SUM(invoice_total-payment_total-credit_total) OVER() AS 'total_due'
        
        , SUM(invoice_total-payment_total-credit_total) OVER vendor_window AS 'vendor_due'
        
        , ROUND(AVG(invoice_total-payment_total-credit_total) OVER vendor_window, 2) AS 'vendor_avg'
        
FROM invoices
WHERE (invoice_total-payment_total-credit_total) > 0
WINDOW vendor_window AS (PARTITION BY vendor_id ORDER BY (invoice_total-payment_total-credit_total))
;
	
	
	
END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_10();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_6_Exercise_11$$
CREATE PROCEDURE sp_Chapter_6_Exercise_11()
COMMENT 'chapter 6 exercise 11'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		Write a SELECT statement that uses an aggregate window function to calcu-late a moving average
		of the sum of invoice totals. Return these columns: The month of the invoice date from the Invoices
		table The sum of the invoice totals from the Invoices table The moving average of the invoice totals sorted by invoice month
		
		The result set should be grouped by invoice month and the frame for the moving average should include the
		current row plus three rows before the current row.

		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-24	Ryan Paradee			Initial Creation
		
	*/
    
    
    /*
    I had no idea how to do this, so I looked up a solution for this problem and for some of the ones
    before this and yeah, I was no where close to the answer, but now I have a better understanding of the concept.
    
	I'm pretty sure this is the book's solution for the problem... 
      */
    
SELECT MONTH(invoice_date) AS 'month'

		, SUM(invoice_total) AS 'total_invoices'
        
		, ROUND(AVG(SUM(invoice_total))OVER(ORDER BY MONTH(invoice_date)
		  RANGE BETWEEN 3 PRECEDING AND CURRENT ROW), 2) AS '4_month_avg'
          
FROM invoices
GROUP BY MONTH(invoice_date)
;


END$$
DELIMITER ;

CALL sp_Chapter_6_Exercise_11();
