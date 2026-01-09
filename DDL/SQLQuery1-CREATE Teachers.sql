--SQLQuery1-CREATE Teachers.sql
USE SPU_411_DDL;

--DROP TABLE Teachets;

CREATE TABLE Teachers
(
	teacher_id		INT				PRIMARY KEY,
	last_name		NVARCHAR(50)	NOT NULL,
	first_name		NVARCHAR(50)	NOT NULL,
	middle_name		NVARCHAR(50),
	birth_day		DATE			NOT NULL,
	rate			MONEY			NOT NULL
);