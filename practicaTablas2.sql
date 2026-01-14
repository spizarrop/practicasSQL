-- =========================================================
-- BLOQUE 1: CREACIÓN DE TABLAS
-- =========================================================

-- Ejercicio 1:
-- Crea una tabla llamada "empleados" con los siguientes campos:
-- id_empleado: entero, clave primaria, autoincremental
-- nombre: texto de máximo 60 caracteres, obligatorio
-- apellido: texto de máximo 60 caracteres, obligatorio
-- dni: texto de 9 caracteres, obligatorio y único
-- salario: número decimal con 2 decimales, obligatorio
-- fecha_alta: fecha y hora

CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    dni VARCHAR(9) NOT NULL UNIQUE,
    salario DECIMAL(10,2) NOT NULL,
    fecha_alta DATETIME
);

-- Ejercicio 2:
-- Crea una tabla llamada "departamentos" con:
-- id_departamento: entero, clave primaria, autoincremental
-- nombre: texto de máximo 80 caracteres, obligatorio
-- presupuesto: número decimal con 2 decimales
-- activo: valor booleano

CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(80) NOT NULL,
    presupuesto DECIMAL(10,2),
    activo BOOLEAN
);


-- =========================================================
-- BLOQUE 2: MODIFICACIÓN DE TABLAS
-- =========================================================

-- Ejercicio 3:
-- A la tabla "empleados", agrega las siguientes columnas:
-- telefono: texto de máximo 20 caracteres
-- email: texto de máximo 100 caracteres, único

ALTER TABLE empleados
ADD COLUMN telefono VARCHAR(20),
ADD COLUMN email VARCHAR(100) UNIQUE;

-- Ejercicio 4:
-- En la tabla "empleados":
-- modifica el campo "salario" para que no permita valores nulos
-- cambia el tamaño del campo "apellido" a 100 caracteres

ALTER TABLE empleados
MODIFY salario DECIMAL(10,2) NOT NULL,
MODIFY apellido VARCHAR(100);

-- Ejercicio 5:
-- Elimina la columna "telefono" de la tabla "empleados"

ALTER TABLE empleados
DROP COLUMN telefono;

-- =========================================================
-- BLOQUE 3: ELIMINACIÓN DE TABLAS Y DATOS
-- =========================================================

-- Ejercicio 6:
-- Elimina completamente la tabla "departamentos"
-- Luego vuelve a crearla con la misma estructura

DROP TABLE departamentos;

CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(80) NOT NULL,
    presupuesto DECIMAL(10,2),
    activo BOOLEAN
);

-- Ejercicio 7:
-- Vacía todos los registros de la tabla "empleados"
-- sin eliminar su estructura

TRUNCATE TABLE empleados;

-- =========================================================
-- BLOQUE 4: CLAVES PRIMARIAS Y FORÁNEAS
-- =========================================================

-- Ejercicio 8:
-- Crea una tabla llamada "proyectos" con:
-- id_proyecto: clave primaria, autoincremental
-- nombre: texto de máximo 100 caracteres
-- id_departamento: clave foránea que referencia a departamentos
-- fecha_inicio: fecha
-- fecha_fin: fecha

CREATE TABLE proyectos (
    id_proyecto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    id_departamento INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    CONSTRAINT fk_departamento
    FOREIGN KEY (id_departamento)
    REFERENCES departamentos(id_departamento)
);

-- Ejercicio 9:
-- Configura la clave foránea entre proyectos y departamentos para que:
-- al eliminar un departamento se eliminen sus proyectos
-- al actualizar el id del departamento se actualice en proyectos

ALTER TABLE proyectos
DROP FOREIGN KEY fk_departamento;

ALTER TABLE proyectos
ADD CONSTRAINT fk_departamento
FOREIGN KEY (id_departamento)
REFERENCES departamentos(id_departamento)
ON DELETE CASCADE
ON UPDATE CASCADE;


-- =========================================================
-- BLOQUE 5: ÍNDICES
-- =========================================================

-- Ejercicio 10:
-- Crea un índice sobre el campo "apellido" de la tabla "empleados"

CREATE INDEX iApellido 
ON empleados(apellido);

-- Ejercicio 11:
-- Asegura que el campo "dni" de la tabla "empleados"
-- no permita valores repetidos usando un índice

CREATE UNIQUE INDEX iDni 
ON empleados(dni);

-- Ejercicio 12:
-- Crea un índice compuesto en la tabla "proyectos"
-- usando id_departamento y fecha_inicio

CREATE INDEX iDepartamentoFechaInicio
ON proyectos(id_departamento, fecha_inicio);

-- =========================================================
-- BLOQUE 6: CAMBIOS DE NOMBRE
-- =========================================================

-- Ejercicio 13:
-- Renombra la tabla "empleados" a "trabajadores"

RENAME TABLE empleados TO trabajadores;

-- Ejercicio 14:
-- En la tabla "trabajadores":
-- renombra la columna "fecha_alta" a "created_at"

ALTER TABLE trabajadores
CHANGE fecha_alta created_at DATETIME;

-- =========================================================
-- BLOQUE 7: ANÁLISIS TEÓRICO (RESPONDER EN COMENTARIOS)
-- =========================================================

-- Ejercicio 15:
-- Explica con tus palabras:
-- 1) Qué diferencia hay entre una clave primaria y una clave foránea
-- 2) Por qué no es recomendable usar VARCHAR para almacenar números
-- 3) Qué problemas puede causar no usar índices en tablas grandes

-- 1) Una clave primaria identifica de forma única cada registro
-- dentro de una tabla. Una clave foránea es un campo que referencia
-- la clave primaria de otra tabla para relacionarlas entre sí.

-- 2) No es recomendable usar VARCHAR para números porque impide
-- realizar operaciones matemáticas correctamente y empeora
-- el rendimiento y la validación de los datos.

-- 3) No usar índices en tablas grandes provoca consultas más lentas,
-- especialmente en búsquedas y JOINs, ya que la base de datos debe
-- recorrer muchos registros para obtener resultados.