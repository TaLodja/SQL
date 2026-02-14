--SQLQuery7-AddAllHolidaysFor.sql
USE SPU_411_Import;
SET DATEFIRST 1;
GO

--CREATE 
ALTER
		PROCEDURE sp_AddAllHolidaysFor	@year	AS	SMALLINT
AS
BEGIN
	EXEC	sp_AddHolidays @year, N'Нов%';
	EXEC	sp_AddHolidays @year, N'23%';
	EXEC	sp_AddHolidays @year, N'8%';
	EXEC	sp_AddHolidays @year, N'Пасха';
	EXEC	sp_AddHolidays @year, N'Май%';
	EXEC	sp_AddHolidays @year, N'Летние%';
	EXEC	sp_AddHolidays @year, N'День%';
END