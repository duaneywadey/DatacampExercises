# Reporting data in SQL

## What is reporting?

1. Case study
Hello! Welcome to this reporting in SQL course. My name is Tyler, and I will be your instructor.

2. What is reporting?
This course aims to strengthen your SQL skills specifically for reporting. But what do I mean when I say reporting? Reporting is the act of presenting data in any shape or form. This can be in the form of a table, a visualization, or simply a number.

3. What is reporting?
So who actually uses reporting? Well, reporting is used by a wide array of individuals in business settings.

4. What is reporting?
For example, you may be a data scientist who must pull reports to answer business questions.

5. What is reporting?
Or perhaps you are a data visualization specialist looking to build robust visualizations using your tool of choice, whether that is R, Python, Excel, or Tableau.

6. What is reporting?
Or maybe you are a software developer looking to add dynamic values to a page on your website.

7. SQL and reporting
Regardless of the situation, reporting always starts the same way: by gathering the data. If that data is stored in a database, you’ll likely be using SQL to pull it. This course aims to provide you the ins-and-outs of using PostgreSQL to pull reports in a variety of ways.

8. Course goals
By the end of this course, you will know how to create real-world reports using real-world data by overcoming real-world obstacles. To give you this taste of reality, this course is centered around a case study.

9. Case study
Here's the case study you will be working on. You just got hired as a data scientist for the up-and-coming sports marketing company DataBallers.

10. Case study
The company has recently been asked to market perhaps the largest global sports event in the world: the Olympics. This is clearly a huge opportunity for the company, but your company has never been involved in global events.

11. Case study
Unsure about how to move forward, the executive team has asked you for guidance. Luckily, the stakeholders already put together a mock-up of a dashboard they are looking for you to create.

12. What is a dashboard?
A dashboard is a collection of reports or visualizations aimed to answer specific questions. Here’s an example dashboard, in this case related to a soccer tournament. Each element in a dashboard is derived from what we call a base report.

13. What is a base report?
A base report is the underlying report that sources a visualization. We use a SQL statement to build this base report. For example, the bar on the right is our visualization which shows wins by country, is ordered by wins, and only keeps three rows. This visualization references the data from the base report shown on the left, which we can get to using this SQL statement. This query pulls in country and wins from the game_log table. The output is ordered by wins in descending order, and keeps only the top 3 rows.

14. Your dashboard
Here is the dashboard your executive team has asked you to build. During this course, each chapter will revolve around building one of these elements. Since this course is focused purely on reporting and not visualization, we will only focus on building the base report for each element.

15. Querying time!
Enough talking! Let's get to it and start building some queries.

## Building the base report
Now, build the base report for this visualization:

This should be built by querying the summer_games table, found in the explorer on the bottom right.

Instructions
100 XP
Using the console on the right, select the sport field from the summer_games table.
Create athletes by counting the distinct occurrences of athlete_id.
Group by the sport field.
Make the report only show 3 rows, with the highest athletes at the top.

```SQL
-- Query the sport and distinct number of athletes
SELECT 
	sport, 
    COUNT(DISTINCT(athlete_id)) AS athletes
FROM summer_games
GROUP BY sport
-- Only include the 3 sports with the most athletes
ORDER BY athletes
LIMIT 5;
```

## Athletes vs events by sport
Now consider the following visualization:

Using the summer_games table, run a query that creates the base report that sources this visualization.

Instructions
100 XP
Pull a report that shows each sport, the number of unique events, and the number of unique athletes from the summer_games table.
Group by the non-aggregated field, which is sport.

```SQL
-- Query sport, events, and athletes from summer_games
SELECT 
	sport, 
    COUNT(DISTINCT event) AS events, 
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
GROUP BY sport;
```

## The Olympics Dataset


Got It!
1. The Olympics dataset
Now that you understand the case study, it’s time to learn about our dataset. Before we dig into the data, I’d like to introduce the concept of an E:R Diagram.

2. Entity-Relationship (E:R) diagram
An E:R or entity-relationship diagram is a visual representation of a database's structure. E:R diagrams show all tables and fields, and connects objects visually to show relationships. An E:R diagram is a great resource to quickly understand the structure of a database.

3. Olympics dataset E:R diagram
Here’s the E:R diagram of our Olympics dataset. It consists of 5 tables: summer_games, winter_games, athletes, countries, and country_stats. Pay attention to the fields found in each table. You’ll notice several “id” fields. An id field represents a unique object and allows for joins between two tables.

4. Olympics dataset E:R diagram
For example, each “id” field in the countries table represents a unique country.

5. Olympics dataset E:R diagram
This id relates to the “country_id” field in the country_stats table. It should be no surprise, then, that when we join the two tables, we join on these two highlighted fields.

6. Tables and fields
Let’s dig a bit deeper into each of the tables. The athletes table appears straightforward; each row represents an athlete, including their name, gender, age, height, and weight.

7. Tables and fields
The summer_games and winter_games tables have the exact same structure. Each row represents the results of a given athlete within an Olympic event. There are three fields that appear to represent the medals in the event: bronze, silver, and gold. We will need to dig into these three fields to understand the format.

8. Tables and fields
Countries is a straightforward table as well, as it simply includes the country and its corresponding region.

9. Tables and fields
Lastly, the country_stats table tracks several metrics related to countries, including gdp, population, and nobel_prize_winners. When dealing with a novel dataset, I recommend taking the time to get a high-level understanding of the tables and relationships. There may be crucial fields that you are not aware of, but taking time to understand the tables and fields can help prevent that situation.

10. Reference for queries
Outside of giving a high-level overview of the tables and fields, E:R diagrams can also be a good reference document when planning out large queries. If you know the required fields for your report, you can identify what tables need to be pulled

11. Reference for queries
by highlighting the relevant fields. Then, you can visually understand what types of JOINs, UNIONs, and other logic may be needed when building your query.

12. Reference for queries
Here’s an example. Let’s say you are trying to build a report that shows total population by region. By looking at the E:R diagram, we can quickly identify which fields are required, as highlighted. We now have an idea what tables need to be pulled and should have an easier time setting up the query. According to the E:R diagram, we can pull from the countries table and then join to the country_stats table ON the id and country_id fields, as indicated by the connector. The full query is shown here, which joins countries and country_stats to pull in region and pop_in_millions. Notice how the ON statement joins the two tables on the id and country_id fields, respectively.

13. Practice time!
Next up, let's practice using E:R diagrams when setting up queries.


## Age of oldest athlete by region
You are given the following E:R diagram:



In the previous exercise, you identified which tables are needed to create a report that shows Age of Oldest Athlete by Region. Now, set up the query to create this report.

Instructions
100 XP
Create a report that shows region and age_of_oldest_athlete.
Include all three tables by running two separate JOIN statements.
Group by the non-aggregated field.
Alias each table AS the first letter in the table (in lower case).

```sql
-- Select the age of the oldest athlete for each region
SELECT 
	cn.region, 
    max(a.age) AS age_of_oldest_athlete
FROM athletes a 
-- First JOIN statement
JOIN summer_games sg
ON a.id = sg.athlete_id
-- Second JOIN statement
JOIN countries cn
ON sg.country_id = cn.id
GROUP BY cn.region;
```

## Number of events in each sport
The full E:R diagram for the database is shown below:



Since the company will be involved in both summer sports and winter sports, it is beneficial to look at all sports in one centralized report.

Your task is to create a query that shows the unique number of events held for each sport. Note that since no relationships exist between these two tables, you will need to use a UNION instead of a JOIN.

Instructions
100 XP
Create a report that shows unique events by sport for both summer and winter events.
Use a UNION to combine the relevant tables.
Use two GROUP BY statements as needed.
Order the final query to show the highest number of events first.

