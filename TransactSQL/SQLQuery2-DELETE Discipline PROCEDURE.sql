--SQLQuery2-DELETE Discipline PROCEDURE.sql
USE SPU_411_Import;
GO

CREATE PROCEDURE sp_DeleteDiscipline
	@group_name			AS NVARCHAR(24),
	@discipline_name	AS NVARCHAR(150)
AS
BEGIN
	DECLARE @group				AS INT		= (SELECT group_id			FROM Groups			WHERE group_name = @group_name);
	DECLARE @discipline			AS SMALLINT = (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
	DELETE FROM Schedule
	WHERE		[group] = @group
	AND			discipline = @discipline;
END