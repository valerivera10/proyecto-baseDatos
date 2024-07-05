CREATE DATABASE garden;
USE garden;

CREATE TABLE pago (
    codigo_cliente INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    forma_pago VARCHAR(40) NOT NULL,
    id_transaccion VARCHAR(50) NOT NULL,
    fecha_pago DATE NOT NULL,
    total DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);

CREATE TABLE oficina (
    codigo_oficina VARCHAR(10) NOT NULL,
    ciudad VARCHAR(30) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50) NOT NULL,
    PRIMARY KEY (codigo_oficina)
);

CREATE TABLE pedido (
    codigo_pedido INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    fecha_espera DATE NOT NULL,
    fecha_entrega DATE NOT NULL,
    estado VARCHAR(15) NOT NULL,
    comentarios TEXT NOT NULL,
    codigo_cliente INT NOT NULL,
    FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);

CREATE TABLE cliente (
    codigo_cliente INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(50) NOT NULL,
    nombre_contacto VARCHAR(30) NOT NULL,
    apellido_contacto VARCHAR(30) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    fax VARCHAR(15) NOT NULL,
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    codigo_empleado_rep_ventas INT NOT NULL,
    limite_credito DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado (codigo_empleado)
);

CREATE TABLE gama_producto (
    gama VARCHAR(50) NOT NULL,
    descripcion_texto TEXT NOT NULL,
    descripcion_html TEXT NOT NULL,
    imagen VARCHAR(256) NOT NULL,
    PRIMARY KEY (gama)
);

CREATE TABLE detalle_pedido (
    codigo_pedido INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    codigo_producto VARCHAR(15) NOT NULL,
    cantidad INT NOT NULL,
    precio_unidad DECIMAL(15, 2) NOT NULL,
    numero_linea SMALLINT NOT NULL,
    FOREIGN KEY (codigo_pedido) REFERENCES pedido (codigo_pedido),
    FOREIGN KEY (codigo_producto) REFERENCES producto (codigo_producto)
);

CREATE TABLE empleado (
    codigo_empleado INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NOT NULL,
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    codigo_oficina VARCHAR(10) NOT NULL,
    codigo_jefe INT NOT NULL,
    puesto VARCHAR(50) NOT NULL,
    FOREIGN KEY (codigo_oficina) REFERENCES oficina (codigo_oficina),
    FOREIGN KEY (codigo_jefe) REFERENCES empleado (codigo_empleado)
);

CREATE TABLE producto (
    codigo_producto VARCHAR(15) NOT NULL,
    nombre VARCHAR(70) NOT NULL,
    gama VARCHAR(50) NOT NULL,
    dimensiones VARCHAR(25) NOT NULL,
    proveedor VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL,
    cantidad_en_stock SMALLINT NOT NULL,
    precio_venta DECIMAL(15, 2) NOT NULL,
    precio_proveedor DECIMAL(15, 2) NOT NULL,
    PRIMARY KEY (codigo_producto),
    FOREIGN KEY (gama) REFERENCES gama_producto (gama)
);
