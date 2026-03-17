# FleetPulse Analytics 🚛📊
FleetPulse Analytics is a data analytics project that simulates a logistics fleet management system using SQL and Python.




The project demonstrates the full data workflow from database design and data generation to analysis, visualization, and insight extraction.

---

## 📌 Project Overview

This project aims to analyze the performance of a logistics fleet by examining:

- Driver activity
- Vehicle fuel consumption
- Maintenance costs
- Route usage
- Trip performance
- Driver violations

---

## 🛠️ Tools & Technologies

- SQL (SQLite)
- Python
- Pandas
- Matplotlib & Seaborn
- Jupyter Notebook

---

## 🗄️ Database Design

The project is built on a relational database that includes:

- Drivers
- Vehicles
- Trips
- Routes
- Fuel Logs
- Maintenance
- Shipments
- Violations

---

## 📊 Key Insights

### 1. Balanced Driver Workload
Trip distribution among drivers is relatively balanced, with top drivers completing between 14–17 trips.

### 2. High Fuel Consumption in Specific Vehicles
Vehicle 23 shows the highest fuel consumption (~7,916 liters), indicating higher usage or lower efficiency.

### 3. Maintenance Cost Concentration
Vehicles 16 and 44 have the highest maintenance costs (over 40,000), suggesting potential inefficiencies.

### 4. Major Logistics Route
The Riyadh → Jeddah route is the most frequently used, with 89 trips.

### 5. Operational Performance Issues
Completed trips represent only 35%, while delayed and cancelled trips are relatively high.

### 6. Violation Trends
Overloading is the most common violation, followed by unsafe driving.

### 7. Diverse Shipment Weights
Shipment weights range from 100 kg to 5000 kg, indicating varied cargo operations.

### 8. Trips vs Violations
There is no strong linear relationship between trips and violations, suggesting behavior varies by driver.

---

## 📂 Project Structure

- `schema.sql` → Database schema
- `analysis_queries.sql` → SQL analysis queries
- `exploratory_analysis.sql` → EDA queries
- `data_generation.ipynb` → Data generation
- `visual_analysis.ipynb` → Visualization and analysis
- `fleetpulse.db` → Database file
- `fleetpulse_erd_hd.png` → ERD diagram

---

## 🚀 Conclusion

This project demonstrates end-to-end data analysis skills, including database design, SQL querying, data visualization, and insight generation for business decision-making.
