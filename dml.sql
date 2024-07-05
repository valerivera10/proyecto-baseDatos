INSERT INTO oficina (codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2) VALUES
('OF001', 'Bogotá', 'Colombia', 'Cundinamarca', '110111', '123-4567', 'Calle 123 #45-67', 'Edificio ABC, Piso 4'),
('OF002', 'Medellín', 'Colombia', 'Antioquia', '050001', '234-5678', 'Avenida 80 #12-34', 'Centro Comercial XYZ, Local 101'),
('OF003', 'Cali', 'Colombia', 'Valle del Cauca', '760001', '345-6789', 'Carrera 15 #10-20', 'Edificio DEF, Piso 2'),
('OF004', 'Barranquilla', 'Colombia', 'Atlántico', '080001', '456-7890', 'Calle 30 #25-40', 'Centro Empresarial GHI, Oficina 304'),
('OF005', 'Cartagena', 'Colombia', 'Bolívar', '130001', '567-8901', 'Avenida San Martín #10-15', 'Centro de Negocios JKL, Piso 1');

-- Insertar datos en la tabla gama_producto
INSERT INTO gama_producto (gama, descripcion_texto, descripcion_html, imagen) VALUES
('Gama Baja', 'Productos de gama baja con precios accesibles', '<p>Productos de gama baja con precios accesibles</p>', 'imagenes/gama_baja.jpg'),
('Gama Media', 'Productos de gama media con buena relación calidad-precio', '<p>Productos de gama media con buena relación calidad-precio</p>', 'imagenes/gama_media.jpg'),
('Gama Alta', 'Productos de gama alta con características premium', '<p>Productos de gama alta con características premium</p>', 'imagenes/gama_alta.jpg'),
('Gama Lujo', 'Productos de lujo con la máxima calidad y exclusividad', '<p>Productos de lujo con la máxima calidad y exclusividad</p>', 'imagenes/gama_lujo.jpg');

INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto) VALUES
('Juan', 'Perez', 'Gomez', '101', 'juan.perez@example.com', 'OF1', NULL, 'Gerente'),
('Maria', 'Lopez', 'Rodriguez', '102', 'maria.lopez@example.com', 'OF1', 1, 'Asistente'),
('Pedro', 'Garcia', 'Martinez', '103', 'pedro.garcia@example.com', 'OF2', 1, 'Vendedor'),
('Ana', 'Sanchez', 'Hernandez', '104', 'ana.sanchez@example.com', 'OF2', 1, 'Vendedor'),
('Luis', 'Ramirez', 'Torres', '105', 'luis.ramirez@example.com', 'OF3', 1, 'Vendedor');

INSERT INTO cliente (nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, codigo_empleado_rep_ventas, limite_credito) VALUES
('Comercial S.A.', 'Carlos', 'Diaz', '123456789', '987654321', 'Calle 1', 'Apt 1', 'Bogota', 'Cundinamarca', 'Colombia', '110111', 1, 10000.00),
('Industrias ABC', 'Laura', 'Fernandez', '234567890', '876543210', 'Calle 2', 'Apt 2', 'Medellin', 'Antioquia', 'Colombia', '220222', 2, 20000.00),
('Tecnologia XYZ', 'Marta', 'Suarez', '345678901', '765432109', 'Calle 3', 'Apt 3', 'Cali', 'Valle', 'Colombia', '330333', 3, 15000.00),
('Servicios Ltda.', 'Jose', 'Rojas', '456789012', '654321098', 'Calle 4', 'Apt 4', 'Cartagena', 'Bolivar', 'Colombia', '440444', 4, 25000.00),
('Consultores SAS', 'Ana', 'Vargas', '567890123', '543210987', 'Calle 5', 'Apt 5', 'Bucaramanga', 'Santander', 'Colombia', '550555', 5, 30000.00);

INSERT INTO producto (codigo_producto, nombre, gama, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor) VALUES
('P001', 'Producto 1', 'Gama Baja', '10x10x10', 'Proveedor A', 'Descripcion del Producto 1', 100, 50.00, 30.00),
('P002', 'Producto 2', 'Gama Media', '20x20x20', 'Proveedor B', 'Descripcion del Producto 2', 200, 100.00, 60.00),
('P003', 'Producto 3', 'Gama Alta', '30x30x30', 'Proveedor C', 'Descripcion del Producto 3', 300, 150.00, 90.00),
('P004', 'Producto 4', 'Gama Baja', '40x40x40', 'Proveedor D', 'Descripcion del Producto 4', 400, 200.00, 120.00),
('P005', 'Producto 5', 'Gama Lujo', '50x50x50', 'Proveedor E', 'Descripcion del Producto 5', 500, 250.00, 150.00);

INSERT INTO pedido (fecha_pedido, fecha_espera, fecha_entrega, estado, comentarios, codigo_cliente) VALUES
('2024-07-01', '2024-07-05', '2024-07-10', 'Pendiente', 'Pedido urgente', 1),
('2024-07-02', '2024-07-06', '2024-07-11', 'Completado', 'Entregar en la mañana', 2),
('2024-07-03', '2024-07-07', '2024-07-12', 'En proceso', 'Requiere revisión', 3),
('2024-07-04', '2024-07-08', '2024-07-13', 'Pendiente', 'Confirmar dirección', 4),
('2024-07-05', '2024-07-09', '2024-07-14', 'Completado', 'Cliente VIP', 5);

INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea) VALUES
(1, 'P001', 10, 50.00, 1),
(1, 'P002', 5, 100.00, 2),
(2, 'P003', 7, 150.00, 1),
(3, 'P004', 3, 200.00, 1),
(4, 'P005', 8, 250.00, 1);

INSERT INTO pago (codigo_cliente, forma_pago, id_transaccion, fecha_pago, total) VALUES
(1, 'Tarjeta de crédito', 'TXN001', '2024-07-01', 500.00),
(2, 'PayPal', 'TXN002', '2024-07-02', 700.00),
(3, 'Transferencia bancaria', 'TXN003', '2024-07-03', 600.00),
(4, 'Efectivo', 'TXN004', '2024-07-04', 800.00),
(5, 'Cheque', 'TXN005', '2024-07-05', 900.00);
