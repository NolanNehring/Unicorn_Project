--Questions
--Main Question: What is the current and future trend for Unicorn Companies?

--Questions that will help explain the trends

--1. What is the distribution of unicorn companies by industry, and which industries have the highest number of unicorns? Bar Graph
--2. What is the distribution of funding across different unicorn industries, and how much money goes into each industry? Bar Graph
--3. What is the geographic distribution of unicorn companies, and which countries and cities have the highest number of unicorns? World Graph
--4. How has the number of unicorn companies changed over time? Line Graph
--5. Which countries have the highest amount of valuations based on the available data? Bar Graph
--6. How has the distribution of funding across different unicorn industries changed over time? Line Graph
--I am going to create tables for each of the questions data.
Select *
From PortfolioProjects..Unicorn2022
-- I had to drop a column because Python did not detect it
Alter Table Unicorn2022
Drop Column F1
-- Another Fix on the Industry column
UPDATE PortfolioProjects..table_1 SET Industry = 'Internet software & services' WHERE Industry = 'Internet';

--1. What is the distribution of unicorn companies by industry, and which industries have the highest number of unicorns? Bar Graph
Create view table_1 as
Select Industry 
From PortfolioProjects..Unicorn2022

Select *
From PortfolioProjects..table_1



-- What is the distribution of funding across different unicorn industries, and how much money goes into each industry?
CREATE VIEW table_2 AS
SELECT Industry, SUM([Valuation ($B)]) AS [Total Valuation]
FROM PortfolioProjects..Unicorn2022
GROUP BY Industry;

Select *
From PortfolioProjects..table_2

--3. What is the geographic distribution of unicorn companies, and which countries have the highest number of unicorns? World Graph
CREATE VIEW table_3 AS
SELECT Country
FROM PortfolioProjects..Unicorn2022

Select *
From PortfolioProjects..table_3

--4. How has the number of unicorn companies changed over time? Line Graph
CREATE VIEW table_4 AS
SELECT Industry, YEAR([Date Joined]) AS YearJoined, 
       COUNT(*) AS CumulativeCount
FROM Unicorn2022
WHERE [Date Joined] <= '2022-12-31'
GROUP BY Industry, YEAR([Date Joined])
ORDER BY Industry, YEAR([Date Joined]), COUNT(*) DESC
OFFSET 0 ROWS
FETCH NEXT 1000000000 ROWS ONLY

Select *
From PortfolioProjects..table_4

--5. Which countries have the highest amount of valuations based on the available data? World Graph
CREATE VIEW table_5 AS 
SELECT Country, SUM([Valuation ($B)]) AS [Total Valuation]
FROM PortfolioProjects..Unicorn2022
GROUP BY Country;

Select *
From PortfolioProjects..table_5

--6. How has the distribution of funding across different unicorn industries changed over time?
CREATE VIEW table_6 AS
SELECT Industry, YEAR([Date Joined]) AS YearJoined, 
        SUM([Valuation ($B)]) AS [Total Valuation]
FROM Unicorn2022
WHERE [Date Joined] <= '2022-12-31'
GROUP BY Industry, YEAR([Date Joined])
ORDER BY Industry, YEAR([Date Joined]), SUM([Valuation ($B)]) DESC
OFFSET 0 ROWS
FETCH NEXT 1000000000 ROWS ONLY

Select *
From PortfolioProjects..table_6