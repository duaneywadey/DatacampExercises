# Joining Data in SQL

## Your first join

Throughout this course, you'll be working with the countries database, which contains information about the most populous world cities in the world, along with country-level economic, population, and geographic data. The database also contains information on languages spoken in each country.

You can see the different tables in this database to get a sense of what they contain by clicking on the corresponding tabs. Click through them and familiarize yourself with the fields that seem to be shared across tables before you continue with the course.

In this exercise, you'll use the cities and countries tables to build your first inner join. You'll start off by selecting all columns in step 1, performing your join in step 2, and then refining your join to choose specific columns in step 3.

* Begin by selecting all columns from the cities table, using the SQL shortcut that selects all.

```sql
-- Select all columns from cities
SELECT * FROM cities;

```

## Joining with aliased tables

Recall from the video that instead of writing full table names in queries, you can use table aliasing as a shortcut. The alias can be used in other parts of your query, such as the SELECT statement!

You also learned that when you SELECT fields, a field can be ambiguous. For example, imagine two tables, apples and oranges, both containing a column called color. You need to use the syntax apples.color or oranges.color in your SELECT statement to point SQL to the correct table. Without this, you would get the following error:
```
column reference "color" is ambiguous
```
In this exercise, you'll practice joining with aliased tables. You'll use data from both the countries and economies tables to examine the inflation rate in 2010 and 2015.

When writing joins, many SQL users prefer to write the SELECT statement after writing the join code, in case the SELECT statement requires using table aliases.

* Start with your inner join in line 5; join the tables countries AS c (left) with economies (right), aliasing economies AS e.

* Next, use code as your joining field in line 7; do not use the USING command here.

* Lastly, select the following columns in order in line 2: code from the countries table (aliased as country_code), name, year, and inflation_rate.

```sql
-- Select fields with aliases
SELECT c.code AS country_code, name, year, inflation_rate
FROM countries AS c
-- Join to economies (alias e)
INNER JOIN economies as e
-- Match on code field using table aliases
ON c.code=e.code; 
```

## USING in action

In the previous exercises, you performed your joins using the ON keyword. Recall that when both the field names being joined on are the same, you can take advantage of the USING clause.

You'll now explore the languages table from our database. Which languages are official languages, and which ones are unofficial?

You'll employ USING to simplify your query as you explore this question.

* Use the country code field to complete the INNER JOIN with USING; do not change any alias names.

```sql
SELECT c.name AS country, l.name AS language, official
FROM countries AS c
INNER JOIN languages AS l
-- Match using the code column
USING(code);
```

## Inspecting a relationship

You've just identified that the countries table has a many-to-many relationship with the languages table. That is, many languages can be spoken in a country, and a language can be spoken in many countries.

This exercise looks at each of these in turn. First, what is the best way to query all the different languages spoken in a country? And second, how is this different from the best way to query all the countries that speak each language?

Recall that when writing joins, many users prefer to write SQL code out of order by writing the join first (along with any table aliases), and writing the SELECT statement at the end.

* Start with the join statement in line 6; perform an inner join with the countries table as c on the left with the languages table as l on the right.

* Make use of the USING keyword to join on code in line 8.
* Lastly, in line 2, select the country name, aliased as country, and the language name, aliased as language.

```sql
-- Select country and language names, aliased
SELECT c.name AS country, l.name AS language
-- From countries (aliased)
FROM countries AS c
-- Join to languages (aliased)
INNER JOIN languages as l
-- Use code as the joining field with the USING keyword
USING(code);
```

## Joining multiple tables
You've seen that the ability to combine multiple joins using a single query is a powerful feature of SQL.

Suppose you are interested in the relationship between fertility and unemployment rates. Your task in this exercise is to join tables to return the country name, year, fertility rate, and unemployment rate in a single result from the countries, populations and economies tables.

Instructions 1/2
50 XP
* Perform an inner join of countries AS c (left) with populations AS p (right), on code.
* Select name, year and fertility_rate.
* Chain another inner join to your query with the economies table AS e, using code.
* Select name, and using table aliases, select year and unemployment_rate from economies.

```sql
-- Select relevant fields
SELECT name, year, fertility_rate
FROM countries AS c
-- Inner join countries and populations, aliased, on code
INNER JOIN populations AS p
ON c.code=p.country_code;
```

## Checking multi-table joins
Have a look at the results for Albania from the previous query below. You can see that the 2015 fertility_rate has been paired with 2010 unemployment_rate, and vice versa.

name	year	fertility_rate	unemployment_rate
Albania	2015	1.663	17.1
Albania	2010	1.663	14
Albania	2015	1.793	17.1
Albania	2010	1.793	14

Instead of four records, the query should return two: one for each year. The last join was performed on c.code = e.code, without also joining on year. Your task in this exercise is to fix your query by explicitly stating that both the country code and year should match!

* Modify your query so that you are joining to economies on year as well as code.

