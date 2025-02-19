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
z
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


---------------------------------
--ChatGPT database:
CREATE TABLE IF NOT EXISTS "usuario" (
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
    usuario_nombre VARCHAR(255) NOT NULL,
    usuario_email VARCHAR(255) NOT NULL,
    FOREIGN KEY (usuario_nombre, usuario_email) REFERENCES "usuario"(nombre, email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "cafe" (
    nombre VARCHAR(255) NOT NULL,
    origen VARCHAR(255) NOT NULL,
    tueste VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    precio DECIMAL(7,2) NOT NULL,
    peso INT NOT NULL,
    PRIMARY KEY (nombre, origen, tueste, tienda_nombre, tienda_email),
    FOREIGN KEY (tienda_nombre, tienda_email) REFERENCES "tienda"(nombre, email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "carrito" (
    usuario_nombre VARCHAR(255) NOT NULL,
    usuario_email VARCHAR(255) NOT NULL,
    nombre_cafe VARCHAR(255) NOT NULL,
    origen_cafe VARCHAR(255) NOT NULL,
    tueste_cafe VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (usuario_nombre, usuario_email, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre, tienda_email),
    FOREIGN KEY (usuario_nombre, usuario_email) REFERENCES "usuario"(nombre, email) ON DELETE CASCADE,
    FOREIGN KEY (nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre, tienda_email) 
        REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre, tienda_email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "pedido_cafe" (
    id_pedido INT NOT NULL,
    nombre_cafe VARCHAR(255) NOT NULL,
    origen_cafe VARCHAR(255) NOT NULL,
    tueste_cafe VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_pedido, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre, tienda_email),
    FOREIGN KEY (id_pedido) REFERENCES "pedido"(id) ON DELETE CASCADE,
    FOREIGN KEY (nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre, tienda_email)
        REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre, tienda_email) ON DELETE CASCADE
);  

CREATE TABLE IF NOT EXISTS "valoracion" (
    usuario_nombre VARCHAR(255) NOT NULL,
    usuario_email VARCHAR(255) NOT NULL,
    nombre_cafe VARCHAR(255) NOT NULL,
    origen_cafe VARCHAR(255) NOT NULL,
    tueste_cafe VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    valoracion INT NOT NULL,
    PRIMARY KEY (usuario_nombre, usuario_email, nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre, tienda_email),
    FOREIGN KEY (usuario_nombre, usuario_email) REFERENCES "usuario"(nombre, email) ON DELETE CASCADE,
    FOREIGN KEY (nombre_cafe, origen_cafe, tueste_cafe, tienda_nombre, tienda_email)
        REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre, tienda_email) ON DELETE CASCADE
);

--DeepSeek database

-- Tablas principales
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

-- Tabla pedido (sin cambios)
CREATE TABLE IF NOT EXISTS "pedido" (
    id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    precioTotal DECIMAL(10,2) NOT NULL,
    user_nombre VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_nombre, user_email) REFERENCES "user"(nombre, email) ON DELETE CASCADE
);

-- Tabla cafe CORREGIDA (clave primaria incluye tienda_email)
CREATE TABLE IF NOT EXISTS "cafe" (
    nombre VARCHAR(255) NOT NULL,
    origen VARCHAR(255) NOT NULL,
    tueste VARCHAR(255) NOT NULL,
    tienda_nombre VARCHAR(255) NOT NULL,
    tienda_email VARCHAR(255) NOT NULL,
    precio DECIMAL(7,2) NOT NULL,
    peso INT NOT NULL,
    PRIMARY KEY (nombre, origen, tueste, tienda_nombre, tienda_email), -- Se añade tienda_email
    FOREIGN KEY (tienda_nombre, tienda_email) REFERENCES "tienda"(nombre, email) ON DELETE CASCADE
);

-- Tabla carrito CORREGIDA (claves foráneas alineadas)
CREATE TABLE IF NOT EXISTS "carrito" (
    user_nombre VARCHAR(255) NOT NULL,       -- Nombre más claro
    user_email VARCHAR(255) NOT NULL,         -- Nombre más claro
    cafe_nombre VARCHAR(255) NOT NULL,        -- Nombre más claro
    cafe_origen VARCHAR(255) NOT NULL,        -- Nombre más claro
    cafe_tueste VARCHAR(255) NOT NULL,        -- Nombre más claro
    cafe_tienda_nombre VARCHAR(255) NOT NULL, -- Nombre más claro
    cafe_tienda_email VARCHAR(255) NOT NULL,  -- Nombre más claro
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
    FOREIGN KEY (user_nombre, user_email) REFERENCES "user"(nombre, email) ON DELETE CASCADE,
    FOREIGN KEY (cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email) 
        REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre, tienda_email) ON DELETE CASCADE
);

