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
	SET @interval = dbo.GetNextDay(@group_name) - DATEPART(WEEKDAY, @last_date);
	IF @interval <= 0 SET @interval = @interval + 7;
	SET @next_date = DATEADD(DAY, @interval, @last_date);
	RETURN @next_date;
END