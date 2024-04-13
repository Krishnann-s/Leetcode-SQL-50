Table: Customer
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). 
average_amount should be rounded to two decimal places.
Return the result table ordered by visited_on in ascending order.


SOLUTION


WITH INITIAL
AS (
	SELECT SUM(amount) AS amount
		,visited_on
	FROM Customer
	GROUP BY visited_on
	)
	,CTE
AS (
	SELECT c.visited_on
		,SUM(ic.amount) AS amount
		,ROUND(AVG(ic.amount), 2) average_amount
	FROM INITIAL c
	INNER JOIN INITIAL AS ic ON c.visited_on >= ic.visited_on
	WHERE ic.visited_on >= DATE_SUB(c.visited_on, INTERVAL 6 DAY)
		AND ic.visited_on <= c.visited_on
		AND c.visited_on IN (
			SELECT DATE_ADD(visited_on, INTERVAL 6 DAY)
			FROM Customer
			)
	GROUP BY c.visited_on
	ORDER BY c.visited_on
	)
SELECT *
FROM CTE;