-- ============================================================================
-- Ejercicio 8. Realización de consultas simples SQL
-- Base de datos: jardineria (UF04)
-- ============================================================================

USE jardineria;

-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT pk_oficina, ciudad
FROM oficina;

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono
FROM oficina
WHERE pais = 'España';

-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE fk_jefe = 7;

-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto, nombre, apellido1, apellido2, email
FROM empleado
WHERE fk_jefe IS NULL;

-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto != 'Representante Ventas';

-- 6. Devuelve un listado con el nombre de todos los clientes españoles.
SELECT nombre_cliente
FROM cliente
WHERE pais = 'Spain';

-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT estado
FROM pedido;

-- 8. Devuelve un listado con el código de cliente (sin repetir) de aquellos clientes que realizaron algún pago en 2008.
-- 8a. Utilizando la función YEAR de MySQL:
SELECT DISTINCT fk_cliente
FROM pago
WHERE YEAR(fecha_pago) = 2008;

-- 8b. Utilizando la función DATE_FORMAT de MySQL:
SELECT DISTINCT fk_cliente
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';

-- 8c. Sin utilizar ninguna de las funciones anteriores:
SELECT DISTINCT fk_cliente
FROM pago
WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';

-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
SELECT pk_pedido, fk_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;

-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
-- 10a. Utilizando la función ADDDATE de MySQL:
SELECT pk_pedido, fk_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega <= ADDDATE(fecha_esperada, -2);

-- 10b. Utilizando la función DATEDIFF de MySQL:
SELECT pk_pedido, fk_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;

-- 10c. ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
-- Sí, siempre que se acompañe de la cláusula INTERVAL (si se resta un entero directamente,
-- MySQL convierte la fecha a número AAAAMMDD y puede producir fechas inválidas al cambiar de mes).
SELECT pk_pedido, fk_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega <= fecha_esperada - INTERVAL 2 DAY;

-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT *
FROM pedido
WHERE estado = 'Rechazado' AND YEAR(fecha_pedido) = 2009;

-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
SELECT *
FROM pedido
WHERE estado = 'Entregado' AND MONTH(fecha_entrega) = 1;

-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante PayPal. Ordena el resultado de mayor a menor.
SELECT *
FROM pago
WHERE YEAR(fecha_pago) = 2008 AND forma_pago = 'PayPal'
ORDER BY total DESC;

-- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago (sin repetir).
SELECT DISTINCT forma_pago
FROM pago;

-- 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock, ordenados por precio_venta descendente.
SELECT *
FROM producto
WHERE fk_gama = (SELECT pk_gama FROM gama_producto WHERE gama = 'Ornamentales')
  AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;

-- (Alternativa si la tabla producto almacena el texto de gama directamente en la columna 'gama'):
-- SELECT * FROM producto WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100 ORDER BY precio_venta DESC;

-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
SELECT *
FROM cliente
WHERE ciudad = 'Madrid'
  AND fk_representante_ventas IN (11, 30);
