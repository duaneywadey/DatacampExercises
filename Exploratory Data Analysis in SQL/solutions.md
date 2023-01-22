# Exploratory Data Analysis in SQL

## Read an entity relationship diagram
The information you need is sometimes split across multiple tables in the database.

What is the most common stackoverflow tag_type? What companies have a tag of that type?

To generate a list of such companies, you'll need to join three tables together.

Reference the entity relationship diagram as needed when determining which columns to use when joining tables.

Instructions 1/2
50 XP
First, using the tag_type table, count the number of tags with each type.
Order the results to find the most common tag type.

```sql
-- Count the number of tags with each type
SELECT type, COUNT(type)
  FROM tag_type
 -- To get the count for each type, what do you need to do?
 GROUP BY type
 -- Order the results with the most common
 -- tag types listed first
 ORDER BY COUNT(type) DESC;
```

## Coalesce
The coalesce() function can be useful for specifying a default or backup value when a column contains NULL values.

coalesce() checks arguments in order and returns the first non-NULL value, if one exists.

coalesce(NULL, 1, 2) = 1
coalesce(NULL, NULL) = NULL
coalesce(2, 3, NULL) = 2
In the fortune500 data, industry contains some missing values. Use coalesce() to use the value of sector as the industry when industry is NULL. Then find the most common industry.

Instructions
100 XP
Use coalesce() to select the first non-NULL value from industry, sector, or 'Unknown' as a fallback value.
Alias the result of the call to coalesce() as industry2.
Count the number of rows with each industry2 value.
Find the most common value of industry2.

Take Hint (-30 XP)

```sql
-- Use coalesce
SELECT COALESCE(industry, 'Unknown') AS industry2,
       -- Don't forget to count!
       COUNT(*) 
  FROM fortune500
-- Group by what? (What are you counting by?)
  GROUP BY industry
-- Order results to see most common first
  ORDER BY COUNT(*) DESC
-- Limit results to get just the one value you want
  LIMIT 1;
```

## Coalesce with a self-join
You previously joined the company and fortune500 tables to find out which companies are in both tables. Now, also include companies from company that are subsidiaries of Fortune 500 companies as well.

To include subsidiaries, you will need to join company to itself to associate a subsidiary with its parent company's information. To do this self-join, use two different aliases for company.

coalesce will help you combine the two ticker columns in the result of the self-join to join to fortune500.

Instructions
100 XP
Join company to itself to add information about a company's parent to the original company's information.
Use coalesce to get the parent company ticker if available and the original company ticker otherwise.
INNER JOIN to fortune500 using the ticker.
Select original company name, fortune500 title and rank.

```sql
SELECT company_original.name, title, rank
  -- Start with original company information
  FROM company AS company_original
       -- Join to another copy of company with parent
       -- company information
	   LEFT JOIN company AS company_parent
       ON company_original.parent_id = company_parent.id 
       -- Join to fortune500, only keep rows that match
       INNER JOIN fortune500 
       -- Use parent ticker if there is one, 
       -- otherwise original ticker
       ON coalesce(company_parent.ticker, 
                   company_original.ticker) = 
             fortune500.ticker
 -- For clarity, order by rank
 ORDER BY rank; 
```

## Effects of casting
When you cast data from one type to another, information can be lost or changed. See how the casting changes values and practice casting data using the CAST() function and the :: syntax.

SELECT CAST(value AS new_type);

SELECT value::new_type;
Instructions 1/3
0 XP
Select profits_change and profits_change cast as integer from fortune500.
Look at how the values were converted.
Compare the results of casting of dividing the integer value 10 by 3 to the result of dividing the numeric value 10 by 3.
Now cast numbers that appear as text as numeric.
Note: 1e3 is scientific notation.

```sql
-- Select the original value
SELECT profits_change, 
	   -- Cast profits_change
       CAST(profits_change AS integer) AS profits_change_int
  FROM fortune500;
```

## Summarize the distribution of numeric values
Was 2017 a good or bad year for revenue of Fortune 500 companies? Examine how revenue changed from 2016 to 2017 by first looking at the distribution of revenues_change and then counting companies whose revenue increased.

Instructions 1/3
1 XP
Use GROUP BY and count() to examine the values of revenues_change.
Order the results by revenues_change to see the distribution.

```sql
-- Select the count of each value of revenues_change
SELECT revenues_change, count(*) 
  FROM fortune500
 GROUP BY revenues_change 
 -- order by the values of revenues_change
 ORDER BY revenues_change;
```