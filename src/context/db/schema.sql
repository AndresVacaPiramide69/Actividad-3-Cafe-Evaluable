CREATE TABLE IF NOT EXISTS "user" (
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    domicilio VARCHAR(255),
    PRIMARY KEY (nombre, email)
);

CREATE TABLE IF NOT EXISTS "tienda" (
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    domicilio VARCHAR(255),
    PRIMARY KEY (nombre, email)
);

CREATE TABLE IF NOT EXISTS "pedido" (
    id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    precioTotal DECIMAL(10,2) NOT NULL,
    user_nombre VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_nombre, user_email) REFERENCES "user"(nombre, email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "cafe"(
    nombre VARCHAR(255) NOT NULL,
    origen VARCHAR(255) NOT NULL,
    tueste VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    precio DECIMAL(7,2) NOT NULL,
    peso INT NOT NULL,
    PRIMARY KEY (nombre, origen, tueste, tienda_nombre),
    FOREIGN KEY (tienda_nombre, tienda_email) REFERENCES "tienda"(nombre, email) ON DELETE CASCADE
)

CREATE TABLE IF NOT EXISTS "carrito"(
    nombre_usuario VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) NOT NULL,
    nombre_cafe VARCHAR(255) NOT NULL,
    origen_cafe VARCHAR(255) NOT NULL,
    tueste_cafe VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (nombre_usuario, email_usuario, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre),
    FOREIGN KEY (nombre_usuario, email_usuario) REFERENCES "user"(nombre, email) ON DELETE CASCADE,
    FOREIGN KEY (nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre) REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "pedido_cafe"(
    id_pedido INT NOT NULL,
    nombre_cafe VARCHAR(255) NOT NULL,
    origen_cafe VARCHAR(255) NOT NULL,
    tueste_cafe VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_pedido, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre),
    FOREIGN KEY (id_pedido) REFERENCES "pedido"(id) ON DELETE CASCADE,
    FOREIGN KEY (nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre) REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "valoracion"(
    nombre_usuario VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) NOT NULL,
    nombre_cafe VARCHAR(255) NOT NULL,
    origen_cafe VARCHAR(255) NOT NULL,
    tueste_cafe VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    valoracion INT NOT NULL,
    PRIMARY KEY (nombre_usuario, email_usuario, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre),
    FOREIGN KEY (nombre_usuario, email_usuario) REFERENCES "user"(nombre, email) ON DELETE CASCADE,
    FOREIGN KEY (nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre) REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre) ON DELETE CASCADE
);

SELECT * FROM valoracion;

---------------------------------

CREATE TABLE IF NOT EXISTS "user" (
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    domicilio VARCHAR(255),
    PRIMARY KEY (nombre, email)
);

CREATE TABLE IF NOT EXISTS "tienda" (
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    domicilio VARCHAR(255),
    PRIMARY KEY (nombre, email)
);

CREATE TABLE IF NOT EXISTS "pedido" (
    id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    precioTotal DECIMAL(10,2) NOT NULL,
    user_nombre VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_nombre, user_email) REFERENCES "user"(nombre, email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "cafe" (
    nombre VARCHAR(255) NOT NULL,
    origen VARCHAR(255) NOT NULL,
    tueste VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    precio DECIMAL(7,2) NOT NULL,
    peso INT NOT NULL,
    PRIMARY KEY (nombre, origen, tueste, tienda_nombre),
    FOREIGN KEY (tienda_nombre, tienda_email) REFERENCES "tienda"(nombre, email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "carrito" (
    nombre_usuario VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) NOT NULL,
    nombre_cafe VARCHAR(255) NOT NULL,
    origen_cafe VARCHAR(255) NOT NULL,
    tueste_cafe VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (nombre_usuario, email_usuario, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre),
    FOREIGN KEY (nombre_usuario, email_usuario) REFERENCES "user"(nombre, email) ON DELETE CASCADE,
    FOREIGN KEY (nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre) REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "pedido_cafe" (
    id_pedido INT NOT NULL,
    nombre_cafe VARCHAR(255) NOT NULL,
    origen_cafe VARCHAR(255) NOT NULL,
    tueste_cafe VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_pedido, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre),
    FOREIGN KEY (id_pedido) REFERENCES "pedido"(id) ON DELETE CASCADE,
    FOREIGN KEY (nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre) REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre) ON DELETE CASCADE
);  

CREATE TABLE IF NOT EXISTS "valoracion" (
    nombre_usuario VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) NOT NULL,
    nombre_cafe VARCHAR(255) NOT NULL,
    origen_cafe VARCHAR(255) NOT NULL,
    tueste_cafe VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    valoracion INT NOT NULL,
    PRIMARY KEY (nombre_usuario, email_usuario, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre),
    FOREIGN KEY (nombre_usuario, email_usuario) REFERENCES "user"(nombre, email) ON DELETE CASCADE,
    FOREIGN KEY (nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre) REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre) ON DELETE CASCADE
);

