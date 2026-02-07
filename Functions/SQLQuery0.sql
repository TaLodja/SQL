--SQLQuery0.sql
SET DATEFIRST 1;
USE SPU_411_Import;

PRINT (dbo.GetLastDate(N'PD_212'));
PRINT (dbo.GetNextDay(N'PD_212'));
PRINT (dbo.GetNextDate(N'PD_212'));
PRINT (dbo.GetLastDate(N'PV_319'));
PRINT (dbo.GetNextDay(N'PV_319'));
PRINT (dbo.GetNextDate(N'PV_319'));
PRINT (dbo.GetLastDate(N'SPU_411'));
PRINT (dbo.GetNextDay(N'SPU_411'));
PRINT (dbo.GetNextDate(N'SPU_411'));

--SELECT * FROM Schedule WHERE [group] = 3;