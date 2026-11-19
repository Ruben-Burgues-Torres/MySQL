-- ============================================================================
-- Ejercicio 7. Realización de consultas simples SQL
-- Base de datos: nomina (UF03)
-- ============================================================================

USE nomina;

-- 1. Lista los nombres de todos los empleados que hay en la tabla empleado.
SELECT nombre
FROM empleado;

-- 2. Lista los nombres y los sueldos de todos los empleados de la tabla empleado.
SELECT nombre, sueldo
FROM empleado;

-- 3. Lista todas las columnas (*) de la tabla empleado.
SELECT *
FROM empleado;

-- 4. Lista el nombre + apellido de todos los empleados, su fecha de nacimiento y su fecha de contrato.
SELECT nombre, apellido, fecha_nacimiento, fecha_contrato
FROM empleado;

-- 5. Lista el nombre de los empleados, su apellido, el sexo e hijos.
SELECT nombre, apellido, sexo, hijos
FROM empleado;

-- 6. Utiliza los siguientes alias para las columnas: nombre del empleado, apellido del empleado, sexo, número de hijos.
SELECT
    nombre AS `nombre del empleado`,
    apellido AS `apellido del empleado`,
    sexo,
    hijos AS `número de hijos`
FROM empleado;

-- 7. Lista los nombres + apellidos y el sueldo de todos los empleados de la tabla empleado, mostrando los apellidos en mayúsculas (función UPPER).
SELECT nombre, UPPER(apellido) AS apellido, sueldo
FROM empleado;

-- 8. Lista los nombres + apellidos y estado civil de todos los empleados de la tabla empleado, mostrando el estado civil en minúscula (función LOWER).
SELECT nombre, apellido, LOWER(estado_civil) AS estado_civil
FROM empleado;

-- 9. Lista los nombres + apellidos de todos los empleados y calcula las iniciales de los mismos (función LEFT).
SELECT
    nombre,
    apellido,
    CONCAT(LEFT(nombre, 1), '.', LEFT(apellido, 1), '.') AS iniciales
FROM empleado;

-- 10. Lista los nombres + apellidos de todos los empleados y calcula su edad a partir de la fecha de nacimiento.
SELECT
    nombre,
    apellido,
    TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad
FROM empleado;

-- 11. Lista los nombres + apellidos de todos los empleados y calcula su antigüedad a partir de la fecha del contrato.
SELECT
    nombre,
    apellido,
    TIMESTAMPDIFF(YEAR, fecha_contrato, CURDATE()) AS antiguedad
FROM empleado;

-- 12. Lista sin repetir el código de los cargos (fk_cargo) de la tabla empleado.
SELECT DISTINCT fk_cargo
FROM empleado;

-- 13. Lista la tabla empleado ordenada de forma ascendente (ASC) por apellido y nombre.
SELECT *
FROM empleado
ORDER BY apellido ASC, nombre ASC;

-- 14. Lista la tabla empleado ordenada de forma descendente (DESC) por sueldos.
SELECT *
FROM empleado
ORDER BY sueldo DESC;

-- 15. Lista los empleados ordenados en primer lugar por el estado civil de forma ascendente y en segundo lugar el sueldo de forma descendente.
SELECT *
FROM empleado
ORDER BY estado_civil ASC, sueldo DESC;

-- 16. Devuelve una lista con las 3 primeras filas de la tabla cargo.
SELECT *
FROM cargo
LIMIT 3;

-- 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla departamento (cuarta fila incluida).
SELECT *
FROM departamento
LIMIT 2 OFFSET 3;

-- 18. Lista el nombre + apellido y el sueldo del empleado que gane menos sueldo.
SELECT nombre, apellido, sueldo
FROM empleado
ORDER BY sueldo ASC
LIMIT 1;

-- 19. Lista el nombre + apellido y la fecha de nacimiento del empleado de mayor edad.
SELECT nombre, apellido, fecha_nacimiento
FROM empleado
ORDER BY fecha_nacimiento ASC
LIMIT 1;

-- 20. Lista el nombre de todos los empleados cuyo fk_departamento es igual a 2.
SELECT nombre
FROM empleado
WHERE fk_departamento = 2;

-- 21. Lista nombre + apellido de los empleados que tienen un sueldo menor o igual a 15.000€.
SELECT nombre, apellido
FROM empleado
WHERE sueldo <= 15000;

-- 22. Lista nombre + apellido de los empleados que tienen un sueldo mayor o igual a 40.000€.
SELECT nombre, apellido
FROM empleado
WHERE sueldo >= 40000;

-- 23. Lista nombre + apellido de los empleados que no tienen un sueldo mayor o igual a 14.000€.
SELECT nombre, apellido
FROM empleado
WHERE NOT sueldo >= 14000;

-- 24. Lista todos los empleados que tengan un sueldo entre 18.000€ y 25.000€. Sin utilizar el operador BETWEEN.
SELECT *
FROM empleado
WHERE sueldo >= 18000 AND sueldo <= 25000;

-- 25. Lista todos los empleados que tengan un sueldo entre 16.000€ y 20.000€. Utilizando el operador BETWEEN.
SELECT *
FROM empleado
WHERE sueldo BETWEEN 16000 AND 20000;

-- 26. Lista los empleados que tengan un sueldo mayor que 15.000€ y que el fk_departamento sea igual a 6.
SELECT *
FROM empleado
WHERE sueldo > 15000 AND fk_departamento = 6;

-- 27. Lista los empleados donde el fk_cargo sea 1, 3 o 5. Sin utilizar el operador IN.
SELECT *
FROM empleado
WHERE fk_cargo = 1 OR fk_cargo = 3 OR fk_cargo = 5;

-- 28. Lista todos los empleados donde el fk_cargo sea 1, 3 o 5. Utilizando el operador IN.
SELECT *
FROM empleado
WHERE fk_cargo IN (1, 3, 5);

-- 29. Lista el nombre + apellido de los empleados y su mes de nacimiento.
SELECT nombre, apellido, MONTH(fecha_nacimiento) AS mes_nacimiento
FROM empleado;

-- 30. Lista los empleados cuyo nombre empiece por la letra S.
SELECT *
FROM empleado
WHERE nombre LIKE 'S%';

-- 31. Lista los empleados cuyo nombre termine por la vocal e.
SELECT *
FROM empleado
WHERE nombre LIKE '%e';

-- 32. Lista los cargos que contengan el carácter r.
SELECT *
FROM cargo
WHERE cargo LIKE '%r%';

-- 33. Devuelve una lista de todos los empleados que contienen la cadena ana en el nombre.
SELECT *
FROM empleado
WHERE nombre LIKE '%ana%';

-- 34. Haz una lista de todos los empleados que contienen la cadena ez en el apellido y tienen un sueldo inferior a 21.500€.
SELECT *
FROM empleado
WHERE apellido LIKE '%ez%' AND sueldo < 21500;

-- 35. Lista los apellidos cuya longitud sea igual a 4 caracteres.
SELECT apellido
FROM empleado
WHERE apellido LIKE '____';

-- 36. Lista el nombre y el sueldo de todos los empleados que tengan un sueldo mayor o igual a 18.000€.
-- Ordena el resultado en primer lugar por el sueldo (descendente) y en segundo lugar por el apellido (ascendente).
SELECT nombre, sueldo
FROM empleado
WHERE sueldo >= 18000
ORDER BY sueldo DESC, apellido ASC;
