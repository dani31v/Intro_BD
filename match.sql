/* Listado de los scores de las búsquedas en los campos de productName y productDescription.
Se presenta por igual la sumatoria de los resultados de ambas búsquedas, y solo los registros cuyas
sumatorias son mayor que 0*/
SELECT *
FROM
(
    SELECT A.productCode, A.Score AS AScore, B.Score AS BScore, (A.Score + B.Score) AS NScore
    FROM
    (
        SELECT productCode, MATCH(productName) AGAINST ('davidson bar' IN NATURAL LANGUAGE MODE) AS Score
        FROM products
    ) A,
    (
        SELECT productCode, MATCH(productDescription) AGAINST ('davidson bar' IN NATURAL LANGUAGE MODE) AS Score
        FROM products
    ) B
    WHERE
        A.productCode = B.productCode
) C
WHERE
	C.NScore > 0
ORDER BY C.NScore DESC;

/* Búsqueda con modo BOOLEANO. Funciona como un AND*/
SELECT *
FROM products
WHERE 
	MATCH(productDescription) AGAINST ('+wheels -rubber' IN BOOLEAN MODE) /*Con el + indicamos lo que nos interesa buscar,
    mientras que con el - indicamos lo que NO nos interesa buscar.*/