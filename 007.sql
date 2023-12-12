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