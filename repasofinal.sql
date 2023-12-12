

/*1.- Liste, para el año 2004, para los estados de la orden 'Shipped' y 'Resolved',
 el monto comprado por los clientes, de aquellos que el nombre de contacto está entre la 'L' u la 'O' 
 (usando expresiones regulares), ordenado del que más compra al que menos.*/

SELECT orders.status, YEAR(orders.orderDate) as Y_, SUM(orderdetails.quantityOrdered*orderdetails.priceEach)as Monto
FROM orderdetails,orders,customers
WHERE
	orderdetails.orderNumber =orders.orderNumber
    AND orders.customerNumber =customers.customerNumber
    AND orders.orderDate LIKE '2004%'
    AND orders.status IN ('Shipped', 'Resolved')
    AND customers.customerName REGEXP '^[L-O]'
 ORDER BY Monto;

/*2.- Liste los empleados que venden en países de América, mostrando la cantidad que ha vendido cada uno, del que más al que menos.*/
SELECT employees.employeeNumber, employees.firstName,customers.salesRepEmployeeNumber,offices.country, SUM(orderdetails.quantityOrdered*orderdetails.priceEach) as Monto
FROM employees, offices, orderdetails, orders, customers
WHERE 
    offices.officeCode = employees.officeCode
    AND employees.employeeNumber = customers.salesRepEmployeeNumber
    AND customers.customerNumber  = orders.customerNumber
    AND orders.orderNumber = orderdetails.orderNumber
    AND offices.country IN ("USA","Canada","Mexico","Brazil","Argentina","Venezuela","Chile")
    GROUP BY employees.employeeNumber
    ORDER BY Monto DESC;
/*3.-  Recomiende al comprador alguno de los productos que más se vende (por unidades vendidas),
 en los años 2003 y 2004, que en la descripción del producto contenga alguna de las palabras: 
 'doors', 'engine', 'steering', 'suspension' ,'trunk', 'turnable' y 'wheels', ordenado de mejor a peor puntaje.*/
 SELECT products.productCode, products.productName, products.productDescription, SUM(orderdetails.quantityOrdered) as TotalU
 FROM products, orderdetails, orders
 WHERE 
    products.productCode = orderdetails.productCode
    AND orderdetails.orderNumber = orders.orderNumber
    AND (orders.orderDate LIKE "2003%" OR orders.orderDate LIKE "2004%")
    AND products.productDescription REGEXP 'doors|engine|steering|suspension|trunk|turnable|wheels'
GROUP BY products.productCode
ORDER BY TotalU DESC;

/*4.- Indique qué productos tienen en el nombre y en la descripción alguna de las palabras: 'engine', 'suspension'
 y 'turnable' (mediante FTS) y cuánto se ha facturado de esos productos en el 2005.*/
 SELECT products.productCode, products.productName, products.productDescription, SUM(orderdetails.quantityOrdered*orderdetails.priceEach) as Monto
 FROM products, orderdetails, orders
    WHERE
        products.productCode = orderdetails.productCode
        AND orderdetails.orderNumber = orders.orderNumber
        AND orders.orderDate LIKE "2005%"
        AND MATCH(productName, productDescription) AGAINST ("engine, suspension, turnable" IN NATURAL LANGUAGE MODE)
     
GROUP BY products.productCode
ORDER BY Monto DESC;

/*5.- Para todas las órdenes con estado diferente a 'Shipped' y 'Resolved', dterminar si el 
correo electrónico del vendedor es correcto usando REGEXP.*/
SELECT employees.employeeNumber, employees.firstName, employees.email, orders.status
FROM employees, customers, orders
WHERE 
    employees.employeeNumber = customers.salesRepEmployeeNumber
    AND customers.customerNumber = orders.customerNumber
    AND orders.status NOT IN ("Shipped", "Resolved")
    AND employees.email REGEXP '^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$'
ORDER BY employees.employeeNumber;