```sql
-- Select sport and events for summer sports
SELECT 
	sport, 
    COUNT(DISTINCT event) AS events
FROM summer_games
GROUP BY sport
UNION
-- Select sport and events for winter sports
SELECT 
	sport, 
    COUNT(DISTINCT event) AS events
FROM winter_games
GROUP BY sport
-- Show the most events at the top of the report
ORDER BY events DESC;
```

## Exploring our data

1. Exploring our data
Last lesson, we learned how E:R diagrams help us understand the structure of a database. But structure is only half of the equation; we also want to understand the actual data. This is where DATA EXPLORATION comes in.

2. Exploring with the console
The simplest way to explore data is to look at a preview, such as in a SQL client or in the DataCamp console. While this does quickly answer questions about what each field means, there are limitations to this approach.

3. Exploring with the console
First, since it’s only a preview of the dataset, it’s possible the preview does not provide an accurate picture. For example, when looking in the explorer at the summer_games table, you may only see NULL values for the bronze field. While it is useful to understand NULL values exist, it does not provide any information about existing values.

4. Exploring with the console
Second, previews do not provide any information on the distribution of values. For example, you may work for a company that works primarily in Europe. If the first few rows in the preview are North American countries, you may incorrectly conclude the company primarily works with North American clients.

5. Exploring with queries
A more robust approach to exploring the data is to run simple queries. By SELECTing the distinct values in the region field, we learn that the field is formatted with all uppercase. We also have a better understanding of what the region field represents after viewing the values.

6. Exploring with queries
You can also add a GROUP BY instead of DISTINCT to get this report. This query may perform better, but our dataset is not large enough to worry about performance. Regardless, it’s an important concept to know about.

7. Field-level aggregations
Another exploration technique is to include an aggregated metric and sort the data to identify value distributions. By adding COUNT() to our query, you can see which values are most common.

8. Field-level aggregations
The same technique can be used with other metrics, such as sum, max, min, and average. Sum is useful when looking at revenue sources in a business. If 99% of your company’s revenue comes from two sources, then you may want to focus on these sources when building reports.

9. Table-level aggregations
You can also leverage aggregations on the table level. A simple COUNT() shows how large a table is, which may impact how you construct your query as well as your understanding of what the table represents. If you expected only a few rows, but the table has several thousand rows, the table may have a different meaning than you expected.

10. Query validation
These data exploration techniques can also be used to validate queries. Remember that an INNER JOIN only keeps common values between two tables. Because of this, it’s possible we lose rows after a join.

11. Query validation
A useful approach is to turn your query into a subquery and run an aggregation on it. By comparing total revenue in the original table versus our query, we can identify any inconsistencies in our data. In this example, we are losing revenue in our query due to some rows being excluded after the JOIN.

12. Query validation
The same applies when testing for duplication. In this example, some rows are showing multiple times after the join, causing a major increase in revenue. Validating your query is a crucial step to ensure your report is reliable.

13. Let's explore!
Let’s practice exploring our dataset, then finish up the chapter by creating our first report in the dashboard.

## Exploring summer_games
Exploring the data in a table can provide further insights into the database as a whole. In this exercise, you will try out a series of different techniques to explore the summer_games table.

Instructions 4/4
25 XP
4
Let's see how much of our dataset is NULL. Add a field that shows number of rows to your query.

```SQL
-- Add the rows column to your query
SELECT 
	bronze, 
	COUNT(*) AS rows
FROM summer_games
GROUP BY bronze;
```

## Validating our query
The same techniques we use to explore the data can be used to validate queries. By using the query as a subquery, you can run exploratory techniques to confirm the query results are as expected.

In this exercise, you will create a query that shows Bronze Medals by Country and then validate it using the subquery technique.

Feel free to reference the E:R Diagram as needed.

Instructions 1/3
35 XP
1
2
3
The value for total_bronze_medals is commented out for reference. Setup a query that shows bronze_medals for summer_games by country.

```sql
/* Pull total_bronze_medals from summer_games below
SELECT SUM(bronze) AS total_bronze_medals
FROM summer_games; 
>> OUTPUT = 141 total_bronze_medals */

-- Setup a query that shows bronze_medal by country
SELECT 
	country, 
    SUM(bronze) AS bronze_medals
FROM summer_games AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY country;
```

Add parenthesis to your query you just created and alias as subquery.
Select the total number of bronze_medals and compare to the total bronze medals in summer_games.

```sql
/* Pull total_bronze_medals from summer_games below
SELECT SUM(bronze) AS total_bronze_medals
FROM summer_games; 
>> OUTPUT = 141 total_bronze_medals */

-- Select the total bronze_medals from your query
SELECT SUM(bronze_medals)
FROM 
-- Previous query is shown below.  Alias this AS subquery.
  (SELECT 
      country, 
      SUM(bronze) AS bronze_medals
  FROM summer_games AS s
  JOIN countries AS c
  ON s.country_id = c.id
  GROUP BY country) AS subquery
;
```

## Report 1: Most decorated summer athletes
Now that you have a good understanding of the data, let's get back to our case study and build out the first element for the dashboard, Most Decorated Summer Athletes:



Your job is to create the base report for this element. Base report details:

Column 1 should be athlete_name.
Column 2 should be gold_medals.
The report should only include athletes with at least 3 medals.
The report should be ordered by gold medals won, with the most medals at the top.
Instructions
100 XP
Instructions
100 XP
Select athlete_name and gold_medals by joining summer_games and athletes.
Only include athlete_name with at least 3 gold medals.
Sort the table so that the most gold_medals appears at the top.

```sql
-- Pull athlete_name and gold_medals for summer games
SELECT 
	a.name AS athlete_name, 
    SUM(gold) AS gold_medals
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
GROUP BY a.name
-- Filter for only athletes with 3 gold medals or more
HAVING SUM(gold) > 2
-- Sort to show the most gold medals at the top
ORDER BY gold_medals DESC;
```

## JOIN then UNION query
Your goal is to create a report with the following fields:

season, which outputs either summer or winter
country
events, which shows the unique number of events
There are multiple ways to create this report. In this exercise, create the report by using the JOIN first, UNION second approach.

As always, feel free to reference your E:R Diagram to identify relevant fields and tables.

Instructions
100 XP
Setup a query that shows unique events by country and season for summer events.
Setup a similar query that shows unique events by country and season for winter events.
Combine the two queries using a UNION ALL.
Sort the report by events in descending order.

```sql
-- Query season, country, and events for all summer events
SELECT 
  'summer' AS season, 
    country, 
    COUNT(DISTINCT event) AS events
FROM summer_games AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY country
-- Combine the queries
UNION ALL
-- Query season, country, and events for all winter events
SELECT 
  'winter' AS season, 
    country, 
    COUNT(DISTINCT event) AS events
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
GROUP BY country
-- Sort the results to show most events at the top
ORDER BY events DESC;
```

## UNION then JOIN query
Your goal is to create the same report as before, which contains with the following fields:

season, which outputs either summer or winter
country
events, which shows the unique number of events
In this exercise, create the query by using the UNION first, JOIN second approach. When taking this approach, you will need to use the initial UNION query as a subquery. The subquery will need to include all relevant fields, including those used in a join.

As always, feel free to reference the E:R Diagram.

Instructions
100 XP
In the subquery, construct a query that outputs season, country_id and event by combining summer and winter games with a UNION ALL.
Leverage a JOIN and another SELECT statement to show the fields season, country and unique events.
GROUP BY any unaggregated fields.
Sort the report by events in descending order.

```sql
-- Add outer layer to pull season, country and unique events
SELECT 
  season, 
    country, 
    COUNT(DISTINCT event) AS events
FROM
    -- Pull season, country_id, and event for both seasons
    (SELECT 
      'summer' AS season, 
      country_id, 
      event
    FROM summer_games
    UNION ALL
    SELECT 
      'winter' AS season, 
      country_id, 
      event
    FROM winter_games) AS subquery
JOIN countries AS c
ON subquery.country_id = c.id
-- Group by any unaggregated fields
GROUP BY season, country
-- Order to show most events at the top
ORDER BY events DESC;
```

