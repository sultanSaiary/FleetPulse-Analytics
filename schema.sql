الجدول الاول
CREATE TABLE Drivers (
    driver_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    national_id TEXT UNIQUE,
    phone_number TEXT,
    license_number TEXT UNIQUE,
    license_type TEXT,
    hire_date TEXT,
    city TEXT,
    rating REAL,
    status TEXT
);


ثاني جدول 

CREATE TABLE Vehicles (
    vehicle_id INTEGER PRIMARY KEY,
    plate_number TEXT UNIQUE NOT NULL,
    vehicle_type TEXT NOT NULL,
    brand TEXT NOT NULL,
    model TEXT NOT NULL,
    manufacture_year INTEGER NOT NULL,
    capacity_tons REAL NOT NULL,
    fuel_type TEXT NOT NULL,
    purchase_date TEXT,
    status TEXT NOT NULL
);


الجدول الثالث

CREATE TABLE Routes (
    route_id INTEGER PRIMARY KEY,
    origin_city TEXT NOT NULL,
    destination_city TEXT NOT NULL,
    distance_km REAL NOT NULL,
    estimated_duration_hours REAL NOT NULL,
    route_type TEXT
);

الرابع

CREATE TABLE Trips (
    trip_id INTEGER PRIMARY KEY,

    driver_id INTEGER NOT NULL,
    vehicle_id INTEGER NOT NULL,
    route_id INTEGER NOT NULL,

    departure_datetime TEXT NOT NULL,
    arrival_datetime TEXT,

    trip_status TEXT NOT NULL,
    shipment_count INTEGER,
    total_weight_kg REAL,
    delivered_on_time INTEGER,

    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
    FOREIGN KEY (route_id) REFERENCES Routes(route_id)
);

الخامس

CREATE TABLE Maintenance (
    maintenance_id INTEGER PRIMARY KEY,
    vehicle_id INTEGER NOT NULL,
    maintenance_date TEXT NOT NULL,
    maintenance_type TEXT NOT NULL,
    cost REAL NOT NULL,
    service_provider TEXT,
    downtime_days INTEGER,
    
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

السادس
CREATE TABLE Shipments (
    shipment_id INTEGER PRIMARY KEY,
    trip_id INTEGER NOT NULL,
    customer_name TEXT,
    pickup_city TEXT NOT NULL,
    delivery_city TEXT NOT NULL,
    weight_kg REAL NOT NULL,
    shipment_value REAL,
    delivery_status TEXT NOT NULL,
    delivery_deadline TEXT,
    
    FOREIGN KEY (trip_id) REFERENCES Trips(trip_id)
);

السابع
CREATE TABLE Fuel_Logs (
    fuel_log_id INTEGER PRIMARY KEY,
    trip_id INTEGER NOT NULL,
    vehicle_id INTEGER NOT NULL,
    fuel_date TEXT NOT NULL,
    liters_filled REAL NOT NULL,
    fuel_cost REAL NOT NULL,
    odometer_km REAL,
    station_city TEXT,
    
    FOREIGN KEY (trip_id) REFERENCES Trips(trip_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

الثامن

CREATE TABLE Violations (
    violation_id INTEGER PRIMARY KEY,
    driver_id INTEGER NOT NULL,
    vehicle_id INTEGER NOT NULL,
    trip_id INTEGER NOT NULL,
    violation_date TEXT NOT NULL,
    violation_type TEXT NOT NULL,
    severity TEXT,
    fine_amount REAL NOT NULL,
    
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
    FOREIGN KEY (trip_id) REFERENCES Trips(trip_id)
);

اضافة سطر واحد
من البيانات لكل عمود في كل جدول

INSERT INTO Drivers (
    driver_id,
    full_name,
    national_id,
    phone_number,
    license_number,
    license_type,
    hire_date,
    city,
    rating,
    status
)
VALUES (
    1,
    'Ahmed Alshammari',
    '1029384756',
    '0501234567',
    'LIC12345',
    'Heavy',
    '2023-01-10',
    'Riyadh',
    4.5,
    'Active'
);

select * from Drivers;

INSERT INTO Vehicles (
    vehicle_id,
    plate_number,
    vehicle_type,
    brand,
    model,
    manufacture_year,
    capacity_tons,
    fuel_type,
    purchase_date,
    status
)
VALUES (
    1,
    'ABC1234',
    'Truck',
    'Volvo',
    'FH16',
    2022,
    18,
    'Diesel',
    '2022-06-01',
    'Available'
);

select * from Vehicles;

INSERT INTO Routes (
    route_id,
    origin_city,
    destination_city,
    distance_km,
    estimated_duration_hours,
    route_type
)
VALUES (
    1,
    'Riyadh',
    'Jeddah',
    950,
    10,
    'Intercity'
);

SELECT * FROM Routes

INSERT INTO Trips (
    trip_id,
    driver_id,
    vehicle_id,
    route_id,
    departure_datetime,
    arrival_datetime,
    trip_status,
    shipment_count,
    total_weight_kg,
    delivered_on_time
)
VALUES (
    1,
    1,
    1,
    1,
    '2025-03-10 08:00',
    '2025-03-10 18:00',
    'Completed',
    3,
    12000,
    1
);

SELECT * FROM Trips


INSERT INTO Shipments (
    shipment_id,
    trip_id,
    customer_name,
    pickup_city,
    delivery_city,
    weight_kg,
    shipment_value,
    delivery_status,
    delivery_deadline
)
VALUES (
    1,
    1,
    'Saudi Retail Co',
    'Riyadh',
    'Jeddah',
    4000,
    20000,
    'Delivered',
    '2025-03-10'
);

SELECT * from Shipments

INSERT INTO Fuel_Logs (
    fuel_log_id,
    trip_id,
    vehicle_id,
    fuel_date,
    liters_filled,
    fuel_cost,
    odometer_km,
    station_city
)
VALUES (
    1,
    1,
    1,
    '2025-03-10',
    200,
    500,
    150000,
    'Riyadh'
);

select * from Fuel_Logs

INSERT INTO Maintenance (
    maintenance_id,
    vehicle_id,
    maintenance_date,
    maintenance_type,
    cost,
    service_provider,
    downtime_days
)
VALUES (
    1,
    1,
    '2024-12-01',
    'Oil Change',
    1200,
    'Volvo Service Center',
    1
);

select * from Maintenance

INSERT INTO Violations (
    violation_id,
    driver_id,
    vehicle_id,
    trip_id,
    violation_date,
    violation_type,
    severity,
    fine_amount
)
VALUES (
    1,
    1,
    1,
    1,
    '2025-03-10',
    'Speeding',
    'Medium',
    500
);

select * from Violations

