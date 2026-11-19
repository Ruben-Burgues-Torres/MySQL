-- 1. Crear el usuario administrador
CREATE USER 'rburgues'@'localhost' IDENTIFIED BY '1234';

-- 2. Otorgarle absolutamente todos los permisos (rol de root)
    GRANT ALL PRIVILEGES ON *.* TO 'rburgues'@'localhost' WITH GRANT OPTION;

-- 3. Aplicar los cambios en el sistema
FLUSH PRIVILEGES;