```sql
SELECT name, e.year, fertility_rate, unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code
-- Add an additional joining condition such that you are also joining on year
AND e.year = p.year;
```

## This is a LEFT JOIN, right?
Nice work getting to grips with the structure of joins! In this exercise, you'll explore the differences between INNER JOIN and LEFT JOIN. This will help you decide which type of join to use.

As before, you will be using the cities and countries tables.

You'll begin with an INNER JOIN with the cities table (left) and countries table (right). This helps if you are interested only in records where a country is present in both tables.

You'll then change to a LEFT JOIN. This helps if you're interested in returning all countries in the cities table, whether or not they have a match in the countries table.

Instructions 1/2
50 XP
Instructions 1/2
50 XP

* Perform an inner join with cities AS c1 on the left and countries as c2 on the right.
* Use code as the field to merge your tables on.
* Change the code to perform a LEFT JOIN instead of an INNER JOIN.
* After executing this query, have a look at how many records the query result contains.

```sql
SELECT 
    c1.name AS city,
    code,
    c2.name AS country,
    region,
    city_proper_pop
FROM cities AS c1
-- Perform an inner join with cities as c1 and countries as c2 on country code
INNER JOIN COUNTRIES AS c2 
ON c1.country_code = c2.code
ORDER BY code DESC;
```

## Building on your LEFT JOIN
You'll now revisit the use of the AVG() function introduced in a previous course.

Being able to build more than one SQL function into your query will enable you to write compact, supercharged queries.

You will use AVG() in combination with a LEFT JOIN to determine the average gross domestic product (GDP) per capita by region in 2010.

Instructions 1/3
35 XP
Complete the LEFT JOIN with the countries table on the left and the economies table on the right on the code field.
Filter the records from the year 2010.

```sql
SELECT name, region, gdp_percapita
FROM countries AS c
LEFT JOIN economies AS e
-- Match on code fields
ON c.code = e.code
-- Filter for the year 2010
WHERE year=2010;
```

## Is this RIGHT?
You learned that right joins are not used as commonly as left joins. A key reason for this is that right joins can always be re-written as left joins, and because joins are typically typed from left to right, joining from the left feels more intuitive when constructing queries.

It can be tricky to wrap one's head around when left and right joins return equivalent results. You'll explore this in this exercise!

Instructions
100 XP
Write a new query using RIGHT JOIN that produces an identical result to the LEFT JOIN provided.

```sql
-- Modify this query to use RIGHT JOIN instead of LEFT JOIN
SELECT countries.name AS country, languages.name AS language, percent
FROM countries
LEFT JOIN languages
USING(code)
ORDER BY language;
```

## Comparing joins
In this exercise, you'll examine how results can differ when performing a full join compared to a left join and inner join by joining the countries and currencies tables. You'll be focusing on the North American region and records where the name of the country is missing.

You'll begin with a full join with countries on the left and currencies on the right. Recall the workings of a full join with the diagram below!



You'll then complete a similar left join and conclude with an inner join, observing the results you see along the way.

Instructions 1/3
35 XP
Instructions 1/3
35 XP
Perform a full join with countries (left) and currencies (right).
Filter for the North America region or NULL country names.
Repeat the same query as before, turning your full join into a left join with the currencies table.
Have a look at what has changed in the output by comparing it to the full join result.
Repeat the same query again, this time performing an inner join of countries with currencies.
Have a look at what has changed in the output by comparing it to the full join and left join results!

```sql
SELECT name AS country, code, region, basic_unit
FROM countries
-- Join to currencies
FULL JOIN currencies
USING (code)
-- Where region is North America or name is null
WHERE region='North America' OR name isnull
ORDER BY region;
```

## Chaining FULL JOINs
As you have seen in the previous chapter on INNER JOIN, it is possible to chain joins in SQL, such as when looking to connect data from more than two tables.

Suppose you are doing some research on Melanesia and Micronesia, and are interested in pulling information about languages and currencies into the data we see for these regions in the countries table. Since languages and currencies exist in separate tables, this will require two consecutive full joins involving the countries, languages and currencies tables.

Instructions
100 XP
Complete the FULL JOIN with countries as c1 on the left and languages as l on the right, using code to perform this join.
Next, chain this join with another FULL JOIN, placing currencies on the right, joining on code again.

```sql
SELECT 
	c1.name AS country, 
    region, 
    l.name AS language,
	basic_unit, 
    frac_unit
FROM countries as c1 
-- Full join with languages (alias as l)
FULL JOIN languages as l 
USING (code)
-- Full join with currencies (alias as c2)
FULL JOIN currencies as c2
USING (code)  
WHERE region LIKE 'M%esia';
```
## Histories and languages
Well done getting to know all about CROSS JOIN! As you have learned, CROSS JOIN can be incredibly helpful when asking questions that involve looking at all possible combinations or pairings between two sets of data.

