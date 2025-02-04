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