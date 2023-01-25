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

## Correlation
What's the relationship between a company's revenue and its other financial attributes? Compute the correlation between revenues and other financial variables with the corr() function.

Instructions
0 XP
Compute the correlation between revenues and profits.
Compute the correlation between revenues and assets.
Compute the correlation between revenues and equity.

```sql
-- Correlation between revenues and profit
SELECT corr(revenues, profits) AS rev_profits,
	   -- Correlation between revenues and assets
       corr(revenues, assets) AS rev_assets,
       -- Correlation between revenues and equity
       corr(revenues, equity) AS rev_equity 
  FROM fortune500;
```

## Mean and Median
Compute the mean (avg()) and median assets of Fortune 500 companies by sector.

Use the percentile_disc() function to compute the median:
```
percentile_disc(0.5) 
WITHIN GROUP (ORDER BY column_name)
```
Instructions
0 XP
Select the mean and median of assets.
Group by sector.
Order the results by the mean.

```sql
-- What groups are you computing statistics by?
SELECT sector, 
       -- Select the mean of assets with the avg function
       avg(assets) AS mean,
       -- Select the median
       percentile_disc(0.5) WITHIN GROUP (ORDER BY assets) AS median
  FROM fortune500
 -- Computing statistics for each what?
 GROUP BY sector
 -- Order results by a value of interest
 ORDER BY mean;
```

## Create a temp table
Find the Fortune 500 companies that have profits in the top 20% for their sector (compared to other Fortune 500 companies).

To do this, first, find the 80th percentile of profit for each sector with

```
percentile_disc(fraction) 
WITHIN GROUP (ORDER BY sort_expression)
and save the results in a temporary table.
```

Then join fortune500 to the temporary table to select companies with profits greater than the 80th percentile cut-off.

Instructions 1/2
0 XP
1
2
Create a temporary table called profit80 containing the sector and 80th percentile of profits for each sector.
Alias the percentile column as pct80.

```sql
-- Code from previous step
DROP TABLE IF EXISTS profit80;

CREATE TEMP TABLE profit80 AS
  SELECT sector, 
         percentile_disc(0.8) WITHIN GROUP (ORDER BY profits) AS pct80
    FROM fortune500 
   GROUP BY sector;

-- Select columns, aliasing as needed
SELECT title, fortune500.sector, 
       profits, profits/pct80 AS ratio
-- What tables do you need to join?  
  FROM fortune500 
       LEFT JOIN profit80
-- How are the tables joined?
       ON fortune500.sector=profit80.sector
-- What rows do you want to select?
 WHERE profits > pct80;
```

## Create a temp table to simplify a query
The Stack Overflow data contains daily question counts through 2018-09-25 for all tags, but each tag has a different starting date in the data.

Find out how many questions had each tag on the first date for which data for the tag is available, as well as how many questions had the tag on the last day. Also, compute the difference between these two values.

To do this, first compute the minimum date for each tag.

Then use the minimum dates to select the question_count on both the first and last day. To do this, join the temp table startdates to two different copies of the stackoverflow table: one for each column - first day and last day - aliased with different names.

Instructions 1/2
0 XP
1
2
First, create a temporary table called startdates with each tag and the min() date for the tag in stackoverflow.

```sql
-- To clear table if it already exists
DROP TABLE IF EXISTS startdates;

CREATE TEMP TABLE startdates AS
SELECT tag, min(date) AS mindate
  FROM stackoverflow
 GROUP BY tag;
 
-- Select tag (Remember the table name!) and mindate
SELECT startdates.tag, 
       mindate, 
       -- Select question count on the min and max days
	   so_min.question_count AS min_date_question_count,
       so_max.question_count AS max_date_question_count,
       -- Compute the change in question_count (max- min)
       so_max.question_count - so_min.question_count AS change
  FROM startdates
       -- Join startdates to stackoverflow with alias so_min
       INNER JOIN stackoverflow AS so_min
          -- What needs to match between tables?
          ON startdates.tag = so_min.tag
         AND startdates.mindate = so_min.date
       -- Join to stackoverflow again with alias so_max
       INNER JOIN stackoverflow AS so_max
          -- Again, what needs to match between tables?
          ON startdates.tag = so_max.tag
         AND so_max.date = '2018-09-25';
```

## Insert into a temp table
While you can join the results of multiple similar queries together with UNION, sometimes it's easier to break a query down into steps. You can do this by creating a temporary table and inserting rows into it.

Compute the correlations between each pair of profits, profits_change, and revenues_change from the Fortune 500 data.

