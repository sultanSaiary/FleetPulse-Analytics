-- ====================================
-- FleetPulse Analytics
-- Exploratory Data Analysis (EDA)
-- ====================================


-- ====================================
-- Descriptive Statistics
-- ====================================

SELECT
    COUNT(*) AS total_shipments,       -- عدد الشحنات
    AVG(weight_kg) AS avg_weight,      -- متوسط الوزن
    MIN(weight_kg) AS min_weight,      -- أقل وزن
    MAX(weight_kg) AS max_weight       -- أعلى وزن
FROM Shipments;


SELECT
    COUNT(*) AS fuel_records,          -- عدد سجلات الوقود
    AVG(liters_filled) AS avg_fuel,    -- متوسط التعبئة
    MIN(liters_filled) AS min_fuel,    -- أقل تعبئة
    MAX(liters_filled) AS max_fuel     -- أكبر تعبئة
FROM Fuel_Logs;


SELECT
    COUNT(*) AS maintenance_records,   -- عدد عمليات الصيانة
    AVG(cost) AS avg_cost,             -- متوسط التكلفة
    MIN(cost) AS min_cost,             -- أقل تكلفة
    MAX(cost) AS max_cost              -- أعلى تكلفة
FROM Maintenance;


SELECT
    COUNT(*) AS total_violations,      -- عدد المخالفات
    AVG(fine_amount) AS avg_fine,      -- متوسط الغرامة
    MIN(fine_amount) AS min_fine,      -- أقل غرامة
    MAX(fine_amount) AS max_fine       -- أعلى غرامة
FROM Violations;


-- ====================================
--  Distribution Analysis
-- ====================================

SELECT
    rating,
    COUNT(*) AS driver_count
FROM Drivers
GROUP BY rating
ORDER BY rating;

-- معرفة عدد كل نوع من المركبات
-- ------------------------------------

SELECT
    vehicle_type,
    COUNT(*) AS vehicle_count
FROM Vehicles
GROUP BY vehicle_type
ORDER BY vehicle_count DESC;


-- معرفة أكثر أنواع المسارات شيوعًا
-- ------------------------------------

SELECT
    route_type,
    COUNT(*) AS route_count
FROM Routes
GROUP BY route_type
ORDER BY route_count DESC;



-- معرفة عدد الرحلات المكتملة أو المتأخرة أو الملغاة
-- ------------------------------------

SELECT
    trip_status,
    COUNT(*) AS trip_count
FROM Trips
GROUP BY trip_status
ORDER BY trip_count DESC;


-- ------------------------------------
-- Violation Type Distribution
-- الهدف:
-- معرفة أكثر أنواع المخالفات تكرارًا
-- ------------------------------------

SELECT
    violation_type,
    COUNT(*) AS violation_count
FROM Violations
GROUP BY violation_type
ORDER BY violation_count DESC;

-- ====================================
-- . Driver Performance Analysis
-- ====================================

-- معرفة عدد الرحلات التي قام بها كل سائق
-- ------------------------------------


SELECT
    d.full_name,            -- اسم السائق
    COUNT(t.trip_id) AS trip_count
FROM Trips t
JOIN Drivers d
ON t.driver_id = d.driver_id
GROUP BY d.full_name
ORDER BY trip_count DESC;

-- معرفة السائقين الذين لديهم أكبر عدد من المخالفات
-- ------------------------------------

SELECT
    d.full_name,                    -- اسم السائق
    COUNT(v.violation_id) AS violation_count   -- عدد المخالفات
FROM Violations v
JOIN Drivers d
ON v.driver_id = d.driver_id
GROUP BY d.full_name
ORDER BY violation_count DESC;


-- معرفة السائقين الأعلى تقييمًا
-- ------------------------------------

SELECT
    full_name,      -- اسم السائق
    rating          -- تقييم السائق
FROM Drivers
ORDER BY rating DESC;



-- ====================================
-- 5. Vehicle Utilization Analysis
-- ====================================

-- Number of trips per vehicle
-- الهدف: معرفة أكثر المركبات استخدامًا

SELECT
    v.vehicle_id,
    COUNT(t.trip_id) AS trip_count
FROM Trips t
JOIN Vehicles v ON t.vehicle_id = v.vehicle_id
GROUP BY v.vehicle_id
ORDER BY trip_count DESC;


