# Filtro MySQL

### Nombres de los integrantes

## Laura Valentina Herrera Rivera
## Johan Sebastian Duarte Reyes
---


# consultas

---

## Consultas sobre una tabla
---

####     1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

    SELECT codigo_oficina, ciudad 
    FROM oficina;


####     2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

    SELECT ciudad, telefono
    FROM oficina
    WHERE pais = 'España';

####     3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.

    SELECT nombre, apellido1, apellido2, email
    FROM empleado
    WHERE codigo_jefe = 7;

####     4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

    SELECT e.puesto, e.nombre, e.apellido1, e.email
    FROM empleado e
    WHERE e.codigo_empleado = 1;


####     5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.

    SELECT nombre, apellido1, apellido2, puesto
    FROM empleado
    WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente 
                                    WHERE codigo_empleado_rep_ventas IS NOT NULL);


####     6. Devuelve un listado con el nombre de los todos los clientes españoles.

    SELECT nombre_cliente
    FROM cliente
    WHERE pais = 'España';


####     7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.

    SELECT DISTINCT estado
    FROM pedido;


####     8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
####     • Utilizando la función YEAR de MySQL.
    SELECT DISTINCT codigo_cliente
    FROM pago
    WHERE YEAR(fecha_pago) = 2008;

####     • Utilizando la función DATE_FORMAT de MySQL.
    SELECT DISTINCT codigo_cliente
    FROM pago
    WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';

####     • Sin utilizar ninguna de las funciones anteriores.
    SELECT DISTINCT p.codigo_cliente
    FROM pago p
    WHERE fecha_pago >= '2008-01-01' AND fecha_pago <= '2008-12-31';



####     9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
    SELECT codigo_pedido, codigo_cliente, fecha_espera, fecha_entrega
    FROM pedido
    WHERE fecha_entrega > fecha_espera;

####     10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
####     • Utilizando la función ADDDATE de MySQL.
    SELECT codigo_pedido, codigo_cliente, fecha_espera, fecha_entrega
    FROM pedido
    WHERE fecha_entrega < ADDDATE(fecha_espera, -2);

####     • Utilizando la función DATEDIFF de MySQL.
    SELECT codigo_pedido, codigo_cliente, fecha_espera, fecha_entrega
    FROM pedido
    WHERE DATEDIFF(fecha_entrega, fecha_espera) <= -2;

####     • ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
            No es posible resolver esta consulta utilizando operadores aritméticos estándar en SQL.
####     11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

    SELECT fecha_pedido, fecha_espera, fecha_espera, estado, comentarios, codigo_cliente
    FROM pedido
    WHERE YEAR(fecha_pedido) = 2009 AND estado = 'rechazado';

###     12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.

    SELECT fecha_pedido, fecha_espera, fecha_espera, estado, comentarios, codigo_cliente
    FROM pedido
    WHERE MONTH(fecha_entrega) = 1;

####     13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

    SELECT codigo_cliente, forma_pago, id_transaccion, fecha_pago, total
    FROM pago
    WHERE YEAR(fecha_pago) = 2008 AND forma_pago = 'PayPal'
    ORDER BY total DESC;

####     14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
    SELECT DISTINCT forma_pago
    FROM pago;

####     15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
    SELECT codigo_producto, nombre, gama, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor
    FROM producto
    WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100
    ORDER BY precio_venta DESC;


####     16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.

    SELECT nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, codigo_empleado_rep_ventas, limite_credito
    FROM cliente c
    WHERE ciudad = 'Madrid' AND codigo_empleado_rep_ventas IN (11, 30);


## Consultas multitabla (Composición interna)
###### Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.
---

#### 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

    SELECT c.nombre_cliente, e.nombre AS "nombre representante", e.apellido1 AS "apellido repredentante"
    FROM cliente c
    JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

#### 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

    SELECT c.nombre_cliente, e.nombre AS "nombre representante", e.apellido1 AS "apellido repredentante"
    FROM cliente c
    JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    WHERE c.codigo_cliente IN (SELECT DISTINCT codigo_cliente FROM pago);


#### 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

    SELECT c.nombre_cliente, e.nombre AS "nombre representante", e.apellido1 AS "apellido repredentante"
    FROM cliente c
    JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    WHERE c.codigo_cliente NOT IN (SELECT DISTINCT codigo_cliente FROM pago);

#### 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

    SELECT c.nombre_cliente, e.nombre AS "nombre representante", e.apellido1 AS "apellido repredentante"
    FROM cliente c
    JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    WHERE c.codigo_cliente IN (SELECT DISTINCT codigo_cliente FROM pago);

#### 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

    SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
    FROM cliente c
    JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    WHERE c.codigo_cliente NOT IN (SELECT DISTINCT codigo_cliente FROM pago);

#### 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

    SELECT DISTINCT ofi.linea_direccion1, ofi.linea_direccion2
    FROM oficina ofi
    JOIN empleado e ON ofi.codigo_oficina = e.codigo_oficina
    JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    WHERE c.ciudad = 'Fuenlabrada';