## CASE statement refresher
CASE statements are useful for grouping values into different buckets based on conditions you specify. Any row that fails to satisfy any condition will fall to the ELSE statement (or show as null if no ELSE statement exists).

In this exercise, your goal is to create the segment field that buckets an athlete into one of three segments:

Tall Female, which represents a female that is at least 175 centimeters tall.
Tall Male, which represents a male that is at least 190 centimeters tall.
Other
Each segment will need to reference the fields height and gender from the athletes table. Leverage CASE statements and conditional logic (such as AND/OR) to build this.

Remember that each line of a case statement looks like this: CASE WHEN {condition} THEN {output}

Instructions
100 XP
Update the CASE statement to output three values: Tall Female, Tall Male, and Other.

```sql
SELECT 
  name,
    -- Output 'Tall Female', 'Tall Male', or 'Other'
  CASE WHEN gender = 'F' AND height >= 175 THEN 'Tall Female'
    WHEN gender = 'M' AND height >= 190 THEN 'Tall Male'
    ELSE 'Other' END AS segment
FROM athletes;
```

## BMI bucket by sport
You are looking to understand how BMI differs by each summer sport. To answer this, set up a report that contains the following:

sport, which is the name of the summer sport
bmi_bucket, which splits up BMI into three groups: <.25, .25-.30, >.30
athletes, or the unique number of athletes
Definition: BMI = 100 * weight / (height squared).

Also note that CASE statements run row-by-row, so the second conditional is only applied if the first conditional is false. This makes it that you do not need an AND statement excluding already-mentioned conditionals.

Feel free to reference the E:R Diagram.

Instructions
100 XP
Build a query that pulls from summer_games and athletes to show sport, bmi_bucket, and athletes.
Without using AND or ELSE, set up a CASE statement that splits bmi_bucket into three groups: '<.25', '.25-.30', and '>.30'.
Group by the non-aggregated fields.
Order the report by sport and then athletes in descending order.

```sql
-- Pull in sport, bmi_bucket, and athletes
SELECT 
  sport,
    -- Bucket BMI in three groups: <.25, .25-.30, and >.30  
    CASE WHEN 100*weight/height^2 <.25 THEN '<.25'
    WHEN 100*weight/height^2 <=.30 THEN '.25-.30'
    WHEN 100*weight/height^2 >.30 THEN '>.30' END AS bmi_bucket,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
-- GROUP BY non-aggregated fields
GROUP BY sport, bmi_bucket
-- Sort by sport and then by athletes in descending order
ORDER BY sport, athletes DESC;
```
## Troubleshooting CASE statements
In the previous exercise, you may have noticed several null values in our case statement, which can indicate there is an issue with the code.

In these instances, it's worth investigating to understand why these null values are appearing. In this exercise, you will go through a series of steps to identify the issue and make changes to the code where necessary.

Instructions 1/3
35 XP
1
2
3
Comment out the query from last exercise (lines 2 - 12).
Create a query that pulls height, weight, and bmi from athletes and filters for null bmi values.

```sql
-- Query from last exercise shown below.  Comment it out.
/*SELECT 
  sport,
    CASE WHEN weight/height^2*100 <.25 THEN '<.25'
    WHEN weight/height^2*100 <=.30 THEN '.25-.30'
    WHEN weight/height^2*100 >.30 THEN '>.30' END AS bmi_bucket,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
GROUP BY sport, bmi_bucket
ORDER BY sport, athletes DESC;*/

-- Show height, weight, and bmi for all athletes
SELECT 
  height, 
    weight, 
    weight/height^2*100 AS bmi
FROM athletes
-- Filter for NULL bmi values
WHERE weight/height^2*100 IS NULL;
```
## Troubleshooting CASE statements
In the previous exercise, you may have noticed several null values in our case statement, which can indicate there is an issue with the code.

In these instances, it's worth investigating to understand why these null values are appearing. In this exercise, you will go through a series of steps to identify the issue and make changes to the code where necessary.

Instructions 3/3
0 XP
3
Comment out the troubleshooting query, uncomment the original query, and add an ELSE line to the CASE statement that outputs 'no weight recorded'.

```sql
-- Uncomment the original query
SELECT 
  sport,
    CASE WHEN weight/height^2*100 <.25 THEN '<.25'
    WHEN weight/height^2*100 <=.30 THEN '.25-.30'
    WHEN weight/height^2*100 >.30 THEN '>.30'
    -- Add ELSE statement to output 'no weight recorded'
    ELSE 'no weight recorded' END AS bmi_bucket,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
GROUP BY sport, bmi_bucket
ORDER BY sport, athletes DESC;

-- Comment out the troubleshooting query
/*SELECT 
  height, 
    weight, 
    weight/height^2*100 AS bmi
FROM athletes
WHERE weight/height^2*100 IS NULL;*/
```

## Filtering with a JOIN
When adding a filter to a query that requires you to reference a separate table, there are different approaches you can take. One option is to JOIN to the new table and then add a basic WHERE statement.

Your goal is to create a report with the following characteristics:

First column is bronze_medals, or the total number of bronze.
Second column is silver_medals, or the total number of silver.
Third column is gold_medals, or the total number of gold.
Only summer_games are included.
Report is filtered to only include athletes age 16 or under.
In this exercise, use the JOIN approach.

Instructions
0 XP
Create a query that pulls total bronze_medals, silver_medals, and gold_medals from summer_games.
Use a JOIN and a WHERE statement to filter for athletes ages 16 and below.

```sql
-- Pull summer bronze_medals, silver_medals, and gold_medals
SELECT 
  SUM(bronze) AS bronze_medals, 
    SUM(silver) AS silver_medals, 
    SUM(gold) AS gold_medals
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
-- Filter for athletes age 16 or below
WHERE age <= 16;
```

## Filtering with a subquery
Another approach to filter from a separate table is to use a subquery. The process is as follows:

Create a subquery that outputs a list.
In your main query, add a WHERE statement that references the list.
Your goal is to create the same report as the last exercise, which contains the following characteristics:

First column is bronze_medals, or the total number of bronze.
Second column is silver_medals, or the total number of silver.
Third column is gold_medals, or the total number of gold.
Only summer_games are included.
Report is filtered to only include athletes age 16 or under.
In this exercise, use the subquery approach.

Instructions
100 XP
Create a query that pulls total bronze_medals, silver_medals, and gold_medals from summer_games.
Setup a subquery that outputs all athletes age 16 or below.
Add a WHERE statement that references the subquery to filter for athletes age 16 or below.

```sql
-- Pull summer bronze_medals, silver_medals, and gold_medals
SELECT 
  SUM(bronze) AS bronze_medals, 
    SUM(silver) AS silver_medals, 
    SUM(gold) AS gold_medals
FROM summer_games
-- Add the WHERE statement below
WHERE athlete_id IN
    -- Create subquery list for athlete_ids age 16 or below   
    (SELECT id
     FROM athletes
     WHERE age <= 16);
```

## Report 2: Top athletes in nobel-prized countries
It's time to bring together all the concepts brought up in this chapter to expand on your dashboard! Your next report to build is Report 2: Athletes Representing Nobel-Prize Winning Countries.

Report Details:

Column 1 should be event, which represents the Olympic event. Both summer and winter events should be included.
Column 2 should be gender, which represents the gender of athletes in the event.
Column 3 should be athletes, which represents the unique athletes in the event.
Athletes from countries that have had no nobel_prize_winners should be excluded.
The report should contain 10 events, where events with the most athletes show at the top.
Click to view the E:R Diagram.

Instructions 1/4
1 XP
1
2
3
4
Select event from the summer_games table and create the athletes field by counting the distinct number of athlete_id.

```sql
-- Pull event and unique athletes from summer_games 
SELECT 
  event, 
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
GROUP BY event;
```

