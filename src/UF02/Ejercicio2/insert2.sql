USE ej2_sistema_ventas;

-- 1. Tabla proveedores
INSERT INTO proveedores (pk_proveedor_cif, nombre, calle, numero, ciudad, codigo_postal, telefono, pagina_web) VALUES ('B12345678', 'TechDistribución SL', 'Av. Diagonal', '450', 'Barcelona', '08006', '932112233', 'https://www.techdistribucion.es');
INSERT INTO proveedores (pk_proveedor_cif, nombre, calle, numero, ciudad, codigo_postal, telefono, pagina_web) VALUES ('A87654321', 'Componentes Iberia SA', 'Calle Alcalá', '120', 'Madrid', '28009', '914556677', 'https://www.componentesiberia.com');
INSERT INTO proveedores (pk_proveedor_cif, nombre, calle, numero, ciudad, codigo_postal, telefono, pagina_web) VALUES ('B99887766', 'Suministros Levante SL', 'Calle Colón', '34', 'Valencia', '46004', '963445566', 'https://www.suministroslevante.es');
INSERT INTO proveedores (pk_proveedor_cif, nombre, calle, numero, ciudad, codigo_postal, telefono, pagina_web) VALUES ('B44556677', 'OfiMaterial Vallès SL', 'Rambla d''Ègara', '210', 'Terrassa', '08221', '937889900', 'https://www.ofimaterialvalles.cat');
INSERT INTO proveedores (pk_proveedor_cif, nombre, calle, numero, ciudad, codigo_postal, telefono, pagina_web) VALUES ('A11223344', 'Redes y Sistemas Norte SA', 'Gran Vía', '85', 'Bilbao', '48011', '944123456', 'https://www.redesnorte.es');

-- 2. Tabla clientes
INSERT INTO clientes (pk_cliente_cif, nombre, calle, numero, ciudad, codigo_postal) VALUES ('12345678Z', 'Carlos Martínez Gómez', 'Calle Mayor', '12', 'Terrassa', '08221');
INSERT INTO clientes (pk_cliente_cif, nombre, calle, numero, ciudad, codigo_postal) VALUES ('87654321X', 'Laura Soler Puig', 'Passeig de Gràcia', '78', 'Barcelona', '08008');
INSERT INTO clientes (pk_cliente_cif, nombre, calle, numero, ciudad, codigo_postal) VALUES ('B55443322', 'Innova Consultores SL', 'Calle Serrano', '45', 'Madrid', '28001');
INSERT INTO clientes (pk_cliente_cif, nombre, calle, numero, ciudad, codigo_postal) VALUES ('45678912M', 'Marc Vila Roca', 'Avinguda Jacquard', '55', 'Terrassa', '08222');
INSERT INTO clientes (pk_cliente_cif, nombre, calle, numero, ciudad, codigo_postal) VALUES ('B66778899', 'Estudio Gráfico Delta SL', 'Calle Sierpes', '19', 'Sevilla', '41004');
INSERT INTO clientes (pk_cliente_cif, nombre, calle, numero, ciudad, codigo_postal) VALUES ('78912345L', 'Elena Morales Ruiz', 'Calle Alfonso I', '23', 'Zaragoza', '50003');

-- 3. Tabla telefonos_clientes (varios teléfonos de contacto por cliente)
INSERT INTO telefonos_clientes (fk_cliente_cif, telefono) VALUES ('12345678Z', '600111222');
INSERT INTO telefonos_clientes (fk_cliente_cif, telefono) VALUES ('12345678Z', '937111222');
INSERT INTO telefonos_clientes (fk_cliente_cif, telefono) VALUES ('87654321X', '611222333');
INSERT INTO telefonos_clientes (fk_cliente_cif, telefono) VALUES ('B55443322', '915001122');
INSERT INTO telefonos_clientes (fk_cliente_cif, telefono) VALUES ('B55443322', '622333444');
INSERT INTO telefonos_clientes (fk_cliente_cif, telefono) VALUES ('45678912M', '633444555');
INSERT INTO telefonos_clientes (fk_cliente_cif, telefono) VALUES ('B66778899', '954112233');
INSERT INTO telefonos_clientes (fk_cliente_cif, telefono) VALUES ('78912345L', '644555666');
INSERT INTO telefonos_clientes (fk_cliente_cif, telefono) VALUES ('78912345L', '976223344');

-- 4. Tabla categorias
INSERT INTO categorias (pk_categoria, nombre, descripcion) VALUES (1, 'Ordenadores', 'Equipos portátiles, sobremesa y estaciones de trabajo');
INSERT INTO categorias (pk_categoria, nombre, descripcion) VALUES (2, 'Periféricos', 'Monitores, teclados, ratones e impresoras');
INSERT INTO categorias (pk_categoria, nombre, descripcion) VALUES (3, 'Componentes', 'Procesadores, memoria RAM, placas base y almacenamiento SSD');
INSERT INTO categorias (pk_categoria, nombre, descripcion) VALUES (4, 'Redes', 'Routers, switches, puntos de acceso y cableado estructurado');
INSERT INTO categorias (pk_categoria, nombre, descripcion) VALUES (5, 'Mobiliario Oficina', 'Sillas ergonómicas, mesas y soportes articulados');

