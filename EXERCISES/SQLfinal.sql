/*
	ASSIGNMENT: 	final_database
    AUTHOR: 		Ryan Paradee
    DATE CREATED:	2022-12-01
	DESCRIPTION: 	database for checking courses and whatnot
*/


/*dropping and establishing the database*/

DROP DATABASE IF EXISTS sc;
CREATE DATABASE sc;

/*select the database*/

USE sc;


/*create tables*/

CREATE TABLE students
(
	student_id		INT				NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT
    , last_name		VARCHAR(100)	NOT NULL
    , first_name	VARCHAR(50)		NOT NULL
    , dob			DATE			NOT NULL
    , sat_score		INT				
);

CREATE TABLE professors
(
	professor_id	INT				NOT NULL	PRIMARY KEY		AUTO_INCREMENT
    , last_name		VARCHAR(100)	NOT NULL
    , first_name	VARCHAR(50)		NOT NULL
    , degree_list	VARCHAR(255)	
);

CREATE TABLE curriculum
(
	course_seq_num	INT				NOT NULL	PRIMARY KEY		AUTO_INCREMENT
    , course_id		INT				NOT NULL	
    , course_name	VARCHAR(50)		NOT NULL
    , credit_hours	INT
);

CREATE TABLE courses
(
	student_id			INT				NOT NULL
    , professor_id		INT				NOT NULL
    , course_seq_num	INT				NOT NULL
    , grade						VARCHAR(1)
   
 , CONSTRAINT courses_fk_students
 FOREIGN KEY (student_id)
 REFERENCES students(student_id)
 , CONSTRAINT courses_fk_professors
 FOREIGN KEY (professor_id)
 REFERENCES professors(professor_id)
 , CONSTRAINT courses_fk_curriculum
 FOREIGN KEY (course_seq_num)
 REFERENCES curriculum(course_seq_num)
);

CREATE INDEX idx_curriculum_course_id
ON curriculum(course_id);

CREATE TABLE student_courses
(
	student_id		INT				NOT NULL
    , course_id		INT				NOT NULL
    
, CONSTRAINT student_courses_fk_students
FOREIGN KEY (student_id)
REFERENCES students(student_id)
, CONSTRAINT student_courses_fk_curriculum
FOREIGN KEY (course_id)
REFERENCES curriculum(course_id)
);


/*insert values into the tables*/

INSERT INTO students VALUES

