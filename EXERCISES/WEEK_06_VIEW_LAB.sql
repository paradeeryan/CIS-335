/*
	ASSIGNMENT: 	view_assignment
    AUTHOR: 		Ryan Paradee
    DATE CREATED:	2022-10-17
	DESCRIPTION: Write a single SQL file that performs the tasks for Exercises 1 and 2 on page 398 of the Murach text
*/

/*Problem 1
Create a view named open_items that shows the invoices that haven’t been paid.
 This view should return four columns from the Vendors and
 Invoices tables: vendor_name, invoice_number, invoice_total, and balance_due (invoice_total - payment_total - credit_total).
A row should only be returned when the balance due is greater than zero, and the rows should be in sequence by vendor_name.
*/
USE ap;
CREATE OR REPLACE VIEW open_items
AS
SELECT vendor_name
, invoice_number
, invoice_total
,(invoice_total 
	- payment_total 
	- credit_total) 
		AS 'balance_due'

FROM vendors INNER JOIN invoices

ON vendors.vendor_id = invoices.vendor_id

WHERE (
	invoice_total 
	- payment_total 
	- credit_total
		) > 0
ORDER BY 
	vendor_name
;
/*Problem 2:
	Write a SELECT statement that returns all of the columns in the open_items view that you created in exercise 1,
	with one row for each invoice that has a balance due of $1000 or more.
*/

SELECT *
FROM open_items
WHERE balance_due >= 1000
;

