# Data Driven Decision Using SQL

## First account for each country.
Conduct an analysis to see when the first customer accounts were created for each country.

Instructions
100 XP
Create a table with a row for each country and columns for the country name and the date when the first customer account was created.
Use the alias first_account for the column with the dates.
Order by date in ascending order.

```SQL
SELECT country, min(date_account_start) AS first_account
FROM customers
GROUP BY country
ORDER BY first_account;
```

## Average movie ratings
For each movie the average rating, the number of ratings and the number of views has to be reported. Generate a table with meaningful column names.

Instructions 1/4
25 XP
Group the data in the table renting by movie_id and report the ID and the average rating.

```SQL
SELECT movie_id, avg(rating)    -- Calculate average rating per movie
FROM renting
group by movie_id;
```

Add two columns for the number of ratings and the number of movie rentals to the results table.
Use alias names avg_rating, number_rating and number_renting for the corresponding columns.

```SQL
SELECT movie_id, 
       AVG(rating) AS avg_rating, -- Use as alias avg_rating
       count(rating) AS number_rating, -- Add column for number of ratings with alias number_rating
       count(renting_id) as number_renting -- Add column for number of movie rentals with alias number_renting
FROM renting
GROUP BY movie_id;
```

Order the rows of the table by the average rating such that it is in decreasing order.
Observe what happens to NULL values.

```SQL
SELECT movie_id, 
       AVG(rating) AS avg_rating,
       COUNT(rating) AS number_ratings,
       COUNT(*) AS number_renting
FROM renting
GROUP BY movie_id
order by avg_rating desc; -- Order by average rating in decreasing order
```

## Average rating per customer
Similar to what you just did, you will now look at the average movie ratings, this time for customers. So you will obtain a table with the average rating given by each customer. Further, you will include the number of ratings and the number of movie rentals per customer. You will report these summary statistics only for customers with more than 7 movie rentals and order them in ascending order by the average rating.

Instructions
0 XP
Group the data in the table renting by customer_id and report the customer_id, the average rating, the number of ratings and the number of movie rentals.
Select only customers with more than 7 movie rentals.
Order the resulting table by the average rating in ascending order.

```sql
SELECT customer_id,  -- Report the customer_id
       AVG(rating), -- Report the average rating per customer
       COUNT(rating), -- Report the number of ratings per customer
       COUNT(*) -- Report the number of movie rentals per customer
FROM renting
GROUP BY customer_id
HAVING COUNT(*) > 7 -- Select only customers with more than 7 movie rentals
ORDER BY AVG(rating); -- Order by the average rating in ascending order
```


## Join renting and customers
For many analyses it is necessary to add customer information to the data in the table renting.

Instructions 1/3
35 XP
Augment the table renting with all columns from the table customers with a LEFT JOIN.
Use as alias' for the tables r and c respectively.

```sql
SELECT * -- Join renting with customers
FROM renting r
LEFT JOIN customers c
ON r.customer_id = c.customer_id;
```

Select only records from customers coming from Belgium.

```sql
SELECT *
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
WHERE country = 'Belgium'; -- Select only records from customers coming from Belgium
```

Average ratings of customers from Belgium.

```sql
SELECT avg(rating) -- Average ratings of customers from Belgium
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
WHERE c.country='Belgium';
```

## Aggregating revenue, rentals and active customers
The management of MovieNow wants to report key performance indicators (KPIs) for the performance of the company in 2018. They are interested in measuring the financial successes as well as user engagement. Important KPIs are, therefore, the profit coming from movie rentals, the number of movie rentals and the number of active customers.

Instructions 1/3
35 XP
First, you need to join movies on renting to include the renting_price from the movies table for each renting record.
Use as alias' for the tables m and r respectively.

```SQL
SELECT *
FROM renting AS r
left join movies AS m -- Choose the correct join statment
ON r.movie_id = m.movie_id;
```

Calculate the revenue coming from movie rentals, the number of movie rentals and the number of customers who rented a movie.

