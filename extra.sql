
/*Recomiende al usuario final alguno de los productos que más se vende
 (por monto vendido), que en la descripción del producto contenga alguna 
 de las palabras: 'engine', 'steering', 'suspension', 'turnable', ordenado
de mejor a peor puntaje.*/
SELECT 
    x.productCode, x.productName, x.productDescription, x.Monto, x.puntaje
FROM 
    (SELECT products.productCode,products.productName, products.productDescription, SUM(orderdetails.quantityOrdered * orderdetails.priceEach) as Monto, MATCH(products.productName, products.productDescription) AGAINST ("engine, steering, suspension, turnable" IN NATURAL LANGUAGE MODE) as Puntaje
    FROM products, orderdetails, orders
        WHERE 
            orders.orderNumber= orderdetails.orderNumber 
            AND orderdetails.productCode = products.productCode
            AND MATCH(products.productName, products.productDescription) AGAINST ("engine, steering, suspension, turnable" IN NATURAL LANGUAGE MODE)

    GROUP BY products.productCode) x
ORDER BY x.puntaje DESC;
