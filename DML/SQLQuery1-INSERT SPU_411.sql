--SQLQuery1-INSERT SPU_411.sql
USE SPU_411_Import;

--UPDATE	Disciplines
--SET		number_of_lessons = 21 WHERE discipline_id = 44;


--INSERT Disciplines
--		(discipline_id,	discipline_name,														number_of_lessons)
--VALUES	(40,			N'Основы Информационных технологий (п/с)',								12),
--		(41,			N'Основы программирования на языке C++ (п/с)',							35),
--		(42,			N'Конфигурирование Windows 10 (п/с)',									15),
--		(43,			N'ООП с использованием языка C++ Базовый (п/с)',						6),
--		(44,			N'ООП с использованием языка C++ (п/с)',								21),
--		(45,			N'ООП.Язык UML и паттерны проектирования (п/с)',						9),
--		(46,			N'Платформа Microsoft .NET и язык программирования C# (п/с)',			18),
--		(47,			N'Основы разработки приложений с использованием Windows Forms (п/с)',	15),
--		(48,			N'Теория Баз Данных (п/с)',												9),
--		(49,			N'Технология доступа к базам данных ADO.NET (п/с)',			12),
--		(50,			N'Системное программирование (п/с)',									9),
--		(51,			N'Сетевое программирование (п/с)',										9),
--		(52,			N'Курсовой проект по .NET Framework (п/с',								3),
--		(53,			N'Командный проект и управление программными проектами (п/с)',			6);

--INSERT TeachersDisciplinesRelation
--		(teacher,	discipline)
--VALUES	(4,			40),
--		(4,			42),
--		(1,			41);
--DECLARE @discipline_id AS SMALLINT = 43;
--WHILE (@discipline_id <=53)
--BEGIN
--	INSERT TeachersDisciplinesRelation
--			(teacher,	discipline)
--	VALUES	(1,			@discipline_id);
--	SET @discipline_id = @discipline_id + 1;
--END;

--DECLARE @discipline_id AS SMALLINT = 40;
--WHILE (@discipline_id <=53)
--BEGIN
--	INSERT DisciplinesDirectionsRelation
--			(direction,	discipline)
--	VALUES	(1,			@discipline_id);
--	SET @discipline_id = @discipline_id + 1;
--END;