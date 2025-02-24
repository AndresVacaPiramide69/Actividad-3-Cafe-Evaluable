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

-- 1. Insertar 10 usuarios únicos (PK: nombre + email)
INSERT INTO "user" (nombre, email, password, domicilio) VALUES
('Juan Perez', 'juan.perez@example.com', 'pass123', 'Calle Falsa 123'),
('Maria Gomez', 'maria.gomez@example.com', 'pass123', 'Avenida 456'),
('Carlos Lopez', 'carlos.lopez@example.com', 'pass123', 'Calle Luna 789'),
('Ana Martinez', 'ana.martinez@example.com', 'pass123', 'Calle Sol 321'),
('Luis Rodriguez', 'luis.rod@example.com', 'pass123', 'Calle Estrella 654'),
('Sofia Fernandez', 'sofia.fer@example.com', 'pass123', 'Calle Marte 987'),
('Pedro Sanchez', 'pedro.san@example.com', 'pass123', 'Calle Jupiter 654'),
('Laura Diaz', 'laura.diaz@example.com', 'pass123', 'Calle Saturno 321'),
('Miguel Ruiz', 'miguel.ruiz@example.com', 'pass123', 'Calle Urano 789'),
('Elena Torres', 'elena.torres@example.com', 'pass123', 'Calle Neptuno 123');

-- 2. Insertar 10 tiendas únicas (PK: nombre + email)
INSERT INTO "tienda" (nombre, email, password, domicilio) VALUES
('Tienda Café A', 'tienda.a@example.com', 'pass123', 'Calle Comercio 1'),
('Tienda Café B', 'tienda.b@example.com', 'pass123', 'Calle Comercio 2'),
('Tienda Café C', 'tienda.c@example.com', 'pass123', 'Calle Comercio 3'),
('Tienda Café D', 'tienda.d@example.com', 'pass123', 'Calle Comercio 4'),
('Tienda Café E', 'tienda.e@example.com', 'pass123', 'Calle Comercio 5'),
('Tienda Café F', 'tienda.f@example.com', 'pass123', 'Calle Comercio 6'),
('Tienda Café G', 'tienda.g@example.com', 'pass123', 'Calle Comercio 7'),
('Tienda Café H', 'tienda.h@example.com', 'pass123', 'Calle Comercio 8'),
('Tienda Café I', 'tienda.i@example.com', 'pass123', 'Calle Comercio 9'),
('Tienda Café J', 'tienda.j@example.com', 'pass123', 'Calle Comercio 10');

-- 3. Insertar 10 cafés (cada uno asociado a una tienda existente)
INSERT INTO "cafe" (nombre, origen, tueste, tienda_nombre, tienda_email, precio, peso) VALUES
('Café Colombia', 'Colombia', 'Medio', 'Tienda Café A', 'tienda.a@example.com', 12.50, 250),
('Café Brasil', 'Brasil', 'Oscuro', 'Tienda Café B', 'tienda.b@example.com', 10.00, 500),
('Café Etiopía', 'Etiopía', 'Claro', 'Tienda Café C', 'tienda.c@example.com', 15.00, 250),
('Café Guatemala', 'Guatemala', 'Medio', 'Tienda Café D', 'tienda.d@example.com', 14.00, 500),
('Café Costa Rica', 'Costa Rica', 'Claro', 'Tienda Café E', 'tienda.e@example.com', 16.00, 250),
('Café Honduras', 'Honduras', 'Oscuro', 'Tienda Café F', 'tienda.f@example.com', 11.50, 500),
('Café México', 'México', 'Medio', 'Tienda Café G', 'tienda.g@example.com', 13.00, 250),
('Café Perú', 'Perú', 'Claro', 'Tienda Café H', 'tienda.h@example.com', 17.00, 500),
('Café Nicaragua', 'Nicaragua', 'Oscuro', 'Tienda Café I', 'tienda.i@example.com', 12.00, 250),
('Café Vietnam', 'Vietnam', 'Medio', 'Tienda Café J', 'tienda.j@example.com', 10.50, 500);

-- 4. Insertar 10 pedidos (asociados a usuarios existentes)
INSERT INTO "pedido" (fecha, precioTotal, user_nombre, user_email) VALUES
('2023-10-01', 25.00, 'Juan Perez', 'juan.perez@example.com'),
('2023-10-02', 30.00, 'Maria Gomez', 'maria.gomez@example.com'),
('2023-10-03', 15.00, 'Carlos Lopez', 'carlos.lopez@example.com'),
('2023-10-04', 20.00, 'Ana Martinez', 'ana.martinez@example.com'),
('2023-10-05', 18.00, 'Luis Rodriguez', 'luis.rod@example.com'),
('2023-10-06', 22.00, 'Sofia Fernandez', 'sofia.fer@example.com'),
('2023-10-07', 28.00, 'Pedro Sanchez', 'pedro.san@example.com'),
('2023-10-08', 35.00, 'Laura Diaz', 'laura.diaz@example.com'),
('2023-10-09', 40.00, 'Miguel Ruiz', 'miguel.ruiz@example.com'),
('2023-10-10', 45.00, 'Elena Torres', 'elena.torres@example.com');

