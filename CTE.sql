IF OBJECT_ID('tempdb..##tt') IS NOT NULL
    DROP TABLE ##tt

CREATE TABLE ##tt
(
	id int,
	parentId int null,
	name nvarchar(max)
)


INSERT INTO ##tt
VALUES(1, null, 'root boss')

INSERT INTO ##tt
VALUES(2, 1, 'junior boss1')

INSERT INTO ##tt
VALUES(3, 1, 'junior boss2')

INSERT INTO ##tt
VALUES(4, 2, 'vasya under boss1')

INSERT INTO ##tt
VALUES(5, 2, 'petya under boss1')

INSERT INTO ##tt
VALUES(6, 3, 'kolya under boss2')


;WITH tableexp AS 
(
	SELECT 
		id,
		name,
		parentId
	FROM ##tt
	WHERE 
		id  = 2  --<--- id of whom you want slaves

	UNION ALL
	
	SELECT 
		tt.id,
		tt.name,
		tt.parentId
	FROM 
		##tt AS tt
		INNER JOIN tableexp 
			ON tableexp.id = tt.parentId

)
SELECT 
	*
FROM
	tableexp
