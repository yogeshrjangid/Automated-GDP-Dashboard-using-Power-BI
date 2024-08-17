-- Step 1: Create the table

IF OBJECT_ID( 'Raw_Data_GDP') IS NOT NULL DROP TABLE Raw_Data_GDP

CREATE TABLE Raw_Data_GDP
(DEMO_IND NVARCHAR (200), Indicator NVARCHAR (200), [LOCATION] NVARCHAR(200),
Country NVARCHAR(200), [TIME] NVARCHAR(200),
[Value] FLOAT,
[Flag Codes] NVARCHAR(200),
Flags NVARCHAR (200))


-- Step 2: Importa the Data
BULK INSERT Raw_Data_GDP
FROM 'C:\Users\joshi\Desktop\SP\PowerBi\LearningSQL\Project\ProjectFile\gdp_raw_data.csv'
WITH ( FORMAT='CSV');
--SELECT * FROM Raw_Data_GDP   This command basically pull your all data into the SQL.but for out powerBi we need only few data which will be selected below.


-- Step 3: Create the view we need - This is a "One off"
-- DROP VIEW GDP_Excel_Input (This is used for dropping below created view)

CREATE VIEW GDP_Excel_Input AS

SELECT a.*,b.GDP_Per_Capita FROM
(SELECT Country, [Time] AS Year_No, [Value] AS GDP_Value FROM Raw_Data_GDP
WHERE  Indicator= 'GDP (current US$)') a
LEFT JOIN
(SELECT Country,[Time] AS Year_No, [Value] AS GDP_Per_Capita FROM Raw_Data_GDP
WHERE Indicator ='GDP per capita (current US$)' ) b
ON a.Country= b.Country AND a.Year_No = b.Year_No

-- SELECT * from GDP_Excel_Input    (Shows out view which we have created)
--*/ 

-- STEP 4: Creating a Store Procedure
CREATE PROCEDURE GDP_Excel_Input_Monthly AS

IF OBJECT_ID('Raw_Data_GDP') IS NOT NULL DROP TABLE Raw_Data_GDP

CREATE TABLE Raw_Data_GDP
(DEMO_IND NVARCHAR (200), Indicator NVARCHAR (200), [LOCATION] NVARCHAR (200), Country NVARCHAR(200), [TIME] NVARCHAR (200),
[Value] FLOAT,
[Flag Codes] NVARCHAR(200),
Flags NVARCHAR (200))

-- Step 2: Import the Data

BULK INSERT Raw_Data_GDP
FROM 'C:\Users\joshi\Desktop\SP\PowerBi\LearningSQL\Project\ProjectFile\gdp_raw_data.csv'
WITH (FORMAT='CSV')


-- DROP PROCEDURE dbo.GDP_Excel_Input_Monthly
-- EXEC GDP_Excel_Input_Monthly   (Command to update the Data After change in excel file)