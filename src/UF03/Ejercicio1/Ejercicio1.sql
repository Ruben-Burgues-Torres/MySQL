-- =========================================================================
-- EJERCICIO 1: ARTÍCULOS Y ENCARGOS
-- =========================================================================

DROP DATABASE IF EXISTS ej1_articulos_encargos;
CREATE DATABASE IF NOT EXISTS ej1_articulos_encargos
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci
DEFAULT ENCRYPTION = 'N';

USE ej1_articulos_encargos;

-- 1. Tabla Clientes
CREATE TABLE IF NOT EXISTS clientes (
    pk_cliente INT UNSIGNED AUTO_INCREMENT,
    saldo DECIMAL(12,2) NOT NULL DEFAULT 0.00 COMMENT 'Saldo actual del cliente',
    limite_credito DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT 'Máximo 3.000.000 euros',
    descuento DECIMAL(5,2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT 'Porcentaje de descuento (0 a 100)',
    CONSTRAINT pk_clientes PRIMARY KEY (pk_cliente),
    CONSTRAINT chk_cliente_limite_credito CHECK (limite_credito <= 3000000.00),
    CONSTRAINT chk_cliente_descuento CHECK (descuento BETWEEN 0.00 AND 100.00)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 2. Tabla Direcciones de Envío (varias por cliente)
CREATE TABLE IF NOT EXISTS direcciones_envio (
    pk_direccion INT UNSIGNED AUTO_INCREMENT,
    fk_cliente INT UNSIGNED NOT NULL,
    calle VARCHAR(100) NOT NULL,
    numero VARCHAR(15) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    codigo_postal CHAR(5) NOT NULL,
    CONSTRAINT pk_direcciones_envio PRIMARY KEY (pk_direccion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. Tabla Artículos
CREATE TABLE IF NOT EXISTS articulos (
    pk_articulo INT UNSIGNED AUTO_INCREMENT,
    descripcion VARCHAR(255) NOT NULL,
    CONSTRAINT pk_articulos PRIMARY KEY (pk_articulo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. Tabla Fábricas
CREATE TABLE IF NOT EXISTS fabricas (
    pk_fabrica INT UNSIGNED AUTO_INCREMENT,
    telefono_contacto VARCHAR(20) NOT NULL,
    total_articulos_provistos INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Total de artículos distintos que provee la fábrica',
    CONSTRAINT pk_fabricas PRIMARY KEY (pk_fabrica),
    CONSTRAINT uq_fabrica_telefono UNIQUE (telefono_contacto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 5. Tabla Fábricas Alternativas (información estratégica reflexiva)
CREATE TABLE IF NOT EXISTS fabricas_alternativas (
    fk_fabrica_titular INT UNSIGNED NOT NULL,
    fk_fabrica_alternativa INT UNSIGNED NOT NULL,
    observaciones VARCHAR(150) DEFAULT NULL,
    CONSTRAINT pk_fabricas_alternativas PRIMARY KEY (fk_fabrica_titular, fk_fabrica_alternativa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 6. Tabla Artículos por Fábrica (distribución y existencias)
CREATE TABLE IF NOT EXISTS articulos_fabricas (
    fk_articulo INT UNSIGNED NOT NULL,
    fk_fabrica INT UNSIGNED NOT NULL,
    existencias INT UNSIGNED NOT NULL DEFAULT 0,
    CONSTRAINT pk_articulos_fabricas PRIMARY KEY (fk_articulo, fk_fabrica),
    CONSTRAINT chk_existencias_positivas CHECK (existencias >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 7. Tabla Pedidos (Cabecera del pedido)
CREATE TABLE IF NOT EXISTS pedidos (
    pk_pedido INT UNSIGNED AUTO_INCREMENT,
    fk_cliente INT UNSIGNED NOT NULL,
    fk_direccion_envio INT UNSIGNED NOT NULL,
    fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Incluye fecha y hora',
    CONSTRAINT pk_pedidos PRIMARY KEY (pk_pedido)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 8. Tabla Líneas de Pedido (Cuerpo del pedido)
CREATE TABLE IF NOT EXISTS lineas_pedido (
    fk_pedido INT UNSIGNED NOT NULL,
    num_linea SMALLINT UNSIGNED NOT NULL,
    fk_articulo INT UNSIGNED NOT NULL,
    cantidad INT UNSIGNED NOT NULL,
    CONSTRAINT pk_lineas_pedido PRIMARY KEY (fk_pedido, num_linea),
    CONSTRAINT uq_pedido_articulo UNIQUE (fk_pedido, fk_articulo),
    CONSTRAINT chk_cantidad_pedido CHECK (cantidad > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =========================================================================
-- CLAVES FORÁNEAS (RELACIONES)
-- =========================================================================

ALTER TABLE direcciones_envio
ADD CONSTRAINT fk_direcciones_clientes
FOREIGN KEY (fk_cliente) REFERENCES clientes(pk_cliente)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE fabricas_alternativas
ADD CONSTRAINT fk_alt_fabrica_titular
FOREIGN KEY (fk_fabrica_titular) REFERENCES fabricas(pk_fabrica)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_alt_fabrica_alternativa
FOREIGN KEY (fk_fabrica_alternativa) REFERENCES fabricas(pk_fabrica)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE articulos_fabricas
ADD CONSTRAINT fk_af_articulo
FOREIGN KEY (fk_articulo) REFERENCES articulos(pk_articulo)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT fk_af_fabrica
FOREIGN KEY (fk_fabrica) REFERENCES fabricas(pk_fabrica)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE pedidos
ADD CONSTRAINT fk_pedidos_clientes
FOREIGN KEY (fk_cliente) REFERENCES clientes(pk_cliente)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT fk_pedidos_direcciones
FOREIGN KEY (fk_direccion_envio) REFERENCES direcciones_envio(pk_direccion)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE lineas_pedido
ADD CONSTRAINT fk_lineas_pedidos
FOREIGN KEY (fk_pedido) REFERENCES pedidos(pk_pedido)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_lineas_articulos
FOREIGN KEY (fk_articulo) REFERENCES articulos(pk_articulo)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- =========================================================================
-- DISPARADORES (TRIGGERS)
-- =========================================================================

DELIMITER $$

-- Validar que una fábrica no sea alternativa de sí misma (INSERT y UPDATE)
CREATE TRIGGER tr_fabricas_alternativas_bi
BEFORE INSERT ON fabricas_alternativas
FOR EACH ROW
BEGIN
    IF NEW.fk_fabrica_titular = NEW.fk_fabrica_alternativa THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Una fábrica no puede registrarse como alternativa de sí misma.';
    END IF;
END$$  CREATE TRIGGER tr_fabricas_alternativas_bu BEFORE UPDATE ON fabricas_alternativas FOR EACH ROW BEGIN IF NEW.fk_fabrica_titular = NEW.fk_fabrica_alternativa THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Una fábrica no puede registrarse como alternativa de sí misma.'; END IF; END$$

-- Validar que la dirección de envío pertenezca al cliente que realiza el pedido
CREATE TRIGGER tr_pedidos_validar_direccion
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    DECLARE v_cliente_dir INT UNSIGNED;
    SELECT fk_cliente INTO v_cliente_dir
    FROM direcciones_envio
    WHERE pk_direccion = NEW.fk_direccion_envio;

    IF v_cliente_dir IS NULL OR v_cliente_dir <> NEW.fk_cliente THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La dirección de envío seleccionada no pertenece al cliente indicado.';
    END IF;
END$$  -- Validar que la cantidad pedida sea mayor que cero CREATE TRIGGER tr_lineas_pedido_cantidad BEFORE INSERT ON lineas_pedido FOR EACH ROW BEGIN IF NEW.cantidad <= 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad pedida del artículo debe ser mayor que cero.'; END IF; END$$

-- Actualizar automáticamente el contador de artículos que provee la fábrica al insertar
CREATE TRIGGER tr_articulos_fabricas_ai
AFTER INSERT ON articulos_fabricas
FOR EACH ROW
BEGIN
    UPDATE fabricas
    SET total_articulos_provistos = total_articulos_provistos + 1
    WHERE pk_fabrica = NEW.fk_fabrica;
END$$  -- Actualizar automáticamente el contador de artículos que provee la fábrica al eliminar CREATE TRIGGER tr_articulos_fabricas_ad AFTER DELETE ON articulos_fabricas FOR EACH ROW BEGIN UPDATE fabricas SET total_articulos_provistos = total_articulos_provistos - 1 WHERE pk_fabrica = OLD.fk_fabrica; END$$

DELIMITER ;