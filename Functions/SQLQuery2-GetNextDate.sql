--SQLQuery2-GetNextDate.sql
SET DATEFIRST 1;
USE SPU_411_Import;
GO

--CREATE 
ALTER
		FUNCTION GetNextDate (@group_name AS NVARCHAR(24))
RETURNS DATE
AS
BEGIN
	DECLARE @group_id	AS	INT  = (SELECT group_id FROM Groups WHERE group_name = @group_name);
	DECLARE @last_date	AS	DATE = dbo.GetLastDate(@group_name);
	DECLARE @next_date	AS	DATE = @last_date;
	DECLARE @interval	AS	SMALLINT;
	SET @next_date = DATEADD(DAY, dbo.GetInterval(@group_id, @last_date), @last_date);
	IF @next_date IN (SELECT [date] FROM DaysOFF)
		WHILE @next_date IN (SELECT [date] FROM DaysOFF)
		BEGIN
			SET @next_date = DATEADD(DAY, dbo.GetInterval(@group_id, @last_date), @last_date);
			SET @last_date = @next_date;
		END
	RETURN @next_date;
END

--SET @interval = dbo.GetNextDay(@group_name, @last_date) - DATEPART(WEEKDAY, @last_date);
--IF @interval <= 0 SET @interval = @interval + 7;
--SET @next_date = DATEADD(DAY, @interval, @last_date);