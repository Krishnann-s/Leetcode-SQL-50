Table: Transactions
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].

Write an SQL query to find for each month and country, 
the number of transactions and their total amount, 
the number of approved transactions and their total amount.
Return the result table in any order.

SOLUTION:

SELECT SUBSTR(trans_date, 1, 7) AS month
	,country
	,count(id) AS trans_count
	,SUM(CASE 
			WHEN STATE = "approved"
				THEN 1
			ELSE 0
			END) AS approved_count
	,sum(amount) AS trans_total_amount
	,sum(CASE 
			WHEN STATE = 'approved'
				THEN amount
			ELSE 0
			END) AS approved_total_amount
FROM Transactions
GROUP BY month
	,country;
