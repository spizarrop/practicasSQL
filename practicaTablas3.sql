-- =========================================================
-- BLOQUE 1: CREACIÓN DE TABLAS
-- =========================================================

-- Ejercicio 1:
-- Crea una tabla llamada "clientes" con:
-- id_cliente: entero grande, clave primaria, autoincremental
-- nombre: texto de máximo 100 caracteres, obligatorio
-- apellidos: texto de máximo 100 caracteres, obligatorio
-- dni: texto de 9 caracteres, obligatorio y único
-- saldo: número decimal con 2 decimales, valor por defecto 0
-- fecha_registro: fecha y hora, valor por defecto la fecha actual

CREATE TABLE clientes (
    id_cliente BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(9) NOT NULL UNIQUE,
    saldo DECIMAL(10,2) DEFAULT 0,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Ejercicio 2:
-- Crea una tabla llamada "productos" con:
-- id_producto: entero, clave primaria, autoincremental
-- nombre: texto de máximo 100 caracteres, obligatorio
-- descripcion: texto largo
-- precio: número decimal con 2 decimales
-- stock: entero sin signo
-- activo: valor lógico, por defecto verdadero

CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2),
    stock INT UNSIGNED,
    activo BIT
);

-- =========================================================
-- BLOQUE 2: MODIFICACIÓN DE TABLAS
-- =========================================================

-- Ejercicio 3:
-- A la tabla "clientes", agrega:
-- telefono: texto de máximo 15 caracteres
-- email: texto de máximo 100 caracteres, único y obligatorio

ALTER TABLE clientes
ADD COLUMN telefono VARCHAR(15),
ADD COLUMN email VARCHAR(100) NOT NULL UNIQUE;

-- Ejercicio 4:
-- En la tabla "clientes":
-- cambia el tamaño del campo "apellidos" a 150 caracteres
-- haz que el campo "saldo" no permita valores nulos

ALTER TABLE clientes
MODIFY apellidos VARCHAR(150),
MODIFY saldo DECIMAL(10,2) NOT NULL;

-- =========================================================
-- BLOQUE 3: ELIMINACIÓN Y RESTRICCIONES
-- =========================================================

-- Ejercicio 5:
-- Elimina la columna "descripcion" de la tabla "productos"

ALTER TABLE productos
DROP COLUMN descripcion;

-- Ejercicio 6:
-- Vacía todos los datos de la tabla "productos"
-- sin eliminar su estructura

TRUNCATE TABLE productos;

-- =========================================================
-- BLOQUE 4: CLAVES FORÁNEAS Y RELACIONES
-- =========================================================

-- Ejercicio 7:
-- Crea una tabla "pedidos" con:
-- id_pedido: clave primaria, autoincremental
-- id_cliente: clave foránea que referencia a clientes
-- fecha_pedido: fecha
-- total: número decimal con 2 decimales

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha_pedido DATE,
    total DECIMAL(10,2),
    CONSTRAINT fk_idCliente
    FOREIGN KEY (id_cliente)
    REFERENCES  clientes(id_cliente)
);

-- Ejercicio 8:
-- Configura la clave foránea de "pedidos" para que:
-- si se elimina un cliente, se eliminen sus pedidos
-- si se actualiza el id del cliente, se actualice en pedidos

ALTER TABLE pedidos
DROP FOREIGN KEY fk_idCliente;

ALTER TABLE pedidos
ADD CONSTRAINT fk_idCliente
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- =========================================================
-- BLOQUE 5: ÍNDICES
-- =========================================================

-- Ejercicio 9:
-- Crea un índice sobre el campo "nombre" de la tabla "clientes"

CREATE INDEX iNombre ON clientes(nombre);

-- Ejercicio 10:
-- Crea un índice único sobre el campo "dni" de la tabla "clientes"

CREATE UNIQUE INDEX iDni ON clientes(dni);

-- Ejercicio 11:
-- Crea un índice compuesto en la tabla "pedidos" usando:
-- id_cliente y fecha_pedido

CREATE INDEX iClienteFechaPedido ON pedidos(id_cliente, fecha_pedido);

-- =========================================================
-- BLOQUE 6: CAMBIOS DE NOMBRE
-- =========================================================

-- Ejercicio 12:
-- Renombra la tabla "clientes" a "usuarios"

RENAME TABLE clientes TO usuarios;

-- Ejercicio 13:
-- En la tabla "usuarios":
-- renombra la columna "fecha_registro" a "created_at"

ALTER TABLE usuarios
CHANGE fecha_registro created_at DATETIME;

-- =========================================================
-- BLOQUE 7: ANÁLISIS TEÓRICO
-- =========================================================

-- Ejercicio 14:
-- Explica con tus palabras:
-- 1) Diferencia entre INT, BIGINT y TINYINT y cuándo usarías cada uno
-- 2) Diferencia entre DATE y DATETIME y cuándo usarías cada uno
-- 3) Qué ventajas y riesgos tiene una clave primaria autoincremental
-- 4) Diferencia entre ON DELETE CASCADE y ON DELETE RESTRICT

-- 1) Diferencia entre INT, BIGINT y TINYINT y cuándo usarías cada uno:
-- INT: entero normal, ocupa 4 bytes, rango de -2,147,483,648 a 2,147,483,647. Se usa para IDs, contadores o cantidades medianas.
-- BIGINT: entero grande, ocupa 8 bytes, rango muy amplio (-9,223,372,036,854,775,808 a 9,223,372,036,854,775,807). Se usa para IDs en tablas muy grandes o contadores que pueden superar los límites de INT.
-- TINYINT: entero pequeño, ocupa 1 byte, rango -128 a 127 (o 0 a 255 si es UNSIGNED). Se usa para valores pequeños como edades, booleanos, flags.

-- 2) Diferencia entre DATE y DATETIME y cuándo usarías cada uno:
-- DATE: almacena solo la fecha (AAAA-MM-DD). Se usa cuando la hora no importa, por ejemplo fecha de nacimiento.
-- DATETIME: almacena fecha y hora (AAAA-MM-DD HH:MM:SS). Se usa para registros de eventos donde importa el momento exacto, por ejemplo fecha de registro o transacciones.

-- 3) Qué ventajas y riesgos tiene una clave primaria autoincremental:
-- Ventajas:
--   - Garantiza un identificador único automáticamente.
--   - Facilita inserciones rápidas sin calcular el ID manualmente.
--   - Útil para relaciones y claves foráneas.
-- Riesgos:
--   - Dependencia del orden de inserción, puede generar huecos si se eliminan filas.
--   - Problemas en replicación o migración si no se controla.
--   - No garantiza que el número tenga significado fuera de la base de datos.

-- 4) Diferencia entre ON DELETE CASCADE y ON DELETE RESTRICT:
-- ON DELETE CASCADE: si se elimina un registro en la tabla padre, se eliminan automáticamente todos los registros relacionados en la tabla hija.
-- ON DELETE RESTRICT: impide eliminar un registro en la tabla padre si tiene registros relacionados en la tabla hija. No borra nada automáticamente.