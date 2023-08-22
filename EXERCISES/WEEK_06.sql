/*
		Author: Ryan Paradee
		File:	Week 06
		Modification History
		Date modified 	 	Who did it  			what was modified
		2022-10-06			Ryan Paradee			Initial Creation
		
*/
    
/*EXERCISE 1*/

USE ap;
CREATE INDEX ind_vendors_zipcode
ON vendors(vendor_zip_code)
;

/*EXERCISE 2*/

USE ex;
DROP TABLE IF EXISTS ex.members;
CREATE TABLE ex.members
(
member_id 		INT 			NOT NULL	 PRIMARY KEY 	AUTO_INCREMENT	COMMENT 'unique identifier'
, first_name 	VARCHAR(50)		NOT NULL 									COMMENT 'member first name'
, last_name 	VARCHAR(50) 	NOT NULL 									COMMENT 'member last name'
, address 		VARCHAR(50) 	NULL 										COMMENT 'member address'
, city 			VARCHAR(50) 	NULL 										COMMENT 'member city'
, state 		VARCHAR(2) 		NULL 										COMMENT 'member state'
, phone 		VARCHAR(15) 	NULL 										COMMENT 'member phone'
);

DROP TABLE IF EXISTS ex.members_committees;
CREATE TABLE ex.members_committees
(
member_id 		INT 			NOT NULL	 	COMMENT 'unique identifier'
,committee_id 	INT 			NOT NULL	 	COMMENT 'unique identifier'
,CONSTRAINT fk_members_members_id
FOREIGN KEY (member_id)
REFERENCES members(member_id) 

,CONSTRAINT fk_committees_committee_id
FOREIGN KEY (committee_id)
REFERENCES committees(committee_id)
);

DROP TABLE IF EXISTS ex.committees;
CREATE TABLE ex.committees
(
committee_id 		INT 			NOT NULL	 PRIMARY KEY 	AUTO_INCREMENT	COMMENT 'unique identifier'
,committee_name		VARCHAR(50)		NOT NULL									COMMENT 'committee name'
);

/*EXERCISE 3*/

USE ex;

SELECT * 
FROM members
;


INSERT 
INTO members(member_id, first_name, last_name, address, city, state, phone)
VALUES (NULL, 'John', 'Doe', '123 Rockford Dr', 'Chicago', 'IL', '4025552943')
;
/*1 row(s) affected*/

INSERT 
INTO members(member_id, first_name, last_name, address, city, state, phone)
VALUES (NULL, 'Madison', 'Cena', '5223 Monkey Ave', 'Seattle', 'WA', '5825552067')
;
/*1 row(s) affected*/


USE ex;
SELECT *
FROM committees
;


INSERT
INTO committees(committee_id, committee_name)
VALUES(NULL, 'John')
;

/*2 row(s) returned*/

INSERT
INTO committees(committee_id, committee_name)
VALUES(NULL, 'Madison')
;
/*1 row(s) returned*/


/*EXERCISE 4*/

ALTER TABLE members
ADD annual_due 		INT				NOT NULL		DEFAULT '52.50'
;
ALTER TABLE members
ADD payment_date	VARCHAR(15)		NOT NULL
;