Explore the event field to determine how to split up events by gender (without adding a join), then add the gender field by using a CASE statement that specifies a conditional for 'female' events (all other events should output as 'male').

```sql
-- Pull event and unique athletes from summer_games 
SELECT 
    event,
    -- Add the gender field below
    CASE WHEN event LIKE '%Women%' THEN 'female' 
    ELSE 'male' END AS gender,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
GROUP BY event;
```

Filter for Nobel-prize-winning countries by creating a subquery that outputs country_id from the country_stats table for any country with more than zero nobel_prize_winners.

```sql
-- Pull event and unique athletes from summer_games 
SELECT 
    event,
    -- Add the gender field below
    CASE WHEN event LIKE '%Women%' THEN 'female' 
    ELSE 'male' END AS gender,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
-- Only include countries that won a nobel prize
WHERE country_id IN 
  (SELECT country_id 
    FROM country_stats 
    WHERE nobel_prize_winners > 0)
GROUP BY event;
```

Copy your query with summer_games replaced by winter_games, UNION the two tables together, and order the final report to show the 10 rows with the most athletes.

```sql
-- Pull event and unique athletes from summer_games 
SELECT 
    event,
    -- Add the gender field below
    CASE WHEN event LIKE '%Women%' THEN 'female' 
    ELSE 'male' END AS gender,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
-- Only include countries that won a nobel prize
WHERE country_id IN 
  (SELECT country_id 
    FROM country_stats 
    WHERE nobel_prize_winners > 0)
GROUP BY event
-- Add the second query below and combine with a UNION
UNION
SELECT 
    event,
    CASE WHEN event LIKE '%Women%' THEN 'female' 
    ELSE 'male' END AS gender,
    COUNT(DISTINCT athlete_id) AS athletes
FROM winter_games
WHERE country_id IN 
  (SELECT country_id 
    FROM country_stats 
    WHERE nobel_prize_winners > 0)
GROUP BY event
-- Order and limit the final output
ORDER BY athletes DESC
LIMIT 10;
```

## Identifying data types
Being able to identify data types before setting up your query can help you plan for any potential issues. There is a group of tables, or a schema, called the information_schema, which provides a wide array of information about the database itself, including the structure of tables and columns.

The columns table houses useful details about the columns, including the data type.

Note that the information_schema is not the default schema SQL looks at when querying, which means you will need to explicitly tell SQL to pull from this schema. To pull a table from a non-default schema, use the syntax schema_name.table_name.

Instructions 1/2
0 XP
1
2
Select the fields column_name and data_type from the table columns that resides within the information_schema schema.
Filter only for the 'country_stats' table.

```sql
-- Pull column_name & data_type from the columns table
SELECT 
  column_name, 
    data_type
FROM information_schema.columns
-- Filter for the table 'country_stats'
WHERE table_name = 'country_stats';
```
## Interpreting error messages
Inevitably, you will run into errors when running SQL queries. It is important to understand how to interpret these errors to correctly identify what type of error it is.

The console contains two separate queries, each which will output an error when ran. In this exercise, you will run each query, read the error message, and troubleshoot the error.

Instructions 1/2
50 XP
1
Run the query in the console.
After reading the error, fix it by converting the data type to float.

Take Hint (-15 XP)
2
Comment the first query and uncomment the second query.
Run the code and fix errors by making the join columns int

```sql
-- Run the query, then convert a data type to fix the error
SELECT AVG(CAST(pop_in_millions AS float)) AS avg_population
FROM country_stats;

/*SELECT 
  s.country_id, 
    COUNT(DISTINCT s.athlete_id) AS summer_athletes, 
    COUNT(DISTINCT w.athlete_id) AS winter_athletes
FROM summer_games AS s
JOIN winter_games_str AS w
ON s.country_id = w.country_id
GROUP BY s.country_id;*/
```

Comment the first query and uncomment the second query.
Run the code and fix errors by making the join columns int.

```sql
-- Comment out the previous query
/*SELECT AVG(CAST(pop_in_millions AS float)) AS avg_population
FROM country_stats;*/

-- Uncomment the following block & run the query
SELECT 
  s.country_id, 
    COUNT(DISTINCT s.athlete_id) AS summer_athletes, 
    COUNT(DISTINCT w.athlete_id) AS winter_athletes
FROM summer_games AS s
JOIN winter_games_str AS w
-- Fix the error by making both columns integers
ON s.country_id = CAST(w.country_id AS int)
GROUP BY s.country_id;
```
## Using date functions on strings
There are several useful functions that act specifically on date or datetime fields. For example:

DATE_TRUNC('month', date) truncates each date to the first day of the month.
DATE_PART('year', date) outputs the year, as an integer, of each date value.
In general, the arguments for both functions are ('period', field), where period is a date or time interval, such as 'minute', 'day', or 'decade'.

In this exercise, your goal is to test out these date functions on the country_stats table, specifically by outputting the decade of each year using two separate approaches. To run these functions, you will need to use CAST() function on the year field.

Instructions
100 XP
Pulling from the country_stats table, select the decade using two methods: DATE_PART() and DATE_TRUNC.
Convert the data type of the year field to fix errors.
Sum up gdp to get world_gdp.
Group and order by year (in descending order).

```sql
SELECT 
  year,
    -- Pull decade, decade_truncate, and the world's gdp
    DATE_PART('decade',CAST(year AS date)) AS decade,
    DATE_TRUNC('decade',CAST(year AS date)) AS decade_truncated,
    SUM(gdp) AS world_gdp
FROM country_stats
-- Group and order by year in descending order
GROUP BY year
ORDER BY year DESC;
```

## String functions
There are a number of string functions that can be used to alter strings. A description of a few of these functions are shown below:

The LOWER(fieldName) function changes the case of all characters in fieldName to lower case.
The INITCAP(fieldName) function changes the case of all characters in fieldName to proper case.
The LEFT(fieldName,N) function returns the left N characters of the string fieldName.
The SUBSTRING(fieldName from S for N) returns N characters starting from position S of the string fieldName. Note that both from S and for N are optional.

Instructions 1/4
25 XP
Update the field country_altered to output country in all lower-case.

```sql
-- Convert country to lower case
SELECT 
  country, 
    lower(country) AS country_altered
FROM countries
GROUP BY country;
```

Update the field country_altered to output country in proper-case.

```sql
-- Convert country to proper case
SELECT 
  country, 
    INITCAP(country) AS country_altered
FROM countries
GROUP BY country;
```

Update the field country_altered to output the left 3 characters of country.

```sql
-- Output the left 3 characters of country
SELECT 
  country, 
    LEFT(country,3) AS country_altered
FROM countries
GROUP BY country;
```

Update the field country_altered to output all characters starting with the 7th character of country.

```sql
-- Output all characters starting with position 7
SELECT 
  country, 
    SUBSTRING(country from 7) AS country_altered
FROM countries
GROUP BY country;
```

## Replacing and removing substrings
The REPLACE() function is a versatile function that allows you to replace or remove characters from a string. The syntax is as follows:

REPLACE(fieldName, 'searchFor', 'replaceWith')

Where fieldName is the field or string being updated, searchFor is the characters to be replaced, and replaceWith is the replacement substring.

In this exercise, you will look at one specific value in the countries table and change up the format by using a few REPLACE() functions.

Instructions 1/2
50 XP
1
2
Create the field character_swap that replaces all '&' characters with 'and' from region.
Create the field character_remove that removes all periods from region.

```sql
SELECT 
  region, 
    -- Replace all '&' characters with the string 'and'
    REPLACE(region,'&','and') AS character_swap,
    -- Remove all periods
    REPLACE(region,'.','') AS character_remove
FROM countries
WHERE region = 'LATIN AMER. & CARIB'
GROUP BY region;
```

Add a new field called character_swap_and_remove that runs the alterations of both character_swap and character_remove in one go.

