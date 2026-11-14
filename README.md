# Food Delivery Operations Analysis

## Project Overview

This project analyzes food delivery operations to evaluate delivery performance, order trends, traffic impact, weather conditions, and vehicle performance.

The objective is to identify operational challenges, uncover meaningful patterns, and provide data-driven recommendations to improve delivery efficiency.

## Project Objectives

- Analyze overall order and delivery performance.
- Measure on-time delivery and severe delay rates.
- Understand the impact of traffic and weather on delivery duration.
- Compare delivery performance across vehicle types.
- Identify order demand patterns across cities, weekdays, and order categories.
- Develop actionable recommendations for operational improvement.

## Tools and Technologies

- **Power BI:** Interactive dashboards, data visualization, and DAX measures.
- **SQL:** Data exploration and analytical queries.
- **Python:** Data preparation and analysis, if applicable.

## Dataset Overview

- Total records: 45,584
- Total columns: 34
- Key fields include order date, weather conditions, road traffic density, vehicle type, order type, city, delivery time, and delay indicators.

## Key Performance Indicators

| KPI | Result |
|---|---:|
| Total Orders | 45,584 |
| On-Time Delivery Rate | 70.16% |
| Average Delivery Time | 26.29 minutes |
| Severe Delayed Orders | 1,562 |

## Key Findings

1. **Delivery Performance:** The overall on-time delivery rate is 70.16%.
2. **Traffic Impact:** Average delivery time is 31.18 minutes in Jam traffic compared with 21.27 minutes in Low traffic.
3. **Vehicle Performance:** Motorcycles have the highest severe delay rate at approximately 5.19%.
4. **Weather Impact:** Cloudy conditions have the highest severe delay rate at approximately 5.48%.

## Business Recommendations

- Improve dispatch planning during heavy traffic conditions.
- Review motorcycle delivery operations to identify causes of severe delays.
- Monitor weather-related delivery risks and strengthen contingency planning.
- Track on-time delivery performance to identify opportunities for operational improvement.

## Project Structure

- `01_SQL/` – SQL scripts and queries.
- `02_Python/` – Python notebooks and scripts, if applicable.
- `03_PowerBI/` – Power BI report and dashboard screenshots.
