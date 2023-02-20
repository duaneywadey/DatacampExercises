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
