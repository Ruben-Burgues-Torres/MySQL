USE ej4_sistema_vuelos;

-- 1. Nuevos registros en aeropuertos
INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES ('BCN', 'Josep Tarradellas Barcelona-El Prat', 'Barcelona', 'España');
INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES ('JFK', 'John F. Kennedy International', 'Nueva York', 'Estados Unidos');
INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES ('LHR', 'Heathrow', 'Londres', 'Reino Unido');
INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES ('DXB', 'Dubai International', 'Dubái', 'Emiratos Árabes Unidos');
INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES ('NRT', 'Narita International', 'Tokio', 'Japón');
INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES ('SIN', 'Changi', 'Singapur', 'Singapur');
INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES ('FRA', 'Frankfurt Airport', 'Fráncfort', 'Alemania');
INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES ('EZE', 'Ministro Pistarini - Ezeiza', 'Buenos Aires', 'Argentina');
INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES ('DOH', 'Hamad International', 'Doha', 'Catar');

-- 2. Nuevos registros en modelos_avion
INSERT INTO modelos_avion (pk_modelo, capacidad_plazas) VALUES ('Boeing 787-9 Dreamliner', 296);
INSERT INTO modelos_avion (pk_modelo, capacidad_plazas) VALUES ('Airbus A320neo', 180);
INSERT INTO modelos_avion (pk_modelo, capacidad_plazas) VALUES ('Airbus A380-800', 517);
INSERT INTO modelos_avion (pk_modelo, capacidad_plazas) VALUES ('Boeing 777-300ER', 396);
INSERT INTO modelos_avion (pk_modelo, capacidad_plazas) VALUES ('Airbus A330-200', 288);

-- 3. Nuevos registros en aeropuertos_modelos (compatibilidad de aterrizaje en aeropuertos)
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('BCN', 'Airbus A320neo');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('BCN', 'Airbus A330-200');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('BCN', 'Boeing 787-9 Dreamliner');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('BCN', 'Airbus A380-800');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('MAD', 'Airbus A320neo');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('MAD', 'Boeing 787-9 Dreamliner');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('MAD', 'Airbus A330-200');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('LHR', 'Airbus A320neo');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('LHR', 'Boeing 777-300ER');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('LHR', 'Airbus A380-800');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('JFK', 'Boeing 787-9 Dreamliner');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('JFK', 'Airbus A330-200');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('DXB', 'Airbus A380-800');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('DXB', 'Boeing 777-300ER');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('NRT', 'Boeing 787-9 Dreamliner');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('NRT', 'Boeing 777-300ER');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('SIN', 'Airbus A380-800');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('SIN', 'Boeing 777-300ER');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('SYD', 'Airbus A380-800');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('FRA', 'Airbus A320neo');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('FRA', 'Boeing 787-9 Dreamliner');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('EZE', 'Airbus A330-200');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('EZE', 'Boeing 787-9 Dreamliner');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('DOH', 'Boeing 777-300ER');
INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES ('DOH', 'Boeing 787-9 Dreamliner');

-- 4. Nuevos registros en programas_vuelo
INSERT INTO programas_vuelo (pk_numero_vuelo, linea_aerea, dias_semana, fk_aeropuerto_despegue, fk_aeropuerto_aterrizaje) VALUES (102, 'Vueling', 'Lunes,Martes,Miércoles,Jueves,Viernes', 'BCN', 'LHR');
INSERT INTO programas_vuelo (pk_numero_vuelo, linea_aerea, dias_semana, fk_aeropuerto_despegue, fk_aeropuerto_aterrizaje) VALUES (204, 'Level', 'Martes,Jueves,Sábado', 'BCN', 'JFK');
INSERT INTO programas_vuelo (pk_numero_vuelo, linea_aerea, dias_semana, fk_aeropuerto_despegue, fk_aeropuerto_aterrizaje) VALUES (310, 'Emirates', 'Lunes,Miércoles,Viernes,Domingo', 'BCN', 'SYD');
INSERT INTO programas_vuelo (pk_numero_vuelo, linea_aerea, dias_semana, fk_aeropuerto_despegue, fk_aeropuerto_aterrizaje) VALUES (415, 'Qatar Airways', 'Martes,Viernes,Domingo', 'MAD', 'NRT');
INSERT INTO programas_vuelo (pk_numero_vuelo, linea_aerea, dias_semana, fk_aeropuerto_despegue, fk_aeropuerto_aterrizaje) VALUES (680, 'Aerolíneas Argentinas', 'Lunes,Jueves,Sábado', 'MAD', 'EZE');
INSERT INTO programas_vuelo (pk_numero_vuelo, linea_aerea, dias_semana, fk_aeropuerto_despegue, fk_aeropuerto_aterrizaje) VALUES (722, 'Lufthansa', 'Lunes,Martes,Miércoles,Jueves,Viernes,Sábado', 'FRA', 'BCN');

-- 5. Nuevos registros en escalas_tecnicas (ordenadas secuencialmente)
INSERT INTO escalas_tecnicas (fk_numero_vuelo, numero_orden, fk_aeropuerto) VALUES (310, 1, 'DXB');
INSERT INTO escalas_tecnicas (fk_numero_vuelo, numero_orden, fk_aeropuerto) VALUES (310, 2, 'SIN');
INSERT INTO escalas_tecnicas (fk_numero_vuelo, numero_orden, fk_aeropuerto) VALUES (415, 1, 'DOH');
INSERT INTO escalas_tecnicas (fk_numero_vuelo, numero_orden, fk_aeropuerto) VALUES (415, 2, 'SIN');
INSERT INTO escalas_tecnicas (fk_numero_vuelo, numero_orden, fk_aeropuerto) VALUES (680, 1, 'GRU');

-- 6. Nuevos registros en vuelos_realizados (validando capacidad y compatibilidad mediante el trigger)
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES (1, 555, '2026-10-05', 24, 'Airbus A350-900');
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES (2, 555, '2026-10-08', 12, 'Airbus A350-900');
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES (3, 102, '2026-10-12', 8, 'Airbus A320neo');
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES (4, 102, '2026-10-13', 15, 'Airbus A320neo');
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES (5, 204, '2026-10-15', 19, 'Airbus A330-200');
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES (6, 310, '2026-10-18', 42, 'Airbus A380-800');
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES (7, 415, '2026-10-20', 14, 'Boeing 787-9 Dreamliner');
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES (8, 680, '2026-10-22', 9, 'Airbus A330-200');
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES (9, 722, '2026-10-24', 5, 'Airbus A320neo');
INSERT INTO vuelos_realizados (pk_vuelo_realizado, fk_numero_vuelo, fecha, plazas_vacias, fk_modelo_avion) VALUES (10, 310, '2026-10-25', 31, 'Airbus A380-800');