```SQL
SELECT 
	SUM(m.renting_price), -- Get the revenue from movie rentals
	COUNT(*), -- Count the number of rentals
	COUNT(DISTINCT r.customer_id) -- Count the number of customers
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id;
```

Now, you can report these values for the year 2018. Calculate the revenue in 2018, the number of movie rentals and the number of active customers in 2018. An active customer is a customer who rented at least one movie in 2018.

```SQL
SELECT 
	SUM(m.renting_price), 
	COUNT(*), 
	COUNT(DISTINCT r.customer_id)
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id
-- Only look at movie rentals in 2018
WHERE date_renting BETWEEN '2018-01-01' AND '2018-12-31';
```

## Movies and actors
You are asked to give an overview of which actors play in which movie.

Instructions
100 XP
Create a list of actor names and movie titles in which they act. Make sure that each combination of actor and movie appears only once.
Use as an alias for the table actsin the two letters ai.

```sql
SELECT m.title, -- Create a list of movie titles and actor names
       a.name
FROM actsin ac
LEFT JOIN movies AS m
ON m.movie_id = ac.movie_id
LEFT JOIN actors AS a
ON a.actor_id = ac.actor_id;
```

## Income from movies
How much income did each movie generate? To answer this question subsequent SELECT statements can be used.

Instructions 1/3
35 XP
3
Use a join to get the movie title and price for each movie rental.

```sql
SELECT m.title, m.renting_price
-- Use a join to get the movie title and price for each movie rental
       
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id;
```

Report the total income for each movie.
Order the result by decreasing income.

```sql
SELECT rm.title, -- Report the income from movie rentals for each movie 
       SUM(rm.renting_price) AS income_movie
FROM
       (SELECT m.title, 
               m.renting_price
       FROM renting AS r
       LEFT JOIN movies AS m
       ON r.movie_id=m.movie_id) AS rm
GROUP BY rm.title
ORDER BY income_movie DESC; -- Order the result by decreasing income
```
## Age of actors from the USA
Now you will explore the age of American actors and actresses. Report the date of birth of the oldest and youngest US actor and actress.

Instructions
100 XP
Create a subsequent SELECT statements in the FROM clause to get all information about actors from the USA.
Give the subsequent SELECT statement the alias a.
Report for actors from the USA the year of birth of the oldest and the year of birth of the youngest actor and actress.

```sql
SELECT a.gender, -- Report for male and female actors from the USA 
       min(a.year_of_birth), -- The year of birth of the oldest actor
       max(a.year_of_birth) -- The year of birth of the youngest actor
FROM
   (SELECT * FROM actors WHERE nationality = 'USA') as a -- Use a subsequen SELECT to get all information about actors from the USA
  
    -- Give the table the name a
GROUP BY a.gender;
```
## Identify favorite movies for a group of customers
Which is the favorite movie on MovieNow? Answer this question for a specific group of customers: for all customers born in the 70s.

Instructions 1/4
25 XP
Augment the table renting with customer information and information about the movies.
For each join use the first letter of the table name as alias.

```SQL
SELECT *
FROM renting AS r
LEFT JOIN customers c   -- Add customer information
on r.customer_id = c.customer_id
LEFT JOIN movies m   -- Add movie information
on r.movie_id = m.movie_id;
```

Select only those records of customers born in the 70s.

```SQL
SELECT *
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01'  AND '1979-12-31'; -- Select customers born in the 70s
```

For each movie, report the number of times it was rented, as well as the average rating. Limit your results to customers born in the 1970s.

```sql
SELECT m.title, 
count(*), -- Report number of views per movie
avg(rating) -- Report the average rating per movie
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
group by m.title;
```

Remove those movies from the table with only one rental.
Order the result table such that movies with highest rating come first.

```sql
SELECT m.title, 
COUNT(*),
AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title
HAVING count(r.renting_id) > 1 -- Remove movies with only one rental
ORDER BY AVG(r.rating); -- Order with highest rating first
```

