/*Tarea:
5 examinar para practicar SELECT  Y 5 tablas diferentes
Daniela Valencia Gómez*/

/*Tabla ORDERS*/
SELECT requiredDate, orderDate, status
FROM orders
WHERE
status IN ('Shipped','Cancelled')
ORDER BY requiredDate ASC;

/*Tabla Payments*/
SELECT checkNumber, amount
FROM payments
WHERE
amount >= 10000 AND amount <=100000
ORDER BY amount, checkNumber ASC;

/*Tabla Offices*/
SELECT city, addressLine1, country, postalCode
FROM offices
WHERE
city in ('Boston', 'NYC', 'Sydney', 'London')
ORDER BY postalCode,city ASC;

/*Tabla ORDERDETAILS*/
SELECT productCode, quantityOrdered, priceEach
FROM orderdetails
WHERE
quantityOrdered >= 30 AND quantityOrdered <=100
ORDER BY productCode, quantityOrdered ASC;


/*Tabla Employees*/
SELECT lastName, employeeNumber, jobTitle,email
FROM employees
WHERE
jobTitle in ('President', 'Sales Rep','VP Sales') and employeeNumber <=2000
ORDER BY lastName, firstName, email;
