/*
This query creates a new table "paid_users".  
The code can easily tonot create a new table but to export the query results
as a .csv file using MySQLWorkbench or other interface.

*/

CREATE TABLE paid_users AS

 -- remove test users who paid $0
WITH paid_users1(user_id, first_purchase_date, subscription_type, purchase_price) AS(  
SELECT  user_id, date_purchased, purchase_type, purchase_price
   FROM student_purchases
   WHERE purchase_price > 0.00
), 

  -- select for the chosen time period here
paid_users2 AS( 
SELECT *
FROM paid_users1
WHERE first_purchase_date  >= '2023-01-01 00:00:00' AND first_purchase_date <= '2023-03-31 00:00:00'  
ORDER BY user_id),

paid_users3 AS(
SELECT *
FROM paid_users2
WHERE user_id != 0
ORDER BY user_id),

paid_users4 AS(
SELECT p.user_id,f.visitor_id, p.first_purchase_date, p.subscription_type, p.purchase_price 
FROM paid_users3 p
JOIN front_visitors f ON p.user_id = f.user_id
ORDER BY user_id),

paid_users5 AS(
SELECT p4.user_id, p4.visitor_id, fi.session_id, fi.event_source_url, fi.event_destination_url, p4.subscription_type, p4.purchase_price 
FROM paid_users4 p4
LEFT JOIN front_interactions fi ON p4.visitor_id = fi.visitor_id
ORDER BY visitor_id),

paid_users_select(user_id, session_id, event_source_url, event_destination_url, subscription_type) AS(
SELECT user_id, session_id, event_source_url, event_destination_url, subscription_type
FROM paid_users5),

session_journey AS(
SELECT *, CONCAT(event_source_url, "-", event_destination_url) AS session_user_journey
FROM paid_users_select),

user_journey AS(
SELECT ANY_VALUE(session_user_journey) AS session_user_journey, ANY_VALUE(session_id) AS session_id, ANY_VALUE(user_id) AS user_id, ANY_VALUE(subscription_type) AS subscription_type,
GROUP_CONCAT(session_user_journey SEPARATOR '-') AS user_journey
FROM session_journey
GROUP BY session_id),

user_journey_tab AS(
SELECT user_id, session_id, subscription_type, user_journey
FROM  user_journey
ORDER BY user_id)

SELECT *
FROM user_journey_tab;