The resulting temporary table should have the following structure:

|measure |profits|	profits_change|	revenues_change|
| :---:   | :---: | :---: | :---: | :---: |
|profits |	1.00|	#|	#|
| :---:   | :---: | :---: | :---: | :---: |
|profits_change|	#|	1.00|	#|
| :---:   | :---: | :---: | :---: | :---: |
|revenues_change|	#|	#|	1.00|

Recall the round() function to make the results more readable:
```
round(column_name::numeric, decimal_places)
```
Note that Steps 1 and 2 do not produce output. It is normal for the query result pane to say "Your query did not generate any results."

Instructions 1/3
35 XP
1
2
3
Instructions 1/3
35 XP
1
2
3
Create a temp table correlations.

Compute the correlation between profits and each of the three variables (i.e. correlate profits with profits, profits with profits_change, etc).
Alias columns by the name of the variable for which the correlation with profits is being computed.

```sql
DROP TABLE IF EXISTS correlations;

CREATE TEMP TABLE correlations AS
SELECT 'profits'::varchar AS measure,
       corr(profits, profits) AS profits,
       corr(profits, profits_change) AS profits_change,
       corr(profits, revenues_change) AS revenues_change
  FROM fortune500;

INSERT INTO correlations
SELECT 'profits_change'::varchar AS measure,
       corr(profits_change, profits) AS profits,
       corr(profits_change, profits_change) AS profits_change,
       corr(profits_change, revenues_change) AS revenues_change
  FROM fortune500;

INSERT INTO correlations
SELECT 'revenues_change'::varchar AS measure,
       corr(revenues_change, profits) AS profits,
       corr(revenues_change, profits_change) AS profits_change,
       corr(revenues_change, revenues_change) AS revenues_change
  FROM fortune500;

-- Select each column, rounding the correlations
SELECT measure, 
       round(profits::numeric, 2) AS profits,
       round(profits_change::numeric, 2) AS profits_change,
       round(revenues_change::numeric, 2) AS revenues_change
  FROM correlations;
```

## Count the categories
In this chapter, we'll be working mostly with the Evanston 311 data in table evanston311. This is data on help requests submitted to the city of Evanston, IL.

This data has several character columns. Start by examining the most frequent values in some of these columns to get familiar with the common categories.

How many rows does each priority level have?

```sql
-- Select the count of each level of priority
SELECT priority, count(*) -- Find values of source that appear in at least 100 rows
-- Also get the count of each value
SELECT DISTINCT(source), count(*)
  FROM evanston311
 GROUP BY source
HAVING count(*)  >=100;
  FROM evanston311

  Select the five most common values of street and the count of each.

  ```sql
-- Find the 5 most common values of street and the count of each
SELECT street, count(*)
  FROM evanston311
 GROUP BY street
 ORDER BY count(*) DESC
 LIMIT 5;
  ```
 GROUP BY priority;
```

How many distinct values of zip appear in at least 100 rows?

```sql
-- Find values of zip that appear in at least 100 rows
-- Also get the count of each value
SELECT zip, count(*) 
  FROM evanston311
 GROUP BY zip
HAVING count(*) >=100; 
```

How many distinct values of source appear in at least 100 rows?

```sql
-- Find values of source that appear in at least 100 rows
-- Also get the count of each value
SELECT DISTINCT(source), count(*)
  FROM evanston311
 GROUP BY source
HAVING count(*)  >=100;
```

Select the five most common values of street and the count of each.

```sql
-- Find the 5 most common values of street and the count of each
SELECT street, count(*)
  FROM evanston311
 GROUP BY street
 ORDER BY count(*) DESC
 LIMIT 5;
```

## Trimming
Some of the street values in evanston311 include house numbers with # or / in them. In addition, some street values end in a ..

Remove the house numbers, extra punctuation, and any spaces from the beginning and end of the street values as a first attempt at cleaning up the values.

Instructions
0 XP
Trim digits 0-9, #, /, ., and spaces from the beginning and end of street.
Select distinct original street value and the corrected street value.
Order the results by the original street value.

```sql
SELECT distinct street,
       -- Trim off unwanted characters from street
       trim(street, '0123456789 #/.') AS cleaned_street
  FROM evanston311
 ORDER BY street;
```

## Exploring unstructured text
The description column of evanston311 has the details of the inquiry, while the category column groups inquiries into different types. How well does the category capture what's in the description?

LIKE and ILIKE queries will help you find relevant descriptions and categories. Remember that with LIKE queries, you can include a % on each side of a word to find values that contain the word. For example:

