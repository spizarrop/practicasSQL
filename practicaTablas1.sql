-- =========================================================
-- BLOQUE 1: CREACIÓN DE TABLAS
-- =========================================================

-- Ejercicio 1:
-- Crea una tabla llamada "usuarios" con los siguientes campos:
-- id: entero, clave primaria, autoincremental
-- nombre: texto de máximo 50 caracteres, obligatorio
-- email: texto de máximo 100 caracteres, obligatorio y único
-- edad: entero, puede ser nulo
-- fecha_registro: fecha y hora

CREATE TABLE usuarios (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	edad TINYINT NULL,
	fecha_registro DATETIME
);

-- Ejercicio 2:
-- Crea una tabla llamada "productos" con:
-- id_producto: entero, clave primaria, autoincremental
-- nombre: texto de máximo 100 caracteres
-- precio: número decimal con 2 decimales
-- stock: entero sin signo
-- activo: valor booleano
-- fecha_creacion: fecha

CREATE TABLE productos (
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100),
	precio DECIMAL(10,2),
	stock INT UNSIGNED,
	activo BOOLEAN,
	fecha_creacion DATE
);

-- =========================================================
-- BLOQUE 2: MODIFICACIÓN DE TABLAS
-- =========================================================

-- Ejercicio 3:
-- A la tabla "usuarios", agrega las siguientes columnas:
-- telefono: texto de máximo 20 caracteres
-- pais: texto de máximo 50 caracteres

ALTER TABLE usuarios
ADD COLUMN telefono VARCHAR(20),
ADD COLUMN pais VARCHAR(50);

-- Ejercicio 4:
-- En la tabla "productos":
-- modifica el tamaño del campo "nombre" a 150 caracteres
-- haz que el campo "precio" no permita valores nulos

ALTER TABLE productos
MODIFY nombre VARCHAR(150),
MODIFY precio DECIMAL(10,2) NOT NULL;

-- Ejercicio 5:
-- Elimina la columna "telefono" de la tabla "usuarios"

ALTER TABLE usuarios
DROP COLUMN telefono;

-- =========================================================
-- BLOQUE 3: ELIMINACIÓN DE TABLAS Y DATOS
-- =========================================================

-- Ejercicio 6:
-- Elimina completamente la tabla "productos"
-- Luego vuelve a crearla con la misma estructura

DROP TABLE productos;
CREATE TABLE productos ();


-- Ejercicio 7:
-- Vacía todos los datos de la tabla "usuarios"
-- sin eliminar su estructura

TRUNCATE TABLE usuarios;

-- =========================================================
-- BLOQUE 4: CLAVES PRIMARIAS Y FORÁNEAS
-- =========================================================

-- Ejercicio 8:
-- Crea una tabla llamada "pedidos" con:
-- id_pedido: clave primaria
-- id_usuario: clave foránea que referencia al id de usuarios
-- fecha_pedido: fecha y hora
-- total: número decimal con 2 decimales

CREATE TABLE pedidos (
	id_pedido INT AUTO_INCREMENT PRIMARY KEY;
	id_usuario INT,
	fecha_pedido DATETIME,
	total DECIMAL(10,2),
	CONSTRAINT fk_idUsuario
		FOREIGN KEY (id_usuario)
		REFERENCES usuarios(id)
);

-- Ejercicio 9:
-- Configura la clave foránea entre pedidos y usuarios para que:
-- al eliminar un usuario, se eliminen automáticamente sus pedidos
-- al actualizar el id de un usuario, se actualice en pedidos

ALTER TABLE pedidos
DROP FOREIGN KEY fk_idUsuario;

ALTER TABLE pedidos
ADD CONSTRAINT fk_idUsuario
FOREIGN KEY (id_usuario)
REFERENCES usuarios(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- =========================================================
-- BLOQUE 5: ÍNDICES
-- =========================================================

-- Ejercicio 10:
-- Crea un índice sobre el campo "nombre" de la tabla "usuarios"

CREATE INDEX iNombre
ON usuarios(nombre);

-- Ejercicio 11:
-- Asegura que el campo "email" de la tabla "usuarios"
-- no permita valores repetidos usando un índice

CREATE UNIQUE INDEX iEmail
ON usuarios(email);

-- Ejercicio 12:
-- Crea un índice compuesto en la tabla "pedidos" usando:
-- id_usuario y fecha_pedido

CREATE INDEX iUsuarioPedido
ON pedidos(id_usuario, fecha_pedido);

-- =========================================================
-- BLOQUE 6: CAMBIOS DE NOMBRE
-- =========================================================

-- Ejercicio 13:
-- Renombra la tabla "usuarios" a "clientes"

RENAME TABLE usuarios TO clientes;

-- Ejercicio 14:
-- En la tabla "clientes":
-- renombra la columna "fecha_registro" a "created_at"

ALTER TABLE clientes
CHANGE fecha_registro created_at DATETIME;

-- =========================================================
-- BLOQUE 7: ANÁLISIS TEÓRICO (RESPONDER EN COMENTARIOS)
-- =========================================================

-- Ejercicio 15:
-- Explica con tus palabras:
-- 1) Diferencia entre eliminar una tabla y vaciar sus datos
-- 2) Cuándo usarías un entero normal y cuándo uno de mayor tamaño
-- 3) Por qué es importante indexar claves foráneas

-- 1) Diferencia entre eliminar una tabla y vaciar sus datos:
-- Al eliminar una tabla usando DROP TABLE se borra completamente la tabla,
-- incluyendo su estructura, sus datos, índices y restricciones.
-- En cambio, TRUNCATE TABLE elimina todos los registros de la tabla
-- pero mantiene la estructura, columnas e índices para seguir utilizándola.

-- 2) Cuándo usar un entero normal y cuándo uno de mayor tamaño:
-- Se usa un entero normal (INT) cuando los valores no van a ser muy grandes,
-- por ejemplo edades, cantidades pequeñas o identificadores comunes.
-- Se usa un entero de mayor tamaño (BIGINT) cuando se esperan valores muy grandes,
-- como IDs en tablas con millones de registros o contadores acumulativos.
-- Tipos más pequeños como TINYINT se usan cuando el rango de valores es muy limitado.

-- 3) Por qué es importante indexar claves foráneas:
-- Es importante indexar claves foráneas porque mejora el rendimiento
-- de las consultas que relacionan tablas, especialmente en JOINs.
-- Además, acelera las operaciones de borrado y actualización
-- cuando se usan reglas como ON DELETE CASCADE u ON UPDATE CASCADE.