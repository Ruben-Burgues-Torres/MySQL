USE ventas;

-- 1. Desactivar validaciones temporales para acelerar la carga en InnoDB
SET autocommit = 0;
SET unique_checks = 0;
SET foreign_key_checks = 0;

-- 2. Carga masiva desde la carpeta segura (secure_file_priv)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/Ventas.csv'
INTO TABLE ventas
CHARACTER SET latin1 -- Usa utf8mb4 si en Power Query/Excel exportas como CSV UTF-8
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
-- Opcional: especifica las columnas aquí si tu tabla tiene un ID autoincremental:
-- (columna1, columna2, columna3);

-- 3. Confirmar la transacción y restaurar configuraciones
COMMIT;
SET foreign_key_checks = 1;
SET unique_checks = 1;
SET autocommit = 1;

-- 4. Verificar la carga sin saturar la memoria
SHOW WARNINGS;
SELECT COUNT(*) AS total_registros FROM ventas;
SELECT * FROM ventas LIMIT 10;