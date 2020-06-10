# ETL Project
## Extract Transform Load 
### Team Members
* *Swati Saxena*
* *Firdosh Patel*
* *Ann McNamara*

### This repository contains the files regarding an ETL (Extraction, Transformation and Load) exercise conducted by our group. This folder contains the following:
1.	CSV Files:
    *	00_Extract_BigMacIndex_CSV
2.	Jupyter Notebook files:
    *	00_Extract_FRED_API
    *	01_Transform_FRED_API
    *	01_Transform_BigMacIndex_CSV
    *	02_Load
3.	Entity Relationship Diagram showing the details of the tables we created in our PostgreSQL database.
4.	SQL File, *queries.sql* showing the SQL used to create the tables in the PostgreSQL database.

## Background
This project applies ETL to the the concept of "burgernomics" as detailed in the Economist magazine . *"The big mac index was invented by The Economist in 1986 as a lighthearted guide to whether currencies are at their “correct” level. It is based on the theory of purchasing-power parity (PPP), the notion that in the long run exchange rates should move towards the rate that would equalise the prices of an identical basket of goods and services (in this case, a burger) in any two countries."*[(https://www.economist.com/news/2020/01/15/the-big-mac-index)]

<img src="/images/big_mac.jpg" 
     alt="Big Mac" width="500" />

### ETL
![query](/images/etl.png)

ETL stands for for Extract, Transform, and Load, three separate functions that are combined into one project to extract data out of one or more data sources and place it into another datas store or database. 

* **Extract** is the process of extracting data from one or more source(s). In the extract stage, data is gathered, often from multiple and different types of data sources.  In this example data is collected from API calls and a CSV file. 

* **Transform** is the process of converting the data extracted during the extract phase into a cleaner or more convienient form that better meets the need of the application. Unnecessary data are removed, data are renamed, and data is transformed into a format compatible with the need. Transformation also includes combining the data with other data.

* **Load** is the process of loading the data into the target database.

## Extraction:

We extracted data from two separate sources:
### The Federal Reserve Economic Data (FRED) Website: (https://fred.stlouisfed.org/)
<img src="/images/fred.png" 
     alt="fred" width="100"
     style="float: right; margin-right: 10px;" />

We used Jupyter Notebook to extract data using an API. 
* Four economic indicators related to the stock markets (Dow Jones Industrial Average, Nasdaq, S&P 500 and the Willshire 5000).
* Four economic indicators related to the commodity markets (Brent Crude Oil, WTI Crude Oil, Henry Hub Natural Gas and Gold).
* Four economic indicators related to the foreign currency exchange rate markets (Chinese Yuan to US Dollar, Indian Rupee to US Dollar, Japanese Yen to US Dollar, European Union Euro to US Dollar).

### The Economist Magazine Website: (https://www.economist.com/news/2020/01/15/the-big-mac-index)
<img src="/images/big_mac.png" 
     alt="burgernomics" width="100"
     style="float: right; margin-right: 10px;" />

We extracted data from a CSV file.
* The implied exchange rates calculated by the Economist based on the price of a McDonalds Big Mac in different countries across the world. We were interested in seeing how these “implied exchange rates” would compare to the actual exchange rates reported by the FRED website for the 4 exchange rates that we extracted. 

## Transformation:
We ran two Transformations:
### Data extracted via the API:
We used jupyter notebook to run the following transformations:
* Dropped rows containing “N/A”, spaces or periods instead of actual values.
* Renamed the columns to have intuitive names.
* Created Data Frame # 1 which contains daily level data for all 12 economic indicators. This data frame will be loaded into its own table in a database.
* Converted the Date column to a “Date Time Format”.
* Calculated a monthly level average of the daily level data for all of the 12 economic indicators. The monthly level average was assigned a date corresponding to the end of the month.
* Created Data Frame # 2 which contains monthly average level data for all 12 economic indicators. This data frame will be loaded into its own table in a database.
### Data extracted via the CSV File:
We used Jupyter notebook to run the following transformations:
* Dropped the unrequired columns.
* Dropped the unrequired rows within the column that contained the country name (countries that were not needed).
* Cleaned up the inconsistency in the dates by ensuring that all dates followed a “month-end” date format.
* Provided the ability to clean up the inconsistency in the dates by ensuring that all dates follow a “month-begin” date format (if needed in the future).
* Renamed the columns to have intuitive names.
* Created Data Frame # 3 which contains big mac data implied exchange rate from the economomist. This data frame will be loaded into its own table in a database.
## Load:
### We created a Database and the 3 Tables needed for our project:
We chose to use PostgreSQL as a Database because the data we are working with is very structured and will always be in a consistent format.
We created 3 tables as follows:
1.  combined_macro_eonomic_indicators_table_daily.
2.	aggregated_macro_economic_indicators_table_monthly.
3.	combined_big_mac_table.
Please note that we chose table names that are as descriptive as possible. When dealing with economic data, the level of granularity is so high, that many companies prefer table names to be as descriptive as possible to ensure that there is no ambiguity whatsoever regarding the data stored in a table. 

![erd](ER_Diagram.png)

### Loading Data into Tables in the Database:
* We used a jupyter notebook to load data into the 3 tables in the database as follows:
* We loaded data from Data Frame # 1 into the table called “combined_macro_eonomic_indicators_table_daily”.
* We loaded data from Data Frame # 2 into the table called “aggregated_macro_economic_indicators_table_monthly”.
* We loaded data from Data Frame # 3 into the table called “combined_big_mac_table”.
* We ran select statements from each of the 3 tables inside the PostgreSQL database and verified that all the data is in the 3 tables.

*Please click on images to see full resolution table*

#### TABLE 1: combined_big_mac_table
<img src="/images/select_big_mac.png" 
     alt="Big Mac Table" width="500" /> 

#### TABLE 2: combined_macro_economic_indicators_table_daily

<img src="/images/select_dailypng.png" 
     alt="Daily Table" width="500" />

#### TABLE 3: aggregated_macro_economic_indicators_table_monthly

<img src="/images/select_monthly.png" 
     alt="Monthly Table" width="500" />

### Sample Query
We also extracted the actual Indian Rupee to USD exchange rate, and the implied Indian Rupee to USD exchange rate, by running a join statement joining the following tables:
* aggregated_macro_economic_indicators_table_monthly (which contains data from the FRED website).
* combined_big_mac_table (which contains data from the Economist magazine website).

<!-- <img src="/images/target_analysis.png" 
     alt="Query" width="600" /> -->
![query](/images/target_analysis.png)

## Justification for Selecting PostGreSQL over mongoDB
Justification for why we chose PostGreSQL (relational) instead of MongoDB for our ETL Project:
### Use Relational SQL Databases When:
* ACID (Atomicity, Consistency, Isolation, Durability) principles are enforced. This reduces anomalies, enforces integrity and that is why this is preferred for commerce and financial applications.
* Data structure is not changing. If you application design is solid and not expected to be changing with future requirements (at least not very often) then it is best to  proceed to use this type of construct and be confident in your data.
### Use Non-Relational No-SQL Databases When:
* Rapid Application Development is used. No-SQL database supporting rapidly changing designs and coding sprints and is perfect for more Agile settings, where requirements change often.
*  Storing large amounts of data with little to no structure. Much like expressed in the previous point, if your data requirements are not clear, bu you know that you need to store lots of data somewhere and somehow, then you can use this database type, which you can morph on the fly to match the requirement.

Based on the fact our data structure is not chaning and we want to enforce ACID principles we are confident using a relational database is a good choice for storing this data. 

# Summary
The above description demonstrates our team capability to successfully apply Extract, Tranform and Load (ETL).  