```sql
SELECT 
  region, 
    -- Replace all '&' characters with the string 'and'
    REPLACE(region,'&','and') AS character_swap,
    -- Remove all periods
    REPLACE(region,'.','') AS character_remove,
    -- Combine the functions to run both changes at once
    REPLACE(REPLACE(region,'&','and'),'.','') AS character_swap_and_remove
FROM countries
WHERE region = 'LATIN AMER. & CARIB'
GROUP BY region;
```

## Fixing incorrect groupings
One issues with having strings stored in different formats is that you may incorrectly group data. If the same value is represented in multiple ways, your report will split the values into different rows, which can lead to inaccurate conclusions.

In this exercise, you will query from the summer_games_messy table, which is a messy, smaller version of summer_games. You'll notice that the same event is stored in multiple ways. Your job is to clean the event field to show the correct number of rows.

Instructions 1/3
35 XP
1
2
3
Create a query that pulls the number of distinct athletes by event from the table summer_games_messy.
Group by the non-aggregated field.

```sql
-- Pull event and unique athletes from summer_games_messy 
SELECT 
  event, 
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games_messy
-- Group by the non-aggregated field
GROUP BY event;
```

Notice how we see 6 rows that relate to only 2 events. Alter the event field by trimming all leading and trailing spaces, alias as event_fixed, and update the GROUP BY accordingly.

```sql
-- Pull event and unique athletes from summer_games_messy 
SELECT 
    -- Remove trailing spaces and alias as event_fixed
    TRIM(event) AS event_fixed, 
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games_messy
-- Update the group by accordingly
GROUP BY event_fixed;
```

Notice how there are now only 4 rows. Alter the event_fixed field further by removing all dashes (-).

```sql
-- Pull event and unique athletes from summer_games_messy 
SELECT
    -- Remove dashes from all event values
  REPLACE(TRIM(event),'-','') AS event_fixed, 
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games_messy
-- Update the group by accordingly
GROUP BY event_fixed;
```

## Filtering out nulls
One way to deal with nulls is to simply filter them out. There are two important conditionals related to nulls:

IS NULL is true for any value that is null.
IS NOT NULL is true for any value that is not null. Note that a zero or a blank cell is not the same as a null.
These conditionals can be leveraged by several clauses, such as CASE statements, WHERE statements, and HAVING statements. In this exercise, you will learn how to filter out nulls using two separate techniques.

Feel free to reference the E:R Diagram.

Instructions 1/3
35 XP
1
2
3
Setup a query that pulls country and total golds as gold_medals for all winter games.
Group by the non-aggregated field and order by gold_medals in descending order.

```sql
-- Show total gold_medals by country
SELECT 
  country, 
    SUM(gold) AS gold_medals
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
GROUP BY country
-- Order by gold_medals in descending order
ORDER BY gold_medals DESC;
```

Notice how null values appear at the top of the results. Remove these by adding a WHERE statement that filters out all rows with null gold values.

```sql
-- Show total gold_medals by country
SELECT 
  country, 
    SUM(gold) AS gold_medals
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
-- Removes any row with no gold medals
WHERE gold IS NOT NULL
GROUP BY country
-- Order by gold_medals in descending order
ORDER BY gold_medals DESC;
```

We can do a similar filter using HAVING. Comment out the WHERE statement and add a HAVING statement that filters out countries with no gold medals.

```sql
-- Show total gold_medals by country
SELECT 
  country, 
    SUM(gold) AS gold_medals
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
-- Comment out the WHERE statement
--WHERE gold IS NOT NULL
GROUP BY country
-- Replace WHERE statement with equivalent HAVING statement
HAVING SUM(gold) IS NOT NULL
-- Order by gold_medals in descending order
ORDER BY gold_medals DESC;
```

## Fixing calculations with coalesce
Null values impact aggregations in a number of ways. One issue is related to the AVG() function. By default, the AVG() function does not take into account any null values. However, there may be times when you want to include these null values in the calculation as zeros.

To replace null values with a string or a number, use the COALESCE() function. Syntax is COALESCE(fieldName,replacement), where replacement is what should replace all null instances of fieldName.

This exercise will walk you through why null values can throw off calculations and how to troubleshoot these issues.

Instructions 1/4
25 XP
1
2
3
4
Build a report that shows total_events and gold_medals by athlete_id for all summer events, ordered by total_events descending then athlete_id ascending.

```sql
-- Pull events and golds by athlete_id for summer events
SELECT 
    athlete_id, 
    COUNT(event) AS total_events, 
    SUM(gold) AS gold_medals
FROM summer_games
GROUP BY athlete_id
-- Order by total_events descending and athlete_id ascending
ORDER BY total_events DESC, athlete_id;
```

## Fixing calculations with coalesce
Null values impact aggregations in a number of ways. One issue is related to the AVG() function. By default, the AVG() function does not take into account any null values. However, there may be times when you want to include these null values in the calculation as zeros.

To replace null values with a string or a number, use the COALESCE() function. Syntax is COALESCE(fieldName,replacement), where replacement is what should replace all null instances of fieldName.

This exercise will walk you through why null values can throw off calculations and how to troubleshoot these issues.

Instructions 1/4
1 XP
1
2
3
4
Build a report that shows total_events and gold_medals by athlete_id for all summer events, ordered by total_events descending then athlete_id ascending.

```sql
-- Pull events and golds by athlete_id for summer events
SELECT 
    athlete_id, 
    COUNT(event) AS total_events, 
    SUM(gold) AS gold_medals
FROM summer_games
GROUP BY athlete_id
-- Order by total_events descending and athlete_id ascending
ORDER BY total_events DESC, athlete_id;
```

Create a field called avg_golds that averages the gold field.

```sql
-- Pull events and golds by athlete_id for summer events
SELECT 
    athlete_id, 
    -- Add a field that averages the existing gold field
    AVG(gold) AS avg_golds,
    COUNT(event) AS total_events, 
    SUM(gold) AS gold_medals
FROM summer_games
GROUP BY athlete_id
-- Order by total_events descending and athlete_id ascending
ORDER BY total_events DESC, athlete_id;
```

Fix the avg_golds field by replacing null values with zero.

```sql
-- Pull events and golds by athlete_id for summer events
SELECT 
    athlete_id, 
    -- Replace all null gold values with 0
    AVG(COALESCE(gold,0)) AS avg_golds,
    COUNT(event) AS total_events, 
    SUM(gold) AS gold_medals
FROM summer_games
GROUP BY athlete_id
-- Order by total_events descending and athlete_id ascending
ORDER BY total_events DESC, athlete_id;
```

## Identifying duplication
Duplication can happen for a number of reasons, often in unexpected ways. Because of this, it's important to get in the habit of validating your queries to ensure no duplication exists. To validate a query, take the following steps:

Check the total value of a metric from the original table.
Compare that with the total value of the same metric in your final report.
If the number from step 2 is larger than step 1, then duplication is likely the culprit. In this exercise, you will go through these steps to identify if duplication exists.

Instructions 2/3
35 XP
2
3
Comment out the top query after noting the gold_medals value.
Build a query that shows gold_medals and avg_gdp by country_id, but joins winter_games and country_stats only on the country_id fields.

```sql
-- Comment out the query after noting the gold medal count
/*SELECT SUM(gold) AS gold_medals
FROM winter_games;*/
-- TOTAL GOLD MEDALS: 47 

-- Show gold_medals and avg_gdp by country_id
SELECT 
  w.country_id, 
    SUM(gold) AS gold_medals, 
    AVG(gdp) AS avg_gdp
FROM winter_games AS w
JOIN country_stats AS c
-- Only join on the country_id fields
ON c.country_id = w.country_id
GROUP BY w.country_id;
```

Wrap your newest query in a subquery, alias as subquery, and calculate the total value for the gold_medals field.

