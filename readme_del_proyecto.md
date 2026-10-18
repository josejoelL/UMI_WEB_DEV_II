# UMI_WEB_DEV_II

Proyecto web enfocado en el aprendizaje y aplicación de desarrollo web *Full-Stack* (Frontend y Backend). El objetivo principal es construir una plataforma de **E-commerce**, centrada principalmente en la lógica y gestión de un **carrito de compras**.

## 🛒 Descripción del Proyecto

El sistema administra un catálogo de productos orientados a la categoría de maternidad y bebés, estructurados con sus respectivas marcas y categorías. 

### Características principales:
* **Control de Inventario:** Gestión de productos con atributos como precio, categoría, marca y control de stock disponible en tienda.
* **Gestión de Carrito:** Seguimiento de órdenes mediante folios de venta, desglose de subtotales y totales, y manejo de estados (*Completado*, *Pendiente*, *Cancelado*).

---

## 🛠️ Estructura del Desarrollo

El desarrollo del proyecto está estructurado en tres etapas:

1. **Parte 1: Base de Datos** (Modelado relacional, scripts DDL/DML y consultas analíticas en PostgreSQL).
2. **Parte 2: Backend** *(En desarrollo)*
3. **Parte 3: Frontend** *(En desarrollo)*

---

## 🗄️ Parte 1: Base de Datos (PostgreSQL)

### 1. Creación de Tablas (DDL) y Relaciones

> **Nota:** En PostgreSQL se utiliza `INT GENERATED ALWAYS AS IDENTITY` como estándar para claves primarias autoincrementables.

```sql
-- ============================================================
-- 1. CREACIÓN DE LAS TABLAS
-- ============================================================

-- Tabla Categorías
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

-- Tabla Carrito (Cabecera de la venta)
CREATE TABLE Carrito (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    folioVenta VARCHAR(50) NOT NULL,
    totalCompra NUMERIC(10, 2) NOT NULL,
    estatus VARCHAR(50) NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla CarritoDetalles (Detalle de artículos por venta)
CREATE TABLE CarritoDetalles (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    idCarrito INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal NUMERIC(10, 2) NOT NULL
);

-- ============================================================
-- 2. RELACIONES Y LLAVES FORÁNEAS
-- ============================================================

-- Relación: Productos -> Categorías
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
```

---

### 2. Inserción de Datos (DML)

```sql
-- 1. Inserciones en Categorías
INSERT INTO Categorias (descripcion) VALUES
('Ropa'),
('Higiene'),
('Cocina'),
('Artículos de hogar'),
('Bebés');

-- 2. Inserciones en Marcas
INSERT INTO Marcas (descripcion) VALUES
('Maternity Line'),
('Avent'),
('Chicco'),
('Mustela'),
('Boppy');

-- 3. Inserciones en Productos
INSERT INTO Productos (descripcion, precio, cantidad, idCategoria, idMarca) VALUES
('Vestido de Maternidad Casual', 899.00, 20, 1, 1),
('Crema Anti-Estrías para Embarazo', 450.00, 35, 2, 4),
('Extractor de Leche Eléctrico', 2199.00, 12, 3, 2),
('Cojín / Almohada de Lactancia Ergonómica', 799.00, 15, 4, 5),
('Cuna Colecho Ajustable', 3499.00, 8, 5, 3);

-- 4. Inserciones en Carrito
INSERT INTO Carrito (folioVenta, totalCompra, estatus, fecha) VALUES
('FOL-2026-001', 899.00, 'Completado', '2026-10-15 10:30:00'),
('FOL-2026-002', 1249.00, 'Completado', '2026-10-15 11:15:00'),
('FOL-2026-003', 2199.00, 'Pendiente', '2026-10-16 14:00:00'),
('FOL-2026-004', 900.00, 'Completado', '2026-10-16 16:45:00'),
('FOL-2026-005', 3499.00, 'Cancelado', '2026-10-17 09:20:00');

-- 5. Inserciones en CarritoDetalles
INSERT INTO CarritoDetalles (idCarrito, idProducto, cantidad, subtotal) VALUES
(1, 1, 1, 899.00),
(2, 2, 1, 450.00),
(2, 4, 1, 799.00),
(3, 3, 1, 2199.00),
(4, 2, 2, 900.00);
```

---

### 3. Consultas y Reportes (DQL)

#### Consulta 1: Listado único de categorías
```sql
SELECT DISTINCT descripcion 
FROM Categorias;
```

#### Consulta 2: Total de ventas agrupadas por fecha y estatus
```sql
SELECT
    fecha::date AS fecha,
    estatus,
    SUM(totalCompra) AS total
FROM Carrito
GROUP BY fecha::date, estatus
ORDER BY fecha, estatus;
```

#### Consulta 3: Inventario de productos con Categoría y Marca
```sql
SELECT 
    c.descripcion AS categoria,
    p.descripcion AS producto,
    m.descripcion AS marca,
    p.precio, 
    p.cantidad AS stock
FROM Productos p
INNER JOIN Marcas m ON p.idMarca = m.id
INNER JOIN Categorias c ON p.idCategoria = c.id;
```

#### Consulta 4: Detalle general de compras realizadas
```sql
SELECT 
    b.fecha::date AS fecha,
    b.folioVenta, 
    b.estatus, 
    d.descripcion AS categoria,
    c.descripcion AS marca,
    p.descripcion AS producto,
    a.cantidad,
    a.subtotal,
    b.totalCompra
FROM CarritoDetalles a
INNER JOIN Carrito b ON a.idCarrito = b.id
INNER JOIN Productos p ON a.idProducto = p.id
INNER JOIN Marcas c ON p.idMarca = c.id
INNER JOIN Categorias d ON p.idCategoria = d.id;
```