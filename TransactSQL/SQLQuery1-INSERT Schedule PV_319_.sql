--SQLQuery1-INSERT Schedule PV_319_.sql
USE SPU_411_Import;

DECLARE @group		AS	INT		= (SELECT group_id		FROM Groups			WHERE group_name	=	N'PV_319');
DECLARE @discipline	AS	SMALLINT= (SELECT discipline_id	FROM Disciplines	WHERE discipline_name LIKE N'Сетевое%');
DECLARE @discipline_name AS NVARCHAR(150) = (SELECT discipline_name FROM Disciplines WHERE discipline_id = @discipline);
DECLARE @number_of_lessons AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @discipline);
DECLARE @lesson_number AS INT	= 0;
DECLARE @teacher	AS	SMALLINT= (SELECT teacher_id	FROM Teachers		WHERE last_name		=	N'Ковтун');
DECLARE @start_date AS	DATE	= N'2025-03-20';
SET DATEFIRST 1;
DECLARE @week_day AS INT		= (SELECT DATEPART(weekday, @start_date));
DECLARE @date		AS	DATE	= @start_date;
DECLARE @start_time	AS	TIME	= N'18:30';
DECLARE @time		AS	TIME;
DECLARE @day_in_week AS TINYINT;

PRINT	@group;
PRINT	@discipline;
PRINT	@discipline_name;
PRINT	@number_of_lessons;
PRINT	@teacher;
PRINT	@date;
PRINT	@week_day;
PRINT	@start_time;

IF @week_day = 2 SET @day_in_week = 1;
IF @week_day = 4 SET @day_in_week = 2;
IF @week_day = 6 SET @day_in_week = 3;

WHILE (@lesson_number < @number_of_lessons)
BEGIN
		WHILE (@day_in_week <= 3)
		BEGIN
			IF (@date NOT IN (SELECT [date] FROM DaysOFF))
			BEGIN
				PRINT (N'--------------------------------------');
				SET @lesson_number = @lesson_number + 1;
				IF @lesson_number > @number_of_lessons BREAK;
				PRINT @date;
				PRINT (FORMATMESSAGE(N'Урок %i, дисципдина: %s', @lesson_number, @discipline_name));
				SET @time = @start_time;
				PRINT @time;
				INSERT	Schedule
						([group],	discipline,		teacher,	[date],	[time],	spent)
				VALUES	(@group,	@discipline,	@teacher,	@date,	@time, IIF(@date<GETDATE(),1,0));
				------------------------------------------------
				SET @lesson_number = @lesson_number + 1;
				PRINT (FORMATMESSAGE(N'Урок %i, дисципдина: %s', @lesson_number, @discipline_name));
				SET @time = DATEADD(MINUTE, 95, @time);
				PRINT @time;
				INSERT	Schedule
						([group],	discipline,		teacher,	[date],	[time],	spent)
				VALUES	(@group,	@discipline,	@teacher,	@date,	@time, IIF(@date<GETDATE(),1,0));
			END;
			IF (@day_in_week <= 2) SET @date = DATEADD(DAY, 2, @date);
			SET @day_in_week = @day_in_week + 1;
		END;
		SET @date = DATEADD(DAY, 3, @date);
		SET @day_in_week = 1;
END
;

--DELETE FROM Schedule
--WHERE		[group] = @group
--AND			discipline = @discipline
--;