```sql
-- Comment out the query after noting the gold medal count
/*SELECT SUM(gold) AS gold_medals
FROM winter_games;*/
-- TOTAL GOLD MEDALS: 47 

-- Calculate the total gold_medals in your query
SELECT SUM(gold_medals)
FROM
  (SELECT 
      w.country_id, 
      SUM(gold) AS gold_medals, 
      AVG(gdp) AS avg_gdp
    FROM winter_games AS w
    JOIN country_stats AS c
    ON c.country_id = w.country_id
    -- Alias your query as subquery
    GROUP BY w.country_id) AS subquery;
```

##Fixing duplication through a JOIN
In the previous exercise, you set up a query that contained duplication. This exercise will remove the duplication. One approach to removing duplication is to change the JOIN logic by adding another field to the ON statement.

The final query from last exercise is shown in the console. Your job is to fix the duplication by updating the ON statement. Note that the total gold_medals value should be 47.

Feel free to reference the E:R Diagram.

Instructions
100 XP
Update the ON statement in the subquery by adding a second field to JOIN on.
If an error occurs related to the new JOIN field, use a CAST() statement to fix it.

```sql
SELECT SUM(gold_medals) AS gold_medals
FROM
  (SELECT 
      w.country_id, 
      SUM(gold) AS gold_medals, 
      AVG(gdp) AS avg_gdp
    FROM winter_games AS w
    JOIN country_stats AS c
    -- Update the subquery to join on a second field
    ON c.country_id = w.country_id AND w.year = CAST(c.year AS date)
    GROUP BY w.country_id) AS subquery;
```

## Report 3: Countries with high medal rates
Great work so far! It is time to use the concepts you learned in this chapter to build the next base report for your dashboard.

Details for report 3: medals vs population rate.

Column 1 should be country_code, which is an altered version of the country field.
Column 2 should be pop_in_millions, representing the population of the country (in millions).
Column 3 should be medals, representing the total number of medals.
Column 4 should be medals_per_million, which equals medals / pop_in_millions
Instructions 1/4
25 XP
1
2
3
4
Pull total medals by country for all summer games, where the medals field uses one SUM function and several null-handling functions on the gold, silver, and bronze fields.

```sql
SELECT 
  c.country, 
    -- Add the three medal fields using one sum function
  SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) AS medals
FROM summer_games AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY c.country
ORDER BY medals DESC;
```

Join to country_stats to pull in pop_in_millions, then create medals_per_million by dividing total medals by pop_in_millions and converting data types as needed.

```sql
SELECT 
  c.country,
    -- Pull in pop_in_millions and medals_per_million 
  pop_in_millions,
    -- Add the three medal fields using one sum function
  SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) AS medals,
  SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) / CAST(cs.pop_in_millions AS float) AS medals_per_million
FROM summer_games AS s
JOIN countries AS c 
ON s.country_id = c.id
-- Add a join
JOIN country_stats AS cs 
ON s.country_id = cs.country_id
GROUP BY c.country, pop_in_millions
ORDER BY medals DESC;
```
Notice the repeated values in the results. Add a column on the newest join statement to remove this duplication, and if you run into an error when trying to join, update the query so both fields are stored as type date.

```sql
SELECT 
  c.country,
    -- Pull in pop_in_millions and medals_per_million 
  pop_in_millions,
    -- Add the three medal fields using one sum function
  SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) AS medals,
  SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) / CAST(cs.pop_in_millions AS float) AS medals_per_million
FROM summer_games AS s
JOIN countries AS c 
ON s.country_id = c.id
-- Update the newest join statement to remove duplication
JOIN country_stats AS cs 
ON s.country_id = cs.country_id AND s.year = CAST(cs.year AS date)
GROUP BY c.country, pop_in_millions
ORDER BY medals DESC;
```

Update country to country_code by trimming leading spaces, converting to upper case, removing . characters, and keeping only the left 3 characters, then filter out null populations and keep only the 25 rows with the most medals_per_million.

```sql
SELECT 
  -- Clean the country field to only show country_code
    LEFT(REPLACE(UPPER(TRIM(c.country)), '.', ''), 3) AS country_code,
    -- Pull in pop_in_millions and medals_per_million 
  pop_in_millions,
    -- Add the three medal fields using one sum function
  SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) AS medals,
  SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) / CAST(cs.pop_in_millions AS float) AS medals_per_million
FROM summer_games AS s
JOIN countries AS c 
ON s.country_id = c.id
-- Update the newest join statement to remove duplication
JOIN country_stats AS cs 
ON s.country_id = cs.country_id AND s.year = CAST(cs.year AS date)
-- Filter out null populations
WHERE cs.pop_in_millions IS NOT NULL
GROUP BY c.country, pop_in_millions
-- Keep only the top 25 medals_per_million rows
ORDER BY medals_per_million DESC
LIMIT 25;
```

## Testing out window functions
Window functions reference other rows within the report. There are a variety of window-specific functions to use, but all basic aggregation functions can be used as a window function. These include:

SUM()
AVG()
MAX()
MIN()
The syntax of a window function is FUNCTION(value) OVER (PARTITION BY field ORDER BY field). Note that the PARTITION BY and ORDER BY clauses are optional. The FUNCTION should be replaced with the function of your choice.

In this exercise, you will run a few different window functions on the country_stats table.

Add the field country_avg_gdp that outputs the average gdp for each country.

```sql
SELECT 
  country_id,
    year,
    gdp,
    -- Show the average gdp across all years per country
  AVG(gdp) OVER (PARTITION BY country_id) AS country_avg_gdp
FROM country_stats;
```

Change country_avg_gdp to country_sum_gdp that shows the total gdp for each country across all years.

```sql
SELECT 
  country_id,
    year,
    gdp,
    -- Show total gdp per country and alias accordingly
  SUM(gdp) OVER (PARTITION BY country_id) AS country_sum_gdp
FROM country_stats;
```

Change country_sum_gdp to country_max_gdp that shows the highest GDP for each country.

```sql
SELECT 
  country_id,
    year,
    gdp,
    -- Show max gdp per country and alias accordingly
  MAX(gdp) OVER (PARTITION BY country_id) AS country_max_gdp
FROM country_stats;
```

Change country_max_gdp to global_max_gdp that shows the highest GDP value for the entire world.

```sql
SELECT 
  country_id,
    year,
    gdp,
    -- Show max gdp for the table and alias accordingly
  MAX(gdp) OVER () AS global_max_gdp
FROM country_stats;
```

## Average total country medals by region
Layered calculations are when you create a basic query with an aggregation, then reference that query as a subquery to run an additional calculation. This approach allows you to run aggregations on aggregations, such as a MAX() of a COUNT() or an AVG() of a SUM().

In this exercise, your task is to pull the average total_golds for all countries within each region. This report will apply only for summer events.

To avoid having to deal with null handling, we have created a summer_games_clean table. Please use this when building the report.

Instructions 1/2
50 XP
1
2
Set up a query that pulls total_golds by region and country_id from the summer_games_clean and countries tables.
GROUP BY the unaggregated fields.

```sql
-- Query total_golds by region and country_id
SELECT 
  region, 
    country_id, 
    SUM(gold) AS total_golds
FROM summer_games_clean AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY region, country_id;
```

Alias your query as subquery and add a layer that pulls region and avg_total_golds that outputs the average gold medal count for all countries in the region.
Order by avg_total_golds in descending order.

```sql
-- Pull in avg_total_golds by region
SELECT 
  region,
    AVG(total_golds) AS avg_total_golds
FROM
  (SELECT 
      region, 
      country_id, 
      SUM(gold) AS total_golds
  FROM summer_games_clean AS s
  JOIN countries AS c
  ON s.country_id = c.id
  -- Alias the subquery
  GROUP BY region, country_id) AS subquery
GROUP BY region
-- Order by avg_total_golds in descending order
ORDER BY avg_total_golds DESC;
```
## Most decorated athlete per region
Your goal for this exercise is to show the most decorated athlete per region. To set up this report, you need to leverage the ROW_NUMBER() window function, which numbers each row as an incremental integer, where the first row is 1, the second is 2, and so on.

