--SQLQuery0-CHECK PROCEDURES.sql
SET DATEFIRST 1;
USE SPU_411_Import;
--SET LANGUAGE N'Russian';

--DECLARE @discipline AS NVARCHAR(150) = N'Объект%C++';
--EXEC sp_InsertScheduleSemistacionarInClass N'SPU_411', @discipline, N'Ковтун';
--EXEC sp_InsertScheduleSemistacionar N'SPU_411', @discipline, N'2024-10-26', N'10:00';
--EXEC sp_SelectScheduleFull;
--EXEC sp_SelectSchedule N'PV_319', N'Процедурное%C++';
--EXEC sp_InsertScheduleSemistacionarInClass N'SPU_411', @discipline, N'Свищев';
--EXEC sp_DeleteDiscipline N'SPU_411', @discipline;
--EXEC sp_SelectSchedule N'SPU_411', @discipline;

--DELETE FROM Schedule
--	WHERE		[group] = (SELECT group_id			FROM Groups			WHERE group_name = N'SPU_411');

--DELETE FROM DaysOFF WHERE [date] BETWEEN N'2025-12-20' AND N'2026-12-31';
EXEC sp_AddAllHolidaysFor 2026;
SELECT
	[date], holiday_name
FROM	DaysOFF JOIN Holidays ON (holiday = holiday_id)
WHERE	[date] BETWEEN N'2025-12-20' AND N'2026-12-31';