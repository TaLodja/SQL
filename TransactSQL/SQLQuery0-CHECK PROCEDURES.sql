--SQLQuery0-CHECK PROCEDURES.sql
USE SPU_411_Import;

DECLARE @discipline AS NVARCHAR(150) = N'Основы Информационных%(п/с)';
--EXEC sp_SelectScheduleFull;
--EXEC sp_SelectSchedule N'SPU_411', N'Процедурное%C++';
EXEC sp_InsertScheduleSemistacionar N'SPU_411', @discipline, N'2024-10-19', N'10:00';
--EXEC sp_DeleteDiscipline N'SPU_411', @discipline;
EXEC sp_SelectSchedule N'SPU_411', @discipline;