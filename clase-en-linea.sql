/*LIKE
Esta función necesita de máscaras, entonces con ‘%’ le indicamos que no nos interesa que hayantes de dicha palabra o después.*/

SELECT *
FROM products
WHERE
productDescription LIKE '%replica%'; /*SQL que regresa los productos cuya descripción contiene la palabra ‘replica’*/

/*MATCH() AGAINST ()
Esta función no necesita de máscaras. Dicha función nos regresa un valor de que tan compatible es la búsqueda con cada registro.*/

SELECT *
FROM products
WHERE
	MATCH(productDescription) AGAINST ('replica' IN NATURAL LANGUAGE MODE)
    /*Esto después de hacerle un índice de fulltext a productDescription*/

SELECT *
FROM products
WHERE
	MATCH(productName) AGAINST ('davidson bar' IN NATURAL LANGUAGE MODE); /*Al incluir más de una palabra se maneja con un ‘OR’,
    es decir que regresa los registros en los que se encuentre una u otra palabra, y no importa el orden donde se encuentren
    dichas palabras. Además de que no considera si hay mayúsculas o no*/

SELECT *
FROM
(
    SELECT *
    FROM products
    WHERE
        MATCH(productName) AGAINST ('davidson bar' IN NATURAL LANGUAGE MODE)
) A,
(
    SELECT *
    FROM products
    WHERE
        MATCH(productDescription) AGAINST ('davidson bar' IN NATURAL LANGUAGE 
        MODE)
) B
WHERE
	A.productCode = B.productCode

SELECT productCode,  MATCH(productName) AGAINST ('davidson bar' IN NATURAL LANGUAGE MODE) AS Score
FROM products
ORDER BY Score DESC; /*Mientras más grande es el número, más grande es la concordancia entre la búsqueda con el registro*/


/*EXPRESIONES REGULARES*/
SELECT *
FROM employees
WHERE
	lastName REGEXP '^pa'

/*REGEXP funciona similar a una máscara, y en este caso nos regresa los apellidos que empiecen por pa y de ahí no importa
qué sigue.*/

SELECT *
FROM employees
WHERE
	lastName REGEXP 'son$';

/*Con $ al final indicamos que nos regrese los apellidos que acaben por son sin importa que va antes.*/

SELECT *
FROM employees
WHERE
	lastName REGEXP '^(f|m)';
/*() funciona como un subconjunto, nos regresa apellidos que empiecen con F o con M*/

SELECT *
FROM products
WHERE
	productName REGEXP '^.{10}$';
/*Notación para regresar los productnames cuya longitud es de 10 y sin importar con cuál caracter empiecen.*/
