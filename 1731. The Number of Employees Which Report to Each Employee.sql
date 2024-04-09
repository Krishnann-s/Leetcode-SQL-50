Table: Employees
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.
Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, 
and the average age of the reports rounded to the nearest integer.
Return the result table ordered by employee_id.

SOLUTION:

WITH CTE
AS (
	SELECT COUNT(reports_to) AS reports_count
		,reports_to AS employee_id
		,ROUND(AVG(age)) AS average_age
	FROM Employees
	WHERE reports_to IS NOT NULL
	GROUP BY reports_to
	)
SELECT c.employee_id
	,name
	,reports_count
	,average_age
FROM CTE AS c
INNER JOIN Employees AS e
	ON c.employee_id = e.employee_id
ORDER BY c.employee_id;
