/*
	ASSIGNMENT: 	subquery_assignment
    AUTHOR: 		Ryan Paradee
    DATE CREATED:	2022-10-17
	DESCRIPTION: Provide solutions for Exercises 1 through 9 on pages 228 and 229 of the Murach text.
*/

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_7_Exercise_1$$
CREATE PROCEDURE sp_Chapter_7_Exercise_1()
COMMENT 'chapter 7 exercise 1'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
        
		--
		Write a SELECT statement that returns the same result set as this SELECT
		statement, but don’t use a join.
		Instead, use a subquery in a WHERE clause that uses the IN keyword.
		--
        
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
    
    
SELECT vendor_id
FROM vendors v
WHERE v.vendor_id 
IN
(SELECT i.vendor_id 
FROM invoices i)
ORDER BY vendor_id
;


END$$
DELIMITER ;

CALL sp_Chapter_7_Exercise_1();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_7_Exercise_2$$
CREATE PROCEDURE sp_Chapter_7_Exercise_2()
COMMENT 'chapter 7 exercise 2'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		Write a SELECT statement that answers this question:
		Which invoices have a payment total that’s greater than the average
		payment total for all invoices with a payment total greater than 0?
		Return the invoice_number and invoice_total columns for each invoice.
		This should return 20 rows. Sort the results by the invoice_total column in descending order.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT invoice_number
    ,invoice_total 
    FROM invoices 
    WHERE payment_total > (SELECT AVG(payment_total) 
    FROM invoices 
    WHERE payment_total>0)
    ORDER BY invoice_total DESC
	;
END$$
DELIMITER ;

CALL sp_Chapter_7_Exercise_2();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_7_Exercise_3$$
CREATE PROCEDURE sp_Chapter_7_Exercise_3()
COMMENT 'chapter 7 exercise 3'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		Write a SELECT statement that returns two columns from the General_Ledger_Accounts table:
		account_number and account_description.
		Return one row for each account number that has never been assigned to any line item in the Invoice_Line_Items table.
		To do that, use a subquery intro-duced with the NOT EXISTS operator. This should return 54 rows.
		Sort the results by the account_number column.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	

SELECT account_number
, account_description
FROM general_ledger_accounts AS a

WHERE NOT EXISTS 

(SELECT * 
FROM invoice_line_items AS b
WHERE b.account_number = a.account_number) 
ORDER BY account_number
; 
	
END$$
DELIMITER ;

CALL sp_Chapter_7_Exercise_3();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_7_Exercise_4$$
CREATE PROCEDURE sp_Chapter_7_Exercise_4()
COMMENT 'chapter 7 exercise 4'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		 Write a SELECT statement that returns four columns: vendor_name, invoice_id, invoice_sequence, and line_item_amount.
		 Return a row for each line item of each invoice that has more than one line item in the Invoice_Line_Items table.
		 Hint: Use a subquery that tests for invoice_sequence > 1. This should return 6 rows.
		 Sort the results by the vendor_name, invoice_id, and invoice_sequence columns.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
SELECT vendor_name
	, q.invoice_id
	, li.invoice_sequence
    , li.line_item_amount
FROM vendors e INNER JOIN invoices q 
ON e.vendor_id = q.vendor_id
INNER JOIN invoice_line_items li
ON q.invoice_id = li.invoice_id
WHERE q.invoice_id IN
(SELECT invoice_id
FROM invoice_line_items
WHERE invoice_sequence > 1)
ORDER BY e.vendor_name
	, q.invoice_id
	, li.invoice_sequence
;
	
END$$
DELIMITER ;

CALL sp_Chapter_7_Exercise_4();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_7_Exercise_5$$
CREATE PROCEDURE sp_Chapter_7_Exercise_5()
COMMENT 'chapter 7 exercise 5'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		 Write a SELECT statement that returns two columns: vendor_id and the largest unpaid invoice for each vendor.
		 To do this, you can group the result set by the vendor_id column.
		 This should return 7 rows. Write a second SELECT statement that uses the first SELECT statement in its FROM clause.
		 The main query should return a single value that represents the sum of the largest unpaid invoices for each vendor.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT vendor_id, MAX(invoice_total) AS 'invoice_max'
      FROM invoices
      WHERE (invoice_total - credit_total - payment_total) > 0
      GROUP BY vendor_id
      ;
      
      SELECT SUM(invoice_max) AS 'sum_of_maximums'
      FROM 
      (
      SELECT vendor_id, MAX(invoice_total) AS 'invoice_max'
      FROM invoices
      WHERE (invoice_total - credit_total - payment_total) > 0
      GROUP BY vendor_id 
      ) AS max_invoice
      ;
	
