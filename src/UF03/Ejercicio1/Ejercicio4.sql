-- =========================================================================
-- EJERCICIO 4: SISTEMA DE VUELOS
-- =========================================================================

DROP DATABASE IF EXISTS ej4_sistema_vuelos;
CREATE DATABASE IF NOT EXISTS ej4_sistema_vuelos
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci
DEFAULT ENCRYPTION = 'N';

USE ej4_sistema_vuelos;

-- 1. Tabla Aeropuertos
CREATE TABLE IF NOT EXISTS aeropuertos (
    pk_aeropuerto VARCHAR(10) COMMENT 'Código único internacional del aeropuerto (ej. MAD, SYD)',
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(80) NOT NULL,
    pais VARCHAR(80) NOT NULL,
    CONSTRAINT pk_aeropuertos PRIMARY KEY (pk_aeropuerto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 2. Tabla Modelos de Avión
CREATE TABLE IF NOT EXISTS modelos_avion (
    pk_modelo VARCHAR(50),
    capacidad_plazas SMALLINT UNSIGNED NOT NULL COMMENT 'Número máximo de plazas del modelo',
    CONSTRAINT pk_modelos_avion PRIMARY KEY (pk_modelo),
    CONSTRAINT chk_modelo_capacidad CHECK (capacidad_plazas > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. Tabla Modelos compatibles por Aeropuerto (M:N)
CREATE TABLE IF NOT EXISTS aeropuertos_modelos (
    fk_aeropuerto VARCHAR(10) NOT NULL,
    fk_modelo VARCHAR(50) NOT NULL,
    CONSTRAINT pk_aeropuertos_modelos PRIMARY KEY (fk_aeropuerto, fk_modelo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. Tabla Programas de Vuelo
CREATE TABLE IF NOT EXISTS programas_vuelo (
    pk_numero_vuelo INT UNSIGNED COMMENT 'Número de vuelo único en todo el mundo',
    linea_aerea VARCHAR(80) NOT NULL,
    dias_semana SET('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo') NOT NULL,
    fk_aeropuerto_despegue VARCHAR(10) NOT NULL,
    fk_aeropuerto_aterrizaje VARCHAR(10) NOT NULL,
    CONSTRAINT pk_programas_vuelo PRIMARY KEY (pk_numero_vuelo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 5. Tabla Escalas Técnicas (ordenadas por número de orden)
CREATE TABLE IF NOT EXISTS escalas_tecnicas (
    fk_numero_vuelo INT UNSIGNED NOT NULL,
    numero_orden TINYINT UNSIGNED NOT NULL COMMENT 'Orden secuencial de la escala (1, 2, 3...)',
    fk_aeropuerto VARCHAR(10) NOT NULL,
    CONSTRAINT pk_escalas_tecnicas PRIMARY KEY (fk_numero_vuelo, numero_orden),
    CONSTRAINT uq_escala_vuelo_aeropuerto UNIQUE (fk_numero_vuelo, fk_aeropuerto),
    CONSTRAINT chk_orden_escala CHECK (numero_orden > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 6. Tabla Vuelos Realizados
CREATE TABLE IF NOT EXISTS vuelos_realizados (
    pk_vuelo_realizado INT UNSIGNED AUTO_INCREMENT,
    fk_numero_vuelo INT UNSIGNED NOT NULL,
    fecha DATE NOT NULL,
    plazas_vacias SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    fk_modelo_avion VARCHAR(50) NOT NULL,
    CONSTRAINT pk_vuelos_realizados PRIMARY KEY (pk_vuelo_realizado),
    CONSTRAINT uq_vuelo_fecha UNIQUE (fk_numero_vuelo, fecha)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =========================================================================
-- CLAVES FORÁNEAS (RELACIONES)
-- =========================================================================

ALTER TABLE aeropuertos_modelos
ADD CONSTRAINT fk_am_aeropuerto
FOREIGN KEY (fk_aeropuerto) REFERENCES aeropuertos(pk_aeropuerto)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_am_modelo
FOREIGN KEY (fk_modelo) REFERENCES modelos_avion(pk_modelo)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE programas_vuelo
ADD CONSTRAINT fk_pv_aeropuerto_despegue
FOREIGN KEY (fk_aeropuerto_despegue) REFERENCES aeropuertos(pk_aeropuerto)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT fk_pv_aeropuerto_aterrizaje
FOREIGN KEY (fk_aeropuerto_aterrizaje) REFERENCES aeropuertos(pk_aeropuerto)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE escalas_tecnicas
ADD CONSTRAINT fk_et_programa_vuelo
FOREIGN KEY (fk_numero_vuelo) REFERENCES programas_vuelo(pk_numero_vuelo)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_et_aeropuerto
FOREIGN KEY (fk_aeropuerto) REFERENCES aeropuertos(pk_aeropuerto)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE vuelos_realizados
ADD CONSTRAINT fk_vr_programa_vuelo
FOREIGN KEY (fk_numero_vuelo) REFERENCES programas_vuelo(pk_numero_vuelo)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT fk_vr_modelo_avion
FOREIGN KEY (fk_modelo_avion) REFERENCES modelos_avion(pk_modelo)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- =========================================================================
-- DISPARADORES (TRIGGERS)
-- =========================================================================

DELIMITER $$

-- Validar que el aeropuerto de despegue y aterrizaje sean distintos (INSERT y UPDATE)
CREATE TRIGGER tr_programas_vuelo_bi
BEFORE INSERT ON programas_vuelo
FOR EACH ROW
BEGIN
    IF NEW.fk_aeropuerto_despegue = NEW.fk_aeropuerto_aterrizaje THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El aeropuerto de despegue y el de aterrizaje deben ser diferentes.';
    END IF;
END$$

CREATE TRIGGER tr_programas_vuelo_bu
BEFORE UPDATE ON programas_vuelo
FOR EACH ROW
BEGIN
    IF NEW.fk_aeropuerto_despegue = NEW.fk_aeropuerto_aterrizaje THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El aeropuerto de despegue y el de aterrizaje deben ser diferentes.';
    END IF;
END$$

-- Validar que las plazas vacías no superen la capacidad del avión
-- y que el modelo de avión pueda aterrizar en los aeropuertos del programa
CREATE TRIGGER tr_vuelos_realizados_bi
BEFORE INSERT ON vuelos_realizados
FOR EACH ROW
BEGIN
    DECLARE v_capacidad SMALLINT UNSIGNED;
    DECLARE v_origen VARCHAR(10);
    DECLARE v_destino VARCHAR(10);
    DECLARE v_compatible_origen INT;
    DECLARE v_compatible_destino INT;

    SELECT capacidad_plazas INTO v_capacidad
    FROM modelos_avion
    WHERE pk_modelo = NEW.fk_modelo_avion;

    IF NEW.plazas_vacias > v_capacidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El número de plazas vacías supera la capacidad total del modelo de avión.';
    END IF;

    SELECT fk_aeropuerto_despegue, fk_aeropuerto_aterrizaje INTO v_origen, v_destino
    FROM programas_vuelo
    WHERE pk_numero_vuelo = NEW.fk_numero_vuelo;

    SELECT COUNT(*) INTO v_compatible_origen
    FROM aeropuertos_modelos
    WHERE fk_aeropuerto = v_origen AND fk_modelo = NEW.fk_modelo_avion;

    SELECT COUNT(*) INTO v_compatible_destino
    FROM aeropuertos_modelos
    WHERE fk_aeropuerto = v_destino AND fk_modelo = NEW.fk_modelo_avion;

    IF v_compatible_origen = 0 OR v_compatible_destino = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El modelo de avión seleccionado no está habilitado para operar en los aeropuertos de este programa.';
    END IF;
END$$

DELIMITER ;

-- =========================================================================
-- DATOS DE EJEMPLO DEL ENUNCIADO (VUELO 555 DE IBERIA)
-- =========================================================================

INSERT INTO aeropuertos (pk_aeropuerto, nombre, ciudad, pais) VALUES
('MAD', 'Barajas', 'Madrid', 'España'),
('SYD', 'Caudell', 'Sydney', 'Australia'),
('GRU', 'Los Pradiños', 'Sao Paulo', 'Brasil'),
('SCL', 'El Emperador', 'Santiago', 'Chile'),
('AKL', 'Saint Kitts', 'Auckland', 'Nueva Zelanda');

INSERT INTO modelos_avion (pk_modelo, capacidad_plazas) VALUES
('Airbus A350-900', 348);

INSERT INTO aeropuertos_modelos (fk_aeropuerto, fk_modelo) VALUES
('MAD', 'Airbus A350-900'),
('SYD', 'Airbus A350-900'),
('GRU', 'Airbus A350-900'),
('SCL', 'Airbus A350-900'),
('AKL', 'Airbus A350-900');

INSERT INTO programas_vuelo (pk_numero_vuelo, linea_aerea, dias_semana, fk_aeropuerto_despegue, fk_aeropuerto_aterrizaje) VALUES
(555, 'Iberia', 'Lunes,Jueves', 'MAD', 'SYD');

INSERT INTO escalas_tecnicas (fk_numero_vuelo, numero_orden, fk_aeropuerto) VALUES
(555, 1, 'GRU'),
(555, 2, 'SCL'),
(555, 3, 'AKL');