Syntax for this window function is ROW_NUMBER() OVER (PARTITION BY field ORDER BY field). Notice how there is no argument within the initial function.

When set up correctly, a row_num = 1 represents the most decorated athlete within that region. Note that you cannot use a window calculation within a HAVING or WHERE statement, so you will need to use a subquery to filter.

Feel free to reference the E:R Diagram. We will use summer_games_clean to avoid null handling.

Instructions 1/2
50 XP
1
2
Build a query that pulls region, athlete_name, and total_golds by joining summer_games_clean, athletes, and countries.
Add a field called row_num that uses ROW_NUMBER() to assign a regional rank to each athlete based on total golds won.

```sql
SELECT 
  -- Query region, athlete_name, and total gold medals
    region, 
    name AS athlete_name, 
    SUM(gold) AS total_golds,
    -- Assign a regional rank to each athlete
    ROW_NUMBER() OVER (PARTITION BY region ORDER BY SUM(gold) DESC) AS row_num
FROM summer_games_clean AS s
JOIN athletes AS a
ON a.id = s.athlete_id
JOIN countries AS c
ON s.country_id = c.id
GROUP BY region, athlete_name;
```
Alias the subquery as subquery.
Query region, athlete_name, and total_golds, and then filter for only the top athlete per region.

```sql
-- Query region, athlete name, and total_golds
SELECT 
  region,
    athlete_name,
    total_golds
FROM
    (SELECT 
    -- Query region, athlete_name, and total gold medals
        region, 
        name AS athlete_name, 
        SUM(gold) AS total_golds,
        -- Assign a regional rank to each athlete
        ROW_NUMBER() OVER (PARTITION BY region ORDER BY SUM(gold) DESC) AS row_num
    FROM summer_games_clean AS s
    JOIN athletes AS a
    ON a.id = s.athlete_id
    JOIN countries AS c
    ON s.country_id = c.id
    -- Alias as subquery
    GROUP BY region, athlete_name) AS subquery
-- Filter for only the top athlete per region
WHERE row_num = 1;
```

## Percent of gdp per country
A percent of total calculation is a good way to compare volume metrics across groups. While simply showing the volume metric in a report provides some insights, adding a ratio allows us to easily compare values quickly.

To run a percent of total calculation, take the following steps:

Create a window function that outputs the total volume, partitioned by whatever is considered the total. If the entire table is considered the total, then no partition clause is needed.
Run a ratio that divides each row's volume metric by the total volume in the partition.
In this exercise, you will calculate the percent of gdp for each country relative to the entire world and relative to that country's region.

Instructions 1/4
25 XP
1
2
3
4
Construct a query that pulls the country_gdp by region and country, order the query to show the highest country_gdp at the top, and then filter out all null gdp values.

```sql
-- Pull country_gdp by region and country
SELECT 
  region,
    country,
  SUM(gdp) AS country_gdp
FROM country_stats AS cs
JOIN countries AS c
ON cs.country_id = c.id
-- Filter out null gdp values
WHERE gdp IS NOT NULL
GROUP BY region, country
-- Show the highest country_gdp at the top
ORDER BY country_gdp DESC;
```

Add the field global_gdp that outputs the total gdp across all countries.

```sql
-- Pull country_gdp by region and country
SELECT 
  region,
    country,
  SUM(gdp) AS country_gdp,
    -- Calculate the global gdp
    SUM(SUM(gdp)) OVER () AS global_gdp
FROM country_stats AS cs
JOIN countries AS c
ON cs.country_id = c.id
-- Filter out null gdp values
WHERE gdp IS NOT NULL
GROUP BY region, country
-- Show the highest country_gdp at the top
ORDER BY country_gdp DESC;
```

Create the field perc_global_gdp that calculates the percent of global gdp for the given country.

```sql
-- Pull country_gdp by region and country
SELECT 
  region,
    country,
  SUM(gdp) AS country_gdp,
    -- Calculate the global gdp
    SUM(SUM(gdp)) OVER () AS global_gdp,
    -- Calculate percent of global gdp
    SUM(gdp) / SUM(SUM(gdp)) OVER () AS perc_global_gdp
FROM country_stats AS cs
JOIN countries AS c
ON cs.country_id = c.id
-- Filter out null gdp values
WHERE gdp IS NOT NULL
GROUP BY region, country
-- Show the highest country_gdp at the top
ORDER BY country_gdp DESC;
```

Add the field perc_region_gdp, which runs the same calculation as perc_global_gdp but relative to each region.

```sql
-- Pull country_gdp by region and country
SELECT 
  region,
    country,
  SUM(gdp) AS country_gdp,
    -- Calculate the global gdp
    SUM(SUM(gdp)) OVER () AS global_gdp,
    -- Calculate percent of global gdp
    SUM(gdp) / SUM(SUM(gdp)) OVER () AS perc_global_gdp,
    -- Calculate percent of gdp relative to its region
    SUM(gdp) / SUM(SUM(gdp)) OVER (PARTITION BY region) AS perc_region_gdp
FROM country_stats AS cs
JOIN countries AS c
ON cs.country_id = c.id
-- Filter out null gdp values
WHERE gdp IS NOT NULL
GROUP BY region, country
-- Show the highest country_gdp at the top
ORDER BY country_gdp DESC;
```


## GDP per capita performance index
A performance index calculation is a good way to compare efficiency metrics across groups. A performance index compares each row to a benchmark.

To run a performance index calculation, take the following steps:

Create a window function that outputs the performance for the entire partition.
Run a ratio that divides each row's performance to the performance of the entire partition.
In this exercise, you will calculate the gdp_per_million for each country relative to the entire world.

gdp_per_million = gdp / pop_in_millions
You will reference the country_stats_cleaned table, which is a copy of country_stats without data type issues.

Instructions 1/3
35 XP
1
2
3
Update the query to pull gdp_per_million by region and country from country_stats_clean.
Filter for the year 2016, order by gdp_per_million in descending order, and remove all null gdp values.

Take Hint (-10 XP)

```sql
-- Bring in region, country, and gdp_per_million
SELECT 
    region,
    country,
    SUM(gdp) / SUM(pop_in_millions) AS gdp_per_million
-- Pull from country_stats_clean
FROM country_stats_clean AS cs
JOIN countries AS c 
ON cs.country_id = c.id
-- Filter for 2016 and remove null gdp values
WHERE year = '2016-01-01' AND gdp IS NOT NULL
GROUP BY region, country
-- Show highest gdp_per_million at the top
ORDER BY gdp_per_million DESC;
```
Add the field gdp_per_million_total that takes the total gdp_per_million for the entire world.

```sql
-- Bring in region, country, and gdp_per_million
SELECT 
    region,
    country,
    SUM(gdp) / SUM(pop_in_millions) AS gdp_per_million,
    -- Output the worlds gdp_per_million
    SUM(SUM(gdp)) OVER () / SUM(SUM(pop_in_millions)) OVER () AS gdp_per_million_total
-- Pull from country_stats_clean
FROM country_stats_clean AS cs
JOIN countries AS c 
ON cs.country_id = c.id
-- Filter for 2016 and remove null gdp values
WHERE year = '2016-01-01' AND gdp IS NOT NULL
GROUP BY region, country
-- Show highest gdp_per_million at the top
ORDER BY gdp_per_million DESC;
```

Add the performance_index that divides the gdp_per_million calculation by the gdp_per_million_total calculation.

