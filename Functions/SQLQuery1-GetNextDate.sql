--SQLQuery1-GetNextDate.sql
SET DATEFIRST 1;
USE SPU_411_Import;
GO

--CREATE 
ALTER
		FUNCTION GetNextDate
	(@group_name		AS NVARCHAR(24))
RETURNS DATE
AS
BEGIN
	DECLARE @group_id	AS	INT  = (SELECT group_id FROM Groups WHERE group_name = @group_name);
	DECLARE @next_date	AS	DATE = dbo.GetLastDate(@group_name);
	IF (DATEPART(WEEKDAY, @next_date)) = dbo.GetNextDay(@group_name)
		SET @next_date = DATEADD(DAY, 1, @next_date);
	WHILE (DATEPART(WEEKDAY, @next_date)) != dbo.GetNextDay(@group_name)
	BEGIN
		SET @next_date = DATEADD(DAY, 1, @next_date);
	END
	RETURN @next_date;
END