```
SELECT category
  FROM evanston311
 WHERE category LIKE '%Taxi%';
% matches 0 or more characters.
```

Building up the query through the steps below, find inquires that mention trash or garbage in the description without trash or garbage being in the category. What are the most frequent categories for such inquiries?

Use ILIKE to count rows in evanston311 where the description contains 'trash' or 'garbage' regardless of case.

```SQL
-- Count rows
SELECT COUNT(*)
  FROM evanston311
 -- Where description includes trash or garbage
 WHERE description ILIKE '%trash%' OR
    description ILIKE '%garbage%';
```

category values are in title case. Use LIKE to find category values with 'Trash' or 'Garbage' in them.

```SQL
-- Select categories containing Trash or Garbage
SELECT category
  FROM evanston311
 -- Use LIKE
 WHERE category LIKE '%Trash%' 
    OR category LIKE '%Garbage%';
```

Count rows where the description includes 'trash' or 'garbage' but the category does not.

```SQL
-- Count rows
SELECT count(*)
  FROM evanston311 
 -- description contains trash or garbage (any case)
 WHERE (description ILIKE '%trash%'
    OR description ILIKE '%garbage%') 
 -- category does not contain Trash or Garbage
   AND category NOT LIKE '%Trash%'
   AND category NOT LIKE '%Garbage%';
```

Find the most common categories for rows with a description about trash that don't have a trash-related category.

```SQL
-- Count rows with each category
SELECT category, count(*)
  FROM evanston311 
 WHERE (description ILIKE '%trash%'
    OR description ILIKE '%garbage%') 
   AND category NOT LIKE '%Trash%'
   AND category NOT LIKE '%Garbage%'
 -- What are you counting?
 GROUP BY category
 --- order by most frequent values
 ORDER BY count(*) DESC
 LIMIT 10;
```

## Concatenate strings
House number (house_num) and street are in two separate columns in evanston311. Concatenate them together with concat() with a space in between the values.

Instructions
0 XP
Concatenate house_num, a space ' ', and street into a single value using the concat().
Use a trim function to remove any spaces from the start of the concatenated value.

```sql
-- Concatenate house_num, a space, and street
-- and trim spaces from the start of the result
SELECT ltrim(concat(house_num, ' ', street)) AS address
  FROM evanston311;
```

## Split strings on a delimiter
The street suffix is the part of the street name that gives the type of street, such as Avenue, Road, or Street. In the Evanston 311 data, sometimes the street suffix is the full word, while other times it is the abbreviation.

Extract just the first word of each street value to find the most common streets regardless of the suffix.

To do this, use
```
split_part(string_to_split, delimiter, part_number)
```
Instructions
0 XP
Use split_part() to select the first word in street; alias the result as street_name.
Also select the count of each value of street_name.

```sql
-- Select the first word of the street value
SELECT split_part(street, ' ', 1) AS street_name, 
       count(*)
  FROM evanston311
 GROUP BY street_name
 ORDER BY count DESC
 LIMIT 20;
```

## Shorten long strings
The description column of evanston311 can be very long. You can get the length of a string with the length() function.

For displaying or quickly reviewing the data, you might want to only display the first few characters. You can use the left() function to get a specified number of characters at the start of each value.

To indicate that more data is available, concatenate '...' to the end of any shortened description. To do this, you can use a CASE WHEN statement to add '...' only when the string length is greater than 50.

Select the first 50 characters of description when description starts with the word "I".

Instructions
0 XP
Instructions
0 XP
Select the first 50 characters of description with '...' concatenated on the end where the length() of the description is greater than 50 characters. Otherwise just select the description as is.

Select only descriptions that begin with the word 'I' and not the letter 'I'.

For example, you would want to select "I like using SQL!", but would not want to select "In this course we use SQL!".

```sql
-- Select the first 50 chars when length is greater than 50
SELECT CASE WHEN length(description) > 50
            THEN left(description, 50) || '...'
       -- otherwise just select description
       ELSE description
       END
  FROM evanston311
 -- limit to descriptions that start with the word I
 WHERE description LIKE 'I %'
 ORDER BY description;
```

## Group and recode values
There are almost 150 distinct values of evanston311.category. But some of these categories are similar, with the form "Main Category - Details". We can get a better sense of what requests are common if we aggregate by the main category.

To do this, create a temporary table recode mapping distinct category values to new, standardized values. Make the standardized values the part of the category before a dash ('-'). Extract this value with the split_part() function:
```
split_part(string text, delimiter text, field int)
```
You'll also need to do some additional cleanup of a few cases that don't fit this pattern.

