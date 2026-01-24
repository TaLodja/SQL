--SQLQuery3-JOIN Students.sql
USE SPU_411_Import;

--SELECT
--		[Студент]				=	FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
--		[Группа]				=	group_name,
--		[Направление обучения]	=	direction_name,
--		[Дисциплина]			=	discipline_name
--FROM	Students
--JOIN	Groups		ON	[group]		=	group_id
--JOIN	Directions	ON	direction	=	direction_id
--JOIN	DisciplinesDirectionsRelation ON direction_id = DisciplinesDirectionsRelation.direction
--JOIN	Disciplines	ON	discipline	=	discipline_id
--WHERE	stud_id = 26
--;

--SELECT
--			[Направление обучения]		=	direction_name,
--			[Количество групп]			=	COUNT(DISTINCT group_id),
--			[Количество студентов]		=	COUNT(stud_id),
--			[Количество пустых групп]	=	(SELECT COUNT(stud_id) FROM Students JOIN Groups ON [group]=group_id HAVING COUNT(group_id)=0)
--FROM		Students
--RIGHT JOIN	Groups		ON	[group]		=	group_id
--RIGHT JOIN	Directions	ON	direction	=	direction_id
--GROUP BY	direction_name
--;
--	INNER JOIN	Внутреннее объединение
--	OUTER JOIN	Внешнее объединение:
--		LEFT	OUTER JOIN
--		RIGHT	OUTER JOIN
--		FULL	OUTER JOIN

--SELECT	
--			[Группа]					=	group_name,
--			[Количество студентов]		=	COUNT(stud_id),
--			[Направление обучения]		=	direction_name
--FROM		Students
--RIGHT JOIN	Groups		ON	[group]		=	group_id
--JOIN		Directions	ON	direction	=	direction_id
--GROUP BY	group_name, direction_name
--;

SELECT
			[Направление обучения]		=	direction_name,
			[Количество групп]			=	COUNT(group_id),
			[Количество пустых групп]	=	(SELECT COUNT(group_id) FROM Students JOIN Groups on [group]=group_id HAVING COUNT(stud_id)=0)
FROM		Students
RIGHT JOIN	Groups		ON	[group]		=	group_id
JOIN		Directions	ON	direction	=	direction_id
GROUP BY	direction_name
;

SELECT COUNT(group_id) FROM Students RIGHT JOIN Groups ON [group]=group_id GROUP BY group_id --HAVING COUNT(stud_id)=0;