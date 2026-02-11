--SQLQuery2-GetInterval.sql
SET DATEFIRST 1;
USE SPU_411_Import;
GO

--CREATE 
ALTER
		FUNCTION GetInterval (@group_name AS NVARCHAR(24), @last_date AS DATE)
RETURNS SMALLINT
AS
BEGIN
	DECLARE @group_id	AS	INT  = (SELECT group_id FROM Groups WHERE group_name = @group_name);
	DECLARE @interval	AS SMALLINT;
	
	SET @interval = dbo.GetNextDay(@group_name, @last_date) - DATEPART(WEEKDAY, @last_date);
	IF @interval <= 0 SET @interval = @interval + 7;
	
	RETURN @interval;
END