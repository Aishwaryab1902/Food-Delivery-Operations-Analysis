
-- FOOD DELIVERY OPERATIONS ANALYSIS
-- SQL Stage 1: Data Quality and Performance

-- Query 1: Dataset overview
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
    MIN(time_taken_min) AS fastest_delivery,
    MAX(time_taken_min) AS slowest_delivery
FROM food_delivery_cleaned_final;

-- Query 2: Delivery performance KPIs
SELECT
    COUNT(*) AS total_orders,
    SUM(on_time_30min) AS on_time_orders,
    ROUND(SUM(on_time_30min) * 100.0 / COUNT(*), 2)
        AS on_time_percentage,
    SUM(delayed_over_45min) AS severe_delay_orders,
    ROUND(SUM(delayed_over_45min) * 100.0 / COUNT(*), 2)
        AS severe_delay_percentage
FROM food_delivery_cleaned_final;

-- Query 3: Delivery time by traffic density
SELECT
    road_traffic_density,
    COUNT(*) AS total_orders,
    ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
    ROUND(AVG(time_taken_min) - 26.29, 2)
        AS difference_from_overall
FROM food_delivery_cleaned_final
GROUP BY road_traffic_density
ORDER BY avg_delivery_time DESC;

-- Query 4: Delivery time and severe delays by weather
Next: Weather analysis
Our next SQL query will identify which weather conditions are associated with the longest delivery times.

SELECT
    weather_conditions,
    COUNT(*) AS total_orders,
    ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
    SUM(delayed_over_45min) AS severe_delay_orders
FROM food_delivery_cleaned_final
GROUP BY weather_conditions
ORDER BY avg_delivery_time DESC;


-- Step 5 — Calculate severe-delay rates by weather
--Let's strengthen the analysis by calculating the percentage of orders severely delayed under each weather condition.

SELECT
    weather_conditions,
    COUNT(*) AS total_orders,
    SUM(delayed_over_45min) AS severe_delay_orders,
    ROUND(
        SUM(delayed_over_45min) * 100.0 / COUNT(*), 2
    ) AS severe_delay_percentage
FROM food_delivery_cleaned_final
GROUP BY weather_conditions
ORDER BY severe_delay_percentage DESC;

-- Query 5: Festival impact on delivery performance
Step 3 — Next SQL analysis: Festival impact
SELECT
    festival,
    COUNT(*) AS total_orders,
    ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
    SUM(delayed_over_45min) AS severe_delay_orders,
    ROUND(
        SUM(delayed_over_45min) * 100.0 / COUNT(*), 2
    ) AS severe_delay_percentage
FROM food_delivery_cleaned_final
GROUP BY festival
ORDER BY festival;


-- Query 6: Vehicle type performance.
SELECT
    vehicle_type,
    COUNT(*) AS total_orders,
    ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
    SUM(delayed_over_45min) AS severe_delay_orders,
    ROUND(
        SUM(delayed_over_45min) * 100.0 / COUNT(*), 2
    ) AS severe_delay_percentage
FROM food_delivery_cleaned_final
GROUP BY vehicle_type
ORDER BY avg_delivery_time DESC;

-- Query 7: City-wise delivery performance.
SELECT
    city,
    COUNT(*) AS total_orders,
    ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
    SUM(delayed_over_45min) AS severe_delay_orders,
    ROUND(
        SUM(delayed_over_45min) * 100.0 / COUNT(*), 2
    ) AS severe_delay_percentage
FROM food_delivery_cleaned_final
GROUP BY city
ORDER BY avg_delivery_time DESC;

--Query 8: Validate city-wise severe-delay flags
SELECT
    city,
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN time_taken_min > 45 THEN 1
        ELSE 0
    END) AS actual_over_45_min,
    SUM(delayed_over_45min) AS flagged_severe_delays,
    SUM(CASE
        WHEN (time_taken_min > 45 AND delayed_over_45min <> 1)
          OR (time_taken_min <= 45 AND delayed_over_45min <> 0)
        THEN 1
        ELSE 0
    END) AS mismatched_flags
FROM food_delivery_cleaned_final
GROUP BY city;

-- Query 9: Distance-wise delivery performance.
SELECT
    CASE
        WHEN distance_km_straight_line IS NULL THEN 'Unknown'
        WHEN distance_km_straight_line <= 2 THEN '0-2 km'
        WHEN distance_km_straight_line <= 4 THEN '2-4 km'
        WHEN distance_km_straight_line <= 6 THEN '4-6 km'
        WHEN distance_km_straight_line <= 8 THEN '6-8 km'
        ELSE 'Above 8 km'
    END AS distance_group,

    COUNT(*) AS total_orders,

    ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,

    SUM(delayed_over_45min) AS severe_delay_orders,

    ROUND(
        SUM(delayed_over_45min) * 100.0 / COUNT(*), 2
    ) AS severe_delay_percentage

FROM food_delivery_cleaned_final

GROUP BY distance_group

ORDER BY
    CASE distance_group
        WHEN '0-2 km' THEN 1
        WHEN '2-4 km' THEN 2
        WHEN '4-6 km' THEN 3
        WHEN '6-8 km' THEN 4
        WHEN 'Above 8 km' THEN 5
        ELSE 6
    END;


SELECT
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN distance_km_straight_line IS NULL THEN 1
        ELSE 0
    END) AS null_distances,
    SUM(CASE
        WHEN distance_km_straight_line = 0 THEN 1
        ELSE 0
    END) AS zero_distances,
    SUM(CASE
        WHEN coordinates_valid = 0 THEN 1
        ELSE 0
    END) AS invalid_coordinates
FROM food_delivery_cleaned_final;




--Query 10: Combined traffic and weather impact.
SELECT
    road_traffic_density,
    weather_conditions,
    COUNT(*) AS total_orders,
    ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
    SUM(delayed_over_45min) AS severe_delay_orders,
    ROUND(
        SUM(delayed_over_45min) * 100.0 / COUNT(*), 2
    ) AS severe_delay_percentage
FROM food_delivery_cleaned_final
WHERE road_traffic_density = 'Jam'
  AND weather_conditions = 'Fog'
GROUP BY road_traffic_density, weather_conditions;

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders,
    SUM(CASE WHEN time_taken_min IS NULL THEN 1 ELSE 0 END)
        AS missing_delivery_times,
    SUM(CASE WHEN time_taken_min <= 0 THEN 1 ELSE 0 END)
        AS invalid_delivery_times,
    SUM(CASE WHEN distance_km_straight_line = 0 THEN 1 ELSE 0 END)
        AS zero_distance_values,
    SUM(CASE WHEN delayed_over_45min NOT IN (0, 1)
        OR delayed_over_45min IS NULL THEN 1 ELSE 0 END)
        AS invalid_delay_flags
FROM food_delivery_cleaned_final;