--SQLQuery1-GetStartDate.sql
USE SPU_411_Import;
GO

--CREATE 
ALTER
		FUNCTION GetStartDate(@group_name AS NVARCHAR(24))
RETURNS DATE
AS
BEGIN
	DECLARE @group_id	AS INT	= (SELECT group_id FROM Groups WHERE group_name = @group_name);
	DECLARE @start_date	AS DATE	= NULL;
	IF	(dbo.GetLastDate(@group_name) = NULL)
		SET @start_date = (SELECT start_date FROM Groups WHERE group_id = @group_id);
	ELSE
		SET @start_date = dbo.GetNextDate(@group_name);
	RETURN @start_date;
END