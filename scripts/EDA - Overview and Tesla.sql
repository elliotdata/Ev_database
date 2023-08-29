/* DATABASE PREP */
CREATE TABLE electric_vehicles (
    more_details_url VARCHAR(255),
    make VARCHAR(50),
    model VARCHAR(50),
    battery_capacity FLOAT,
    towbar VARCHAR(10),
    market_segment VARCHAR(50),
    number_of_seats INT,
    acceleration FLOAT,
    top_speed INT,
    range_miles INT,
    efficiency FLOAT,
    fastcharge VARCHAR(10),
    germany_price FLOAT,
    nl_price FLOAT,
    uk_price FLOAT
);

/* IMPORTED THE ev_database_28aug23.csv USING TABLE DATA IMPORT WIZARD*/



/* OVERVIEW OF THE DATABASE*/

/* View of the Data */
SELECT *
FROM electric_vehicles
LIMIT 5; 

/* Shape of the Data */
SELECT COUNT(*) AS total_rows
FROM electric_vehicles;

/* Look for missing values */
SELECT 'electric_vehicles' AS table_name,
       COUNT(*) - COUNT(make) AS missing_make,
       COUNT(*) - COUNT(model) AS missing_model,
       COUNT(*) - COUNT(battery_capacity) AS missing_battery_capacity,
       COUNT(*) - COUNT(towbar) AS missing_towbar_capacity,
       COUNT(*) - COUNT(market_segment) AS missing_market_segment,
       COUNT(*) - COUNT(acceleration) AS missing_acceleration,
       COUNT(*) - COUNT(top_speed) AS missing_top_speed,
       COUNT(*) - COUNT(range_miles) AS missing_range,
       COUNT(*) - COUNT(efficiency) AS missing_efficiency,
       COUNT(*) - COUNT(fastcharge) AS missing_fastcharge,
       COUNT(*) - COUNT(germany_price) AS missing_germany_price,
       COUNT(*) - COUNT(nl_price) AS missing_nl_price,
       COUNT(*) - COUNT(uk_price) AS missing_uk_price
FROM electric_vehicles;

/* Look for distinct values */
SELECT DISTINCT make
FROM electric_vehicles;

/* Count of distinct car makes */
SELECT COUNT(DISTINCT make) AS total_car_makes
FROM electric_vehicles;

/* Battery capacity statistics */
SELECT MIN(battery_capacity) AS min_battery,
       MAX(battery_capacity) AS max_battery,
       AVG(battery_capacity) AS avg_battery
FROM electric_vehicles
WHERE battery_capacity > 0;

/* Acceleration statistics */
SELECT MIN(acceleration) AS min_acceleration,
       MAX(acceleration) AS max_acceleration,
       AVG(acceleration) AS avg_acceleration
FROM electric_vehicles
WHERE acceleration > 0;

/* Top speed statistics */
SELECT MIN(top_speed) AS min_speed,
       MAX(top_speed) AS max_speed,
       AVG(top_speed) AS avg_speed
FROM electric_vehicles
WHERE top_speed > 0;

/* Range miles statistics */
SELECT MIN(range_miles) AS min_range,
       MAX(range_miles) AS max_range,
       AVG(range_miles) AS avg_range
FROM electric_vehicles
WHERE range_miles > 0;

/* Top 5 manufacturers by count in the EV market */
SELECT make, COUNT(*) AS count
FROM electric_vehicles
GROUP BY make
ORDER BY count DESC
LIMIT 5;

/* Top 5 market segments by count in EV market */
SELECT market_segment, COUNT(*) AS count
FROM electric_vehicles
GROUP BY market_segment
ORDER BY count DESC
LIMIT 5;

/* Performance */

/* Top 5 vehicles with highest battery capacity in the EV market */
SELECT make, model, battery_capacity
FROM electric_vehicles
ORDER BY battery_capacity DESC
LIMIT 5;

/* Top 5 vehicles with highest top speed in the EV market */
SELECT make, model, top_speed
FROM electric_vehicles
ORDER BY top_speed DESC
LIMIT 5;

/* Top 5 vehicles with longest range in the EV market */
SELECT make, model, range_miles
FROM electric_vehicles
ORDER BY range_miles DESC
LIMIT 5;

/* Efficiency */

/* Top 5 vehicles with highest efficiency in the EV market */
SELECT make, model, efficiency
FROM electric_vehicles
ORDER BY efficiency DESC
LIMIT 5;

/* Top 5 vehicles with lowest efficiency in the EV market */
SELECT make, model, efficiency
FROM electric_vehicles
ORDER BY efficiency
LIMIT 5;

/* EV that is least expensive in UK and Europe */
SELECT make, model, 
       GREATEST(COALESCE(nl_price, 9999999), COALESCE(germany_price, 9999999), COALESCE(uk_price, 9999999)) AS min_price_across_countries
FROM electric_vehicles
ORDER BY min_price_across_countries
LIMIT 5;

/* EV that is most expensive in UK and Europe */
SELECT make, model, 
       LEAST(COALESCE(nl_price, 0), COALESCE(germany_price, 0), COALESCE(uk_price, 0)) AS max_price_across_countries
FROM electric_vehicles
ORDER BY max_price_across_countries DESC
LIMIT 5;

/* FOCUSED EDA ON TESLA MODELS */
/* Total number of Tesla Vehicles in the EV market */
SELECT COUNT(*) AS total_tesla_vehicles
FROM electric_vehicles
WHERE make = 'Tesla';

/* Range of Tesla Models */
SELECT model, range_miles AS max_range
FROM electric_vehicles
WHERE make = 'Tesla'
GROUP BY model
ORDER BY max_range DESC;

/* Top speed of Tesla Models */
SELECT model, MAX(top_speed) AS max_top_speed
FROM electric_vehicles
WHERE make = 'Tesla'
GROUP BY model;

/* Efficiency of Tesla Models */
SELECT model, AVG(efficiency) AS avg_efficiency
FROM electric_vehicles
WHERE make = 'Tesla'
GROUP BY model;

/* Market Segment and distribution of Tesla Models */
SELECT market_segment, COUNT(*) AS count
FROM electric_vehicles
WHERE make = 'Tesla'
GROUP BY market_segment
ORDER BY count DESC;

/* Pricing ranges of Tesla vehicles */
SELECT model, MIN(uk_price) AS min_uk_price, MAX(uk_price) AS max_uk_price
FROM electric_vehicles
WHERE make = 'Tesla'
GROUP BY model;

/* Pricing ranges of Tesla vehicles using COALESCE */
SELECT model, MIN(COALESCE(uk_price, nl_price, germany_price)) AS price
FROM electric_vehicles
WHERE make = 'Tesla'
GROUP BY model
ORDER BY price DESC;
