-- ============================================================
-- 1. CREACIÓN DE LAS TABLAS (SIN LLAVES FORÁNEAS INICIALES)
-- ============================================================


--En PostgreSQL se usa INT GENERATED ALWAYS AS IDENTITY, 
--que es el equivalente estándar del IDENTITY(1,1) de SQL Server.


-- Tabla Categorias
CREATE TABLE Categorias (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL
);

-- Tabla Marcas
CREATE TABLE Marcas (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL
);

-- Tabla Productos
CREATE TABLE Productos (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    precio NUMERIC(10, 2) NOT NULL,
    cantidad INT NOT NULL,
    idCategoria INT NOT NULL,
    idMarca INT NOT NULL
);

-- Tabla Carrito
CREATE TABLE Carrito (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    folioVenta VARCHAR(50) NOT NULL,
    totalCompra NUMERIC(10, 2) NOT NULL,
    estatus VARCHAR(50) NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla CarritoDetalles
CREATE TABLE CarritoDetalles (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    idCarrito INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal NUMERIC(10, 2) NOT NULL
);

-- ============================================================
-- 2. RELACIONES Y LLAVES FORÁNEAS (ADD CONSTRAINT)
-- ============================================================

-- Relación: Productos -> Categorias
ALTER TABLE Productos
    ADD CONSTRAINT fk_productos_categorias
    FOREIGN KEY (idCategoria) 
    REFERENCES Categorias (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

-- Relación: Productos -> Marcas
ALTER TABLE Productos
    ADD CONSTRAINT fk_productos_marcas
    FOREIGN KEY (idMarca) 
    REFERENCES Marcas (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

-- Relación: CarritoDetalles -> Carrito
ALTER TABLE CarritoDetalles
    ADD CONSTRAINT fk_carritodetalles_carrito
    FOREIGN KEY (idCarrito) 
    REFERENCES Carrito (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Relación: CarritoDetalles -> Productos
ALTER TABLE CarritoDetalles
    ADD CONSTRAINT fk_carritodetalles_productos
    FOREIGN KEY (idProducto) 
    REFERENCES Productos (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;



-- ============================================================
-- 1. INSERCIONES EN CATEGORIAS (Tus 5 categorías)
-- ============================================================
INSERT INTO Categorias (descripcion) VALUES
('Ropa'),
('Higene'),
('Cocina'),
('Articulos de hogar'),
('bebes');

-- ============================================================
-- 2. INSERCIONES EN MARCAS (Marcas especializadas)
-- ============================================================
INSERT INTO Marcas (descripcion) VALUES
('Maternity Line'),
('Avent'),
('Chicco'),
('Mustela'),
('Boppy');

-- ============================================================
-- 3. INSERCIONES EN PRODUCTOS (Artículos para embarazadas y bebés)
-- ============================================================
INSERT INTO Productos (descripcion, precio, cantidad, idCategoria, idMarca) VALUES
('Vestido de Maternidad Casual', 899.00, 20, 1, 1),           -- Ropa / Maternity Line
('Crema Anti-Estrías para Embarazo', 450.00, 35, 2, 4),        -- Higene / Mustela
('Extractor de Leche Eléctrico', 2199.00, 12, 3, 2),          -- Cocina / Avent
('Cojín / Almohada de Lactancia Ergonomica', 799.00, 15, 4, 5),-- Articulos de hogar / Boppy
('Mellizos / Cuna Colecho Ajustable', 3499.00, 8, 5, 3);       -- bebes / Chicco

-- ============================================================
-- 4. INSERCIONES EN CARRITO (5 folios de venta)
-- ============================================================
INSERT INTO Carrito (folioVenta, totalCompra, estatus, fecha) VALUES
('FOL-2026-001', 899.00, 'Completado', '2026-10-15 10:30:00'),
('FOL-2026-002', 1249.00, 'Completado', '2026-10-15 11:15:00'),
('FOL-2026-003', 2199.00, 'Pendiente', '2026-10-16 14:00:00'),
('FOL-2026-004', 900.00, 'Completado', '2026-10-16 16:45:00'),
('FOL-2026-005', 3499.00, 'Cancelado', '2026-10-17 09:20:00');

-- ============================================================
-- 5. INSERCIONES EN CARRITODETALLES (Detalles del carrito)
-- ============================================================
INSERT INTO CarritoDetalles (idCarrito, idProducto, cantidad, subtotal) VALUES
(1, 1, 1, 899.00),  -- 1 Vestido de Maternidad en Carrito 1
(2, 2, 1, 450.00),  -- 1 Crema Anti-Estrías en Carrito 2
(2, 4, 1, 799.00),  -- 1 Cojín de Lactancia en Carrito 2
(3, 3, 1, 2199.00), -- 1 Extractor de Leche en Carrito 3
(4, 2, 2, 900.00);  -- 2 Cremas Anti-Estrías en Carrito 4



--creacion de algunas consultas 


select distinct descripcion from Categorias

SELECT
fecha::date,
estatus,
sum(totalCompra) as total
FROM Carrito
group by 1,2
order by 1,2


select 
c.descripcion as categoria,
p.descripcion as producto,
m.descripcion as marca,
precio, cantidad
FROM Productos p
INNER JOIN Marcas m
on p.id = m.id
INNER JOIN Categorias c
on p.id = c.id



select 
c.descripcion as categoria,
p.descripcion as producto,
m.descripcion as marca,
precio, cantidad
FROM Productos p
INNER JOIN Marcas m
on p.id = m.id
INNER JOIN Categorias c
on p.id = c.id



select 
b.fecha::date,
b.folioVenta, 
b.estatus, 
d.descripcion as categoria,
c.descripcion as marca,
p.descripcion as producto,
b.totalCompra
from CarritoDetalles a
inner join Carrito b on a.idCarrito = b.id
INNER JOIN Productos p on a.idProducto = b.id
INNER JOIN Marcas c on p.id = c.id
INNER JOIN Categorias d on p.id = d.id




