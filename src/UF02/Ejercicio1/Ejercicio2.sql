-- =========================================================================
-- EJERCICIO 2: SISTEMA DE VENTAS
-- =========================================================================

DROP DATABASE IF EXISTS ej2_sistema_ventas;
CREATE DATABASE IF NOT EXISTS ej2_sistema_ventas
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci
DEFAULT ENCRYPTION = 'N';

USE ej2_sistema_ventas;

-- 1. Tabla Proveedores
CREATE TABLE IF NOT EXISTS proveedores (
    pk_proveedor_cif VARCHAR(15),
    nombre VARCHAR(100) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    numero VARCHAR(15) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    codigo_postal CHAR(5) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    pagina_web VARCHAR(150) DEFAULT NULL,
    CONSTRAINT pk_proveedores PRIMARY KEY (pk_proveedor_cif),
    CONSTRAINT uq_proveedor_telefono UNIQUE (telefono)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 2. Tabla Clientes
CREATE TABLE IF NOT EXISTS clientes (
    pk_cliente_cif VARCHAR(15),
    nombre VARCHAR(100) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    numero VARCHAR(15) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    codigo_postal CHAR(5) NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (pk_cliente_cif)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. Tabla Teléfonos de Clientes (varios por cliente)
CREATE TABLE IF NOT EXISTS telefonos_clientes (
    fk_cliente_cif VARCHAR(15) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    CONSTRAINT pk_telefonos_clientes PRIMARY KEY (fk_cliente_cif, telefono)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. Tabla Categorías
CREATE TABLE IF NOT EXISTS categorias (
    pk_categoria INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    descripcion VARCHAR(255) DEFAULT NULL,
    CONSTRAINT pk_categorias PRIMARY KEY (pk_categoria),
    CONSTRAINT uq_categoria_nombre UNIQUE (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 5. Tabla Productos
CREATE TABLE IF NOT EXISTS productos (
    pk_producto INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio_actual DECIMAL(10,2) UNSIGNED NOT NULL,
    stock INT UNSIGNED NOT NULL DEFAULT 0,
    fk_proveedor_cif VARCHAR(15) NOT NULL,
    fk_categoria INT UNSIGNED NOT NULL,
    CONSTRAINT pk_productos PRIMARY KEY (pk_producto),
    CONSTRAINT chk_producto_precio CHECK (precio_actual > 0),
    CONSTRAINT chk_producto_stock CHECK (stock >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 6. Tabla Facturas (Cabecera de venta)
CREATE TABLE IF NOT EXISTS facturas (
    pk_factura INT UNSIGNED AUTO_INCREMENT COMMENT 'Número único de factura',
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fk_cliente_cif VARCHAR(15) NOT NULL,
    descuento DECIMAL(5,2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT 'Porcentaje de descuento (0 a 100)',
    porcentaje_iva DECIMAL(5,2) UNSIGNED NOT NULL DEFAULT 21.00 COMMENT 'Porcentaje de IVA aplicado',
    importe_final DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT 'Importe final con descuento e IVA incluidos',
    CONSTRAINT pk_facturas PRIMARY KEY (pk_factura),
    CONSTRAINT chk_factura_descuento CHECK (descuento BETWEEN 0.00 AND 100.00)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 7. Tabla Líneas de Factura (Detalle de productos vendidos)
CREATE TABLE IF NOT EXISTS lineas_factura (
    fk_factura INT UNSIGNED NOT NULL,
    fk_producto INT UNSIGNED NOT NULL,
    precio_venta DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT 'Precio del producto al momento de la venta',
    cantidad INT UNSIGNED NOT NULL,
    importe_total_producto DECIMAL(12,2) GENERATED ALWAYS AS (precio_venta * cantidad) STORED,
    CONSTRAINT pk_lineas_factura PRIMARY KEY (fk_factura, fk_producto),
    CONSTRAINT chk_linea_precio_venta CHECK (precio_venta > 0),
    CONSTRAINT chk_linea_cantidad CHECK (cantidad > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =========================================================================
-- CLAVES FORÁNEAS (RELACIONES)
-- =========================================================================

ALTER TABLE telefonos_clientes
ADD CONSTRAINT fk_telefonos_clientes
FOREIGN KEY (fk_cliente_cif) REFERENCES clientes(pk_cliente_cif)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE productos
ADD CONSTRAINT fk_productos_proveedores
FOREIGN KEY (fk_proveedor_cif) REFERENCES proveedores(pk_proveedor_cif)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT fk_productos_categorias
FOREIGN KEY (fk_categoria) REFERENCES categorias(pk_categoria)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE facturas
ADD CONSTRAINT fk_facturas_clientes
FOREIGN KEY (fk_cliente_cif) REFERENCES clientes(pk_cliente_cif)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE lineas_factura
ADD CONSTRAINT fk_detalle_facturas
FOREIGN KEY (fk_factura) REFERENCES facturas(pk_factura)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_detalle_productos
FOREIGN KEY (fk_producto) REFERENCES productos(pk_producto)
ON UPDATE CASCADE ON DELETE RESTRICT;

-- =========================================================================
-- DISPARADORES (TRIGGERS)
-- =========================================================================

DELIMITER $$

-- Validar cantidad > 0, disponibilidad de stock y fijar precio de venta histórico
CREATE TRIGGER tr_lineas_factura_bi
BEFORE INSERT ON lineas_factura
FOR EACH ROW
BEGIN
    DECLARE v_stock_actual INT UNSIGNED;
    DECLARE v_precio_actual DECIMAL(10,2);

    IF NEW.cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad vendida debe ser mayor que cero.';
    END IF;

    SELECT stock, precio_actual INTO v_stock_actual, v_precio_actual
    FROM productos
    WHERE pk_producto = NEW.fk_producto;

    IF v_stock_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para realizar la venta del producto.';
    END IF;

    IF NEW.precio_venta IS NULL OR NEW.precio_venta = 0 THEN
        SET NEW.precio_venta = v_precio_actual;
    END IF;
END$$

-- Descontar stock y recalcular el importe final de la factura (con descuento e IVA)
CREATE TRIGGER tr_lineas_factura_ai
AFTER INSERT ON lineas_factura
FOR EACH ROW
BEGIN
    DECLARE v_subtotal DECIMAL(12,2);

    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE pk_producto = NEW.fk_producto;

    SELECT IFNULL(SUM(importe_total_producto), 0.00) INTO v_subtotal
    FROM lineas_factura
    WHERE fk_factura = NEW.fk_factura;

    UPDATE facturas
    SET importe_final = ROUND(v_subtotal * (1 - (descuento / 100)) * (1 + (porcentaje_iva / 100)), 2)
    WHERE pk_factura = NEW.fk_factura;
END$$

DELIMITER ;