--SQLQuery4-SELECT COUNT Teachers&Disciplines.sql
USE SPU_411_Import;

--Количество преподавателей по каждой дисциплине
--SELECT
--			[Наименование дисциплины] = discipline_name,
--			[Количество преподавателей] = COUNT(CASE WHEN teacher_id = teacher AND discipline_id = discipline THEN 1 END)
--FROM		Teachers, Disciplines, TeachersDisciplinesRelation
--WHERE		discipline = discipline_id
--AND			teacher = teacher_id
--OR			discipline_id NOT IN (SELECT discipline  FROM TeachersDisciplinesRelation)
--GROUP BY	discipline_name
--ORDER BY	[Наименование дисциплины]
--;

IF NOT EXISTS (SELECT last_name FROM Teachers WHERE last_name=N'Бандерас')
INSERT Teachers
		(teacher_id,	last_name,		first_name, birth_date)
VALUES
		(9,				N'Бандерас',	N'Антонио',	N'1960-08-10')

--Количество дисциплин, которые может вести каждый преподаватель
SELECT
			[Преподаватель] = FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
			[Количество преподаваемых дисциплин] = COUNT(discipline)
FROM		Teachers, TeachersDisciplinesRelation
WHERE		teacher = teacher_id
GROUP BY	last_name, first_name, middle_name
--;

--Преподаватели, которые не ведут ни одной дисциплины
SELECT
			[Преподаватель] = FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name)
FROM		Teachers, TeachersDisciplinesRelation
WHERE		NOT EXISTS (SELECT teacher FROM TeachersDisciplinesRelation WHERE teacher_id = teacher)
GROUP BY	last_name, first_name, middle_name, teacher_id
;