-- 5. Insertar 10 items en carrito (asociados a usuarios y cafés existentes)
INSERT INTO "carrito" (user_nombre, user_email, cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email, cantidad) VALUES
('Juan Perez', 'juan.perez@example.com', 'Café Colombia', 'Colombia', 'Medio', 'Tienda Café A', 'tienda.a@example.com', 2),
('Maria Gomez', 'maria.gomez@example.com', 'Café Brasil', 'Brasil', 'Oscuro', 'Tienda Café B', 'tienda.b@example.com', 1),
('Carlos Lopez', 'carlos.lopez@example.com', 'Café Etiopía', 'Etiopía', 'Claro', 'Tienda Café C', 'tienda.c@example.com', 3),
('Ana Martinez', 'ana.martinez@example.com', 'Café Guatemala', 'Guatemala', 'Medio', 'Tienda Café D', 'tienda.d@example.com', 2),
('Luis Rodriguez', 'luis.rod@example.com', 'Café Costa Rica', 'Costa Rica', 'Claro', 'Tienda Café E', 'tienda.e@example.com', 1),
('Sofia Fernandez', 'sofia.fer@example.com', 'Café Honduras', 'Honduras', 'Oscuro', 'Tienda Café F', 'tienda.f@example.com', 4),
('Pedro Sanchez', 'pedro.san@example.com', 'Café México', 'México', 'Medio', 'Tienda Café G', 'tienda.g@example.com', 2),
('Laura Diaz', 'laura.diaz@example.com', 'Café Perú', 'Perú', 'Claro', 'Tienda Café H', 'tienda.h@example.com', 3),
('Miguel Ruiz', 'miguel.ruiz@example.com', 'Café Nicaragua', 'Nicaragua', 'Oscuro', 'Tienda Café I', 'tienda.i@example.com', 1),
('Elena Torres', 'elena.torres@example.com', 'Café Vietnam', 'Vietnam', 'Medio', 'Tienda Café J', 'tienda.j@example.com', 2);

-- 6. Insertar 10 relaciones pedido_cafe (asociadas a pedidos y cafés existentes)
INSERT INTO "pedido_cafe" (id_pedido, cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email, cantidad) VALUES
(1, 'Café Colombia', 'Colombia', 'Medio', 'Tienda Café A', 'tienda.a@example.com', 2),
(2, 'Café Brasil', 'Brasil', 'Oscuro', 'Tienda Café B', 'tienda.b@example.com', 1),
(3, 'Café Etiopía', 'Etiopía', 'Claro', 'Tienda Café C', 'tienda.c@example.com', 3),
(4, 'Café Guatemala', 'Guatemala', 'Medio', 'Tienda Café D', 'tienda.d@example.com', 2),
(5, 'Café Costa Rica', 'Costa Rica', 'Claro', 'Tienda Café E', 'tienda.e@example.com', 1),
(6, 'Café Honduras', 'Honduras', 'Oscuro', 'Tienda Café F', 'tienda.f@example.com', 4),
(7, 'Café México', 'México', 'Medio', 'Tienda Café G', 'tienda.g@example.com', 2),
(8, 'Café Perú', 'Perú', 'Claro', 'Tienda Café H', 'tienda.h@example.com', 3),
(9, 'Café Nicaragua', 'Nicaragua', 'Oscuro', 'Tienda Café I', 'tienda.i@example.com', 1),
(10, 'Café Vietnam', 'Vietnam', 'Medio', 'Tienda Café J', 'tienda.j@example.com', 2);

-- 7. Insertar 10 valoraciones (asociadas a usuarios y cafés existentes)
INSERT INTO "valoracion" (user_nombre, user_email, cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email, valoracion) VALUES
('Juan Perez', 'juan.perez@example.com', 'Café Colombia', 'Colombia', 'Medio', 'Tienda Café A', 'tienda.a@example.com', 5),
('Maria Gomez', 'maria.gomez@example.com', 'Café Brasil', 'Brasil', 'Oscuro', 'Tienda Café B', 'tienda.b@example.com', 4),
('Carlos Lopez', 'carlos.lopez@example.com', 'Café Etiopía', 'Etiopía', 'Claro', 'Tienda Café C', 'tienda.c@example.com', 5),
('Ana Martinez', 'ana.martinez@example.com', 'Café Guatemala', 'Guatemala', 'Medio', 'Tienda Café D', 'tienda.d@example.com', 3),
('Luis Rodriguez', 'luis.rod@example.com', 'Café Costa Rica', 'Costa Rica', 'Claro', 'Tienda Café E', 'tienda.e@example.com', 4),
('Sofia Fernandez', 'sofia.fer@example.com', 'Café Honduras', 'Honduras', 'Oscuro', 'Tienda Café F', 'tienda.f@example.com', 5),
('Pedro Sanchez', 'pedro.san@example.com', 'Café México', 'México', 'Medio', 'Tienda Café G', 'tienda.g@example.com', 4),
('Laura Diaz', 'laura.diaz@example.com', 'Café Perú', 'Perú', 'Claro', 'Tienda Café H', 'tienda.h@example.com', 5),
('Miguel Ruiz', 'miguel.ruiz@example.com', 'Café Nicaragua', 'Nicaragua', 'Oscuro', 'Tienda Café I', 'tienda.i@example.com', 3),
('Elena Torres', 'elena.torres@example.com', 'Café Vietnam', 'Vietnam', 'Medio', 'Tienda Café J', 'tienda.j@example.com', 4);