-- 5. Tabla productos
INSERT INTO productos (pk_producto, nombre, precio_actual, stock, fk_proveedor_cif, fk_categoria) VALUES (1, 'Portátil ProBook 15" i7 16GB', 850.00, 40, 'B12345678', 1);
INSERT INTO productos (pk_producto, nombre, precio_actual, stock, fk_proveedor_cif, fk_categoria) VALUES (2, 'Monitor UltraWide 29" IPS', 240.00, 60, 'B12345678', 2);
INSERT INTO productos (pk_producto, nombre, precio_actual, stock, fk_proveedor_cif, fk_categoria) VALUES (3, 'Teclado Mecánico RGB Switch Red', 75.50, 100, 'A87654321', 2);
INSERT INTO productos (pk_producto, nombre, precio_actual, stock, fk_proveedor_cif, fk_categoria) VALUES (4, 'Disco SSD NVMe M.2 1TB', 89.90, 120, 'A87654321', 3);
INSERT INTO productos (pk_producto, nombre, precio_actual, stock, fk_proveedor_cif, fk_categoria) VALUES (5, 'Memoria RAM DDR5 32GB (2x16GB)', 115.00, 80, 'A87654321', 3);
INSERT INTO productos (pk_producto, nombre, precio_actual, stock, fk_proveedor_cif, fk_categoria) VALUES (6, 'Switch Gestionable Gigabit 24 Puertos', 195.00, 25, 'A11223344', 4);
INSERT INTO productos (pk_producto, nombre, precio_actual, stock, fk_proveedor_cif, fk_categoria) VALUES (7, 'Router Wi-Fi 6 Empresarial Dual Band', 130.00, 35, 'A11223344', 4);
INSERT INTO productos (pk_producto, nombre, precio_actual, stock, fk_proveedor_cif, fk_categoria) VALUES (8, 'Silla Ergonómica Lumbar Ajustable', 210.00, 30, 'B44556677', 5);
INSERT INTO productos (pk_producto, nombre, precio_actual, stock, fk_proveedor_cif, fk_categoria) VALUES (9, 'Ratón Inalámbrico Vertical Ergonómico', 39.95, 90, 'B99887766', 2);
INSERT INTO productos (pk_producto, nombre, precio_actual, stock, fk_proveedor_cif, fk_categoria) VALUES (10, 'Soporte Doble Brazo para Monitor', 49.50, 50, 'B44556677', 5);

-- 6. Tabla facturas (el importe_final se actualiza automáticamente mediante el trigger al insertar las líneas)
INSERT INTO facturas (pk_factura, fecha, fk_cliente_cif, descuento, porcentaje_iva, importe_final) VALUES (1, '2026-10-05 10:15:00', '12345678Z', 0.00, 21.00, 0.00);
INSERT INTO facturas (pk_factura, fecha, fk_cliente_cif, descuento, porcentaje_iva, importe_final) VALUES (2, '2026-10-12 16:40:00', 'B55443322', 10.00, 21.00, 0.00);
INSERT INTO facturas (pk_factura, fecha, fk_cliente_cif, descuento, porcentaje_iva, importe_final) VALUES (3, '2026-10-18 11:20:00', '87654321X', 5.00, 21.00, 0.00);
INSERT INTO facturas (pk_factura, fecha, fk_cliente_cif, descuento, porcentaje_iva, importe_final) VALUES (4, '2026-10-25 09:30:00', '45678912M', 0.00, 21.00, 0.00);
INSERT INTO facturas (pk_factura, fecha, fk_cliente_cif, descuento, porcentaje_iva, importe_final) VALUES (5, '2026-11-02 18:05:00', 'B66778899', 15.00, 21.00, 0.00);
INSERT INTO facturas (pk_factura, fecha, fk_cliente_cif, descuento, porcentaje_iva, importe_final) VALUES (6, '2026-11-08 12:50:00', '78912345L', 0.00, 21.00, 0.00);

-- 7. Tabla lineas_factura (importe_total_producto es columna GENERATED; no se incluye en el INSERT)
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (1, 1, 850.00, 1);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (1, 9, 39.95, 1);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (2, 1, 850.00, 4);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (2, 2, 240.00, 4);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (2, 6, 195.00, 2);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (3, 4, 89.90, 2);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (3, 5, 115.00, 2);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (4, 8, 210.00, 1);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (4, 10, 49.50, 1);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (5, 2, 240.00, 6);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (5, 3, 75.50, 6);
INSERT INTO lineas_factura (fk_factura, fk_producto, precio_venta, cantidad) VALUES (6, 7, 130.00, 2);