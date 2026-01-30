--SQLQuery2-SELECT Schedule CREATE PROCEDURE.sql.sql
USE SPU_411_Import;
GO

--CREATE PROCEDURE sp_SelectScheduleFull
ALTER PROCEDURE sp_SelectScheduleFull
AS
BEGIN
	SELECT
			[Группа]		=		group_name,
			[Дата]			=		[date],
			[День недели]	=	(SELECT CASE DATEPART(dw, [date])
								WHEN	1 THEN N'Вс'
								WHEN	2 THEN N'Пн'
								WHEN	3 THEN N'Вт'
								WHEN	4 THEN N'Ср'
								WHEN	5 THEN N'Чт'
								WHEN	6 THEN N'Пт'
								WHEN	7 THEN N'Сб'
								END AS DayOfWeek),
			[Время]			=		[time],
			[Дисциплина]	=		discipline_name,
			[Преподаватель]	=		FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
			[Статус]		=		IIF(spent=1, N'Проведено', N'Запланировано')
	FROM	Schedule
	JOIN	Groups			ON		[group]=group_id
	JOIN	Disciplines		ON		discipline=discipline_id
	JOIN	Teachers		ON		teacher=teacher_id
END