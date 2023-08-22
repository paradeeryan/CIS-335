/*
	FILE 	week_03_lab.sql
    DATE	2022-09-12
    AUTHOR	Ryan Paradee
    DESCRIPTION
			JOIN LAB
*/


USE ap;

SELECT
	vendors.vendor_name
    , invoices.invoice_number
    , invoices.invoice_date
	, (invoices.invoice_total - 
		invoices.payment_total - 
		invoices.credit_total) AS 'balance_due'

FROM vendors
INNER JOIN invoices
ON vendors.vendor_id = invoices.vendor_id
WHERE (invoices.invoice_total - 
		invoices.payment_total - 
		invoices.credit_total) <> 0
ORDER BY vendor_name
;