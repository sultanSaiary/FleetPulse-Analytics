-- FleetPulse Analytics
-- Data Analysis Queries
-- This file contains SQL queries used to analyze the logistics fleet data.

-- ====================================
-- 1. Data Inspection
-- ====================================

--لفهم حجم البيانات عندي 

-- Count number of drivers
SELECT COUNT(*) AS total_drivers
FROM Drivers;

-- Count number of vehicles
SELECT COUNT(*) AS total_vehicles
FROM Vehicles;

-- Count number of routes
SELECT COUNT(*) AS total_routes
FROM Routes;

-- Count number of trips
SELECT COUNT(*) AS total_trips
FROM Trips;

-- Count number of shipments
SELECT COUNT(*) AS total_shipments
FROM Shipments;

-- Count number of fuel logs
SELECT COUNT(*) AS total_fuel_logs
FROM Fuel_Logs;

-- Count number of maintenance records
SELECT COUNT(*) AS total_maintenance
FROM Maintenance;

-- Count number of violations
SELECT COUNT(*) AS total_violations
FROM Violations;

--لفهم البيانات ورؤيتها شكلها وهل هي منطقيها ورؤية الاعمده ونوع بياناتها 
-- Preview drivers
SELECT *
FROM Drivers
LIMIT 5;

-- Preview vehicles
SELECT *
FROM Vehicles
LIMIT 5;

-- Preview routes
SELECT *
FROM Routes
LIMIT 5;

-- Preview trips
SELECT *
FROM Trips
LIMIT 5;

SELECT *
FROM Shipments
LIMIT 5;


SELECT *
FROM Fuel_Logs
LIMIT 5;

SELECT *
FROM Maintenance
LIMIT 5;

SELECT *
FROM Violations
LIMIT 5;

---- ====================================
-- 2. Data Quality Check
-- ====================================
-- فحص البيانات اذا فيه قيم فاضيه او غير منطقيه او تكرار او ناقصه

-- ------------------------------------
-- التأكد أن بيانات  مكتملة
-- ------------------------------------

SELECT *
FROM Drivers
WHERE
    full_name IS NULL OR
    national_id IS NULL OR
    phone_number IS NULL;


SELECT *
FROM Vehicles
WHERE plate_number IS NULL
   OR brand IS NULL;

SELECT *
FROM Trips
WHERE
    driver_id IS NULL OR
    vehicle_id IS NULL OR
    route_id IS NULL;

SELECT *
FROM Shipments
WHERE
    trip_id IS NULL OR
    weight_kg IS NULL;

SELECT *
FROM Fuel_Logs
WHERE
    trip_id IS NULL OR
    vehicle_id IS NULL OR
    liters_filled IS NULL;

SELECT *
FROM Maintenance
WHERE
    vehicle_id IS NULL OR
    maintenance_type IS NULL OR
    cost IS NULL;

SELECT *
FROM Violations
WHERE
    driver_id IS NULL OR
    vehicle_id IS NULL OR
    trip_id IS NULL;

-- ====================================
-- Data Quality Check
-- Logical Data Validation
-- ====================================
--فحص المنطق

SELECT *
FROM Shipments
WHERE weight_kg <= 0;


-- التأكد أن كمية الوقود منطقية
-- ------------------------------------

SELECT *
FROM Fuel_Logs
WHERE liters_filled <= 0;


SELECT *
FROM Maintenance
WHERE cost <= 0;

SELECT *
FROM Violations
WHERE fine_amount <= 0;

-- التأكد أن وقت الوصول بعد وقت الانطلاق
-- ------------------------------------

SELECT *
FROM Trips
WHERE arrival_datetime < departure_datetime;

--التاكد كل رحله لها سائق والتاكد من علاقات قاعدة البيانات 
SELECT *
FROM Trips t
LEFT JOIN Drivers d
ON t.driver_id = d.driver_id
WHERE d.driver_id IS NULL;

-- ------------------------------------
-- Check trips with invalid vehicle references
-- الهدف:
-- التأكد أن vehicle_id في Trips
-- موجود في جدول Vehicles
-- ------------------------------------

SELECT *
FROM Trips t
LEFT JOIN Vehicles v
ON t.vehicle_id = v.vehicle_id
WHERE v.vehicle_id IS NULL;


SELECT *
FROM Trips t
LEFT JOIN Routes r
ON t.route_id = r.route_id
WHERE r.route_id IS NULL;


SELECT *
FROM Shipments s
LEFT JOIN Trips t
ON s.trip_id = t.trip_id
WHERE t.trip_id IS NULL;


SELECT *
FROM Fuel_Logs f
LEFT JOIN Trips t
ON f.trip_id = t.trip_id
WHERE t.trip_id IS NULL;

-- ------------------------------------
-- Check maintenance records referencing invalid vehicles
-- ------------------------------------

SELECT *
FROM Maintenance m
LEFT JOIN Vehicles v
ON m.vehicle_id = v.vehicle_id
WHERE v.vehicle_id IS NULL;

-- ------------------------------------
-- Check violations referencing invalid drivers
-- ------------------------------------

SELECT *
FROM Violations v
LEFT JOIN Drivers d
ON v.driver_id = d.driver_id
WHERE d.driver_id IS NULL;

