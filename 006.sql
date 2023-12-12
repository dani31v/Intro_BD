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