--SQLQuery0-CHECK PROCEDURES.sql
USE SPU_411_Import;
--SET LANGUAGE N'Russian';

DECLARE @discipline AS NVARCHAR(150) = N'Процедурное%C++';
EXEC sp_SelectScheduleFull;
--EXEC sp_SelectSchedule N'PV_319', N'Процедурное%C++';
--EXEC sp_InsertScheduleSemistacionar N'SPU_411', @discipline, N'2024-10-26', N'10:00';
--EXEC sp_DeleteDiscipline N'SPU_411', @discipline;
--EXEC sp_SelectSchedule N'SPU_411', @discipline;