/* C) Listar para cada año (de la orden) la ciudad de cada oficina de la empresa, así como el monto vendido ($), 
para las órdenes con estatus diferente a 'Shipped', 'Resolved' e 'In Process' y que la ciudad del comprador 
final sea igual al de la oficina. Se debe agrupar por año y por ciudad. Ordenar por año y por monto facturado (éste descendente).*/
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