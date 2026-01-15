-- =========================================================
-- BLOQUE 1: CREACIÓN DE TABLAS
-- =========================================================

-- Ejercicio 1:
-- Crea una tabla llamada "usuarios" con los siguientes campos:
-- id_usuario: entero sin signo, clave primaria, autoincremental
-- username: texto de longitud fija de 20 caracteres, obligatorio y único
-- password_hash: binario de longitud fija 60
-- email: texto de máximo 120 caracteres, obligatorio
-- rol: enumerado con valores ('ADMIN', 'USER', 'MOD'), por defecto 'USER'
-- activo: booleano, por defecto verdadero
-- fecha_creacion: timestamp con valor por defecto la fecha y hora actual

CREATE TABLE usuarios (
    id_usuario INT UNSIGNED AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL UNIQUE,
    password_hash VARBINARY(60),
    email VARCHAR(120) NOT NULL,
    rol ENUM('ADMIN','USER','MOD') DEFAULT 'USER',
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario)
);

-- Ejercicio 2:
-- Crea una tabla llamada "perfiles" con:
-- id_perfil: entero pequeño sin signo, clave primaria, autoincremental
-- biografia: texto largo
-- foto: binario (imagen)
-- fecha_nacimiento: fecha
-- color_favorito: conjunto de valores ('ROJO','VERDE','AZUL','NEGRO','BLANCO')
-- id_usuario: entero sin signo, obligatorio

CREATE TABLE perfiles (
    id_perfil SMALLINT UNSIGNED AUTO_INCREMENT,
    biografia TEXT,
    foto BLOB, -- REVISAR ESTE TIPO DE DATO, ES UN BINARIO PARA IMAGENES
    fecha_nacimiento DATE,
    color_favorito SET('ROJO','VERDE','AZUL','NEGRO','BLANCO'),
    id_usuario INT UNSIGNED NOT NULL,
    CONSTRAINT pk_perfil PRIMARY KEY (id_perfil),
    CONSTRAINT fk_perfilUsuario FOREIGN KEY (id_usuario)
    REFERENCES usuarios(id_usuario)
);


-- =========================================================
-- BLOQUE 2: CLAVES FORÁNEAS Y RESTRICCIONES
-- =========================================================

-- Ejercicio 3:
-- Relaciona "perfiles" con "usuarios" usando una clave foránea:
-- al eliminar un usuario, su perfil debe eliminarse
-- al actualizar el id del usuario, debe actualizarse en perfiles

ALTER TABLE perfiles 
DROP FOREIGN KEY fk_perfilUsuario;

ALTER TABLE perfiles
ADD CONSTRAINT fk_perfilUsuario 
FOREIGN KEY (id_usuario)
REFERENCES usuarios(id_usuario)
ON UPDATE CASCADE
ON DELETE CASCADE;


-- Ejercicio 4:
-- Asegura que el campo "email" de la tabla "usuarios"
-- no permita valores duplicados usando una restricción adecuada

ALTER TABLE usuarios
MODIFY email VARCHAR(120) NOT NULL UNIQUE;



-- =========================================================
-- BLOQUE 3: MODIFICACIÓN DE TABLAS
-- =========================================================

-- Ejercicio 5:
-- En la tabla "usuarios":
-- cambia el tipo del campo "activo" para que use BIT
-- haz que el campo "email" no permita valores nulos

ALTER TABLE usuarios
MODIFY activo BIT(1),
modify email VARCHAR(120) NOT NULL;



-- Ejercicio 6:
-- En la tabla "perfiles":
-- cambia el tipo del campo "biografia" para permitir más contenido
-- elimina el campo "color_favorito"

ALTER TABLE perfiles
MODIFY biografia MEDIUMTEXT,
DROP COLUMN color_favorito;



-- =========================================================
-- BLOQUE 4: ÍNDICES
-- =========================================================

-- Ejercicio 7:
-- Crea un índice normal sobre el campo "email" de la tabla "usuarios"

CREATE INDEX i_email ON usuarios(email);


-- Ejercicio 8:
-- Crea un índice compuesto en la tabla "perfiles" usando:
-- id_usuario y fecha_nacimiento

CREATE INDEX i_usuarioFecha ON perfiles(id_usuario, fecha_nacimiento);



-- =========================================================
-- BLOQUE 5: ELIMINACIÓN Y CAMBIOS
-- =========================================================

-- Ejercicio 9:
-- Vacía todos los datos de la tabla "perfiles"
-- sin eliminar su estructura

TRUNCATE TABLE perfiles;



-- Ejercicio 10:
-- Renombra la tabla "usuarios" a "cuentas"

RENAME TABLE usuarios TO cuentas;



-- Ejercicio 11:
-- En la tabla "cuentas":
-- renombra la columna "fecha_creacion" a "created_at"
-- manteniendo su tipo de dato

ALTER TABLE cuentas
CHANGE fecha_creacion created_at TIMESTAMP;



-- =========================================================
-- BLOQUE 6: ANÁLISIS TEÓRICO (RESPONDER EN COMENTARIOS)
-- =========================================================

-- Ejercicio 12:
-- Explica con tus palabras:
-- 1) Diferencia entre CHAR y VARCHAR y cuándo usarías cada uno
-- 2) Diferencia entre TIMESTAMP y DATETIME
-- 3) Qué ventajas y desventajas tiene usar ENUM
-- 4) Para qué sirve un índice compuesto y cuándo NO se usaría

-- 1) CHAR tiene longitud fija y ocupa siempre el mismo espacio, por lo que es más eficiente
-- cuando los valores tienen siempre el mismo tamaño.
-- VARCHAR tiene longitud variable y ahorra espacio cuando los datos varían en tamaño.
-- 2) TIMESTAMP depende de la zona horaria y se actualiza automáticamente,
-- mientras que DATETIME no depende de la zona horaria y solo almacena fecha y hora.
-- 3) ENUM permite restringir los valores posibles de un campo,
-- ahorra espacio y mejora la integridad de los datos,
-- pero es poco flexible porque modificar los valores requiere alterar la tabla.
-- 4) Un índice compuesto sirve para optimizar búsquedas que usan varias columnas juntas.
-- No se utiliza si la consulta solo filtra por columnas que no respetan el orden del índice.
