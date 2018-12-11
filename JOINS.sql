IF OBJECT_ID('tempdb..##T1') IS NOT NULL
    DROP TABLE ##T1

	IF OBJECT_ID('tempdb..##T2') IS NOT NULL
    DROP TABLE ##T2


CREATE TABLE ##T1
(
	col char(1)
)


CREATE TABLE ##T2
(
	col char(1)
)

INSERT INTO ##T1 VALUES ('A')
INSERT INTO ##T1 VALUES ('B')
INSERT INTO ##T1 VALUES ('C')

INSERT INTO ##T2 VALUES ('A')
INSERT INTO ##T2 VALUES ('B')
INSERT INTO ##T2 VALUES ('D')

SELECT 
	* 
FROM 
	##T1 AS t1
	FULL JOIN ##T2 AS t2
		ON t1.col = t2.col
/*
A	A
B	B
C	NULL
NULL	D
*/

SELECT 
	* 
FROM 
	##T1 AS t1
	CROSS JOIN ##T2 AS t2
		
/*
A	A
B	A
C	A
A	B
B	B
C	B
A	D
B	D
C	D
*/


SELECT 
	* 
FROM 
	##T1 AS t1
	CROSS APPLY ##T2 AS t2

/* without specification of the condition, works in the same manner as CROSS JOIN */

SELECT 
	* 
FROM 
	##T1 AS t1
	OUTER APPLY (SELECT * FROM ##T2 WHERE col = t1.col) AS sss
	
/* for eacht row from t1 makes subquery and join this row to the output. if no output, then null. this is the difference from CROSS APPLY

A	A
B	B
C	NULL

*/