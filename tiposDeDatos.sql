/*
===========================================
 TIPOS DE DATOS MySQL (con tamaño)
===========================================

--- NUMÉRICOS ENTEROS ---
TINYINT        -> 1 byte   (-128 a 127)
SMALLINT       -> 2 bytes  (-32,768 a 32,767)
MEDIUMINT      -> 3 bytes  (-8,388,608 a 8,388,607)
INT / INTEGER  -> 4 bytes  (-2,147,483,648 a 2,147,483,647)
BIGINT         -> 8 bytes  (-9.22e18 a 9.22e18)

--- NUMÉRICOS DECIMALES ---
DECIMAL(p,s) / NUMERIC(p,s) -> Variable (precisión exacta)
FLOAT          -> 4 bytes
DOUBLE         -> 8 bytes

--- TEXTO ---
CHAR(n)        -> n bytes (longitud fija)
VARCHAR(n)     -> n bytes (longitud variable)
TINYTEXT       -> 255 bytes
TEXT           -> 65,535 bytes (~64 KB)
MEDIUMTEXT     -> 16,777,215 bytes (~16 MB)
LONGTEXT       -> 4,294,967,295 bytes (~4 GB)

--- FECHA Y HORA ---
DATE           -> 3 bytes
TIME           -> 3 bytes
DATETIME       -> 8 bytes
TIMESTAMP      -> 4 bytes
YEAR           -> 1 byte

--- BOOLEANOS ---
BOOLEAN / BOOL -> 1 byte (internamente TINYINT(1))
BIT(n)         -> n bits

--- BINARIOS ---
BINARY(n)      -> n bytes
VARBINARY(n)   -> n bytes
TINYBLOB       -> 255 bytes
BLOB           -> 65,535 bytes (~64 KB)
MEDIUMBLOB     -> 16,777,215 bytes (~16 MB)
LONGBLOB       -> 4,294,967,295 bytes (~4 GB)

--- ENUM Y SET ---
ENUM           -> 1 o 2 bytes (según cantidad de valores)
SET            -> 1 a 8 bytes

--- JSON ---
JSON           -> Variable (formato binario optimizado)

--- NOTAS ---
* El tamaño real puede variar según charset (utf8, utf8mb4, etc.)
* VARCHAR usa 1–2 bytes extra para almacenar la longitud
* TIMESTAMP depende de la configuración de zona horaria
===========================================
*/