```sql
-- Bring in region, country, and gdp_per_million
SELECT 
    region,
    country,
    SUM(gdp) / SUM(pop_in_millions) AS gdp_per_million,
    -- Output the worlds gdp_per_million
    SUM(SUM(gdp)) OVER () / SUM(SUM(pop_in_millions)) OVER () AS gdp_per_million_total,
    -- Build the performance_index in the 3 lines below
    (SUM(gdp) / SUM(pop_in_millions))
    /
    (SUM(SUM(gdp)) OVER () / SUM(SUM(pop_in_millions)) OVER ()) AS performance_index
-- Pull from country_stats_clean
FROM country_stats_clean AS cs
JOIN countries AS c 
ON cs.country_id = c.id
-- Filter for 2016 and remove null gdp values
WHERE year = '2016-01-01' AND gdp IS NOT NULL
GROUP BY region, country
-- Show highest gdp_per_million at the top
ORDER BY gdp_per_million DESC;
```

## Month-over-month comparison
In order to compare months, you need to use one of the following window functions:

LAG(value, offset), which outputs a value from an offset number previous to to the current row in the report.
LEAD(value, offset), which outputs a value from a offset number after the current row in the report.
Your goal is to build a report that shows each country's month-over-month views. A few tips:

You will need to bucket dates into months. To do this, you can use the DATE_PART() function.
You can calculate the percent change using the following formula: (value)/(previous_value) - 1.
If no offset value is included in the LAG() or LEAD() functions, it will default to 1.
Since the table stops in the middle of June, the query is set up to only include data to the end of May.

Instructions
100 XP
From web_data, pull in country_id and use a DATE_PART() function to create month.
Create month_views that pulls the total views within the month.
Create previous_month_views that pulls the total views from last month for the given country.
Create the field perc_change that calculates the percent change of this month relative to last month for the given country, where a negative value represents a loss in views and a positive value represents growth.

```sql
SELECT
  -- Pull month and country_id
  DATE_PART('month', date) AS month,
  country_id,
    -- Pull in current month views
    SUM(views) AS month_views,
    -- Pull in last month views
    LAG(SUM(views)) OVER (PARTITION BY country_id ORDER BY DATE_PART('month', date)) AS previous_month_views,
    -- Calculate the percent change
    SUM(views) / LAG(SUM(views)) OVER (PARTITION BY country_id ORDER BY DATE_PART('month', date)) - 1 AS perc_change
FROM web_data
WHERE date <= '2018-05-31'
GROUP BY month, country_id;
```

## Week-over-week comparison
In the previous exercise, you leveraged the set window of a month to calculate month-over-month changes. But sometimes, you may want to calculate a different time period, such as comparing last 7 days to the previous 7 days. To calculate a value from the last 7 days, you will need to set up a rolling calculation.

In this exercise, you will take the rolling 7 day average of views for each date and compare it to the previous 7 day average for views. This gives a clear week-over-week comparison for every single day.

Syntax for a rolling average is AVG(value) OVER (PARTITION BY field ORDER BY field ROWS BETWEEN N PRECEDING AND CURRENT ROW), where N is the number of rows to look back when doing the calculation. Remember that CURRENT ROW counts as a row.

Instructions 1/3
35 XP
1
2
3
Show daily_views and weekly_avg by date, where weekly_avg is the rolling 7 day average of views.

Take Hint (-10 XP)

```sql
SELECT
  -- Pull in date and daily_views
  date,
  SUM(views) AS daily_views,
    -- Calculate the rolling 7 day average
  AVG(SUM(views)) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS weekly_avg
FROM web_data
GROUP BY date;
```
Alias the query as subquery, add an outer layer that pulls date and weekly_avg, and order by date in descending order.
Create the field weekly_avg_previous that takes the weekly_avg from 7 days prior to the given date.

```sql
SELECT 
  -- Pull in date and weekly_avg
  date,
    weekly_avg,
    -- Output the value of weekly_avg from 7 days prior
    LAG(weekly_avg,7) OVER (ORDER BY date) AS weekly_avg_previous
FROM
  (SELECT
      -- Pull in date and daily_views
      date,
      SUM(views) AS daily_views,
      -- Calculate the rolling 7 day average
      AVG(SUM(views)) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS weekly_avg
  FROM web_data
  -- Alias as subquery
  GROUP BY date) AS subquery
-- Order by date in descending order
ORDER BY date DESC;
```
Calculate perc_change where a value of 0 indicates no change, a negative value represents a drop in views versus previous period, and a positive value represents growth.

```sql
SELECT 
  -- Pull in date and weekly_avg
  date,
    weekly_avg,
    -- Output the value of weekly_avg from 7 days prior
    LAG(weekly_avg,7) OVER (ORDER BY date) AS weekly_avg_previous,
    -- Calculate percent change vs previous period
    weekly_avg / LAG(weekly_avg,7) OVER (ORDER BY date) - 1 as perc_change
FROM
  (SELECT
      -- Pull in date and daily_views
      date,
      SUM(views) AS daily_views,
      -- Calculate the rolling 7 day average
      AVG(SUM(views)) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS weekly_avg
  FROM web_data
  -- Alias as subquery
  GROUP BY date) AS subquery
-- Order by date in descending order
ORDER BY date DESC;
```

## Report 4: Tallest athletes and % GDP by region
The final report on the dashboard is Report 4: Avg Tallest Athlete and % of world GDP by Region.

Report Details:

Column 1 should be region found in the countries table.
Column 2 should be avg_tallest, which averages the tallest athlete from each country within the region.
Column 3 should be perc_world_gdp, which represents what % of the world's GDP is attributed to the region.
Only winter_games should be included (no summer events).
Instructions 1/3
35 XP
1
2
3
Pull country_id and height for winter athletes, group by these two fields, and order by country_id and height in descending order.
Use ROW_NUMBER() to create row_num, which numbers rows within a country by height where 1 is the tallest.

```sql
SELECT 
  -- Pull in country_id and height
    country_id, 
    height, 
    -- Number the height of each country's athletes
    ROW_NUMBER() OVER (PARTITION BY country_id ORDER BY height DESC) AS row_num
FROM winter_games AS w 
JOIN athletes AS a 
ON w.athlete_id = a.id
GROUP BY country_id, height
-- Order by country_id and then height in descending order
ORDER BY country_id, height DESC;
```

Alias your query as subquery then use this subquery to join the countries table to pull in the region and average_tallest field, the last of which averages the tallest height of each country.

```sql
SELECT
  -- Pull in region and calculate avg tallest height
    region,
    AVG(height) AS avg_tallest
FROM countries AS c
JOIN
    (SELECT 
      -- Pull in country_id and height
        country_id, 
        height, 
        -- Number the height of each country's athletes
        ROW_NUMBER() OVER (PARTITION BY country_id ORDER BY height DESC) AS row_num
    FROM winter_games AS w 
    JOIN athletes AS a 
    ON w.athlete_id = a.id
    GROUP BY country_id, height
    -- Alias as subquery
    ORDER BY country_id, height DESC) AS subquery
ON c.id = subquery.country_id
-- Only include the tallest height for each country
WHERE row_num = 1
GROUP BY region;
```

Join to the country_stats table to create the perc_world_gdp field that calculates [region's GDP] / [world's GDP].

```sql
SELECT
  -- Pull in region and calculate avg tallest height
    region,
    AVG(height) AS avg_tallest,
    -- Calculate region's percent of world gdp
    SUM(gdp)/SUM(SUM(gdp)) OVER () AS perc_world_gdp    
FROM countries AS c
JOIN
    (SELECT 
      -- Pull in country_id and height
        country_id, 
        height, 
        -- Number the height of each country's athletes
        ROW_NUMBER() OVER (PARTITION BY country_id ORDER BY height DESC) AS row_num
    FROM winter_games AS w 
    JOIN athletes AS a ON w.athlete_id = a.id
    GROUP BY country_id, height
    -- Alias as subquery
    ORDER BY country_id, height DESC) AS subquery
ON c.id = subquery.country_id
-- Join to country_stats
JOIN country_stats AS cs 
ON cs.country_id = c.id
-- Only include the tallest height for each country
WHERE row_num = 1
GROUP BY region;
```