(1, 'Doe', 'John', '2000-10-11', 1360),
(2, 'Dingle', 'Quandale', '2002-03-22', 1150),
(3, 'Nisha', 'Aqua', '1999-06-19', 920),
(4, 'Frudd', 'Michael', '2001-09-11', 1090),
(5, 'Matthews', 'Brandon', '2003-01-04', 1440),
(6,'Kidd','Bradley','1987-10-07',1300),
(7,'Davies','George','1990-09-01', 1250),
(8,'Petty','Nylah','1994-03-13',400),
(9,'Nash','Reilly','2001-04-19',850),
(10,'Waters','Bentley','2001-06-10',1440),
(11,'Green','Dylan','1999-08-19',1120),
(12,'Wu','Sariah','1991-01-27',1280),
(13,'Lee','Tommy','1993-12-22',1320),
(14,'Malone','Erik','2001-02-03',1080),
(15,'Williamson','Luz','2000-01-23',900),
(16,'Glass','Willie','1995-08-23',980),
(17,'Kopf','Mike','1994-05-17',760),
(18,'Tinnes','Skylor','1989-09-18',1580),
(19,'Salih','Pasil','2002-09-30',1200),
(20,'Soils','Landon','2002-02-12',1350),
(21,'Sobolik','Madison','1995-08-29',1260),
(22,'Bauwens','Mia','1991-01-18',1440),
(23,'Holmes','Ana','1990-06-17',1600),
(24,'Mora','Nelson','2002-11-06',1590),
(25,'Simpson','Homer','1999-03-26',1330),
(26,'Marsh','Stan','2001-02-14',1220),
(27,'Itadori','Yuji','2000-12-28',1220),
(28,'Yeager','Eren','2000-05-08',780),
(29,'Cannon','Jenna','1999-06-04',500),
(30,'Summers','Janet','1999-07-16',570),
(31,'Parks','Nigel','1989-05-27',1220),
(32,'Blake','Andy','2004-10-06',1260),
(33,'Duke','India','1999-05-29',1320),
(34,'Miller','Lea','1998-04-23',1110),
(35,'Swanson','Joe','1992-04-07',1220),
(36,'Church','Tiffany','1989-01-28',1280),
(37,'Franco','Isabele','2002-03-30',1090),
(38,'Bonilla','Todd','1998-04-22',1080),
(39,'Wells','Joshua','1995-08-09',1290),
(40,'Ali','Chance','1993-05-17',1520),
(41,'Mcpherson','Jessica','1988-12-22',1260),
(42,'Burton','Carlo','1987-03-06',1570),
(43,'Preston','Nicole','1990-05-22',1290),
(44,'Ellis','Augustin','1993-09-16',1240),
(45,'Mason','Haven','2001-09-09',1440),
(46,'Yu','Lana','1993-05-11',1290),
(47,'Klein','Kaitlin','1990-11-08',1200),
(48,'Dunn','Michael','1989-05-06',1100),
(49,'Cortez','Molly','1999-05-31',1600),
(50,'Copeland','Alex','1992-08-28',1250),
(51,'Santiago','Frank','1991-08-10',1550),
(52,'Marks','Halle','1989-12-01',1310),
(53,'Reid','Macie','1986-08-05',1510),
(54,'Kerr','Juliet','2002-06-11',1330),
(55,'Marsh','Randy','1989-12-24',1550),
(56,'Wu','Rodrigo','1994-02-20',1230),
(57,'Herman','Justice','1995-04-10',1540),
(58,'Ritter','Franco','2004-07-05',1490),
(59,'Mosley','Omar','1999-09-23',1380),
(60,'Parker','Tabitha','1997-02-11',1290),
(61,'Guzman','Colby','1994-11-10',1220),
(62,'Duffy','Charles','2004-07-29',1600),
(63,'Walters','Benjamin','2002-01-06',1210),
(64,'Ball','Aryana','1986-12-20',1530),
(65,'Novak','Caden','1986-06-06',1000),
(66,'Hansen','Aidan','1986-01-03',450),
(67,'Ford','Tom','1999-01-26',900),
(68,'Giancarlo','Robert','1993-02-02',760),
(69,'Hugh','Clayton','2002-08-21',1060);

INSERT INTO professors VALUES
(1,'Smith','Robert','Math'),
(2,'Kirpes','James','Computer Science'),
(3,'Patterson','Laura','Psychology '),
(4,'Parker','Jonothan','Biology '),
(5,'Gonzolas','Aaron','Software Engineering'),
(6,'James','Donald','Communications'),
(7,'Stewart','Andrew','Business'),
(8,'Baily','Clarence','Nursing '),
(9,'Phipps','Dave','Theater'),
(10,'Price','Andrew','Economics'),
(11,'Harris','Ryan','English Language and Literature');

INSERT INTO curriculum VALUES
(1,11,'Math',4),
(2,22,'Computer Science',4),
(3,33,'Psychology',4),
(4,44,'Biology',4),
(5,55,'Software Engineering',4),
(6,66,'Communications',4),
(7,77,'Business',3),
(8,88,'Nursing',4),
(9,99,'Theater',4),
(10,1010,'Economics',4),
(11,1111,'English Language and Literature',4);