Then the evanston311 table can be joined to recode to group requests by the new standardized category values.

Create recode with a standardized column; use split_part() and then rtrim() to remove any remaining whitespace on the result of split_part().

```sql
-- Fill in the command below with the name of the temp table
DROP TABLE IF EXISTS recode;

-- Create and name the temporary table
CREATE TEMP TABLE recode AS
-- Write the select query to generate the table 
-- with distinct values of category and standardized values
  SELECT DISTINCT category, 
         rtrim(split_part(category, '-', 1)) AS standardized
    -- What table are you selecting the above values from?
    FROM evanston311;
       
-- Look at a few values before the next step
SELECT DISTINCT standardized 
  FROM recode
 WHERE standardized LIKE 'Trash%Cart'
    OR standardized LIKE 'Snow%Removal%';
```

UPDATE standardized values LIKE 'Trash%Cart' to 'Trash Cart'.
UPDATE standardized values of 'Snow Removal/Concerns' and 'Snow/Ice/Hazard Removal' to 'Snow Removal'.

```sql
-- Code from previous step
DROP TABLE IF EXISTS recode;

CREATE TEMP TABLE recode AS
  SELECT DISTINCT category, 
         rtrim(split_part(category, '-', 1)) AS standardized
    FROM evanston311;
  
-- Update to group trash cart values
UPDATE recode 
   SET standardized='Trash Cart' 
 WHERE standardized LIKE 'Trash%Cart';

-- Update to group snow removal values
UPDATE recode
   SET standardized='Snow Removal' 
 WHERE standardized LIKE 'Snow%Removal%';
 
-- Examine effect of updates
SELECT DISTINCT standardized 
  FROM recode
 WHERE standardized LIKE 'Trash%Cart'
    OR standardized LIKE 'Snow%Removal%';
```

UPDATE recode by setting standardized values of 'THIS REQUEST IS INACTIVE…Trash Cart', '(DO NOT USE) Water Bill', 'DO NOT USE Trash', and 'NO LONGER IN USE' to 'UNUSED'.

```sql
-- Code from previous step
DROP TABLE IF EXISTS recode;

CREATE TEMP TABLE recode AS
  SELECT DISTINCT category, 
         rtrim(split_part(category, '-', 1)) AS standardized
    FROM evanston311;
  
UPDATE recode SET standardized='Trash Cart' 
 WHERE standardized LIKE 'Trash%Cart';

UPDATE recode SET standardized='Snow Removal' 
 WHERE standardized LIKE 'Snow%Removal%';

-- Update to group unused/inactive values
UPDATE recode 
   SET standardized='UNUSED' 
 WHERE standardized IN ('THIS REQUEST IS INACTIVE...Trash Cart', 
               '(DO NOT USE) Water Bill',
               'DO NOT USE Trash', 
               'NO LONGER IN USE');

-- Examine effect of updates
SELECT DISTINCT standardized 
  FROM recode
 ORDER BY standardized;
```

Now, join the evanston311 and recode tables to count the number of requests with each of the standardized values
List the most common standardized values first.

```sql
-- Code from previous step
DROP TABLE IF EXISTS recode;
CREATE TEMP TABLE recode AS
  SELECT DISTINCT category, 
         rtrim(split_part(category, '-', 1)) AS standardized
  FROM evanston311;
UPDATE recode SET standardized='Trash Cart' 
 WHERE standardized LIKE 'Trash%Cart';
UPDATE recode SET standardized='Snow Removal' 
 WHERE standardized LIKE 'Snow%Removal%';
UPDATE recode SET standardized='UNUSED' 
 WHERE standardized IN ('THIS REQUEST IS INACTIVE...Trash Cart', 
               '(DO NOT USE) Water Bill',
               'DO NOT USE Trash', 'NO LONGER IN USE');

-- Select the recoded categories and the count of each
SELECT standardized, count(*) 
-- From the original table and table with recoded values
  FROM evanston311 
       LEFT JOIN recode 
       -- What column do they have in common?
       ON evanston311.category=recode.category 
 -- What do you need to group by to count?
 GROUP BY standardized
 -- Display the most common val values first
 ORDER BY count DESC;
```

## Create a table with indicator variables
Determine whether medium and high priority requests in the evanston311 data are more likely to contain requesters' contact information: an email address or phone number.

Emails contain an @.

Phone numbers have the pattern of three characters, dash, three characters, dash, four characters. For example: 555-555-1212.

