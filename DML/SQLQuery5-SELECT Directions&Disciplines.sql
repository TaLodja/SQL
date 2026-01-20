--SQLQuery5-SELECT Directions&Disciplines.sql
USE SPU_411_Import;

--Для выбранного направления вывести все дисциплины, которые изучаются на этом направлении;
SELECT
			[Направление обучения] = direction_name,
			[Дисциплина] = discipline_name
FROM		Disciplines, Directions, DisciplinesDirectionsRelation
WHERE		direction = direction_id
AND			discipline = discipline_id
AND			direction_name LIKE N'Сетевые%'
;

--Для выбранной дисциплины выяснить, на каких направлениях она изучается
SELECT
			[Дисциплина] = discipline_name,
			[Направление обучения] = direction_name
FROM		Disciplines, Directions, DisciplinesDirectionsRelation
WHERE		direction = direction_id
AND			discipline = discipline_id
AND			discipline_name LIKE N'Java%'