USE ej4_sistema_vuelos;

-- 1. Nuevos registros en aeropuertos
INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES
('BCN', 'Josep Tarradellas Barcelona-El Prat', 'Barcelona', 'España'),
('JFK', 'John F. Kennedy International', 'Nueva York', 'Estados Unidos'),
('LHR', 'Heathrow', 'Londres', 'Reino Unido'),
('DXB', 'Dubai International', 'Dubái', 'Emiratos Árabes Unidos'),
('NRT', 'Narita International', 'Tokio', 'Japón'),
('SIN', 'Changi', 'Singapur', 'Singapur'),
('FRA', 'Frankfurt Airport', 'Fráncfort', 'Alemania'),
('EZE', 'Ministro Pistarini - Ezeiza', 'Buenos Aires', 'Argentina'),
('DOH', 'Hamad International', 'Doha', 'Catar');

-- 2. Nuevos registros en modelos_avion
INSERT INTO modelos_avion (pk_modelo, capacidad_plazas) VALUES
('Boeing 787-9 Dreamliner', 296),
('Airbus A320neo', 180),
('Airbus A380-800', 517),
('Boeing 777-300ER', 396),
('Airbus A330-200', 288);

-- 3. Nuevos registros en aeropuertos_modelos
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES
('BCN', 'Airbus A320neo'),
('BCN', 'Airbus A330-200'),
('BCN', 'Boeing 787-9 Dreamliner'),
('BCN', 'Airbus A380-800'),
('MAD', 'Airbus A320neo'),
('MAD', 'Boeing 787-9 Dreamliner'),
('MAD', 'Airbus A330-200'),
('LHR', 'Airbus A320neo'),
('LHR', 'Boeing 777-300ER'),
('LHR', 'Airbus A380-800'),
('JFK', 'Boeing 787-9 Dreamliner'),
('JFK', 'Airbus A330-200'),
('DXB', 'Airbus A380-800'),
('DXB', 'Boeing 777-300ER'),
('NRT', 'Boeing 787-9 Dreamliner'),
('NRT', 'Boeing 777-300ER'),
('SIN', 'Airbus A380-800'),
('SIN', 'Boeing 777-300ER'),
('SYD', 'Airbus A380-800'),
('FRA', 'Airbus A320neo'),
('FRA', 'Boeing 787-9 Dreamliner'),
('EZE', 'Airbus A330-200'),
('EZE', 'Boeing 787-9 Dreamliner'),
('DOH', 'Boeing 777-300ER'),
('DOH', 'Boeing 787-9 Dreamliner');

-- 4. Nuevos registros en programas_vuelo
INSERT INTO programas_vuelo (pk_numero_vuelo, linea_aerea, dias_semana, fk_aeropuerto_despegue, fk_aeropuerto_aterrizaje) VALUES
(102, 'Vueling', 'Lunes,Martes,Miércoles,Jueves,Viernes', 'BCN', 'LHR'),
(204, 'Level', 'Martes,Jueves,Sábado', 'BCN', 'JFK'),
(310, 'Emirates', 'Lunes,Miércoles,Viernes,Domingo', 'BCN', 'SYD'),
(415, 'Qatar Airways', 'Martes,Viernes,Domingo', 'MAD', 'NRT'),
(680, 'Aerolíneas Argentinas', 'Lunes,Jueves,Sábado', 'MAD', 'EZE'),
(722, 'Lufthansa', 'Lunes,Martes,Miércoles,Jueves,Viernes,Sábado', 'FRA', 'BCN');

-- 5. Nuevos registros en escalas_tecnicas
INSERT INTO escalas_tecnicas (fk_numero_vuelo, numero_orden, fk_aeropuerto) VALUES
(310, 1, 'DXB'),
(310, 2, 'SIN'),
(415, 1, 'DOH'),
(415, 2, 'SIN'),
(680, 1, 'GRU');

-- 6. Nuevos registros en vuelos_realizados
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES
(1, 555, '2026-10-05', 24, 'Airbus A350-900'),
(2, 555, '2026-10-08', 12, 'Airbus A350-900'),
(3, 102, '2026-10-12', 8, 'Airbus A320neo'),
(4, 102, '2026-10-13', 15, 'Airbus A320neo'),
(5, 204, '2026-10-15', 19, 'Airbus A330-200'),
(6, 310, '2026-10-18', 42, 'Airbus A380-800'),
(7, 415, '2026-10-20', 14, 'Boeing 787-9 Dreamliner'),
(8, 680, '2026-10-22', 9, 'Airbus A330-200'),
(9, 722, '2026-10-24', 5, 'Airbus A320neo'),
(10, 310, '2026-10-25', 31, 'Airbus A380-800');