-- Tabla pedido_cafe CORREGIDA
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
    FOREIGN KEY (id_pedido) REFERENCES "pedido"(id) ON DELETE CASCADE,
    FOREIGN KEY (cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email) 
        REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre, tienda_email) ON DELETE CASCADE
);

-- Tabla valoracion CORREGIDA
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
    FOREIGN KEY (user_nombre, user_email) REFERENCES "user"(nombre, email) ON DELETE CASCADE,
    FOREIGN KEY (cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email) 
        REFERENCES "cafe"(nombre, origen, tueste, tienda_nombre, tienda_email) ON DELETE CASCADE
);

INSERT INTO "tienda" (nombre, email, password, domicilio) VALUES
('Tienda1', 'tienda1@example.com', 'pass1', 'Calle Falsa 123'),
('Tienda2', 'tienda2@example.com', 'pass2', 'Avenida Siempre Viva 742'),
('Tienda3', 'tienda3@example.com', 'pass3', 'Plaza Mayor 5'),
('Tienda4', 'tienda4@example.com', 'pass4', 'Camino Real 88'),
('Tienda5', 'tienda5@example.com', 'pass5', 'Boulevard de la Luz 101');

-- Cafés para 'Café Aroma' (17 cafés)
INSERT INTO "cafe" (nombre, origen, tueste, tienda_nombre, tienda_email, precio, peso) 
VALUES
  ('Café Especial Colombia', 'Colombia', 'Medio', 'Café Aroma', 'contacto@cafearoma.com', 12.50, 500),
  ('Blend Brasileño', 'Brasil', 'Oscuro', 'Café Aroma', 'contacto@cafearoma.com', 15.00, 250),
  ('Arabica Etiopía', 'Etiopía', 'Ligero', 'Café Aroma', 'contacto@cafearoma.com', 18.00, 1000),
  ('Costa Rica Tarrazú', 'Costa Rica', 'Medio', 'Café Aroma', 'contacto@cafearoma.com', 14.75, 500),
  ('Guatemala Antigua', 'Guatemala', 'Oscuro', 'Café Aroma', 'contacto@cafearoma.com', 16.90, 750),
  ('Java Blue Mountain', 'Indonesia', 'Ligero', 'Café Aroma', 'contacto@cafearoma.com', 22.00, 250),
  ('Perú Chanchamayo', 'Perú', 'Medio', 'Café Aroma', 'contacto@cafearoma.com', 11.50, 500),
  ('Honduras SHG', 'Honduras', 'Oscuro', 'Café Aroma', 'contacto@cafearoma.com', 13.25, 1000),
  ('Kenia AA', 'Kenia', 'Ligero', 'Café Aroma', 'contacto@cafearoma.com', 19.99, 500),
  ('Nicaragua Maragogype', 'Nicaragua', 'Medio', 'Café Aroma', 'contacto@cafearoma.com', 17.50, 750),
  ('México Altura', 'México', 'Oscuro', 'Café Aroma', 'contacto@cafearoma.com', 12.99, 500),
  ('India Monsoon', 'India', 'Ligero', 'Café Aroma', 'contacto@cafearoma.com', 20.50, 250),
  ('El Salvador Bourbon', 'El Salvador', 'Medio', 'Café Aroma', 'contacto@cafearoma.com', 14.20, 1000),
  ('Tanzania Peaberry', 'Tanzania', 'Oscuro', 'Café Aroma', 'contacto@cafearoma.com', 16.75, 500),
  ('Vietnam Robusta', 'Vietnam', 'Ligero', 'Café Aroma', 'contacto@cafearoma.com', 9.99, 750),
  ('Ecuador Galápagos', 'Ecuador', 'Medio', 'Café Aroma', 'contacto@cafearoma.com', 21.00, 500),
  ('Papúa Nueva Guinea', 'Papúa Nueva Guinea', 'Oscuro', 'Café Aroma', 'contacto@cafearoma.com', 18.50, 250);

