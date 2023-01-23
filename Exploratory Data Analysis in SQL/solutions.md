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

## Division
Compute the average revenue per employee for Fortune 500 companies by sector.

Instructions
100 XP
Compute revenue per employee by dividing revenues by employees; use casting to produce a numeric result.
Take the average of revenue per employee with avg(); alias this as avg_rev_employee.
Group by sector.
Order by the average revenue per employee.

```sql
-- Select average revenue per employee by sector
SELECT sector, 
       avg(revenues/employees::numeric) AS avg_rev_employee
  FROM fortune500
 GROUP BY sector
 -- Use the column alias to order the results
 ORDER BY avg_rev_employee DESC;
```

## Explore with division
In exploring a new database, it can be unclear what the data means and how columns are related to each other.

What information does the unanswered_pct column in the stackoverflow table contain? Is it the percent of questions with the tag that are unanswered (unanswered ?s with tag/all ?s with tag)? Or is it something else, such as the percent of all unanswered questions on the site with the tag (unanswered ?s with tag/all unanswered ?s)?

Divide unanswered_count (unanswered ?s with tag) by question_count (all ?s with tag) to see if the value matches that of unanswered_pct to determine the answer.

Instructions
100 XP
Exclude rows where question_count is 0 to avoid a divide by zero error.
Limit the result to 10 rows.

```sql

-- Divide unanswered_count by question_count
SELECT unanswered_count/question_count::numeric AS computed_pct, unanswered_pct 
       -- What are you comparing the above quantity to? 
  FROM stackoverflow
  WHERE question_count != 0
 -- Select rows where question_count is not 0
 LIMIT 10;
```

## Summarize numeric columns
Summarize the profit column in the fortune500 table using the functions you've learned.

You can access the course slides for reference using the PDF icon in the upper right corner of the screen.

Instructions 2/2
50 XP
Compute the min(), avg(), max(), and stddev() of profits.
Now repeat step 1, but summarize profits by sector.
Order the results by the average profits for each sector.

```sql
-- Select sector and summary measures of fortune500 profits
SELECT sector, min(profits), avg(profits), max(profits), stddev(profits)
  FROM fortune500
 -- What to group by?
 GROUP BY sector
 -- Order by the average profits
 ORDER BY avg;
```

## Summarize group statistics
Sometimes you want to understand how a value varies across groups. For example, how does the maximum value per group vary across groups?

To find out, first summarize by group, and then compute summary statistics of the group results. One way to do this is to compute group values in a subquery, and then summarize the results of the subquery.

For this exercise, what is the standard deviation across tags in the maximum number of Stack Overflow questions per day? What about the mean, min, and max of the maximums as well?

Instructions
0 XP
Start by writing a subquery to compute the max() of question_count per tag; alias the subquery result as maxval.
Then compute the standard deviation of maxval with stddev().
Compute the min(), max(), and avg() of maxval too.

```sql
-- Compute standard deviation of maximum values
SELECT stddev(maxval),
       -- min
       min(maxval),
       -- max
       max(maxval),
       -- avg
       avg(maxval)
  -- Subquery to compute max of question_count by tag
  FROM (SELECT max(question_count) AS maxval
          FROM stackoverflow
         -- Compute max by...
         GROUP BY tag) AS max_results; -- alias for subquery
```

## Truncate
Use trunc() to examine the distributions of attributes of the Fortune 500 companies.

Remember that trunc() truncates numbers by replacing lower place value digits with zeros:

trunc(value_to_truncate, places_to_truncate)
Negative values for places_to_truncate indicate digits to the left of the decimal to replace, while positive values indicate digits to the right of the decimal to keep.

Instructions 1/2
0 XP
Use trunc() to truncate employees to the 100,000s (5 zeros).
Count the number of observations with each truncated value.
Repeat step 1 for companies with < 100,000 employees (most common).
This time, truncate employees to the 10,000s place.

```sql
-- Truncate employees
SELECT trunc(employees, -5) AS employee_bin,
       -- Count number of companies with each truncated value
       count(*)
  FROM fortune500
 -- Use alias to group
 GROUP BY employee_bin
 -- Use alias to order
 ORDER BY employee_bin;
```

## Generate series
Summarize the distribution of the number of questions with the tag "dropbox" on Stack Overflow per day by binning the data.

Recall:

generate_series(from, to, step)
You can reference the slides using the PDF icon in the upper right corner of the screen.

Instructions 3/3
0 XP
Instructions 3/3
0 XP
Select lower and upper from bins, along with the count of values within each bin bounds.

To do this, you'll need to join 'dropbox', which contains the question_count for tag "dropbox", to the bins created by generate_series().

The join should occur where the count is greater than or equal to the lower bound, and strictly less than the upper bound.

```sql
-- Bins created in Step 2
WITH bins AS (
      SELECT generate_series(2200, 3050, 50) AS lower,
             generate_series(2250, 3100, 50) AS upper),
     -- Subset stackoverflow to just tag dropbox (Step 1)
     dropbox AS (
      SELECT question_count 
        FROM stackoverflow
       WHERE tag='dropbox') 
-- Select columns for result
-- What column are you counting to summarize?
SELECT lower, upper, count(question_count) 
  FROM bins  -- Created above
       -- Join to dropbox (created above), 
       -- keeping all rows from the bins table in the join
       LEFT JOIN dropbox
       -- Compare question_count to lower and upper
         ON question_count >= lower 
        AND question_count < upper
 -- Group by lower and upper to count values in each bin
 GROUP BY lower, upper
 -- Order by lower to put bins in order
 ORDER BY lower;
```