#### 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

    SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
    FROM cliente c
    JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

#### 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

    SELECT e.nombre AS empleado, j.nombre AS jefe
    FROM empleado e
    LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado;


#### 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

    SELECT e.nombre AS empleado, j.nombre AS jefe, jj.nombre AS jefe_del_jefe
    FROM empleado e
    LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado   
    LEFT JOIN empleado jj ON j.codigo_jefe = jj.codigo_empleado;

#### 10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

    SELECT c.nombre_cliente
    FROM cliente c
    JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
    WHERE p.fecha_entrega > p.fecha_espera;

#### 11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

    SELECT c.nombre_cliente, GROUP_CONCAT(DISTINCT pr.gama ORDER BY pr.gama SEPARATOR ', ') AS gamas_compradas
    FROM cliente c
    JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
    JOIN detalle_pedido dp ON pe.codigo_pedido = dp.codigo_pedido
    JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
    GROUP BY c.nombre_cliente;

## Consultas multitabla (Composición externa) 
###### Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.
---

#### 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

    SELECT c.nombre_cliente
    FROM cliente c
    LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
    WHERE p.codigo_cliente IS NULL;

#### 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

    SELECT c.nombre_cliente
    FROM cliente c
    LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
    WHERE p.codigo_pedido IS NULL;

#### 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

    SELECT c.nombre_cliente, 
        CASE WHEN p.codigo_cliente IS NULL THEN 'No ha realizado pagos' END AS estado_pago,
        CASE WHEN pe.codigo_pedido IS NULL THEN 'No ha realizado pedidos' END AS estado_pedido
    FROM cliente c
    LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
    LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
    WHERE p.codigo_cliente IS NULL OR pe.codigo_pedido IS NULL;

#### 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

    SELECT e.nombre, e.apellido1, e.apellido2
    FROM empleado e
    LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    WHERE o.codigo_oficina IS NULL;

#### 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

    SELECT e.nombre, e.apellido1, e.apellido2
    FROM empleado e
    LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    WHERE c.codigo_cliente IS NULL;

#### 6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

    SELECT e.nombre, e.apellido1, e.apellido2, o.ciudad
    FROM empleado e
    LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    WHERE c.codigo_cliente IS NULL;

#### 7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

    SELECT e.nombre, e.apellido1, e.apellido2
    FROM empleado e
    LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    WHERE o.codigo_oficina IS NULL OR c.codigo_cliente IS NULL;

#### 8. Devuelve un listado de los productos que nunca han aparecido en un pedido.

    SELECT pr.nombre
    FROM producto pr
    LEFT JOIN detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto
    WHERE dp.codigo_pedido IS NULL;

#### 9. Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.

    SELECT pr.nombre, pr.descripcion
    FROM producto pr
    LEFT JOIN detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto
    WHERE dp.codigo_pedido IS NULL;

#### 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

    SELECT DISTINCT o.codigo_oficina, o.ciudad, o.pais, o.region, o.codigo_postal, o.telefono, o.linea_direccion1, o.linea_direccion2
    FROM oficina o
    LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
    LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
    LEFT JOIN detalle_pedido dp ON pe.codigo_pedido = dp.codigo_pedido
    LEFT JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
    WHERE pr.gama = 'Frutales' AND e.codigo_empleado IS NULL;

#### 11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

    SELECT c.nombre_cliente
    FROM cliente c
    LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
    LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
    WHERE p.codigo_pedido IS NOT NULL AND pa.codigo_cliente IS NULL;

#### 12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

    SELECT e.nombre, e.apellido1, e.apellido2, ej.nombre AS jefe
    FROM empleado e
    LEFT JOIN empleado ej ON e.codigo_jefe = ej.codigo_empleado
    LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    WHERE c.codigo_cliente IS NULL;

# Consultas resumen
---

#### 1. ¿Cuántos empleados hay en la compañía?
    SELECT COUNT(nombre) AS total_empleados
    FROM empleado;

#### 2. ¿Cuántos clientes tiene cada país?

    SELECT pais, COUNT(nombre_cliente) AS total_clientes
    FROM cliente
    GROUP BY pais;

#### 3. ¿Cuál fue el pago medio en 2009?

    SELECT AVG(total) AS pago_medio_2009
    FROM pago
    WHERE YEAR(fecha_pago) = 2009;

#### 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.

    SELECT estado, COUNT(comentarios) AS cantidad_pedidos
    FROM pedido
    GROUP BY estado
    ORDER BY cantidad_pedidos DESC;

#### 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.

    SELECT MAX(precio_venta) AS precio_mas_caro, MIN(precio_venta) AS precio_mas_barato
    FROM producto;

#### 6. Calcula el número de clientes que tiene la empresa.

    SELECT COUNT(nombre_cliente) AS total_clientes
    FROM cliente;

#### 7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

    SELECT COUNT(nombre_cliente) AS total_clientes_madrid
    FROM cliente
    WHERE ciudad = 'Madrid';