Use LIKE to match these patterns. Remember % matches any number of characters (even 0), and _ matches a single character. Enclosing a pattern in % (i.e. before and after your pattern) allows you to locate it within other text.

For example, ```'%___.com%'```would allow you to search for a reference to a website with the top-level domain '.com' and at least three characters preceding it.

Create and store indicator variables for email and phone in a temporary table. LIKE produces True or False as a result, but casting a boolean (True or False) as an integer converts True to 1 and False to 0. This makes the values easier to summarize later.

Create a temp table indicators from evanston311 with three columns: id, email, and phone.

Use LIKE comparisons to detect the email and phone patterns that are in the description, and cast the result as an integer with CAST().

Your phone indicator should use a combination of underscores _ and dashes - to represent a standard 10-digit phone number format.

Remember to start and end your patterns with % so that you can locate the pattern within other text!

```sql
-- To clear table if it already exists
DROP TABLE IF EXISTS indicators;

-- Create the indicators temp table
CREATE TEMP TABLE indicators AS
  -- Select id
  SELECT id, 
         -- Create the email indicator (find @)
         CAST (description LIKE '%@%' AS integer) AS email,
         -- Create the phone indicator
         CAST (description LIKE '%___-___-____%' AS integer) AS phone 
    -- What table contains the data? 
    FROM evanston311;

-- Inspect the contents of the new temp table
SELECT *
  FROM indicators;
```

Join the indicators table to evanston311, selecting the proportion of reports including an email or phone grouped by priority.

Include adjustments to account for issues arising from integer division.

```sql
-- To clear table if it already exists
DROP TABLE IF EXISTS indicators;

-- Create the temp table
CREATE TEMP TABLE indicators AS
  SELECT id, 
         CAST (description LIKE '%@%' AS integer) AS email,
         CAST (description LIKE '%___-___-____%' AS integer) AS phone 
    FROM evanston311;

-- Select the column you'll group by
SELECT priority, 
       -- Compute the proportion of rows with each indicator
       sum(email)/count(*)::numeric AS email_prop, 
       sum(phone)/count(*)::numeric AS phone_prop 
  -- Tables to select from
  FROM evanston311
       LEFT JOIN indicators
       -- Joining condition
       ON evanston311.id=indicators.id
 -- What are you grouping by?
 GROUP BY priority;
```

## Date comparisons
When working with timestamps, sometimes you want to find all observations on a given day. However, if you specify only a date in a comparison, you may get unexpected results. This query:
```
SELECT count(*) 
  FROM evanston311
 WHERE date_created = '2018-01-02'
```
returns 0, even though there were 49 requests on January 2, 2018.

This is because dates are automatically converted to timestamps when compared to a timestamp. The time fields are all set to zero:
```
SELECT '2018-01-02'::timestamp;
```
```
2018-01-02 00:00:00
```
When working with both timestamps and dates, you'll need to keep this in mind.

Count the number of Evanston 311 requests created on January 31, 2017 by casting date_created to a date.

```SQL
-- Count requests created on January 31, 2017
SELECT count(*) 
  FROM evanston311
 WHERE date_created::date = '2017-01-31';
```

Count the number of Evanston 311 requests created on February 29, 2016 by using >= and < operators.

```sql
-- Count requests created on February 29, 2016
SELECT count(*)
  FROM evanston311 
 WHERE date_created >= '2016-02-29' 
   AND date_created < '2016-03-01';
```

Count the number of requests created on March 13, 2017.
Specify the upper bound by adding 1 to the lower bound.

```sql
-- Count requests created on March 13, 2017
SELECT count(*)
  FROM evanston311
 WHERE date_created >= '2017-03-13'
   AND date_created < '2017-03-13'::date + 1;
```

## Date arithmetic
You can subtract dates or timestamps from each other.

You can add time to dates or timestamps using intervals. An interval is specified with a number of units and the name of a datetime field. For example:

```
'3 days'::interval
'6 months'::interval
'1 month 2 years'::interval
'1 hour 30 minutes'::interval
```

Practice date arithmetic with the Evanston 311 data and now().

Subtract the minimum date_created from the maximum date_created.

```sql
-- Subtract the min date_created from the max
SELECT max(date_created) - min(date_created)
  FROM evanston311;
```

Using now(), find out how old the most recent evanston311 request was created.

```sql
-- How old is the most recent request?
SELECT now() - max(date_created)
  FROM evanston311;
```

Add 100 days to the current timestamp.

