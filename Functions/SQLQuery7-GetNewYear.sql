--SQLQuery7-GetNewYear.sql
SET DATEFIRST 1;
USE SPU_411_Import;
GO

--CREATE 
ALTER
		FUNCTION GetNewYear(@year AS SMALLINT) RETURNS DATE
BEGIN
	DECLARE @new_year_date	AS DATE		= DATEFROMPARTS(@year,1,1);
	DECLARE @weekday		AS TINYINT	= DATEPART(WEEKDAY, @new_year_date);
	DECLARE @start_date		AS DATE		= DATEADD(DAY, -@weekday+1, @new_year_date);
	IF @weekday = 1 SET @start_date = DATEADD(DAY, -2, @new_year_date);
	IF @weekday = 7 SET @start_date = DATEADD(DAY, -1, @new_year_date);
	RETURN @start_date;
END