Imagine you are a researcher interested in the languages spoken in two countries: Pakistan and India. You are interested in asking:

What are the languages presently spoken in the two countries?
Given the shared history between the two countries, what languages could potentially have been spoken in either country over the course of their history?
In this exercise, we will explore how INNER JOIN and CROSS JOIN can help us answer these two questions, respectively.

Instructions 1/2
0 XP
Complete the code to perform an INNER JOIN of countries AS c with languages AS l using the code field to obtain the languages currently spoken in the two countries.

```sql
SELECT c.name AS country, l.name AS language
-- Inner join countries as c with languages as l on code
FROM countries AS c        
INNER JOIN languages AS l
USING(code)
WHERE c.code IN ('PAK','IND')
	AND l.code in ('PAK','IND');
```

## Choosing your join
Now that you're fully equipped to use joins, try a challenge problem to test your knowledge!

You will determine the names of the five countries and their respective regions with the lowest life expectancy for the year 2010. Use your knowledge about joins, filtering, sorting and limiting to create this list!

Instructions
100 XP
Complete the join of countries AS c with populations as p.
Filter on the year 2010.
Sort your results by life expectancy in ascending order.
Limit the result to five countries.

```sql
SELECT 
	c.name AS country,
    region,
    life_expectancy AS life_exp
FROM countries AS c
-- Join to populations (alias as p) using an appropriate join
INNER JOIN populations AS p  
ON c.code = p.country_code
-- Filter for only results in the year 2010
WHERE year=2010
-- Sort by life_exp
ORDER BY life_exp
-- Limit to five records
LIMIT 5;
```

## Comparing a country to itself
Self joins are very useful for comparing data from one part of a table with another part of the same table. Suppose you are interested in finding out how much the populations for each country changed from 2010 to 2015. You can visualize this change by performing a self join.

In this exercise, you'll work to answer this question by joining the populations table with itself. Recall that, with self joins, tables must be aliased. Use this as an opportunity to practice your aliasing!

Since you'll be joining the populations table to itself, you can alias populations first as p1 and again as p2. This is good practice whenever you are aliasing tables with the same first letter.

Instructions 1/2
50 XP
Perform an inner join of populations with itself ON country_code, aliased p1 and p2 respectively.
Select the country_code from p1 and the size field from both p1 and p2, aliasing p1.size as size2010 and p2.size as size2015 (in that order).

```sql
-- Select aliased fields from populations as p1
SELECT p1.country_code, p1.size as size2010, p2.size as size2015
FROM populations as p1
-- Join populations as p1 to itself, alias as p2, on country code
INNER JOIN populations as p2
ON p1.country_code = p2.country_code;
```

## Comparing global economies
Are you ready to perform your first set operation?

In this exercise, you have two tables, economies2015 and economies2019, available to you under the tabs in the console. You'll perform a set operation to stack all records in these two tables on top of each other, excluding duplicates.

When drafting queries containing set operations, it is often helpful to write the queries on either side of the operation first, and then call the set operator. The instructions are ordered accordingly.

Instructions
100 XP
Begin your query by selecting all fields from economies2015.
Create a second query that selects all fields from economies2019.
Perform a set operation to combine the two queries you just created, ensuring you do not return duplicates.

```sql
-- Select all fields from economies2015
SELECT * FROM economies2015
-- Set operation
UNION 
-- Select all fields from economies2019
SELECT * FROM economies2019
ORDER BY code, year;
```

## Comparing two set operations
You learned in the video exercise that UNION ALL returns duplicates, whereas UNION does not. In this exercise, you will dive deeper into this, looking at cases for when UNION is appropriate compared to UNION ALL.

You will be looking at combinations of country code and year from the economies and populations tables.

Instructions 1/2
50 XP
Perform an appropriate set operation that determines all pairs of country code and year (in that order) from economies and populations, excluding duplicates.
Order by country code and year.
Amend the query to return all combinations (including duplicates) of country code and year in the economies or the populations tables.

```sql
-- Query that determines all pairs of code and year from economies and populations, without duplicates
SELECT code, year FROM economies
UNION
SELECT country_code, year FROM populations
ORDER BY code, year;
```

## INTERSECT
Well done getting through the material on INTERSECT!

Let's say you are interested in those countries that share names with cities. Use this task as an opportunity to show off your knowledge of set theory in SQL!

Instructions
100 XP
Return all city names that are also country names.

```sql
-- Return all cities with the same name as a country
SELECT name from cities
INTERSECT
SELECT name from countries;
```

## You've got it, EXCEPT...
Just as you were able to leverage INTERSECT to find the names of cities with the same names as countries, you can also do the reverse, using EXCEPT.

In this exercise, you will find the names of cities that do not have the same names as their countries.

Instructions
100 XP
Return all cities that do not have the same name as a country.

```sql
-- Return all cities that do not have the same name as a country
SELECT name FROM cities
EXCEPT
SELECT name from countries
ORDER BY name;
```

