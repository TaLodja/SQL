--SQLQuery1-INSERT Schedule SPU_411.sql
USE SPU_411_Import;

DECLARE @group		AS INT				= (SELECT group_id			FROM Groups		 WHERE group_name		= N'SPU_411');
DECLARE @discipline AS	SMALLINT		= (SELECT discipline_id		FROM Disciplines WHERE discipline_name	LIKE N'Курсовой проект%');
DECLARE @discipline_name AS VARCHAR(150)= (SELECT discipline_name	FROM Disciplines WHERE discipline_id	=	@discipline);
DECLARE @number_of_lessons AS TINYINT	= (SELECT number_of_lessons FROM Disciplines WHERE discipline_id	=	@discipline);
DECLARE @lesson_number AS INT			= 0;
DECLARE @teacher	AS	SMALLINT		= (SELECT teacher_id		FROM Teachers	 WHERE last_name		= N'Ковтун');
DECLARE @start_date AS	DATE			= N'2026-01-24';
DECLARE @date		AS	DATE			= @start_date;
DECLARE @start_time	AS	TIME			= N'8:00';
DECLARE @time		AS	TIME;
DECLARE	@end_time	AS	TIME;

PRINT	@group;
PRINT	@discipline;
PRINT	@discipline_name;
PRINT	@number_of_lessons;
PRINT	@teacher;
PRINT	@date;

--IF (@date = '2025-04-19')
--		BEGIN
--			SET @lesson_number = @lesson_number + 1;
--			PRINT FORMATMESSAGE(N'Урок %i, дисциплина: %s', @lesson_number, @discipline_name);
--			SET @time = DATEADD(MINUTE, 95, @time);
--			PRINT @time;
--			INSERT	Schedule
--					([group],	discipline,		teacher,	[date], [time], spent)
--			VALUES	(@group,	@discipline,	@teacher,	@date,	@time,	IIF(@date<GETDATE(),1,0));
--			SET @date = DATEADD(DAY, 7, @date);
--		END;

WHILE (@lesson_number < @number_of_lessons)
BEGIN
	IF @date NOT IN ('2025-01-04', '2025-02-22', '2025-03-08', '2025-07-12', '2025-08-02', '2025-08-09', '2025-11-01', '2026-01-03')
	BEGIN
		PRINT (N'-----------------------------');
		SET @lesson_number = @lesson_number + 1;
		IF @lesson_number > @number_of_lessons BREAK;
		PRINT @date;
		PRINT FORMATMESSAGE(N'Урок %i, дисциплина: %s', @lesson_number, @discipline_name);
		SET @time = @start_time;
		SET @end_time = DATEADD(MINUTE, 120, @time);
		PRINT @time;
		INSERT	Schedule
				([group],	discipline,		teacher,	[date], [time], spent)
		VALUES	(@group,	@discipline,	@teacher,	@date,	@time,	IIF(@date<GETDATE(),1,0));
		------------------------------------
		SET @lesson_number = @lesson_number + 1;
		IF @lesson_number > @number_of_lessons BREAK;
		PRINT FORMATMESSAGE(N'Урок %i, дисциплина: %s', @lesson_number, @discipline_name);
		SET @time = DATEADD(MINUTE, 95, @time);
		SET @end_time = DATEADD(MINUTE, 120, @time);
		PRINT @time;
		INSERT	Schedule
				([group],	discipline,		teacher,	[date], [time], spent)
		VALUES	(@group,	@discipline,	@teacher,	@date,	@time,	IIF(@date<GETDATE(),1,0));
		------------------------------------
		SET @lesson_number = @lesson_number + 1;
		IF @lesson_number > @number_of_lessons BREAK;
		PRINT FORMATMESSAGE(N'Урок %i, дисциплина: %s', @lesson_number, @discipline_name);
		SET @time = DATEADD(MINUTE, 95, @time);
		SET @end_time = DATEADD(MINUTE, 120, @time);
		PRINT @time;
		INSERT	Schedule
				([group],	discipline,		teacher,	[date], [time], spent)
		VALUES	(@group,	@discipline,	@teacher,	@date,	@time,	IIF(@date<GETDATE(),1,0));
		--------------------------------------
		IF (@date <= '2025-02-08') SET @date = DATEADD(DAY, 14, @date);
		ELSE	SET @date = DATEADD(DAY, 7, @date);
		IF @date = '2025-01-11'	SET @date = DATEADD(DAY, 7, @date);
	END;
	ELSE SET @date = DATEADD(DAY, 7, @date);
END;

--DELETE FROM Schedule
--WHERE		[group] = @group
--AND			discipline = @discipline
--;

--UPDATE	Schedule
--SET		[time] = '10:00' WHERE [date] = '2025-04-19';