```sql
-- Add 100 days to the current timestamp
SELECT now() + '100 days'::interval;
```

Select the current timestamp and the current timestamp plus 5 minutes.

```sql
-- Select the current timestamp, 
-- and the current timestamp + 5 minutes
SELECT now(),
       now() + '5 minutes'::interval;
```

## Completion time by category
The evanston311 data includes a date_created timestamp from when each request was created and a date_completed timestamp for when it was completed. The difference between these tells us how long a request was open.

Which category of Evanston 311 requests takes the longest to complete?

Instructions
100 XP
Compute the average difference between the completion timestamp and the creation timestamp by category.
Order the results with the largest average time to complete the request first.

```sql
-- Select the category and the average completion time by category
SELECT category, 
       avg(date_completed - date_created) AS completion_time
  FROM evanston311
 GROUP BY category
-- Order the results
 ORDER BY completion_time DESC;
```

## Date parts
The date_part() function is useful when you want to aggregate data by a unit of time across multiple larger units of time. For example, aggregating data by month across different years, or aggregating by hour across different days.

Recall that you use date_part() as:
```
SELECT date_part('field', timestamp);
```

In this exercise, you'll use date_part() to gain insights about when Evanston 311 requests are submitted and completed.

How many requests are created in each of the 12 months during 2016-2017?

```sql
-- Extract the month from date_created and count requests
SELECT date_part('month', date_created) AS month, 
       count(*)
  FROM evanston311
 -- Limit the date range
 WHERE date_created >= '2016-01-01'
   AND date_created < '2018-01-01'
 -- Group by what to get monthly counts?
 GROUP BY month;
```

What is the most common hour of the day for requests to be created?

```sql
-- Get the hour and count requests
SELECT date_part('hour', date_created) AS hour,
       count(*)
  FROM evanston311
 GROUP BY hour
 -- Order results to select most common
 ORDER BY count DESC
 LIMIT 1;
```

During what hours are requests usually completed? Count requests completed by hour.
Order the results by hour.

```sql
-- Count requests completed by hour
SELECT date_part('hour', date_completed) AS hour,
       count(*)
  FROM evanston311
 GROUP BY hour
 ORDER BY hour;
```

## Variation by day of week
Does the time required to complete a request vary by the day of the week on which the request was created?

We can get the name of the day of the week by converting a timestamp to character data:
```
to_char(date_created, 'day') 
```
But character names for the days of the week sort in alphabetical, not chronological, order. To get the chronological order of days of the week with an integer value for each day, we can use:
```
EXTRACT(DOW FROM date_created)
```
DOW stands for "day of week."

Select the name of the day of the week the request was created (date_created) as day.
Select the mean time between the request completion (date_completed) and request creation as duration.
Group by day (the name of the day of the week) and the integer value for the day of the week (use a function).
Order by the integer value of the day of the week using the same function used in GROUP BY.

```sql
-- Select name of the day of the week the request was created 
SELECT to_char(date_created, 'day') AS day, 
       -- Select avg time between request creation and completion
       avg(date_completed - date_created) AS duration 
  FROM evanston311 
 -- Group by the name of the day of the week and 
 -- integer value of day of week the request was created
 GROUP BY day, EXTRACT(DOW FROM date_created) 
 -- Order by integer value of the day of the week 
 -- the request was created
 ORDER BY EXTRACT(DOW FROM date_created);
```

## Date truncation
Unlike date_part() or EXTRACT(), date_trunc() keeps date/time units larger than the field you specify as part of the date. So instead of just extracting one component of a timestamp, date_trunc() returns the specified unit and all larger ones as well.

Recall the syntax:
```
date_trunc('field', timestamp)
```
Using date_trunc(), find the average number of Evanston 311 requests created per day for each month of the data. Ignore days with no requests when taking the average.

```sql
-- Aggregate daily counts by month
SELECT date_trunc('month', day) AS month,
       avg(count)
  -- Subquery to compute daily counts
  FROM (SELECT date_trunc('day', date_created) AS day,
               count(*) AS count
          FROM evanston311
         GROUP BY day) AS daily_count
 GROUP BY month
 ORDER BY month;
```

## Find missing dates
The generate_series() function can be useful for identifying missing dates.

Recall:

generate_series(from, to, interval)
where from and to are dates or timestamps, and interval can be specified as a string with a number and a unit of time, such as '1 month'.

Are there any days in the Evanston 311 data where no requests were created?