-- Cafés para 'Tostaduría Premium' (17 cafés)
INSERT INTO "cafe" (nombre, origen, tueste, tienda_nombre, tienda_email, precio, peso)
VALUES
  ('Premium Colombia Supremo', 'Colombia', 'Oscuro', 'Tostaduría Premium', 'info@tostaduriapremium.com', 24.50, 500),
  ('Brasil Santos', 'Brasil', 'Ligero', 'Tostaduría Premium', 'info@tostaduriapremium.com', 13.99, 750),
  ('Etiopía Yirgacheffe', 'Etiopía', 'Medio', 'Tostaduría Premium', 'info@tostaduriapremium.com', 27.00, 250),
  ('Costa Rica La Minita', 'Costa Rica', 'Oscuro', 'Tostaduría Premium', 'info@tostaduriapremium.com', 19.95, 500),
  ('Guatemala Huehuetenango', 'Guatemala', 'Ligero', 'Tostaduría Premium', 'info@tostaduriapremium.com', 23.75, 1000),
  ('Sumatra Mandheling', 'Indonesia', 'Medio', 'Tostaduría Premium', 'info@tostaduriapremium.com', 16.50, 750),
  ('Perú Organic', 'Perú', 'Oscuro', 'Tostaduría Premium', 'info@tostaduriapremium.com', 15.25, 500),
  ('Honduras Marcala', 'Honduras', 'Ligero', 'Tostaduría Premium', 'info@tostaduriapremium.com', 18.00, 250),
  ('Kenia AA Plus', 'Kenia', 'Medio', 'Tostaduría Premium', 'info@tostaduriapremium.com', 29.99, 500),
  ('Nicaragua Jinotega', 'Nicaragua', 'Oscuro', 'Tostaduría Premium', 'info@tostaduriapremium.com', 17.80, 1000),
  ('México Pluma', 'México', 'Ligero', 'Tostaduría Premium', 'info@tostaduriapremium.com', 14.50, 750),
  ('India Plantation A', 'India', 'Medio', 'Tostaduría Premium', 'info@tostaduriapremium.com', 22.25, 500),
  ('El Salvador Pacamara', 'El Salvador', 'Oscuro', 'Tostaduría Premium', 'info@tostaduriapremium.com', 20.00, 250),
  ('Tanzania Mbeya', 'Tanzania', 'Ligero', 'Tostaduría Premium', 'info@tostaduriapremium.com', 16.99, 500),
  ('Vietnam Dak Lak', 'Vietnam', 'Medio', 'Tostaduría Premium', 'info@tostaduriapremium.com', 12.75, 750),
  ('Ecuador Loja', 'Ecuador', 'Oscuro', 'Tostaduría Premium', 'info@tostaduriapremium.com', 19.50, 500),
  ('Hawaii Kona', 'Hawái', 'Ligero', 'Tostaduría Premium', 'info@tostaduriapremium.com', 45.00, 250);

-- Cafés para 'Granos Selectos' (16 cafés)
INSERT INTO "cafe" (nombre, origen, tueste, tienda_nombre, tienda_email, precio, peso)
VALUES
  ('Selecto Colombia Excelso', 'Colombia', 'Medio', 'Granos Selectos', 'ventas@granosselectos.com', 10.99, 500),
  ('Brasil Cerrado Mineiro', 'Brasil', 'Oscuro', 'Granos Selectos', 'ventas@granosselectos.com', 12.50, 750),
  ('Etiopía Sidamo', 'Etiopía', 'Ligero', 'Granos Selectos', 'ventas@granosselectos.com', 15.25, 250),
  ('Costa Rica Tres Ríos', 'Costa Rica', 'Medio', 'Granos Selectos', 'ventas@granosselectos.com', 13.75, 1000),
  ('Guatemala Atitlán', 'Guatemala', 'Oscuro', 'Granos Selectos', 'ventas@granosselectos.com', 14.99, 500),
  ('Java Jampit', 'Indonesia', 'Ligero', 'Granos Selectos', 'ventas@granosselectos.com', 18.50, 750),
  ('Perú Cajamarca', 'Perú', 'Medio', 'Granos Selectos', 'ventas@granosselectos.com', 11.25, 500),
  ('Honduras Copán', 'Honduras', 'Oscuro', 'Granos Selectos', 'ventas@granosselectos.com', 16.00, 250),
  ('Kenia AB', 'Kenia', 'Ligero', 'Granos Selectos', 'ventas@granosselectos.com', 21.99, 500),
  ('Nicaragua Segovia', 'Nicaragua', 'Medio', 'Granos Selectos', 'ventas@granosselectos.com', 14.50, 1000),
  ('México Chiapas', 'México', 'Oscuro', 'Granos Selectos', 'ventas@granosselectos.com', 12.75, 750),
  ('India Malabar', 'India', 'Ligero', 'Granos Selectos', 'ventas@granosselectos.com', 19.25, 500),
  ('El Salvador Santa Ana', 'El Salvador', 'Medio', 'Granos Selectos', 'ventas@granosselectos.com', 15.50, 250),
  ('Tanzania Kilimanjaro', 'Tanzania', 'Oscuro', 'Granos Selectos', 'ventas@granosselectos.com', 17.99, 500),
  ('Vietnam Arabica', 'Vietnam', 'Ligero', 'Granos Selectos', 'ventas@granosselectos.com', 10.50, 750),
  ('Ecuador Intag', 'Ecuador', 'Medio', 'Granos Selectos', 'ventas@granosselectos.com', 20.00, 500);