# Introduction to SQL Server

## Create tables
Say you want to create a table to consolidate some useful track information into one table. This will consist of the track name, the artist, and the album the track came from. You also want to store the track length in a different format to how it is currently stored in the track table. How can you go about doing this? Using CREATE TABLE. Recall the example from the video:

```
CREATE TABLE test_table(
  test_date DATE, 
  test_name VARCHAR(20), 
  test_int INT
)
```
Let's get started!

Instructions 1/3
35 XP
1
2
3
Create a table named 'results' with 3 VARCHAR columns called track, artist, and album, with lengths 200, 120, and 160, respectively.

```sql
-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
    -- Create artist column
	artist VARCHAR(120),
    -- Create album column
	album VARCHAR(160),
	);
```

Create one integer column called track_length_mins.

```sql
-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
    -- Create artist column
	artist VARCHAR(120),
    -- Create album column
	album VARCHAR(160),
	-- Create track_length_mins
	track_length_mins INT,
	);
```

SELECT all the columns from your new table. No rows will be returned, but you can confirm that the table has been created.

```sql
-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
    -- Create artist column
	artist VARCHAR(120),
    -- Create album column
	album VARCHAR(160),
	-- Create track_length_mins
	track_length_mins INT,
	);

-- Select all columns from the table
SELECT 
  track, 
  artist, 
  album, 
  track_length_mins 
FROM 
  results;
```

## Insert
This exercise consists of two parts: In the first, you'll create a new table very similar to the one you created in the previous interactive exercise. After that, you'll insert some data and retrieve it.

You'll continue working with the Chinook database here.

Instructions 1/2
0 XP
1
2
Create a table called tracks with 2 VARCHAR columns named track and album, and one integer column named track_length_mins. Then SELECT all columns from your new table using the * shortcut to verify the table structure.

Hint

```sql
-- Create the table
CREATE TABLE tracks(
  -- Create track column
  track VARCHAR(200), 
  -- Create album column
  album VARCHAR(160), 
  -- Create track_length_mins column
  track_length_mins INT
);
-- Select all columns from the new table
SELECT 
  * 
FROM 
  tracks;
```

Insert the track 'Basket Case', from the album 'Dookie', with a track length of 3, into the appropriate columns. Then perform the SELECT * once more to view your newly inserted row.

```sql
-- Create the table
CREATE TABLE tracks(
  -- Create track column
  track VARCHAR(200), 
  -- Create album column
  album VARCHAR(160), 
  -- Create track_length_mins column
  track_length_mins INT
);
-- Complete the statement to enter the data to the table     
INSERT INTO tracks 
-- Specify the destination columns
(track, album, track_length_mins) 
-- Insert the appropriate values for track, album and track length
VALUES 
  ('Basket Case', 'Dookie', 3);
-- Select all columns from the new table
SELECT 
  * 
FROM 
  tracks;
```

## Update

You may sometimes have to update the rows in a table. For example, in the album table, there is a row with a very long album title, and you may want to shorten it.

You don't want to delete the record - you just want to update it in place. To do this, you need to specify the album_id to ensure that only the desired row is updated and all others are not modified.

Instructions 2/3
1 XP
2
3
That's a very long album title, isn't it? Use an UPDATE statement to modify the title to 'Pure Cult: The Best Of The Cult'.

```sql
-- Select the album
SELECT 
  title 
FROM 
  album 
WHERE 
  album_id = 213;
-- UPDATE the album table
UPDATE 
  album 
-- SET the new title  
SET 
  title = 'Pure Cult: The Best Of The Cult' 
WHERE 
  album_id = 213;
```

## Delete
You may not have permissions to delete from your database, but it is safe to practice it here in this course!

Remember - there is no confirmation before deleting. When you execute the statement, the record(s) are deleted immediately. Always ensure you test with a SELECT and WHERE in a separate query to ensure you are selecting and deleting the correct records. If you forget to specify a WHERE condition, you will delete ALL rows from the table.

Instructions 2/2
50 XP
2
DELETE the record from album where album_id is 1 and then hit 'Submit Answer'.

