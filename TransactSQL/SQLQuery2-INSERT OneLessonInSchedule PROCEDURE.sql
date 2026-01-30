--SQLQuery2-INSERT OneLessonInSchedule PROCEDURE.sql
USE SPU_411_Import;
GO

CREATE PROCEDURE sp_InsertOneLesson
	@group			AS INT,
	@discipline		AS SMALLINT,
	@teacher		AS SMALLINT,
	@date			AS DATE,
	@time			AS TIME
AS
BEGIN
	IF NOT EXISTS (SELECT [group] FROM Schedule WHERE [group]=@group AND [date]=@date AND [time]=@time)
	BEGIN
		INSERT	Schedule
				([group],	discipline,		teacher,	[date], [time], spent)
		VALUES	(@group,	@discipline,	@teacher,	@date,	@time,	IIF(@date<GETDATE(),1,0));
	END
END