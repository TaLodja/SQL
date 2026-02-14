--SQLQuery1-INSERT ScheduleSemi PROCEDURE.sql
USE SPU_411_Import;
GO

--CREATE 
ALTER
		PROCEDURE sp_InsertScheduleSemistacionarInClass
	 @group_name		AS	NVARCHAR(24)
	,@discipline_name	AS	NVARCHAR(150)
	,@teacher			AS	NVARCHAR(50)
AS
BEGIN
	DECLARE @group_id			AS	INT		=	(SELECT group_id		FROM Groups		 WHERE group_name=@group_name);
	DECLARE @discipline_id		AS	SMALLINT=	(SELECT discipline_id	FROM Disciplines WHERE discipline_name LIKE @discipline_name);
	DECLARE @number_of_lessons	AS	TINYINT =	(SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_id);
	DECLARE @lesson_number		AS	TINYINT	=	(SELECT COUNT(discipline) FROM Schedule WHERE [group] = @group_id AND discipline = @discipline_id);
	--IF @lesson_number = 0 SET @lesson_number = 1;
	DECLARE @teacher_id			AS	SMALLINT=	(SELECT teacher_id		FROM Teachers	 WHERE last_name = @teacher);
--	DECLARE @start_date			AS	DATE	=	dbo.GetNextDate(@group_name);
	DECLARE @date				AS	DATE	=	dbo.GetLastDate(@group_name);
	DECLARE @start_time			AS	TIME	=	(SELECT start_time		FROM Groups		 WHERE group_id=@group_id);
	DECLARE @time				AS	TIME	=	@start_time;

	IF @date IS NULL SET @date = (SELECT start_date FROM Groups WHERE group_id=@group_id);

	PRINT '--------------------------------------------------------------------';
	PRINT @group_id;
	PRINT @discipline_id;
	PRINT @teacher;
	PRINT @date;
	PRINT @time;
	PRINT @lesson_number;
	PRINT '--------------------------------------------------------------------';

	WHILE @lesson_number < @number_of_lessons
	BEGIN
		IF dbo.GetLastDate(@group_name) IS NOT NULL SET @date = dbo.GetNextDate(@group_name);
		SET @time = @start_time;
		EXEC sp_InsertLesson @group_id, @discipline_id, @teacher_id, @date, @time OUTPUT, @lesson_number OUTPUT;
		--SET @time = DATEADD(MINUTE,  95,@time);
		EXEC sp_InsertLesson @group_id, @discipline_id, @teacher_id, @date, @time OUTPUT, @lesson_number OUTPUT;
		--SET @time = DATEADD(MINUTE,  95,@time);
		EXEC sp_InsertLesson @group_id, @discipline_id, @teacher_id, @date, @time OUTPUT, @lesson_number OUTPUT;
		--https://stackoverflow.com/questions/11632831/incorrect-syntax-near-minute-when-passing-expression-to-stored-procedure
		PRINT @lesson_number;
		PRINT '======================================================'
	END
END

--BEGIN
--	DECLARE @group_id			AS INT		= (SELECT group_id			FROM Groups			WHERE group_name = @group_name);
--	DECLARE @discipline_id		AS SMALLINT = (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
--	DECLARE @teacher_id			AS SMALLINT = (SELECT teacher_id		FROM Teachers		WHERE last_name = @teacher);
--	--DECLARE @start_date			AS DATE		= dbo.GetNextDate(@group_name);
--	DECLARE @date				AS DATE		= dbo.GetLastDate(@group_name);
--	DECLARE @start_time			AS TIME		= (SELECT start_time		FROM Groups			WHERE group_id = @group_id);
--	DECLARE @time				AS TIME		= @start_time;
--	DECLARE @number_of_lessons	AS TINYINT	= (SELECT number_of_lessons FROM Disciplines	WHERE discipline_id = @discipline_id);
--	DECLARE @pair_number		AS TINYINT	= 1;
--	DECLARE @recorded_lessons	AS TINYINT	= (SELECT COUNT(discipline) FROM Schedule WHERE discipline = @discipline_id AND [group] = @group_id);
--	DECLARE @remaining_lessons	AS TINYINT	= @number_of_lessons - @recorded_lessons;
--	DECLARE @lesson_number		AS INT		= @recorded_lessons + 1;
--
--	IF @date IS NULL SET @date = (SELECT start_date FROM Groups WHERE group_id = @group_id);
--	WHILE @lesson_number <= @number_of_lessons AND @recorded_lessons <= @number_of_lessons
--	BEGIN
--		IF dbo.GetLastDate(@group_name) IS NOT NULL SET @date = dbo.GetNextDate(@group_name);
--		SET @time = @start_time;
--		SET @pair_number = 1;
--		WHILE @pair_number <=3
--		BEGIN
--			IF @lesson_number > @number_of_lessons BREAK;
--			EXEC sp_InsertLesson @group_id, @discipline_id, @teacher_id, @date, @time OUTPUT, @lesson_number OUTPUT;
--			SET @pair_number = @pair_number + 1;
--		END
--	END
--END

--BEGIN
--	DECLARE @group_id			AS INT		= (SELECT group_id			FROM Groups			WHERE group_name = @group_name);
--	DECLARE @discipline_id		AS SMALLINT = (SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
--	DECLARE @teacher_id			AS SMALLINT = (SELECT teacher_id		FROM Teachers		WHERE last_name = @teacher);
--	DECLARE @number_of_lessons	AS TINYINT	= (SELECT number_of_lessons FROM Disciplines	WHERE discipline_id = @discipline_id);
--	DECLARE @lesson_number		AS INT		= 0;
--	DECLARE @start_date			AS DATE		= dbo.GetStartDate(@group_name);
--	DECLARE @date				AS DATE		= @start_date;
--	DECLARE @start_time			AS TIME		= (SELECT start_time		FROM Groups			WHERE group_id = @group_id);
--	DECLARE @time				AS TIME;

--	WHILE (@lesson_number < @number_of_lessons)
--	BEGIN
--		IF (@date NOT IN (SELECT [date] FROM DaysOFF))
--		BEGIN
--			SET @lesson_number = @lesson_number + 1;
--			IF @lesson_number > @number_of_lessons BREAK;
--			SET @time = @start_time;
--			EXEC sp_InsertOneLesson @group_id, @discipline_id, @teacher_id, @date, @time;
--			------------------------------------
--			SET @lesson_number = @lesson_number + 1;
--			IF @lesson_number > @number_of_lessons BREAK;
--			SET @time = DATEADD(MINUTE, 95, @time);
--			EXEC sp_InsertOneLesson @group_id, @discipline_id, @teacher_id, @date, @time;
--			------------------------------------
--			SET @lesson_number = @lesson_number + 1;
--			IF @lesson_number > @number_of_lessons BREAK;
--			SET @time = DATEADD(MINUTE, 95, @time);
--			EXEC sp_InsertOneLesson @group_id, @discipline_id, @teacher_id, @date, @time;
--		END
--		ELSE SET @date = dbo.GetNextDate(@group_name, @date);
--	END
--END