```sql
-- Run the query
SELECT 
  * 
FROM 
  album 
  -- DELETE the record
DELETE FROM 
  album 
WHERE 
  album_id = 1 
  -- Run the query again
SELECT 
  * 
FROM 
  album;
```
## DECLARE and SET a variable
Using variables makes it easy to run a query multiple times, with different values, without having to scroll down and amend the WHERE clause each time. You can quickly update the variable at the top of the query instead. This also helps provide greater security, but that is out of scope of this course.

Let's go back to the now very familiar grid table for this exercise, and use it to practice extracting data according to your newly defined variable.

Instructions 2/3
1 XP
2
3
SET your newly defined variable to 'RFC'.


```sql
-- Declare the variable @region
DECLARE @region VARCHAR(10)

-- Update the variable value
SET @region = 'RFC'
```

```sql
-- Declare the variable @region
DECLARE @region VARCHAR(10)

-- Update the variable value
SET @region = 'RFC'

SELECT description,
       nerc_region,
       demand_loss_mw,
       affected_customers
FROM grid
WHERE nerc_region = @region;
```

## Declare multiple variables
You've seen how to DECLARE and SET set 1 variable. Now, you'll DECLARE and SET multiple variables. There is already one variable declared, however you need to overwrite this and declare 3 new ones. The WHERE clause will also need to be modified to return results between a range of dates.

Instructions 2/4
1 XP
2
3
4
Declare a new variable called @stop of type DATE.

```sql
-- Declare @start
DECLARE @start DATE

-- Declare @stop
DECLARE @stop DATE;

-- SET @start to '2014-01-24'
SET @start = '2014-01-24'

-- SET @stop to '2014-07-02'
SET @stop  = '2014-07-02';
```

Declare a new variable called @affected of type INT.

```sql
-- Declare @start
DECLARE @start DATE

-- Declare @stop
DECLARE @stop DATE

-- Declare @affected
Declare @affected INT;

-- SET @start to '2014-01-24'
SET @start = '2014-01-24'

-- SET @stop to '2014-07-02'
SET @stop  = '2014-07-02'

-- Set @affected to 5000
SET @affected =  5000;
```

Retrieve all rows where event_date is BETWEEN @start and @stop and affected_customers is greater than or equal to @affected.

```sql
-- Declare your variables
DECLARE @start DATE
DECLARE @stop DATE
DECLARE @affected INT;
-- SET the relevant values for each variable
SET @start = '2014-01-24'
SET @stop  = '2014-07-02'
SET @affected =  5000 ;

SELECT 
  description,
  nerc_region,
  demand_loss_mw,
  affected_customers
FROM 
  grid
-- Specify the date range of the event_date and the value for @affected
WHERE event_date BETWEEN @start AND @stop
AND affected_customers >= @affected;
```

## Ultimate Power
Sometimes you might want to 'save' the results of a query so you can do some more work with the data. You can do that by creating a temporary table that remains in the database until SQL Server is restarted. In this final exercise, you'll select the longest track from every album and add that into a temporary table which you'll create as part of the query.

Instructions
100 XP
Insert data via a SELECT statement into a temporary table called #maxtracks.
Join album to artist using artist_id, and track to album using album_id.
Run the final SELECT statement to retrieve all the columns from your new table.

```sql
SELECT  album.title AS album_title,
  artist.name as artist,
  MAX(track.milliseconds / (1000 * 60) % 60 ) AS max_track_length_mins
-- Name the temp table #maxtracks
INTO #maxtracks
FROM album
-- Join album to artist using artist_id
INNER JOIN artist ON album.artist_id = artist.artist_id
-- Join track to album using album_id
INNER JOIN track ON album.album_id = track.album_id
GROUP BY artist.artist_id, album.title, artist.name, album.album_id
-- Run the final SELECT query to retrieve the results from the temporary table
SELECT album_title, artist, max_track_length_mins
FROM  #maxtracks
ORDER BY max_track_length_mins DESC, artist;
```