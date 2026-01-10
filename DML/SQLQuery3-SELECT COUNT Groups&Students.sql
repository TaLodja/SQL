--SQLQuery3-SELECT COUNT Groups&Students.sql
USE SPU_411_Import;

SELECT
			direction_name		AS N'Направление обучения',
			COUNT(DISTINCT group_name)	AS N'Количество групп',		--DISTINCT убирает дубликаты и возвращает уникальные значения
			COUNT(stud_id)		AS N'Количество студентов'
FROM		Students,Groups,Directions
WHERE		direction		=	direction_id
AND			[group]			=	group_id
--AND		COUNT(group_name) < 5		--WHERE не понимает функции агригирования
GROUP BY	direction_name
--HAVING		COUNT(group_name) < 5	--HAVING обязательно должен идти непосредственно после GROUP BY
ORDER BY	N'Количество групп'	ASC
;