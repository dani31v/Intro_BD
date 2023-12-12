/* A) Obtener la ciudad de los clientes y la cantidad ($) de lo comprado por esos clientes, con órdenes con estatus 
'Shipped', 'Resolved' e 'In Process', con fechas de solicitud del 2003-01-01 al 2004-12-31 inclusive,
 agrupado por ciudad y ordenado por el total comprado de manera descendente.
 */
 SELECT customers.city, SUM(orderdetails.quantityOrdered*orderdetails.priceEach) as Monto, orders.status, orders.orderDate
 FROM orders, customers, orderdetails
 WHERE
    customers.customerNumber = orders.customerNumber
    AND orders.orderNumber = orderdetails.orderNumber
    AND orders.orderDate BETWEEN '2003-01-01' AND '2004-12-31'
    AND orders.status REGEXP "Shipped|Resolved|In Process"
GROUP BY customers.city
ORDER BY Monto DESC;

/* B) Listar para cada año el código, el nombre y la línea de producto, así como el monto vendido ($) por ClassicModels,
 para las órdenes con estatus 'Shipped', 'Resolved' e 'In Process'. Se debe agrupar por año y por código de producto.
 Ordenar por año y por monto facturado (éste descendente).*/

SELECT products.productCode, products.productName, products.productLine, YEAR(orders.orderDate) as Y_, SUM(orderdetails.quantityOrdered*orderdetails.priceEach) as Monto, orders.status
FROM products, orderdetails, orders
WHERE 
    products.productCode = orderdetails.productCode
    AND orderdetails.orderNumber = orders.orderNumber
    AND orders.status REGEXP "Shipped|Resolved|In Process"
GROUP BY Y_, products.productCode
ORDER BY Y_, Monto DESC;

/* C) Listar para cada año (de la orden) la ciudad de cada oficina de la empresa, así como el monto vendido ($), 
para las órdenes con estatus diferente a 'Shipped', 'Resolved' e 'In Process' y que la ciudad del comprador 
final sea igual al de la oficina. Se debe agrupar por año y por ciudad. Ordenar por año y por monto facturado (éste descendente).*/
SELECT orders.orderNumber, orders.status, offices.city, YEAR (orders.orderDate) AS Y_, SUM(orderdetils.quantityOrdered*orderdetails.priceEach) as Monto
FROM orders, offices, customers, orderdetails, employees
WHERE 
    offices.officeCode = employees.officeCode
    AND employees.employeeNumber = customers.salesRepEmployeeNumber
    AND customers.customerNumber = orders.customerNumber
    AND orders.orderNumber = orderdetails.orderNumber
    AND orders.status not in ("Shipped", "Resolved", "In Process")
    AND offices.city = customers.city
GROUP BY Y_, offices.city
ORDER BY Y_, Monto DESC;

/* D) Recomiende al usuario final alguno de los productos que más se vende (por monto vendido), 
que en la descripción del producto contenga alguna de las palabras: 'engine', 'steering', 'suspension', 
'turnable', ordenado de mejor a peor puntaje.*/
SELECT orders.orderNumber, orders.status, (offices.city)as Offices_City,(customers.city)as Customers_City, YEAR (orders.orderDate) AS Y_, SUM(orderdetails.quantityOrdered*orderdetails.priceEach) as Monto
FROM orders, offices, customers, orderdetails, employees
WHERE 
    offices.officeCode = employees.officeCode
    AND employees.employeeNumber = customers.salesRepEmployeeNumber
    AND customers.customerNumber = orders.customerNumber
    AND orders.orderNumber = orderdetails.orderNumber
    AND orders.status not in ("Shipped", "Resolved", "In Process")
    AND offices.city = customers.city
GROUP BY Y_, offices.city
ORDER BY Y_, Monto DESC;