------------------------------------------
-- Datos para la tabla "user"
INSERT INTO "user" (nombre, email, password, domicilio) VALUES
('Alice', 'alice@example.com', 'passAlice', '123 Main St'),
('Bob', 'bob@example.com', 'passBob', '456 Oak Ave'),
('Charlie', 'charlie@example.com', 'passCharlie', '789 Pine Rd'),
('David', 'david@example.com', 'passDavid', '101 Maple Blvd'),
('Eva', 'eva@example.com', 'passEva', '202 Elm St');

-- Datos para la tabla "tienda"
INSERT INTO "tienda" (nombre, email, password, domicilio) VALUES
('TiendaOne', 'contact@tiendaone.com', 'storePass1', '111 Store St'),
('TiendaTwo', 'contact@tiendatwo.com', 'storePass2', '222 Market Ave'),
('TiendaThree', 'contact@tiendathree.com', 'storePass3', '333 Commerce Rd'),
('TiendaFour', 'contact@tiendafour.com', 'storePass4', '444 Retail Blvd'),
('TiendaFive', 'contact@tiendafive.com', 'storePass5', '555 Shopping Ln');

-- Datos para la tabla "cafe"
INSERT INTO "cafe" (nombre, origen, tueste, tienda_nombre, tienda_email, precio, peso) VALUES
('CafeExpresso', 'Colombia', 'Medio', 'TiendaOne', 'contact@tiendaone.com', 3.50, 250),
('CafeLatte', 'Brasil', 'Claro', 'TiendaTwo', 'contact@tiendatwo.com', 4.00, 300),
('CafeAmericano', 'Etiopia', 'Oscuro', 'TiendaThree', 'contact@tiendathree.com', 3.75, 200),
('CafeMocha', 'Costa Rica', 'Medio', 'TiendaFour', 'contact@tiendafour.com', 4.25, 250),
('CafeCapuchino', 'Guatemala', 'Claro', 'TiendaFive', 'contact@tiendafive.com', 4.50, 300);

-- Datos para la tabla "carrito"
INSERT INTO "carrito" (nombre_usuario, email_usuario, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre, tienda_email, cantidad) VALUES
('Alice', 'alice@example.com', 'CafeExpresso', 'Colombia', 'Medio', 'TiendaOne', 'contact@tiendaone.com', 2),
('Bob', 'bob@example.com', 'CafeLatte', 'Brasil', 'Claro', 'TiendaTwo', 'contact@tiendatwo.com', 1),
('Charlie', 'charlie@example.com', 'CafeAmericano', 'Etiopia', 'Oscuro', 'TiendaThree', 'contact@tiendathree.com', 3),
('David', 'david@example.com', 'CafeMocha', 'Costa Rica', 'Medio', 'TiendaFour', 'contact@tiendafour.com', 1),
('Eva', 'eva@example.com', 'CafeCapuchino', 'Guatemala', 'Claro', 'TiendaFive', 'contact@tiendafive.com', 2);

-- Datos para la tabla "valoracion"
INSERT INTO "valoracion" (nombre_usuario, email_usuario, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre, tienda_email, valoracion) VALUES
('Alice', 'alice@example.com', 'CafeExpresso', 'Colombia', 'Medio', 'TiendaOne', 'contact@tiendaone.com', 5),
('Bob', 'bob@example.com', 'CafeLatte', 'Brasil', 'Claro', 'TiendaTwo', 'contact@tiendatwo.com', 4),
('Charlie', 'charlie@example.com', 'CafeAmericano', 'Etiopia', 'Oscuro', 'TiendaThree', 'contact@tiendathree.com', 3),
('David', 'david@example.com', 'CafeMocha', 'Costa Rica', 'Medio', 'TiendaFour', 'contact@tiendafour.com', 4),
('Eva', 'eva@example.com', 'CafeCapuchino', 'Guatemala', 'Claro', 'TiendaFive', 'contact@tiendafive.com', 5);