Instructions
100 XP
Write a subquery using generate_series() to get all dates between the min() and max() date_created in evanston311.
Write another subquery to select all values of date_created as dates from evanston311.
Both subqueries should produce values of type date (look for the ::).
Select dates (day) from the first subquery that are NOT IN the results of the second subquery. This gives you days that are not in date_created.


```sql
SELECT day
-- 1) Subquery to generate all dates
-- from min to max date_created
  FROM (SELECT generate_series(min(date_created),
                               max(date_created),
                               '1 day')::date AS day
          -- What table is date_created in?
          FROM evanston311) AS all_dates      
-- 4) Select dates (day from above) that are NOT IN the subquery
 WHERE day NOT IN 
       -- 2) Subquery to select all date_created values as dates
       (SELECT date_created::date
          FROM evanston311);
```

## Custom aggregation periods
Find the median number of Evanston 311 requests per day in each six month period from 2016-01-01 to 2018-06-30. Build the query following the three steps below.

Recall that to aggregate data by non-standard date/time intervals, such as six months, you can use generate_series() to create bins with lower and upper bounds of time, and then summarize observations that fall in each bin.

Remember: you can access the slides with an example of this type of query using the PDF icon link in the upper right corner of the screen.

Instructions 1/3
35 XP
1
2
3
Use generate_series() to create bins of 6 month intervals. Recall that the upper bin values are exclusive, so the values need to be one day greater than the last day to be included in the bin.

Notice how in the sample code, the first bin value of the upper bound is July 1st, and not June 30th.
Use the same approach when creating the last bin values of the lower and upper bounds (i.e. for 2018).

```sql
-- Generate 6 month bins covering 2016-01-01 to 2018-06-30

-- Create lower bounds of bins
SELECT generate_series('2016-01-01',  -- First bin lower value
                       '2018-01-01',  -- Last bin lower value
                       '6 months'::interval) AS lower,
-- Create upper bounds of bins
       generate_series('2016-07-01',  -- First bin upper value
                       '2018-07-01',  -- Last bin upper value
                       '6 months'::interval) AS upper;
```

Count the number of requests created per day. Remember to not count * or you will risk counting NULL values.

Include days with no requests by joining evanston311 to a daily series from 2016-01-01 to 2018-06-30.

- Note that because we are not generating bins, you can use June 30th as your series end date.

```sql
-- Count number of requests made per day 
SELECT day, count(date_created) AS count
-- Use a daily series from 2016-01-01 to 2018-06-30 
-- to include days with no requests
  FROM (SELECT generate_series('2016-01-01',  -- series start date
                               '2018-06-30',  -- series end date
                               '1 day'::interval)::date AS day) AS daily_series
       LEFT JOIN evanston311
       -- match day from above (which is a date) to date_created
       ON day = date_created::date
 GROUP BY day;
```

Assign each daily count to a single 6 month bin by joining bins to daily_counts.
Compute the median value per bin using percentile_disc().

```sql
-- Bins from Step 1
WITH bins AS (
   SELECT generate_series('2016-01-01',
                            '2018-01-01',
                            '6 months'::interval) AS lower,
            generate_series('2016-07-01',
                            '2018-07-01',
                            '6 months'::interval) AS upper),
-- Daily counts from Step 2
     daily_counts AS (
     SELECT day, count(date_created) AS count
       FROM (SELECT generate_series('2016-01-01',
                                    '2018-06-30',
                                    '1 day'::interval)::date AS day) AS daily_series
            LEFT JOIN evanston311
            ON day = date_created::date
      GROUP BY day)
-- Select bin bounds
SELECT lower, 
       upper, 
       -- Compute median of count for each bin
       percentile_disc(0.5) WITHIN GROUP (ORDER BY count) AS median
  -- Join bins and daily_counts
  FROM bins
       LEFT JOIN daily_counts
       -- Where the day is between the bin bounds
       ON day >= lower
          AND day < upper
 -- Group by bin bounds
 GROUP BY lower, upper
 ORDER BY lower;
```

## Monthly average with missing dates
Find the average number of Evanston 311 requests created per day for each month of the data.

This time, do not ignore dates with no requests.

Instructions
100 XP
Generate a series of dates from 2016-01-01 to 2018-06-30.
Join the series to a subquery to count the number of requests created per day.
Use date_trunc() to get months from date, which has all dates, NOT day.
Use coalesce() to replace NULL count values with 0. Compute the average of this value.