-- Fuel consumption per vehicle
-- الهدف: معرفة المركبات الأكثر استهلاكًا للوقود

SELECT
    vehicle_id,
    SUM(liters_filled) AS total_fuel_used
FROM Fuel_Logs
GROUP BY vehicle_id
ORDER BY total_fuel_used DESC;


-- Maintenance cost per vehicle
-- الهدف: معرفة المركبات الأعلى تكلفة صيانة

SELECT
    vehicle_id,
    SUM(cost) AS total_maintenance_cost
FROM Maintenance
GROUP BY vehicle_id
ORDER BY total_maintenance_cost DESC;


-- ====================================
-- 6. Route Performance Analysis
-- ====================================

-- Most used routes
-- الهدف: معرفة المسارات الأكثر استخدامًا

SELECT
    r.origin_city,
    r.destination_city,
    COUNT(t.trip_id) AS trip_count
FROM Trips t
JOIN Routes r ON t.route_id = r.route_id
GROUP BY r.origin_city, r.destination_city
ORDER BY trip_count DESC;


-- Average shipment weight per route
-- الهدف: معرفة متوسط وزن الشحنات لكل مسار

SELECT
    r.origin_city,
    r.destination_city,
    AVG(s.weight_kg) AS avg_shipment_weight
FROM Shipments s
JOIN Trips t ON s.trip_id = t.trip_id
JOIN Routes r ON t.route_id = r.route_id
GROUP BY r.origin_city, r.destination_city
ORDER BY avg_shipment_weight DESC;


-- ====================================
-- 7. Trip Performance Analysis
-- ====================================

-- Distribution of trip status
-- الهدف: معرفة نسبة الرحلات المكتملة والمتأخرة والملغاة

SELECT
    trip_status,
    COUNT(*) AS trip_count
FROM Trips
GROUP BY trip_status
ORDER BY trip_count DESC;


-- Average shipment count per trip
-- الهدف: معرفة متوسط عدد الشحنات في الرحلة

SELECT
    AVG(shipment_count) AS avg_shipments_per_trip
FROM Trips;




-- ====================================
-- 8. Cost Analysis
-- ====================================

-- Total fuel cost
-- الهدف: معرفة إجمالي تكلفة الوقود

SELECT
    SUM(fuel_cost) AS total_fuel_cost
FROM Fuel_Logs;


-- Total maintenance cost
-- الهدف: معرفة إجمالي تكلفة الصيانة

SELECT
    SUM(cost) AS total_maintenance_cost
FROM Maintenance;


-- Total violation fines
-- الهدف: معرفة إجمالي الغرامات

SELECT
    SUM(fine_amount) AS total_violation_fines
FROM Violations;



-- ====================================
-- Cost per Trip
-- الهدف:
-- حساب متوسط تكلفة الوقود لكل رحلة
-- ====================================

SELECT
    t.trip_id,
    SUM(f.fuel_cost) AS total_fuel_cost
FROM Trips t
JOIN Fuel_Logs f ON t.trip_id = f.trip_id
GROUP BY t.trip_id
ORDER BY total_fuel_cost DESC;


-- ====================================
-- Fuel Efficiency per Vehicle
-- الهدف:
-- معرفة إجمالي استهلاك الوقود لكل مركبة
-- ====================================

SELECT
    vehicle_id,
    SUM(liters_filled) AS total_fuel_used
FROM Fuel_Logs
GROUP BY vehicle_id
ORDER BY total_fuel_used DESC;




-- ====================================
-- Violation Rate per Driver
-- الهدف:
-- مقارنة عدد المخالفات بعدد الرحلات لكل سائق
-- ====================================

SELECT
    d.full_name,
    COUNT(DISTINCT t.trip_id) AS total_trips,
    COUNT(v.violation_id) AS total_violations
FROM Drivers d
LEFT JOIN Trips t ON d.driver_id = t.driver_id
LEFT JOIN Violations v ON d.driver_id = v.driver_id
GROUP BY d.full_name
ORDER BY total_violations DESC;


-- =========================================
-- FleetPulse Analytics
-- Advanced SQL Analysis
-- =========================================



-- =========================================
-- 1. Total Operational Cost per Vehicle
-- الهدف:
-- حساب تكلفة التشغيل لكل مركبة
-- (وقود + صيانة)
-- =========================================

