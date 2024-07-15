## User Journeys in an E-Learning Subscription Service

### Project Overview
This project aims to analse user activity and engagement in their user journey up to the point that they purchase a (new) subscription in Q1 2023 in an online learning platform. The focus is on the website pages that that they visit before their purchase and the path and length of their user journeys. This information has implications for UX/UI design, as well as for relevant KPIs and marketing strategies.

### Data Sources
The data is taken from an SQL database consisting of three tables: 
* __Front Interactions__ (1.6+ million records) includes visitor activity on the website by visitor and by session, from front page clickthroughs to various pages including checkout.
* __Purchases__ (126 546 records) focuses on user purchase activity including type of subscription (monthly, quarterly, annual) and the purchase price and date.
* __Front Visitors__ (244 670 records) is a link between the other two tables by referencing user_id and visitor_id.
 
### Tools

![MySQL Badge](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=fff&style=flat)
![Docker Badge](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=fff&style=flat)
![Python Badge](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=fff&style=flat)
![Visual Studio Code Badge](https://img.shields.io/badge/Visual%20Studio%20Code-007ACC?logo=visualstudiocode&logoColor=fff&style=flat)

### Data Cleaning/Preparation
The main preparation neeeded to get the data ready for further processing included:
* Checking for NULL values and removing records where necessary
* Removing test users (i.e. users who paid $0 for a subscription) from the data
* [Re-formatting website page names to use aliases](pre-processing/url_to_alias.sql)
* [Changing subscription type from code to text](pre-processing/reformat_purchase_type.sql)


### Data Analysis: User Journeys
The data were extracted using [SQL queries](user_journey_analysis/user_journey_by_quarter.sql) on MySQLWorkbench to show the sequence of pages visited that led to a first-time subscrition purchase in Q1 2023 (January 1, 2023 to March 31, 2023). Some further [formatting](data_formatting/formatting.py) was needed after the SQL processing, and as this was text data it was done using Python instead. The exported .csv file shows User ID, Session ID, Subscription Type, and User Journey.


<img src="src/user_journey_file.png?raw=true"/>




Some further formatting was needed after the 

### Data Analysis: Purchase Patterns