#### 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?

    SELECT ciudad, COUNT(nombre_cliente) AS total_clientes
    FROM cliente
    WHERE ciudad LIKE 'M%'
    GROUP BY ciudad;

#### 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.

    SELECT CONCAT(e.nombre, ' ', e.apellido1) AS representante_ventas, COUNT(c.codigo_cliente) AS num_clientes
    FROM empleado e
    LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    GROUP BY e.nombre, e.apellido1;

#### 10. Calcula el número de clientes que no tiene asignado representante de ventas.

    SELECT COUNT(nombre_cliente) AS clientes_sin_representante
    FROM cliente
    WHERE codigo_empleado_rep_ventas IS NULL;

#### 11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

    SELECT c.nombre_cliente, c.nombre_contacto, c.apellido_contacto,
        MIN(fecha_pago) AS primer_pago, MAX(fecha_pago) AS ultimo_pago
    FROM cliente c
    LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
    GROUP BY c.nombre_cliente, c.nombre_contacto, c.apellido_contacto;

#### 12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.

    SELECT codigo_pedido, COUNT(cantidad) AS num_productos_diferentes
    FROM detalle_pedido
    GROUP BY codigo_pedido;

#### 13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
    SELECT codigo_pedido, SUM(cantidad) AS cantidad_total_productos
    FROM detalle_pedido
    GROUP BY codigo_pedido;

#### 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.

    SELECT dp.codigo_producto, pr.nombre, SUM(dp.cantidad) AS unidades_vendidas
    FROM detalle_pedido dp
    JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
    GROUP BY dp.codigo_producto, pr.nombre
    ORDER BY unidades_vendidas DESC
    LIMIT 20;

#### 15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.

    SELECT 
        SUM(dp.cantidad * pr.precio_venta) AS base_imponible,
        SUM(dp.cantidad * pr.precio_venta) * 0.21 AS iva,
        SUM(dp.cantidad * pr.precio_venta) + (SUM(dp.cantidad * pr.precio_venta) * 0.21) AS total_facturado
    FROM detalle_pedido dp
    JOIN producto pr ON dp.codigo_producto = pr.codigo_producto;

#### 16. La misma información que en la pregunta anterior, pero agrupada por código de producto.

    SELECT 
        dp.codigo_producto,
        SUM(dp.cantidad * pr.precio_venta) AS base_imponible,
        SUM(dp.cantidad * pr.precio_venta) * 0.21 AS iva,
        SUM(dp.cantidad * pr.precio_venta) + (SUM(dp.cantidad * pr.precio_venta) * 0.21) AS total_facturado
    FROM detalle_pedido dp
    JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
    GROUP BY dp.codigo_producto;

#### 17. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.

    SELECT 
        dp.codigo_producto,
        SUM(dp.cantidad * pr.precio_venta) AS base_imponible,
        SUM(dp.cantidad * pr.precio_venta) * 0.21 AS iva,
        SUM(dp.cantidad * pr.precio_venta) + (SUM(dp.cantidad * pr.precio_venta) * 0.21) AS total_facturado
    FROM detalle_pedido dp
    JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
    WHERE dp.codigo_producto LIKE 'OR%'
    GROUP BY dp.codigo_producto;

#### 18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).

    SELECT pr.nombre,
        SUM(dp.cantidad) AS unidades_vendidas,
        SUM(dp.cantidad * pr.precio_venta) AS total_facturado,
        SUM(dp.cantidad * pr.precio_venta) * 1.21 AS total_facturado_con_iva
    FROM detalle_pedido dp
    JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
    GROUP BY pr.nombre
    HAVING total_facturado > 3000;

#### 19. Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.

    SELECT YEAR(fecha_pago) AS año, SUM(total) AS total_pagos
    FROM pago
    GROUP BY YEAR(fecha_pago);


## Consultas variadas
#### 1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.

    SELECT c.nombre_cliente, COUNT(p.codigo_pedido) AS pedidos_realizados
    FROM cliente c
    LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
    GROUP BY c.nombre_cliente;

#### 2. Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.

    SELECT c.nombre_cliente, IFNULL(SUM(pa.total), 0) AS total_pagado
    FROM cliente c
    LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
    GROUP BY c.nombre_cliente;

#### 3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.

    SELECT DISTINCT c.nombre_cliente
    FROM cliente c
    JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
    WHERE YEAR(p.fecha_pedido) = 2008
    ORDER BY c.nombre_cliente ASC;

#### 4. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.

    SELECT c.nombre_cliente, e.nombre, e.apellido1, o.telefono
    FROM cliente c
    LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
    WHERE p.id_transaccion IS NULL;

#### 5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.

    SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
    FROM cliente c
    LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

#### 6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.

    SELECT e.nombre, e.apellido1, e.puesto, o.telefono
    FROM empleado e
    JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    WHERE c.codigo_cliente IS NULL;

#### 7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.

    SELECT o.ciudad, COUNT(e.codigo_empleado) AS num_empleados
    FROM oficina o
    LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
    GROUP BY o.ciudad;
