USE ej3_carreteras;

-- 1. Tabla comunidades_autonomas
INSERT INTO comunidades_autonomas (pk_comunidad, nombre) VALUES
(1, 'Cataluña'),
(2, 'Aragón'),
(3, 'Comunidad de Madrid'),
(4, 'Comunidad Valenciana'),
(5, 'Andalucía');

-- 2. Tabla provincias
INSERT INTO provincias (pk_provincia, nombre, fk_comunidad) VALUES
(1, 'Barcelona', 1),
(2, 'Girona', 1),
(3, 'Tarragona', 1),
(4, 'Lleida', 1),
(5, 'Zaragoza', 2),
(6, 'Huesca', 2),
(7, 'Madrid', 3),
(8, 'Castellón', 4),
(9, 'Valencia', 4),
(10, 'Sevilla', 5);

-- 3. Tabla carreteras
INSERT INTO carreteras (pk_carretera, nombre, titularidad, nivel, tipo_via, acceso_controlado, doble_calzada, prefijo, color, senal, observaciones) VALUES
('AP-7', 'Autopista del Mediterráneo', 'Estatal', NULL, 'Autopista', 1, 1, 'AP', 'Azul', 'S-1', 'Eje transeuropeo corredor mediterráneo libre de peaje'),
('A-2', 'Autovía del Nordeste', 'Estatal', NULL, 'Autovía', 1, 1, 'A', 'Azul', 'S-1a', 'Conecta Madrid con Barcelona y la frontera francesa'),
('C-58', 'Autopista del Vallès', 'Autonómica', 1, 'Autopista', 1, 1, 'C', 'Naranja', 'S-1', 'Vía de alta densidad entre Barcelona, Sabadell y Terrassa'),
('C-16', 'Autopista de Montserrat / Eje del Llobregat', 'Autonómica', 1, 'Autopista', 1, 1, 'C', 'Naranja', 'S-1', 'Incluye túneles de Vallvidrera y túnel del Cadí'),
('C-1415a', 'Carretera de Terrassa a Sentmenat', 'Autonómica', 2, 'Convencional', 0, 0, 'C', 'Verde', 'S-410', 'Carretera comarcal de segundo nivel'),
('B-120', 'Carretera de Terrassa a Olesa de Montserrat', 'Provincial', 2, 'Convencional', 0, 0, 'B', 'Verde', 'S-420', 'Gestionada por la Diputación de Barcelona'),
('BV-1221', 'Carretera de Terrassa a Matadepera y Mura', 'Provincial', 3, 'Convencional', 0, 0, 'BV', 'Amarillo', 'S-430', 'Tramo sinuoso de montaña por el Parc Natural de Sant Llorenç'),
('M-30', 'Calle 30 Circunvalación de Madrid', 'Municipal', 3, 'Autopista', 1, 1, 'M', 'Amarillo', 'S-1', 'Vía de circunvalación urbana de titularidad municipal');

-- 4. Tabla tramos
INSERT INTO tramos (pk_tramo, fk_carretera, km_inicial, km_final, tipo_terreno, entorno, velocidad_limite, num_carriles_sentido, fk_provincia_inicio, fk_provincia_fin, observaciones) VALUES
(1, 'AP-7', 0.000, 125.400, 'Plano', 'Extraurbano', 120, 3, 2, 1, 'Tramo La Jonquera a Barberà del Vallès'),
(2, 'AP-7', 125.400, 340.800, 'Plano', 'Extraurbano', 120, 3, 1, 8, 'Tramo Barberà del Vallès hasta límite provincial Castellón'),
(3, 'A-2', 0.000, 315.000, 'Plano', 'Extraurbano', 120, 2, 7, 5, 'Tramo Madrid a Zaragoza'),
(4, 'A-2', 315.000, 605.000, 'Cuesta subida', 'Extraurbano', 120, 2, 5, 1, 'Tramo Zaragoza a Barcelona pasando por Lleida'),
(5, 'C-58', 0.000, 14.500, 'Plano', 'Extraurbano', 100, 3, 1, 1, 'Tramo Nus de la Trinitat a Sant Quirze del Vallès con carril Bus-VAO'),
(6, 'C-58', 14.500, 25.200, 'Cuesta subida', 'Extraurbano', 100, 2, 1, 1, 'Tramo Sant Quirze a Terrassa y enlace con C-16'),
(7, 'C-16', 0.000, 56.000, 'Cuesta subida', 'Extraurbano', 120, 2, 1, 1, 'Tramo Barcelona - Terrassa - Manresa'),
(8, 'B-120', 0.000, 12.800, 'Cuesta bajada', 'Extraurbano', 80, 1, 1, 1, 'Curvas peligrosas en el descenso hacia Olesa'),
(9, 'BV-1221', 0.000, 24.500, 'Cuesta subida', 'Travesía', 50, 1, 1, 1, 'Paso urbano por Matadepera y ascenso al Coll d''Estenalles'),
(10, 'M-30', 0.000, 32.500, 'Plano', 'Urbano', 90, 3, 7, 7, 'Anillo completo con tramos soterrados junto al río Manzanares');

-- 5. Tabla tramos_provincias
INSERT INTO tramos_provincias (fk_tramo, fk_provincia, km_inicio_provincia, km_fin_provincia) VALUES
(1, 2, 0.000, 85.200),
(1, 1, 85.200, 125.400),
(2, 1, 125.400, 195.000),
(2, 3, 195.000, 310.500),
(2, 8, 310.500, 340.800),
(4, 5, 315.000, 430.000),
(4, 4, 430.000, 525.000),
(4, 1, 525.000, 605.000),
(5, 1, 0.000, 14.500),
(6, 1, 14.500, 25.200);

-- 6. Tabla extremos_carretera
INSERT INTO extremos_carretera (fk_carretera, tipo_extremo, fk_tramo, tipo_finalizacion, fk_carretera_confluye, fk_tramo_confluye, fk_provincia_confluye, km_confluencia) VALUES
('AP-7', 'Principio', 1, 'Concluye físicamente', NULL, NULL, NULL, NULL),
('C-58', 'Final', 6, 'Confluye en otra carretera', 'C-16', 7, 1, 22.400),
('B-120', 'Principio', 8, 'Confluye en otra carretera', 'C-58', 6, 1, 19.800),
('BV-1221', 'Final', 9, 'Concluye físicamente', NULL, NULL, NULL, NULL),
('A-2', 'Final', 4, 'Confluye en otra carretera', 'AP-7', 2, 1, 158.000);