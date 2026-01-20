--SQLQuery3-SELECT COUNT Groups&Students.sql
USE SPU_411_Import;

--SELECT
--			direction_name		AS N'Направление обучения',
--			COUNT(DISTINCT group_name)	AS N'Количество групп',		--DISTINCT убирает дубликаты и возвращает уникальные значения
--			COUNT(stud_id)		AS N'Количество студентов'
--FROM		Students,Groups,Directions
--WHERE		direction		=	direction_id
--AND			[group]			=	group_id
----AND		COUNT(group_name) < 5		--WHERE не понимает функции агригирования
--GROUP BY	direction_name
----HAVING		COUNT(group_name) < 5	--HAVING обязательно должен идти непосредственно после GROUP BY
--ORDER BY	N'Количество групп'	ASC
--;

--Подсчет количества студентов в каждой группе с отображением пустых групп
SELECT
			[Группа] = group_name,
			[Количество студентов] = COUNT(CASE WHEN Groups.group_id = Students.[group] THEN 1 END)
FROM		Students, Groups
WHERE		[group] = group_id
OR			Groups.group_id NOT IN (SELECT [group] FROM Students)
GROUP BY	group_name
;

--Подсчет количества групп и студентов по каждому направлению
WITH		Number_of_groups
			AS
			(SELECT		dir = direction,
						group_num = COUNT(DISTINCT group_name)
			FROM Groups
			GROUP BY	direction)

SELECT
			[Направление обучения] = direction_name,
			[Количество групп] = SUM(DISTINCT CASE WHEN Number_of_groups.dir = direction_id THEN group_num ELSE 0 END),
			[Количество студентов] = COUNT(CASE WHEN Groups.group_id = Students.[group] AND Directions.direction_id = Groups.direction THEN 1 END)
FROM		Directions, Groups, Students, Number_of_groups
WHERE		direction = direction_id
AND			dir = direction
AND			[group] = group_id
OR			Groups.group_id NOT IN (SELECT [group] FROM Students)
GROUP BY	direction_name
ORDER BY	[Количество групп] DESC
;