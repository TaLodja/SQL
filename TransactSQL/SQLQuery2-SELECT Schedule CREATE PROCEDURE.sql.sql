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
			[Время]			=		[time],
			[Дисциплина]	=		discipline_name,
			[Преподаватель]	=		FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
			[Статус]		=		IIF(spent=1, N'Ïðîâåäåíî', N'Çàïëàíèðîâàíî')
	FROM	Schedule
	JOIN	Groups			ON		[group]=group_id
	JOIN	Disciplines		ON		discipline=discipline_id
	JOIN	Teachers		ON		teacher=teacher_id
END