END$$
DELIMITER ;

CALL sp_Chapter_7_Exercise_5();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_7_Exercise_6$$
CREATE PROCEDURE sp_Chapter_7_Exercise_6()
COMMENT 'chapter 7 exercise 6'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		 Write a SELECT statement that returns the name, city, and state of each vendor that’s located in a unique city and state.
		 In other words, don’t include vendors that have a city and state in common with another vendor. This should return 38 rows.
         
         Sort the results by the vendor_state and vendor_city columns.

		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT vendor_name
			, vendor_city
			, vendor_state
    FROM vendors
    WHERE vendor_city + vendor_state
    NOT IN
    (SELECT vendor_city + vendor_state
    FROM vendors
    GROUP BY vendor_city
			+ vendor_state
	HAVING COUNT(*)>1)
    ORDER BY vendor_state
			, vendor_city
    ;
    
	
END$$
DELIMITER ;

CALL sp_Chapter_7_Exercise_6();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_7_Exercise_7$$
CREATE PROCEDURE sp_Chapter_7_Exercise_7()
COMMENT 'chapter 7 exercise 7'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		 Use a correlated subquery to return one row per vendor, representing the vendor’s oldest invoice 
         (the one with the earliest date).
		 Each row should include these four columns: vendor_name, invoice_number, invoice_date, and invoice_total.
         This should return 34 rows. 
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT vendor_name
    , invoice_number
    , invoice_date
    , invoice_total 
    FROM invoices im
    INNER JOIN vendors v 
    ON im.vendor_id = v.vendor_id
    WHERE invoice_date =
	(SELECT MIN(invoice_date)
	FROM invoices i_s
	WHERE i_s.vendor_id = im.vendor_id)
    ORDER BY v.vendor_name ASC
			, im.invoice_date DESC
	;
    
END$$
DELIMITER ;

CALL sp_Chapter_7_Exercise_7();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_7_Exercise_8$$
CREATE PROCEDURE sp_Chapter_7_Exercise_8()
COMMENT 'chapter 7 exercise 8'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		  Rewrite exercise 7 so it gets the same result but uses an inline view instead of a correlated subquery.
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	
SELECT vendor_name
    , invoice_number AS 'oldest_invoice'
    , invoice_date
    , invoice_total 
    FROM invoices i_m
    INNER JOIN (SELECT vendor_id
						, MIN(invoice_date) AS 'oldest_invoice_date'
				FROM invoices
                GROUP BY vendor_id) o_i
    ON (i_m.vendor_id = o_i.vendor_id 
    AND i_m.invoice_date = o_i.oldest_invoice_date)
    INNER JOIN vendors v_m
    ON i_m.vendor_id = v_m.vendor_id
    ORDER BY vendor_name
	;
    
    
END$$
DELIMITER ;

CALL sp_Chapter_7_Exercise_8();

--

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Chapter_7_Exercise_9$$
CREATE PROCEDURE sp_Chapter_7_Exercise_9()
COMMENT 'chapter 7 exercise 9'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 02
		DESCRIPTION:
		
		--
		  Rewrite exercise 5 so it uses a common table expression (CTE) instead of an inline view
		--
		
		Modification History
		Date modified - Who did it - what was modified
		2022-10-17	Ryan Paradee			Initial Creation
		
	*/
	/*used some outside resources/references to get me started with this exercise, mainly the WITH statement*/
WITH invoice_max AS
(
	SELECT vendor_id
			, MAX(invoice_total) AS 'invoice_max'
	FROM invoices
	WHERE (invoice_total 
			- credit_total 
			- payment_total) > 0
	GROUP BY vendor_id
)
SELECT SUM(invoice_max) AS 'sum_of_maximums'
FROM invoice_max
	;
    
END$$
DELIMITER ;

CALL sp_Chapter_7_Exercise_9();
