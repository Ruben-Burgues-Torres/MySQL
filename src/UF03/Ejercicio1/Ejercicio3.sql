-- =========================================================================
-- EJERCICIO 3: CARRETERAS
-- =========================================================================

DROP DATABASE IF EXISTS ej3_carreteras;
CREATE DATABASE IF NOT EXISTS ej3_carreteras
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci
DEFAULT ENCRYPTION = 'N';

USE ej3_carreteras;

-- 1. Tabla Comunidades Autónomas
CREATE TABLE IF NOT EXISTS comunidades_autonomas (
    pk_comunidad INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    CONSTRAINT pk_comunidades_autonomas PRIMARY KEY (pk_comunidad),
    CONSTRAINT uq_comunidad_nombre UNIQUE (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 2. Tabla Provincias
CREATE TABLE IF NOT EXISTS provincias (
    pk_provincia INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    fk_comunidad INT UNSIGNED NOT NULL,
    CONSTRAINT pk_provincias PRIMARY KEY (pk_provincia),
    CONSTRAINT uq_provincia_nombre UNIQUE (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. Tabla Carreteras
CREATE TABLE IF NOT EXISTS carreteras (
    pk_carretera VARCHAR(20) COMMENT 'Código único de la carretera (ej. AP-7, C-58)',
    nombre VARCHAR(120) NOT NULL,
    titularidad ENUM('Estatal', 'Autonómica', 'Provincial', 'Municipal') NOT NULL,
    nivel TINYINT UNSIGNED DEFAULT NULL COMMENT '1, 2, 3 o NULL para Estatales',
    tipo_via ENUM('Autopista', 'Autovía', 'Multicarril', 'Convencional') NOT NULL,
    acceso_controlado BOOLEAN NOT NULL DEFAULT FALSE,
    doble_calzada BOOLEAN NOT NULL DEFAULT FALSE,
    prefijo VARCHAR(10) NOT NULL,
    color ENUM('Rojo', 'Azul', 'Naranja', 'Verde', 'Amarillo', 'Otro') NOT NULL,
    senal VARCHAR(50) NOT NULL,
    observaciones TEXT DEFAULT NULL,
    CONSTRAINT pk_carreteras PRIMARY KEY (pk_carretera),
    CONSTRAINT chk_jerarquia_nivel_titularidad CHECK (
        (titularidad = 'Estatal' AND nivel IS NULL) OR
        (nivel = 1 AND titularidad = 'Autonómica' AND color = 'Naranja') OR
        (nivel = 2 AND titularidad IN ('Autonómica', 'Provincial') AND color = 'Verde') OR
        (nivel = 3 AND titularidad IN ('Autonómica', 'Provincial', 'Municipal') AND color = 'Amarillo')
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. Tabla Tramos
CREATE TABLE IF NOT EXISTS tramos (
    pk_tramo INT UNSIGNED AUTO_INCREMENT COMMENT 'Código autogenerado del tramo',
    fk_carretera VARCHAR(20) NOT NULL,
    km_inicial DECIMAL(8,3) UNSIGNED NOT NULL,
    km_final DECIMAL(8,3) UNSIGNED NOT NULL,
    longitud DECIMAL(8,3) GENERATED ALWAYS AS (km_final - km_inicial) STORED COMMENT 'Longitud autogenerada',
    tipo_terreno ENUM('Plano', 'Cuesta subida', 'Cuesta bajada') NOT NULL,
    entorno ENUM('Urbano', 'Travesía', 'Extraurbano') NOT NULL,
    velocidad_limite SMALLINT UNSIGNED NOT NULL,
    num_carriles_sentido TINYINT UNSIGNED NOT NULL DEFAULT 1,
    fk_provincia_inicio INT UNSIGNED NOT NULL COMMENT 'Provincia donde empieza el tramo',
    fk_provincia_fin INT UNSIGNED NOT NULL COMMENT 'Provincia donde termina el tramo',
    observaciones VARCHAR(255) DEFAULT NULL COMMENT 'Ejemplo: curva peligrosa',
    CONSTRAINT pk_tramos PRIMARY KEY (pk_tramo),
    CONSTRAINT chk_tramo_kilometros CHECK (km_final > km_inicial),
    CONSTRAINT chk_tramo_velocidad CHECK (velocidad_limite > 0),
    CONSTRAINT chk_tramo_carriles CHECK (num_carriles_sentido >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 5. Tabla Paso de Tramos por Provincias (cuando un tramo pasa por una o varias provincias)
CREATE TABLE IF NOT EXISTS tramos_provincias (
    fk_tramo INT UNSIGNED NOT NULL,
    fk_provincia INT UNSIGNED NOT NULL,
    km_inicio_provincia DECIMAL(8,3) UNSIGNED NOT NULL COMMENT 'Km de la carretera donde entra en la provincia',
    km_fin_provincia DECIMAL(8,3) UNSIGNED NOT NULL COMMENT 'Km de la carretera donde sale de la provincia',
    CONSTRAINT pk_tramos_provincias PRIMARY KEY (fk_tramo, fk_provincia, km_inicio_provincia),
    CONSTRAINT chk_km_provincia CHECK (km_fin_provincia > km_inicio_provincia)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 6. Tabla Extremos de Carretera (Principio o Final: Conclusión física o Confluencia)
CREATE TABLE IF NOT EXISTS extremos_carretera (
    fk_carretera VARCHAR(20) NOT NULL,
    tipo_extremo ENUM('Principio', 'Final') NOT NULL,
    fk_tramo INT UNSIGNED NOT NULL COMMENT 'Tramo que supone el principio o final',
    tipo_finalizacion ENUM('Concluye físicamente', 'Confluye en otra carretera') NOT NULL,
    fk_carretera_confluye VARCHAR(20) DEFAULT NULL,
    fk_tramo_confluye INT UNSIGNED DEFAULT NULL,
    fk_provincia_confluye INT UNSIGNED DEFAULT NULL,
    km_confluencia DECIMAL(8,3) UNSIGNED DEFAULT NULL,
    CONSTRAINT pk_extremos_carretera PRIMARY KEY (fk_carretera, tipo_extremo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =========================================================================
-- CLAVES FORÁNEAS (RELACIONES)
-- =========================================================================

ALTER TABLE provincias
ADD CONSTRAINT fk_provincias_comunidades
FOREIGN KEY (fk_comunidad) REFERENCES comunidades_autonomas(pk_comunidad)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE tramos
ADD CONSTRAINT fk_tramos_carreteras
FOREIGN KEY (fk_carretera) REFERENCES carreteras(pk_carretera)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT fk_tramos_prov_inicio
FOREIGN KEY (fk_provincia_inicio) REFERENCES provincias(pk_provincia)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT fk_tramos_prov_fin
FOREIGN KEY (fk_provincia_fin) REFERENCES provincias(pk_provincia)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE tramos_provincias
ADD CONSTRAINT fk_tp_tramos
FOREIGN KEY (fk_tramo) REFERENCES tramos(pk_tramo)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_tp_provincias
FOREIGN KEY (fk_provincia) REFERENCES provincias(pk_provincia)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE extremos_carretera
ADD CONSTRAINT fk_ext_carretera
FOREIGN KEY (fk_carretera) REFERENCES carreteras(pk_carretera)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_ext_tramo
FOREIGN KEY (fk_tramo) REFERENCES tramos(pk_tramo)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_ext_carretera_confluye
FOREIGN KEY (fk_carretera_confluye) REFERENCES carreteras(pk_carretera)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT fk_ext_tramo_confluye
FOREIGN KEY (fk_tramo_confluye) REFERENCES tramos(pk_tramo)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT fk_ext_provincia_confluye
FOREIGN KEY (fk_provincia_confluye) REFERENCES provincias(pk_provincia)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- =========================================================================
-- DISPARADORES (TRIGGERS)
-- =========================================================================

DELIMITER $$

-- Impedir que un tramo cambie de carretera una vez asignado
CREATE TRIGGER tr_tramos_no_cambiar_carretera
BEFORE UPDATE ON tramos
FOR EACH ROW
BEGIN
    IF OLD.fk_carretera <> NEW.fk_carretera THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Regla de negocio violada: Un tramo pertenece a una única carretera y no puede cambiar de carretera.';
    END IF;
END$$

-- Validar extremos de carretera y datos de confluencia (INSERT)
CREATE TRIGGER tr_extremos_validar_confluencia_bi
BEFORE INSERT ON extremos_carretera
FOR EACH ROW
BEGIN
    IF NEW.tipo_finalizacion = 'Concluye físicamente' AND (
        NEW.fk_carretera_confluye IS NOT NULL OR
        NEW.fk_tramo_confluye IS NOT NULL OR
        NEW.fk_provincia_confluye IS NOT NULL OR
        NEW.km_confluencia IS NOT NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Si la carretera concluye físicamente, los datos de confluencia deben ser NULL.';
    END IF;

    IF NEW.tipo_finalizacion = 'Confluye en otra carretera' AND (
        NEW.fk_carretera_confluye IS NULL OR
        NEW.fk_tramo_confluye IS NULL OR
        NEW.fk_provincia_confluye IS NULL OR
        NEW.km_confluencia IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Si confluye en otra carretera, debe indicar carretera, tramo, provincia y km de confluencia.';
    END IF;

    IF NEW.tipo_finalizacion = 'Confluye en otra carretera' AND NEW.fk_carretera = NEW.fk_carretera_confluye THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Una carretera debe confluir con una carretera distinta a sí misma.';
    END IF;
END$$

-- Validar extremos de carretera y datos de confluencia (UPDATE)
CREATE TRIGGER tr_extremos_validar_confluencia_bu
BEFORE UPDATE ON extremos_carretera
FOR EACH ROW
BEGIN
    IF NEW.tipo_finalizacion = 'Concluye físicamente' AND (
        NEW.fk_carretera_confluye IS NOT NULL OR
        NEW.fk_tramo_confluye IS NOT NULL OR
        NEW.fk_provincia_confluye IS NOT NULL OR
        NEW.km_confluencia IS NOT NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Si la carretera concluye físicamente, los datos de confluencia deben ser NULL.';
    END IF;

    IF NEW.tipo_finalizacion = 'Confluye en otra carretera' AND (
        NEW.fk_carretera_confluye IS NULL OR
        NEW.fk_tramo_confluye IS NULL OR
        NEW.fk_provincia_confluye IS NULL OR
        NEW.km_confluencia IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Si confluye en otra carretera, debe indicar carretera, tramo, provincia y km de confluencia.';
    END IF;

    IF NEW.tipo_finalizacion = 'Confluye en otra carretera' AND NEW.fk_carretera = NEW.fk_carretera_confluye THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Una carretera debe confluir con una carretera distinta a sí misma.';
    END IF;
END$$

DELIMITER ;