INSERT INTO courses VALUES
(1,1,1,'F'),
(2,2,2,'A'),
(3,3,3,'D'),
(4,4,4,'D'),
(5,5,5,'A'),
(6,6,6,'A'),
(7,7,7,'A'),
(8,8,8,'A'),
(9,9,9,'A'),
(10,10,10,'A'),
(11,11,11,'A'),
(12,1,1,'C'),
(13,2,2,'A'),
(14,3,3,'A'),
(15,4,4,'D'),
(16,5,5,'C'),
(17,6,6,'B'),
(18,7,7,'A'),
(19,8,8,'C'),
(20,9,9,'B'),
(21,10,10,'D'),
(22,11,11,'A'),
(23,1,1,'F'),
(24,2,2,'A'),
(25,3,3,'A'),
(26,4,4,'F'),
(27,5,5,'A'),
(28,6,6,'D'),
(29,7,7,'A'),
(30,8,8,'C'),
(31,9,9,'A'),
(32,10,10,'C'),
(33,11,11,'B'),
(34,1,1,'B'),
(35,2,2,'A'),
(36,3,3,'B'),
(37,4,4,'A'),
(38,5,5,'A'),
(39,6,6,'A'),
(40,7,7,'D'),
(41,8,8,'D'),
(42,9,9,'D'),
(43,10,10,'B'),
(44,11,11,'C'),
(45,1,1,'C'),
(46,2,2,'A'),
(47,3,3,'A'),
(48,4,4,'D'),
(49,5,5,'D'),
(50,6,6,'A'),
(51,7,7,'A'),
(52,8,8,'A'),
(53,9,9,'B'),
(54,10,10,'A'),
(55,11,11,'C'),
(56,1,1,'D'),
(57,2,2,'F'),
(58,3,3,'B'),
(59,4,4,'F'),
(60,5,5,'D'),
(61,6,6,'D'),
(62,7,7,'C'),
(63,8,8,'C'),
(64,9,9,'A'),
(65,10,10,'A'),
(66,11,11,'A'),
(67,1,1,'A'),
(68,2,2,'C'),
(69,3,3,'B');

/*views to see which particular student has which letter grade*/

CREATE VIEW view_grade_inquiry_F AS 
SELECT s.first_name,
		s.last_name,
        c.grade
FROM students s
INNER JOIN courses c ON s.student_id = c.student_id
WHERE grade = 'F';

CREATE VIEW view_grade_inquiry_D AS 
SELECT s.first_name,
		s.last_name,
        c.grade
FROM students s
INNER JOIN courses c ON s.student_id = c.student_id
WHERE grade = 'D';

CREATE VIEW view_grade_inquiry_C AS 
SELECT s.first_name,
		s.last_name,
        c.grade
FROM students s
INNER JOIN courses c ON s.student_id = c.student_id
WHERE grade = 'C';

CREATE VIEW view_grade_inquiry_B AS 
SELECT s.first_name,
		s.last_name,
        c.grade
FROM students s
INNER JOIN courses c ON s.student_id = c.student_id
WHERE grade = 'B';

CREATE VIEW view_grade_inquiry_A AS 
SELECT s.first_name,
		s.last_name,
        c.grade
FROM students s
INNER JOIN courses c ON s.student_id = c.student_id
WHERE grade = 'A';

INSERT INTO student_courses VALUES
(1,11),
(2,22),
(3,33),
(4,44),
(5,55),
(6,66),
(7,77),
(8,88),
(9,99),
(10,1010),
(11,1111),
(12,11),
(13,22),
(14,33),
(15,44),
(16,55),
(17,66),
(18,77),
(19,88),
(20,99),
(21,1010),
(22,1111),
(23,11),
(24,22),
(25,33),
(26,44),
(27,55),
(28,66),
(29,77),
(30,88),
(31,99),
(32,1010),
(33,1111),
(34,11),
(35,22),
(36,33),
(37,44),
(38,55),
(39,66),
(40,77),
(41,88),
(42,99),
(43,1010),
(44,1111),
(45,11),
(46,22),
(47,33),
(48,44),
(49,55),
(50,66),
(51,77),
(52,88),
(53,99),
(54,1010),
(55,1111),
(56,11),
(57,22),
(58,33),
(59,44),
(60,55),
(61,66),
(62,77),
(63,88),
(64,99),
(65,1010),
(66,1111),
(67,11),
(68,22),
(69,33);

/*views to see who is in each class/curriculum and who is the professor for the class/curriculum*/

CREATE VIEW view_math AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'Math';

CREATE VIEW view_computer_science AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'Computer Science';

CREATE VIEW view_psychology AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'Psychology';

CREATE VIEW view_biology AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'Biology';

CREATE VIEW view_software_engineering AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'Software Engineering';

CREATE VIEW view_communications AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'Communications';

CREATE VIEW view_business AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'Business';

CREATE VIEW view_nursing AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'Nursing';

CREATE VIEW view_theater AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'Theater';

CREATE VIEW view_economics AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'Economics';

