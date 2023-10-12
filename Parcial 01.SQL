 /*Obtener el número de cliente, su nombre, ciudad, estado, código postal, país y 
 límite de crédito, ordenado por nombre de cliente*/

SELECT customerNumber, customerName,city,state,postalCode,country,creditLimit
FROM `customers` 
ORDER BY `customerName` ASC;

/*Obtener el número de cliente, ciudad, código postal, país, límite de crédito y 
todos los productos que ha comprado a los largo de los años.*/
SELECT customerNumber, city, postalCode, country, creditLimit, products.productCode, products.productName
FROM 
    orderdetails 
INNER JOIN orderdetails ON products.productCode = orderdetails.productCode
INNER JOIN orders on orderdetails.orderNumber= orders.orderNumber
INNER JOIN customers on orders.customerNumber =customers.customerNumber

ORDER BY 
	customerNumber;



/*Obtener todas las órdenes de compra, con estatus Shipped, del año 2005.*/
SELECT *
FROM orders
WHERE
status = "Shipped" AND YEAR(shippedDate) = 2005;

/*Para cada uno de los empleados, obtener en qué país está la oficina
a la que pertenecen.*/
SELECT employeeNumber,lastName, firstName, offices.officeCode, offices.country
FROM employees, offices
WHERE
	employees.officeCode = offices.officeCode;


/*Obtener los productos comprados, con órdenes con estatus In Process, entre las fechas de embarque del 2003-04-08 al 2005-02-08, ordenado por número de orden de manera descendente..*/

SELECT 
    orderDetails.productCode, products.productName, orders.orderNumber, orders.status,orders.orderDate
FROM 
    products 
INNER JOIN orderdetails ON products.productCode = orderdetails.productCode
INNER JOIN orders ON orderdetails.orderNumber = orders.orderNumber
WHERE 
    orders.status = 'In Process'
    AND orders.shippedDate BETWEEN '2003-04-08' AND '2005-02-08'
    
ORDER BY 
    orders.orderNumber DESC;
