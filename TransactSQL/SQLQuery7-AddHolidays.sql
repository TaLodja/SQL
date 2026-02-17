--SQLQuery7-AddHolidays.sql
USE SPU_411_Import;
SET DATEFIRST 1;
GO

--CREATE 
ALTER
		PROCEDURE sp_AddHolidays
	@year	AS	SMALLINT,
	@id		AS	TINYINT
	--@name	AS	NVARCHAR(150)
AS
BEGIN
	DECLARE
	@name		AS	NVARCHAR(150)	= (SELECT holiday_name FROM Holidays WHERE holiday_id = @id),
	@duration	AS	TINYINT = (SELECT duration		FROM Holidays	WHERE holiday_id = @id);
	--@holiday_id	AS	TINYINT = (SELECT holiday_id	FROM Holidays	WHERE holiday_name LIKE @name);
	DECLARE @start_date	AS	DATE	= dbo.GetHolidaysStartDate(@name, @year);
	DECLARE
	@date		AS	DATE	= @start_date,
	@day		AS	TINYINT	= 0;
	
	WHILE @day < @duration AND @date NOT IN (SELECT [date] FROM DaysOFF)
	BEGIN
		INSERT DaysOFF	([date],holiday)
		VALUES			(@date, @id);
		--VALUES			(@date, @holiday_id);
		SET @day += 1;
		SET @date = DATEADD(DAY, 1, @date);
	END
END