CREATE VIEW view_english AS
SELECT sc.student_id
	, s.first_name
    , s.last_name
	, c.course_name
    , p.last_name AS 'professor_name'
FROM student_courses sc
INNER JOIN students s ON sc.student_id = s.student_id
INNER JOIN courses q ON sc.student_id = q.student_id
INNER JOIN professors p ON q.professor_id = p.professor_id
INNER JOIN curriculum c ON sc.course_id = c.course_id
WHERE course_name = 'English Language and Literature';



/*audit triggers for students table and professors table*/

DELIMITER //

CREATE TABLE students_audit
(
	student_id		INT				NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT
    , last_name		VARCHAR(100)	NOT NULL
    , first_name	VARCHAR(50)		NOT NULL
    , dob			DATE			NOT NULL
    , sat_score		INT				
);


CREATE TRIGGER tr_students_after_insert 
AFTER INSERT ON students 
FOR EACH ROW 
BEGIN
 INSERT INTO students_audit VALUES
(NEW.student_id, NEW.last_name, NEW.first_name, NEW.dob, NEW.sat_score, 'INSERTED', NOW());
END//


CREATE TABLE professors_audit
(
	professor_id	INT				NOT NULL	PRIMARY KEY		AUTO_INCREMENT
    , last_name		VARCHAR(100)	NOT NULL
    , first_name	VARCHAR(50)		NOT NULL
    , degree_list	VARCHAR(255)	
);

CREATE TRIGGER tr_professors_after_insert 
AFTER INSERT ON professors 
FOR EACH ROW 
BEGIN
 INSERT INTO professors_audit VALUES
(NEW.professor_id, NEW.last_name, NEW.first_name, NEW.degree_list, 'INSERTED', NOW());
END//
DELIMITER ;

SET FOREIGN_KEY_CHECKS=0;
/*start of stored procedures*/

USE sc;
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_sc_stored_procedure_1$$
CREATE PROCEDURE sp_sc_stored_procedure_1()
COMMENT 'stored procedure 1'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	SQLfinal.sql
		DESCRIPTION:
		--
		 This stored procedure will update a student's sat score due to an external error. 
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-12-05	Ryan Paradee			Initial Creation
	*/
	SELECT * 
    FROM students
    WHERE student_id = 30;
    
    UPDATE students 
	SET sat_score = '1440'
	WHERE student_id = 30;
END$$
DELIMITER ;
CALL sp_sc_stored_procedure_1();


USE sc;
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_sc_stored_procedure_2$$
CREATE PROCEDURE sp_sc_stored_procedure_2()
COMMENT 'stored procedure 2'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	SQLfinal.sql
		DESCRIPTION:
		--
			This stored procedure will replace a professor
            who has since been fired for disorderly conduct
            with another student.
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-12-05	Ryan Paradee			Initial Creation
	*/
	UPDATE professors
    SET last_name = 'West',
		first_name = 'Kanye'
	WHERE professor_id = 7;
END$$
DELIMITER ;
CALL sp_sc_stored_procedure_2();

USE sc;
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_sc_stored_procedure_3$$
CREATE PROCEDURE sp_sc_stored_procedure_3()
COMMENT 'stored procedure 3'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	SQLfinal.sql
		DESCRIPTION:
		--
		This stored procedure will update the credit hours column to 
		have the business course give 4 credit hours instead of 3 
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-12-05	Ryan Paradee			Initial Creation
	*/
	
		UPDATE curriculum 
		SET credit_hours = 4
		WHERE course_id = 77;
	
END$$
DELIMITER ;
CALL sp_sc_stored_procedure_3();

USE sc;
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_sc_stored_procedure_4$$
CREATE PROCEDURE sp_sc_stored_procedure_4()
COMMENT 'stored procedure 4'
BEGIN
	/*
		Copyright statement
		Author: Ryan Paradee
		File:	SQLfinal.sql
		DESCRIPTION:
		--
		This stored procedure will remove students from the database who have
		an F in their course
		--
		Modification History
		Date modified - Who did it - what was modified
		2022-12-05	Ryan Paradee			Initial Creation
	*/
	
		DELETE FROM courses 
		WHERE grade = 'F';
	
END$$
DELIMITER ;
CALL sp_sc_stored_procedure_4();



    



