--SQLQuery1-INSERT Schedule PV_319_OOP C++ add.sql
USE SPU_411_Import;

DECLARE @group		AS	INT		= (SELECT group_id		FROM Groups			WHERE group_name	=	N'PV_319');
DECLARE @discipline	AS	SMALLINT= (SELECT discipline_id	FROM Disciplines	WHERE discipline_name LIKE N'Объектно%C++');
DECLARE @discipline_name AS NVARCHAR(150) = (SELECT discipline_name FROM Disciplines WHERE discipline_id = @discipline);
DECLARE @number_of_lessons AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @discipline);
DECLARE @lesson_number AS INT	= 50;
DECLARE @teacher	AS	SMALLINT= (SELECT teacher_id	FROM Teachers		WHERE last_name		=	N'Ковтун');
DECLARE @start_date AS	DATE	= N'2024-08-13';
DECLARE @date		AS	DATE	= @start_date;
DECLARE @start_time	AS	TIME	= N'18:30';
DECLARE @time		AS	TIME;
DECLARE @day_in_week AS	TINYINT;

PRINT	@group;
PRINT	@discipline;
PRINT	@discipline_name;
PRINT	@number_of_lessons;
PRINT	@teacher;
PRINT	@date;
PRINT	@start_time;

WHILE (@lesson_number < @number_of_lessons)
BEGIN
		SET @day_in_week = 1;
		WHILE (@day_in_week <= 3)
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
			IF @day_in_week <= 2 SET @date = DATEADD(DAY, 2, @date);
			SET @day_in_week = @day_in_week + 1;
		END
		SET @date = DATEADD(DAY, 3, @date);
END
;