/* 01.- Determinar el número de productos por cada línea de productos.*/
SELECT productlines.productLine, count(*)
FROM productlines
INNER JOIN products ON products.productLine = productlines.productLine
GROUP BY productlines.productLine;

/* 02.- Calcular el precio promedio de los productos de cada línea de productos.*/
SELECT productlines.productLine, AVG(products.MSRP)
FROM productlines
INNER JOIN products ON products.productLine = productlines.productLine
GROUP BY productlines.productLine;

/* 03.- Listar los montos comprados de todos los productos, del mayor al menor.*/
SELECT productCode, SUM(buyPrice*quantityInStock) as Total FROM products
GROUP BY productCode
ORDER BY Total DESC;

/* 04.- Determinar la orden de compra que tiene el monto más alto.*/
SELECT  orderdetails.orderNumber, SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS total
FROM orderdetails
GROUP BY total
ORDER BY orderdetails.orderNumber DESC;

/* 05.- Listar las unidades compradas (por los clientes) de todos los productos, del menor al mayor.*/
SELECT products.productCode, SUM(orderdetails.quantityOrdered) as "total"
FROM orders
INNER JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
INNER JOIN products ON products.productCode = orderdetails.productCode
GROUP BY products.productCode
ORDER BY total ASC

/* 06.- Determinar los productos que han sido cancelados y listarlos por unidades vendidas, de manera descendente.*/
SELECT products.productCode, orders.status, SUM(orderdetails.quantityOrdered)
FROM products, orderdetails, orders
WHERE
    products.productCode = orderdetails.productCode
    AND
    orders.orderNumber = orderdetails.orderNumber
    AND 
    orders.status = 'Cancelled'
GROUP BY products.productCode;

/* 07.- Determinar cuál es la escala de productos que mejor se vende.*/
SELECT products.productScale, SUM(orderdetails.quantityOrdered) as "total"
FROM orders
INNER JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
INNER JOIN products ON products.productCode = orderdetails.productCode
GROUP BY products.productScale
ORDER BY total DESC;

/* 08.- Determinar, por cada año y estatus, los montos facturados, para los estatus Shipped y Resolved.*/
SELECT YEAR(orders.orderDate) as "anio", orders.status, SUM(orderdetails.quantityOrdered * orderdetails.priceEach) as "total"
FROM orders
INNER JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
WHERE orders.status IN ("Shipped", "Resolved")
GROUP BY anio, orders.status

/* 09.- Listar, en orden descendente, los montos de lo comprado por los distintos cliente.*/
SELECT customers.customerNumber, SUM(orderdetails.quantityOrdered * orderdetails.priceEach) as total
FROM orders, orderdetails, customers
WHERE
	orderdetails.orderNumber = orders.orderNumber
    AND orders.customerNumber = customers.customerNumber
GROUP BY customers.customerNumber
ORDER BY total DESC;

/* 10.- Determinar los países de los clientes que más han comprado.*/
SELECT country, SUM(orderdetails.quantityOrdered * orderdetails.priceEach) as total
FROM orders, orderdetails, customers
WHERE
	orderdetails.orderNumber = orders.orderNumber
    AND orders.customerNumber = customers.customerNumber
GROUP BY country
ORDER BY total DESC;

/* 11.- Listar, en orden descendente, del mejor a peor vendedor.*/
SELECT employeeNumber, firstName, lastName, SUM(orderdetails.quantityOrdered * orderdetails.priceEach) as total
FROM orders, orderdetails, customers, employees
WHERE
	employees.employeeNumber = customers.salesRepEmployeeNumber
    AND orderdetails.orderNumber = orders.orderNumber
    AND orders.customerNumber = customers.customerNumber
GROUP BY employeeNumber
ORDER BY total DESC;