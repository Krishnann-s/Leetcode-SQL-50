Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column.

Find all numbers that appear at least three times consecutively.
Return the result table in any order.

SOLUTION:

WITH CTE
AS (
	SELECT num
		,LEAD(num, 1) OVER (
			ORDER BY id
			) AS num1
		,LEAD(num, 2) OVER (
			ORDER BY id
			) AS num2
	FROM Logs
	)
SELECT DISTINCT (num) AS "ConsecutiveNums"
FROM CTE
WHERE num = num1
	AND num = num2;
