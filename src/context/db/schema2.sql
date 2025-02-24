-- Añadimos ON UPDATE CASCADE a todas las claves foráneas relevantes
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

-- Tabla pedido con actualización en cascada
CREATE TABLE IF NOT EXISTS "pedido" (
    id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    precioTotal DECIMAL(10,2) NOT NULL,
    user_nombre VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_nombre, user_email) 
        REFERENCES "user"(nombre, email) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE  -- Añadido para actualizaciones
);

-- Tabla cafe con doble cascada
CREATE TABLE IF NOT EXISTS "cafe" (
    nombre VARCHAR(255) NOT NULL,
    origen VARCHAR(255) NOT NULL,
    tueste VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    precio DECIMAL(7,2) NOT NULL,
    peso INT NOT NULL,
    PRIMARY KEY (nombre, origen, tueste, tienda_nombre, tienda_email),
    FOREIGN KEY (tienda_nombre, tienda_email) 
        REFERENCES "tienda"(nombre, email) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE  -- Añadido para actualizaciones de tienda
);

-- Tabla carrito con cascada completa
CREATE TABLE IF NOT EXISTS "carrito" (
    user_nombre VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    cafe_nombre VARCHAR(255) NOT NULL,
    cafe_origen VARCHAR(255) NOT NULL,
    cafe_tueste VARCHAR(255) NOT NULL,
    cafe_tienda_nombre VARCHAR(255) NOT NULL,
    cafe_tienda_email VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (
        user_nombre, 
        user_email, 
        cafe_nombre, 
        cafe_origen, 
        cafe_tueste, 
        cafe_tienda_nombre, 
        cafe_tienda_email
    ),
    FOREIGN KEY (user_nombre, user_email) 
        REFERENCES "user"(nombre, email) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email) 
        REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre, tienda_email) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Tabla pedido_cafe actualizada
CREATE TABLE IF NOT EXISTS "pedido_cafe" (
    id_pedido INT NOT NULL,
    cafe_nombre VARCHAR(255) NOT NULL,
    cafe_origen VARCHAR(255) NOT NULL,
    cafe_tueste VARCHAR(255) NOT NULL,
    cafe_tienda_nombre VARCHAR(255) NOT NULL,
    cafe_tienda_email VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (
        id_pedido, 
        cafe_nombre, 
        cafe_origen, 
        cafe_tueste, 
        cafe_tienda_nombre, 
        cafe_tienda_email
    ),
    FOREIGN KEY (id_pedido) 
        REFERENCES "pedido"(id) 
        ON DELETE CASCADE,
    FOREIGN KEY (cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email) 
        REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre, tienda_email) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Tabla valoracion mejorada
CREATE TABLE IF NOT EXISTS "valoracion" (
    user_nombre VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    cafe_nombre VARCHAR(255) NOT NULL,
    cafe_origen VARCHAR(255) NOT NULL,
    cafe_tueste VARCHAR(255) NOT NULL,
    cafe_tienda_nombre VARCHAR(255) NOT NULL,
    cafe_tienda_email VARCHAR(255) NOT NULL,
    valoracion INT NOT NULL,
    PRIMARY KEY (
        user_nombre, 
        user_email, 
        cafe_nombre, 
        cafe_origen, 
        cafe_tueste,
        cafe_tienda_nombre, 
        cafe_tienda_email
    ),
    FOREIGN KEY (user_nombre, user_email) 
        REFERENCES "user"(nombre, email) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email) 
        REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre, tienda_email) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);