SELECT
    v.vehicle_id,
    SUM(f.fuel_cost) AS total_fuel_cost,
    SUM(m.cost) AS total_maintenance_cost,
    SUM(f.fuel_cost) + SUM(m.cost) AS total_operational_cost
FROM Vehicles v
LEFT JOIN Fuel_Logs f
ON v.vehicle_id = f.vehicle_id
LEFT JOIN Maintenance m
ON v.vehicle_id = m.vehicle_id
GROUP BY v.vehicle_id
ORDER BY total_operational_cost DESC;



-- =========================================
-- 2. Top 10 Most Expensive Vehicles
-- الهدف:
-- معرفة المركبات الأكثر تكلفة في التشغيل
-- =========================================

SELECT
    v.vehicle_id,
    SUM(f.fuel_cost) + SUM(m.cost) AS total_operational_cost
FROM Vehicles v
LEFT JOIN Fuel_Logs f
ON v.vehicle_id = f.vehicle_id
LEFT JOIN Maintenance m
ON v.vehicle_id = m.vehicle_id
GROUP BY v.vehicle_id
ORDER BY total_operational_cost DESC
LIMIT 10;



-- =========================================
-- 3. Fuel Consumption per Vehicle
-- الهدف:
-- معرفة المركبات الأكثر استهلاكًا للوقود
-- =========================================

SELECT
    vehicle_id,
    SUM(liters_filled) AS total_fuel_consumption
FROM Fuel_Logs
GROUP BY vehicle_id
ORDER BY total_fuel_consumption DESC;



-- =========================================
-- 4. Maintenance Cost per Vehicle
-- الهدف:
-- معرفة المركبات الأعلى تكلفة صيانة
-- =========================================

SELECT
    vehicle_id,
    SUM(cost) AS total_maintenance_cost
FROM Maintenance
GROUP BY vehicle_id
ORDER BY total_maintenance_cost DESC;



-- =========================================
-- 5. Most Active Drivers
-- الهدف:
-- معرفة السائقين الأكثر تنفيذًا للرحلات
-- =========================================

SELECT
    d.full_name,
    COUNT(t.trip_id) AS trip_count
FROM Drivers d
JOIN Trips t
ON d.driver_id = t.driver_id
GROUP BY d.full_name
ORDER BY trip_count DESC;



-- =========================================
-- 6. Drivers With Most Violations
-- الهدف:
-- معرفة السائقين الأكثر ارتكابًا للمخالفات
-- =========================================

SELECT
    d.full_name,
    COUNT(v.violation_id) AS violation_count
FROM Drivers d
JOIN Violations v
ON d.driver_id = v.driver_id
GROUP BY d.full_name
ORDER BY violation_count DESC;



-- =========================================
-- 7. Violation Rate per Driver
-- الهدف:
--  عدد  المخالفات لكل سائق
-- =========================================



SELECT
    d.driver_id,
    d.full_name,
    COUNT(v.violation_id) AS total_violations
FROM Drivers d
LEFT JOIN Violations v
ON d.driver_id = v.driver_id
GROUP BY d.driver_id, d.full_name
ORDER BY total_violations DESC;



-- =========================================
-- 8. Most Used Routes
-- الهدف:
-- معرفة المسارات الأكثر استخدامًا
-- =========================================

SELECT
    r.origin_city,
    r.destination_city,
    COUNT(t.trip_id) AS trip_count
FROM Trips t
JOIN Routes r
ON t.route_id = r.route_id
GROUP BY r.origin_city, r.destination_city
ORDER BY trip_count DESC;



-- =========================================
-- 9. Average Shipment Weight per Route
-- الهدف:
-- معرفة متوسط وزن الشحنات لكل مسار
-- =========================================

SELECT
    r.origin_city,
    r.destination_city,
    AVG(s.weight_kg) AS avg_weight
FROM Shipments s
JOIN Trips t
ON s.trip_id = t.trip_id
JOIN Routes r
ON t.route_id = r.route_id
GROUP BY r.origin_city, r.destination_city
ORDER BY avg_weight DESC;



-- =========================================
-- 10. Total Violation Fines
-- الهدف:
-- معرفة إجمالي الغرامات في النظام
-- =========================================

SELECT
    SUM(fine_amount) AS total_violation_fines
FROM Violations;


--معرفة المخالفات للسائق 
SELECT *
FROM Violations
WHERE driver_id = 7;
