USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_4_Exercise_2$$
CREATE PROCEDURE sp_Champter_4_Exercise_2()
COMMENT 'chapter 4 exercise 2'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 03
		DESCRIPTION:
        --
		Write a SELECT statement that returns these four columns:
			vendor_name			The vendor_name column from the Vendors table
            
			invoice_number		The invoice_number column from the Invoices table
            
			invoice_date		The invoice_date column from the Invoices table
            
			balance_due			The invoice_total column minus the payment_total
								and credit_total columns from the Invoices table
                            
			Use these aliases for the tables: v for Vendors and i for Invoices.
            Return one row for each invoice with a non-zero balance.
            This should return 11 rows.
            Sort the result set by vendor_name in ascending order.
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-10	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT 
	vendors.vendor_name
    , invoices.invoice_number
    , invoices.invoice_date
    , (invoices.invoice_total
    - invoices.payment_total
    - invoices.credit_total) AS 'balance_due'
FROM vendors
INNER JOIN invoices
ON vendors.vendor_id = invoices.vendor_id
WHERE (invoices.invoice_total
    - invoices.payment_total
    - invoices.credit_total) <> 0
ORDER BY vendors.vendor_name
;	
END$$
DELIMITER ;

CALL sp_Champter_4_Exercise_2();

USE ap;


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_4_Exercise_3$$
CREATE PROCEDURE sp_Champter_4_Exercise_3()
COMMENT 'chapter 4 exercise 3'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 03
		DESCRIPTION:
        --
		Write a SELECT statement that returns these three columns:
		
		vendor_name			The vendor_name column from the Vendors table
		default_account		The default_account_number column from the Vendors table
		description			The account_description column from the 
							General_Ledger_Accounts table

		Return one row for each vendor.
		This should return 122 rows.
		Sort the result set by account_description and then by vendor_name
        --
		Modification History
		Date modified - Who did it - what was modified
		2022-09-10	Ryan Paradee			Initial Creation
		
	*/
	SELECT 
		vendors.vendor_name
        , vendors.default_account_number
        , (general_ledger_accounts.account_description) AS 'description'
    
    FROM vendors
    INNER JOIN general_ledger_accounts
    ON vendors.default_account_number = general_ledger_accounts.account_number
    ORDER BY general_ledger_accounts.account_description, vendors.vendor_name
    ;
	
	
END$$
DELIMITER ;

CALL sp_Champter_4_Exercise_3();

USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_4_Exercise_4$$
CREATE PROCEDURE sp_Champter_4_Exercise_4()
COMMENT 'chapter 4 exercise 4'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 03
		DESCRIPTION:
		--
		Write a SELECT statement that returns these five columns:
		
			vendor_name			The vendor_name column from the Vendors table
			invoice_date		The invoice_date column from the Invoices table
			invoice_number		The invoice_number column from the Invoices table
			li_sequence			The invoice_sequence column from the Invoice_Line_Items table
			li_amount			The line_item_amount column from the Invoice_Line_Items table
		
		Use aliases for the tables.
		This should return 118 rows.
		Sort the final result set by vendor_name,
        invoice_date, invoice_number, and invoice_sequence.
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-10	Ryan Paradee			Initial Creation
		
	*/
	SELECT 
		vendors.vendor_name
        , invoices.invoice_date
        , invoices.invoice_number
        , invoice_line_items.invoice_sequence AS 'li_sequence'
        , invoice_line_items.line_item_amount AS 'li_amount'
    FROM vendors
    INNER JOIN invoices 
    ON vendors.vendor_id = invoices.vendor_id
    INNER JOIN invoice_line_items 
    ON invoices.invoice_id = invoice_line_items.invoice_id
    ORDER BY vendors.vendor_name
			, invoices.invoice_date
            , invoices.invoice_number
            , invoice_line_items.invoice_sequence
            , invoice_line_items.line_item_amount
    ;
	
	
END$$
DELIMITER ;

CALL sp_Champter_4_Exercise_4();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_4_Exercise_5$$
CREATE PROCEDURE sp_Champter_4_Exercise_5()
COMMENT 'chapter 4 exercise 5'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 03
		DESCRIPTION:
		--
		Write a SELECT statement that returns three columns:
		
			vendor_id		The vendor_id column from the Vendors table
			vendor_name		The vendor_name column from the Vendors table
			contact_name	A concatenation of the vendor_contact_first_name 
							and vendor_contact_last_name columns with a space between
 
		Return one row for each vendor whose contact has the same last name
		as another vendor’s contact. This should return 2 rows. 
		
		Hint: Use a self-join to check that the vendor_id columns aren’t
		equal but the vendor_contact_last_name columns are equal.
		
		Sort the result set by vendor_contact_last_name.
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-10	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT 
		v1.vendor_id
        , v1.vendor_name
        , CONCAT(v1.vendor_contact_first_name, + ' ', + v1.vendor_contact_last_name)
        AS 'contact_name'
    FROM vendors v1
    INNER JOIN vendors v2
    ON v1.vendor_contact_last_name = v2.vendor_contact_last_name 
    AND v1.vendor_id <> v2.vendor_id
    ORDER BY v1.vendor_contact_last_name
    ;
	
END$$
DELIMITER ;

CALL sp_Champter_4_Exercise_5();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_4_Exercise_6$$
CREATE PROCEDURE sp_Champter_4_Exercise_6()
COMMENT 'chapter 4 exercise 6'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 03
		DESCRIPTION:
		--
		Write a SELECT statement that returns these three columns:
		
			account_number			The account_number column from the 
									General_Ledger_Accounts table
									
			account_description		The account_description column from 
									General_Ledger_Accounts table
									
			invoice_id				The invoice_id column from the
									Invoice_Line_Items table
	
		Return one row for each account number that has never been used.
		This should return 54 rows.

		Hint: Use an outer join and only return rows where the invoice_id
		column contains a null value. Remove the invoice_id column from the
		SELECT clause. Sort the final result set by the account_number column.

		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-14	Ryan Paradee			Initial Creation
		
	*/
	
		SELECT 
			t.account_number
            , t.account_description
            , l.invoice_id
        FROM general_ledger_accounts t
        LEFT JOIN invoice_line_items l
        ON t.account_number = l.account_number
		WHERE l.invoice_id IS NULL
        ORDER BY t.account_number
        ;
        
END$$
DELIMITER ;

CALL sp_Champter_4_Exercise_6();


USE ap;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Champter_4_Exercise_7$$
CREATE PROCEDURE sp_Champter_4_Exercise_7()
COMMENT 'chapter 4 exercise 7'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	Week 03
		DESCRIPTION:
		--
		Use the UNION operator to generate a result set consisting of two
		columns from the Vendors table: vendor_name and vendor_state.
		If the vendor is in California, the vendor_state value should
		be “CA”; otherwise, the vendor_state value should be “Outside CA.”
		
		Sort the final result set by vendor_name.
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-09-10	Ryan Paradee			Initial Creation
		
	*/
	
	SELECT 'CA', vendor_name
    FROM vendors
    UNION
    SELECT 'Outside CA', vendor_name
    FROM vendors
    ORDER BY vendor_name
	;
END$$
DELIMITER ;

CALL sp_Champter_4_Exercise_7();
