Table: MovieRating
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 
 

Write a solution to:
Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.


SOLUTION

WITH rating_cte
AS (
	SELECT name
		,COUNT(rating) AS rating_count
	FROM Users AS u
	INNER JOIN MovieRating AS mr ON u.user_id = mr.user_id
	GROUP BY name
	ORDER BY COUNT(*) DESC
		,name
	)
	,average_cte
AS (
	SELECT title
		,AVG(rating) AS rating_avg
	FROM Movies AS m
	INNER JOIN MovieRating AS mr ON m.movie_id = mr.movie_id
	WHERE created_at BETWEEN '2020-02-01'
			AND '2020-02-29'
	GROUP BY title
	ORDER BY 2 DESC
		,title
	) (
		SELECT name AS results
		FROM rating_cte
		HAVING MAX(rating_count)
		ORDER BY name ASC LIMIT 1
		)

UNION ALL

(
	SELECT title AS results
	FROM average_cte
	HAVING MAX(rating_avg)
	ORDER BY title ASC LIMIT 1
	);

