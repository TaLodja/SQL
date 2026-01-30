--SQLQuery2-INSERT Schedule semistacionar PROCEDURE.sql
USE SPU_411_Import;
GO

--CREATE PROCEDURE sp_InsertScheduleSemistacionar
ALTER PROCEDURE sp_InsertScheduleSemistacionar
	@group_name			AS NVARCHAR(24),
	@discipline_name	AS NVARCHAR(150),
	@start_date			AS DATE,
	@start_time			AS TIME
AS
BEGIN
	DECLARE @group				AS INT		= (SELECT group_id			FROM Groups			WHERE group_name = @group_name);
	DECLARE @discipline			AS SMALLINT = (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
	DECLARE @number_of_lessons	AS TINYINT	= (SELECT number_of_lessons FROM Disciplines	WHERE discipline_id = @discipline);
	DECLARE @lesson_number		AS INT		= 0;
	DECLARE @teacher			AS SMALLINT = (SELECT	CASE WHEN @discipline IN (31, 32, 33, 40, 42)	THEN 4 ELSE 1 END);
	DECLARE @date				AS DATE		= @start_date;
	DECLARE @time				AS TIME;
	
	PRINT @teacher;
	
	WHILE (@lesson_number < @number_of_lessons)
	BEGIN
		IF (@date NOT IN (SELECT [date] FROM DaysOFF))
		BEGIN
			--PRINT (N'-----------------------------');
			--PRINT @date;
			SET @lesson_number = @lesson_number + 1;
			IF @lesson_number > @number_of_lessons BREAK;
			SET @time = @start_time;
			--PRINT @time;
			EXEC sp_InsertOneLesson @group, @discipline, @teacher, @date, @time;
			------------------------------------
			SET @lesson_number = @lesson_number + 1;
			IF @lesson_number > @number_of_lessons BREAK;
			SET @time = DATEADD(MINUTE, 95, @time);
			--PRINT @time;
			EXEC sp_InsertOneLesson @group, @discipline, @teacher, @date, @time;
			------------------------------------
			SET @lesson_number = @lesson_number + 1;
			IF @lesson_number > @number_of_lessons BREAK;
			SET @time = DATEADD(MINUTE, 95, @time);
			--PRINT @time;
			EXEC sp_InsertOneLesson @group, @discipline, @teacher, @date, @time;
			--------------------------------------
			IF (@date <= '2025-02-08') SET @date = DATEADD(DAY, 14, @date);
			ELSE SET @date = DATEADD(DAY, 7, @date);
			IF (@date = '2024-12-28') SET @date = DATEADD(DAY, 14, @date);
		END
		ELSE SET @date = DATEADD(DAY, 7, @date);
	END
END