```sql
-- generate series with all days from 2016-01-01 to 2018-06-30
WITH all_days AS 
     (SELECT generate_series('2016-01-01',
                             '2018-06-30',
                             '1 day'::interval) AS date),
     -- Subquery to compute daily counts
     daily_count AS 
     (SELECT date_trunc('day', date_created) AS day,
             count(*) AS count
        FROM evanston311
       GROUP BY day)
-- Aggregate daily counts by month using date_trunc
SELECT date_trunc('month', date) AS month,
       -- Use coalesce to replace NULL count values with 0
       avg(coalesce(count, 0)) AS average
  FROM all_days
       LEFT JOIN daily_count
       -- Joining condition
       ON all_days.date=daily_count.day
 GROUP BY month
 ORDER BY month; 
```

## Longest gap
What is the longest time between Evanston 311 requests being submitted?

Recall the syntax for lead() and lag():
```
lag(column_to_adjust) OVER (ORDER BY ordering_column)
lead(column_to_adjust) OVER (ORDER BY ordering_column)
```
Instructions
100 XP
Select date_created and the date_created of the previous request using lead() or lag() as appropriate.
Compute the gap between each request and the previous request.
Select the row with the maximum gap.

```sql
-- Compute the gaps
WITH request_gaps AS (
        SELECT date_created,
               -- lead or lag
               lag(date_created) OVER (ORDER BY date_created) AS previous,
               -- compute gap as date_created minus lead or lag
               date_created - lag(date_created) OVER (ORDER BY date_created) AS gap
          FROM evanston311)
-- Select the row with the maximum gap
SELECT *
  FROM request_gaps
-- Subquery to select maximum gap from request_gaps
 WHERE gap = (SELECT max(gap) 
                FROM request_gaps);
```

## Rats!
Requests in category "Rodents- Rats" average over 64 days to resolve. Why?

Investigate in 4 steps:

Why is the average so high? Check the distribution of completion times. Hint: date_trunc() can be used on intervals.

See how excluding outliers influences average completion times.

Do requests made in busy months take longer to complete? Check the correlation between the average completion time and requests per month.

Compare the number of requests created per month to the number completed.

Remember: the time to resolve, or completion time, is date_completed - date_created.

Use date_trunc() to examine the distribution of rat request completion times by number of days.

```sql
-- Truncate the time to complete requests to the day
SELECT date_trunc('day', date_completed - date_created) AS completion_time,
-- Count requests with each truncated time
       count(*) 
  FROM evanston311
-- Where category is rats
 WHERE category = 'Rodents- Rats'
-- Group and order by the variable of interest
 GROUP BY completion_time
 ORDER BY completion_time;
```

Compute average completion time per category excluding the longest 5% of requests (outliers).

```sql
SELECT category, 
       -- Compute average completion time per category
       avg(date_completed - date_created) AS avg_completion_time
  FROM evanston311
-- Where completion time is less than the 95th percentile value
 WHERE date_completed - date_created < 
-- Compute the 95th percentile of completion time in a subquery
         (SELECT percentile_disc(0.95) WITHIN GROUP (ORDER BY date_completed - date_created)
            FROM evanston311)
 GROUP BY category
-- Order the results
 ORDER BY avg_completion_time DESC;
```

Get corr() between avg. completion time and monthly requests. EXTRACT(epoch FROM interval) returns seconds in interval.

```sql
-- Compute correlation (corr) between 
-- avg_completion time and count from the subquery
SELECT corr(avg_completion, count)
  -- Convert date_created to its month with date_trunc
  FROM (SELECT date_trunc('month', date_created) AS month, 
               -- Compute average completion time in number of seconds           
               avg(EXTRACT(epoch FROM date_completed - date_created)) AS avg_completion, 
               -- Count requests per month
               count(*) AS count
          FROM evanston311
         -- Limit to rodents
         WHERE category='Rodents- Rats' 
         -- Group by month, created above
         GROUP BY month) 
         -- Required alias for subquery 
         AS monthly_avgs;
```

Select the number of requests created and number of requests completed per month.

```sql
-- Compute monthly counts of requests created
WITH created AS (
       SELECT date_trunc('month', date_created) AS month,
              count(*) AS created_count
         FROM evanston311
        WHERE category='Rodents- Rats'
        GROUP BY month),
-- Compute monthly counts of requests completed
      completed AS (
       SELECT date_trunc('month', date_completed) AS month,
              count(*) AS completed_count
         FROM evanston311
        WHERE category='Rodents- Rats'
        GROUP BY month)
-- Join monthly created and completed counts
SELECT created.month, 
       created_count, 
       completed_count
  FROM created
       INNER JOIN completed
       ON created.month=completed.month
 ORDER BY created.month;
```
