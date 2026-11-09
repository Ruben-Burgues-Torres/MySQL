# Guía Sencilla: Opciones de Base de Datos y Tablas en MySQL

Cuando creamos una base de datos o una tabla en MySQL, añadimos unas líneas al final para decirle al programa **cómo debe guardar, ordenar y proteger los textos y los datos**.

---

## 1. Opciones al crear la Base de Datos (`CREATE DATABASE`)

```sql
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci
DEFAULT ENCRYPTION = 'N';
```

* **`DEFAULT CHARACTER SET utf8mb4` (El idioma y los símbolos)**
  Le dice a la base de datos qué diccionario de letras puede usar. `utf8mb4` es el estándar actual porque permite guardar **cualquier carácter sin que salgan símbolos raros**: acepta tildes (`á, é, í, ó, ú`), la letra `ñ`, la `ç` e incluso emojis.

* **`DEFAULT COLLATE utf8mb4_general_ci` (Cómo ordenar y buscar textos)**
  Define las reglas para comparar palabras y ordenarlas alfabéticamente. Las letras **`_ci`** del final significan *Case Insensitive* (insensible a mayúsculas y minúsculas). Es decir, para MySQL será lo mismo buscar `"Juan"`, `"juan"` o `"JUAN"`.

* **`DEFAULT ENCRYPTION = 'N'` (Cifrado de archivos)**
  Indica si queremos que los archivos internos de la base de datos se guarden encriptados en el disco duro. `'N'` (*No*) lo deja desactivado (lo normal en clase y desarrollo), mientras que `'Y'` (*Yes*) lo activa.

---

## 2. Opciones al crear una Tabla (`CREATE TABLE`)

```sql
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
```

* **`ENGINE=InnoDB` (El motor de la tabla)**
  Es el "motor" interno que hace funcionar la tabla. En bases de datos relacionales siempre se usa **`InnoDB`** porque es el que permite **relacionar tablas entre sí** usando claves foráneas (`FOREIGN KEY` con `ON UPDATE` y `ON DELETE`) y protege los datos si ocurre un fallo.

* **`DEFAULT CHARSET=utf8mb4` (Juego de caracteres de la tabla)**
  Es exactamente lo mismo que `CHARACTER SET utf8mb4`, pero escrito de forma abreviada para esa tabla en concreto: asegura que todas las columnas de texto de esa tabla acepten tildes, eñes y símbolos especiales.

* **`COLLATE=utf8mb4_general_ci` (Regla de ordenación de la tabla)**
  Aplica la misma regla a la tabla para que al ordenar o buscar textos no distinga entre mayúsculas y minúsculas (`_ci`).

---

## Resumen rápido para recordar

| Instrucción | ¿Para qué sirve en pocas palabras? |
| :--- | :--- |
| **`utf8mb4`** | Para poder escribir `ñ`, tildes, `ç` y emojis sin errores. |
| **`utf8mb4_general_ci`** | Para ordenar bien en nuestro idioma y que `"A"` sea igual que `"a"`. |
| **`ENCRYPTION = 'N'`** | Para indicar que no ciframos el disco (`'N'` = No). |
| **`ENGINE=InnoDB`** | Para poder usar relaciones (`FOREIGN KEY`) entre tablas. |