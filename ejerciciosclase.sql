/*proporcionar un análisis de las ventas internacionales (aquellas donde el país del cliente difiere del país de la oficina) en comparación con las ventas totales, tanto en términos del número de ventas como del valor total de estas ventas. Proporciona una visión clara del porcentaje de negocios de una oficina que proviene de mercados fuera de su propio país.*/

SELECT
	Y.OffCountry,
    	(1 - Y.locNumSales/Y.numSales) * 100 AS numInter,
    	(1 - Y.locTotSales/Y.totalSales) * 100 AS totInter
FROM
(
    SELECT
	    X.OffCountry,
        SUM(X.numSales) AS numSales,
    	    SUM(X.locNumSales) AS locNumSales,
    	    SUM(X.totalSales) AS totalSales,
    	    SUM(X.locTotSales) AS locTotSales
    FROM
        (
    SELECT
	offices.country AS OffCountry,
	customers.country AS CusCountry,
    COUNT(*) as numSales,
    SUM(CASE 
    	WHEN customers.country = offices.country then 1
        		ELSE 0
    	END) AS locNumSales,
    	SUM(priceEach * quantityordered) AS totalSales,
    	SUM(CASE
        	WHEN customers.country = offices.country then priceEach * quantityordered
        		ELSE 0
    	END) AS locTotSales
    FROM offices, employees, customers, orders, orderdetails
    WHERE
	    offices.officeCode = employees.officeCode
    	    AND employees.employeeNumber = customers.salesRepEmployeeNumber
    	    AND customers.customerNumber = orders.customerNumber
    	    AND orders.orderNumber = orderdetails.orderNumber
    GROUP BY OffCountry, CusCountry
    ORDER BY OffCountry
    ) X
    GROUP BY X.OffCountry
    ORDER BY X.OffCountry
) Y
ORDER BY Y.OffCountry;

