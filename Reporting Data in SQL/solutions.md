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