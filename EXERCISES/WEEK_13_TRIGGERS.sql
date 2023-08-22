/*
	ASSIGNMENT: 	triggers_assignment
    AUTHOR: 		Ryan Paradee
    DATE CREATED:	2022-11-28
	DESCRIPTION: 	Exercise 2 on page 490 
*/
USE ap;
DELIMITER
DROP TABLE IF EXISTS invoices_audit;
CREATE TABLE invoices_audit
(vendor_id INT NOT NULL
, invoice_number VARCHAR(50) NOT NULL
, invoice_total DECIMAL(9,2) NOT NULL
, action_type VARCHAR(50) NOT NULL
, action_date DATETIME NOT NULL);


DROP TRIGGER IF EXISTS tr_invoices_after_update;
CREATE TRIGGER tr_invoices_after_update
AFTER UPDATE ON invoices
FOR EACH ROW
BEGIN

INSERT INTO invoices_audit
VALUES (OLD.vendor_id
, OLD.invoice_number
, OLD.invoice_total
, 'UPDATED'
, NOW())
END ;



UPDATE invoices
SET payment_total = 100
WHERE invoice_id = 112;

SELECT *
FROM invoices_audit;

/*Clean up*/

UPDATE invoices
SET payment_total = 0
WHERE invoice_id = 112;


DELIMITER ;





