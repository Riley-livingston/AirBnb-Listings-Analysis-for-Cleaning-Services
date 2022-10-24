<img src="https://i.imgur.com/KAKciod.jpg" height = "100%" width="100%" alt = ">Airbnb Analysis for Cleaning Services"/>

<h1>Airbnb Analysis for Cleaning Services in NYC - Active Directory </h1>
<h2>Key Findings</h2>
Put key findings in this space. Shoert and sweet explanatoin of what you found and why it matters in the context of the business problem


<h2>Authors</h2>

<a href="https://github.com/Riley-livingston"> @RileyLivingston</a>

<h2>Description</h2>
This project consists of exploritory analysis of publicly available Airbnb data. This directory will guide you through the steps I took and thought process in formulating a client list for an Airbnb cleaning service in New York City.

<br />

<h2>Languages and utilities used</h2>

- <b>MySQL</b> 
- <b>Tableau</b>

<h2>Environments used </h2>

- <b>DBeaver 22.2.2</b>

<h2>Data source</h2>

- <a href="https://drive.google.com/drive/folders/1Q2yFaDajfJ6hALKMCmrQbHnFhsti44bO?usp=sharing"> Airbnb detailed listings and reviews data NYC 09-07-2022</a>
- <a href="https://docs.google.com/spreadsheets/d/1iWCNJcSutYqpULSQHlNyGInUvHg2BoUGoNRIGa6Szc4/edit#gid=1322284596"> Data dictionary</a>

<h2>Methods</h2>

- <b>Exploratory data analysis</b>

<h2>Data Analysis Process:</h2>

<p align="left">
 <u>Business task</u>:
 
- <b>Determine a high conversion rate client list that can be utulized by airbnb cleaning services in NYC using exploratory analysis.</b>
 
  -<b> KEY METRICS: 
    - <b>number of distinct reviews that contain words signaling uncleanliness grouped by host
    - <b>number of distinct reviews that contain words signaling uncleanliness per listing grouped by host
 

<br />
<br />
<p align="left">
 <u>Data preparation</u>: 
 
 -<b> PRIVACY AND ACESSABILITY:
 
   - Data for this analysis was scrapped directly from Airbnb's website by third party <a href="https://insideairbnb.com"> insideairbnb</a>.
   - All data present in this repository as well as findings derived from analysis is publicly available information and falls under fair use. No private         information is being used including names, listings, and review details as it is all publicly displayed on Airbnb’s website.
 <br/>
 -<b> DATA STRUCTURE AND INTEGRITY:
 
   - Data used in this analysis is organized in 2 tables(listigns and reviews) and columns in csv format. 
   - Integrity of the data source was verfified by choosing 10 random listings urls from the listings table listing_url column and comparing the information from the link to the infromtion scrped and orgsnized into columns in the reviews and listings tables.

 
<br />
<br />
Documentation of data processing and cleaning: <br/>
  - <a href="https://github.com/Riley-livingston/AirBnb-Project/blob/main/clean_and_filtered_airbnb_mysql_script_v1.sql"> SQL script to clean and filter the data.sql</a>
<br />
  - <a href="https://github.com/Riley-livingston/AirBnb-Project/blob/main/clean_and_filtered_airbnb_data_v2.csv"> Cleaned and filtered data.csv</a>
 <br />
 <br />
<img src="https://i.imgur.com/ZkfqMyt.png" height = "100%" width="100%" alt = ">SQL select statement with explaination"/>
      - From the listings table, host_id, host_nmae and host_url are selected. host_url and host_id are used as primary keys for the listings table to unqiyely identify each host
 <br />
 <br /> 
       - Host_total_listing count and number_of_reviews are selected and casted as integers. This turns all non-numerical data in both of those columns into NULL. The data is also tranformed to be used with operators and aggregations if needed.
 <br />
 <br />
       - Distinct comments are counted, selected from the reviews table, and aggregated into a new column called dirty_review_count that will count all distinct reviews that contain specified 'dirty review' words.
 <br />
 <br />
<img src="https://i.imgur.com/Fr7ChSk.png" height = "100%" width="100%" alt = ">SQL Join statement and conditions for dirty reviews with explaination"/>
   - An inner join is made between the listings and reviews tables, returning columns where the listing id matches the id field from the review table AND where airbnb listing reviews in the comments column of the review table contain at least one of the specified dirty words contained in the LIKE statements.
 <br />
 <br />
<img src="https://i.imgur.com/Q31eJA5.png" height = "100%" width="100%" alt = ">SQL more filtering and group by order by conditions with explaination"/>
  - The inner join between the lstings and reviews tables are further filtered under the condtions that the length of the review_score_rating and review_score_cleanliness ratings are no greater than 4 characters in length
  <br />
  <br />
 - The maximum nnumber of reviews of any given listing is 999 so the maximum length of the number_of_reviews column was set to 3 in order to filter out potential invalid data.
  <br />
  <br />
 - The query is fianlly grouped by host_id and host_url and then ordered by the total number of dirty reviews counted in descending order as a way to gain immediate insight into potential customers to contact for cleaning services.
<br />
<br />
<br />
Analysis:  <br/>

<br />
<br />
 <u> key findings</u>:
<br/>
<br/> 
 - <b>VIZ PREVIEW:
   <img src="https://i.imgur.com/hs9FuEm.png" height = "100%" width="100%" alt = "Results Snapshot: Top 25 Hosts sorted by dirty reviews per listing"/>
 - <a href="https://public.tableau.com/app/profile/riley.livingston/viz/Airbnbdirtyreviewproject/Dashboard1?publish=yes"> Tableau | Dashboard</a>
<br />
<br />
 - <b>VIZ PREVIEW:
   <img src="https://i.imgur.com/lOKLiWT.png" height = "100%" width="100%" alt = "Results Snapshot: Distribution and percentiles of Dirty Reviews per listing grouped by host"/>
 - <a href="https://public.tableau.com/app/profile/riley.livingston/viz/Airbnbdirtyreviewproject/Dashboard2?publish=yes"> Tableau | Dashboard </a>
<br />
<h2>Limitations and what can be improved </h2>
 - <b>The data and results of the analysis are a snapshot of listings available on Airbnb on September 7th 2022. Hosts may remove or add listings at anytime and renters may post or delete reviews at anytime which may impact the results of the analysis. Seasonality bias may be present in the number of reviews that contain 'dirty' words indicating uncleanliness.</b>
<br />
<br />
 - The words used to measure dirty reviews are all weighted the same but each dirty review may differ in the severity of the uncleanliness which would impact bookings and be of greater interest to a cleaning service looking for clients.
<br />
<br />
 - A list of 15 words was selected to search for dirty reviews in the communts column of the reviews table. This list may not represnted all of the ways a person would describe unclenliness and leading to some reviews not being counted and included in the analysis.

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
