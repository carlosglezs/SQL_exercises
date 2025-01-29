/* 2.Muestra los nombres de todas las películas con una clasificación por 
edades de ‘Rʼ*/
select "title" 
from "film"
where "rating" = 'R';

/* 3.Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 
y 40.*/
SELECT CONCAT("first_name", ' ', "last_name")
FROM "actor"
WHERE "actor_id" BETWEEN 30 AND 40;

/* 4.Obtén las películas cuyo idioma coincide con el idioma original.*/
SELECT "title", "language_id", "original_language_id" 
FROM "film" f
WHERE "language_id" = "original_language_id";

 /* 5.Ordena las películas por duración de forma ascendente.*/
SELECT "title","length" 
FROM "film" f 
ORDER BY "length" asc;

 /* 6.Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su 
apellido.*/
SELECT "first_name", "last_name" 
FROM "actor" a 
WHERE "last_name" ~* 'Allen' /* Para conseguir que sea insensible a mayusculas*/; 

/* 7.Encuentra la cantidad total de películas en cada clasificación de la tabla 
“filmˮ y muestra la clasificación junto con el recuento.*/
SELECT "rating", COUNT(*) AS "total_movies"
FROM "film"
GROUP BY "rating"
ORDER BY "total_movies" DESC;

/* 8.Encuentra el título de todas las películas que son ‘PG13ʼ o tienen una 
duración mayor a 3 horas en la tabla film.*/
SELECT "title", "rating","length" 
FROM "film"F 
WHERE "rating" = 'PG-13' OR "length" > 180;

 /* 9.Encuentra la variabilidad de lo que costaría reemplazar las películas.*/
SELECT VARIANCE(replacement_cost) 
FROM film;

 /* 10.Encuentra la mayor y menor duración de una película de nuestra BBDD.*/
SELECT max("length"), min"(length")
FROM	"film";

 /* 11.Encuentra lo que costó el antepenúltimo alquiler ordenado por día.*/
SELECT p."amount" 
FROM "rental" r
JOIN "payment" p ON r.rental_id = p.rental_id
ORDER BY r.rental_date DESC
LIMIT 1
OFFSET 2;

 /* 12.Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.*/
SELECT "title" 
FROM "film" f 
WHERE "rating" NOT IN ('NC-17', 'G');

 /* 13.Encuentra el promedio de duración de las películas para cada 
clasificación de la tabla film y muestra la clasificación junto con el 
promedio de duración.*/
SELECT "rating", AVG("length") 
FROM "film" f 
GROUP BY "rating";

/* 14.Encuentra el título de todas las películas que tengan una duración mayor 
a 180 minutos.*/
SELECT "title" 
FROM "film" f 
WHERE "length" >180;

/* 15.¿Cuánto dinero ha generado en total la empresa?*/
SELECT sum("amount") AS Pago_Total 
FROM "payment" p;

/* 16.Muestra los 10 clientes con mayor valor de id.*/
SELECT "customer_id", concat("first_name",' ',"last_name") 
FROM "customer" c /* No se si se refiere a la tabla customer o Customer*/
ORDER BY "customer_id" DESC 
LIMIT 10;

/* 17.Encuentra el nombre y apellido de los actores que aparecen en la 
película con título ‘Egg Igbyʼ.*/
SELECT "first_name", "last_name" 
FROM "actor" a 
JOIN "film_actor" fa ON a."actor_id" = fa."actor_id" 
JOIN film f ON fa."film_id" = f."film_id" 
WHERE f."title" ~* 'Egg Igby';

/* 18.Selecciona todos los nombres de las películas únicos.*/
SELECT DISTINCT("title") 
FROM "film" f;

/* 19.Encuentra el título de las películas que son comedias y tienen una 
duración mayor a 180 minutos en la tabla “filmˮ.*/
SELECT "title" 
FROM "film" f 
JOIN "film_category" fc ON f."film_id" = fc."film_id" 
JOIN "category" c ON fc."category_id" = c."category_id" 
WHERE f."length" > 180 AND c."name" = 'Comedy';

/* 20.Encuentra las categorías de películas que tienen un promedio de 
duración superior a 110 minutos y muestra el nombre de la categoría 
junto con el promedio de duración.*/
SELECT "name", avg("length") 
FROM "category" c	
JOIN "film_category" fc ON c."category_id" = fc."category_id" 
JOIN film f ON fc."film_id" = f."film_id"
GROUP BY c."name"
HAVING avg("length") > 110;

/* 21.¿Cuál es la media de duración del alquiler de las películas?*/
SELECT avg("rental_duration") 
FROM "film" f; 

/* 22.Crea una columna con el nombre y apellidos de todos los actores y 
actrices.*/
SELECT concat("first_name",' ',"last_name") 
FROM "actor" a;

/* 23.Números de alquiler por día, ordenados por cantidad de alquiler de 
forma descendente.*/
SELECT count("rental_id") 
FROM "rental" r 
GROUP BY "rental_date" 
ORDER BY count("rental_id") DESC;

/* 24. Encuentra las películas con una duración superior al promedio.*/
SELECT "title", "length"
FROM "film" f
WHERE "length" >(SELECT  avg("length")
				FROM "film" f2 );
/* 25.Averigua el número de alquileres registrados por mes.*/
SELECT 
    EXTRACT(YEAR FROM "rental_date") AS year,
    EXTRACT(MONTH FROM "rental_date") AS month,
    COUNT(*) AS total_rentals
FROM "rental"
GROUP BY EXTRACT(YEAR FROM "rental_date"), EXTRACT(MONTH FROM "rental_date")
ORDER BY year, month;

/* 26.Encuentra el promedio, la desviación estándar y varianza del total 
pagado.*/
SELECT avg("amount"), variance("amount"), stddev("amount") 
FROM "payment" p;

/* 27.¿Qué películas se alquilan por encima del precio medio?*/
SELECT "title"
FROM "film" f 
WHERE "rental_rate" > (SELECT avg("rental_rate")
                      FROM "film" f2);

/* 28.Muestra el id de los actores que hayan participado en más de 40 
películas.*/
SELECT "actor_id", COUNT ("film_id") AS Total_Movies
FROM "film_actor" fa 
GROUP BY "actor_id" 
HAVING count("film_id") > 40; 

/* 29.Obtener todas las películas y, si están disponibles en el inventario, 
mostrar la cantidad disponible.*/
SELECT "title", f."film_id", count("inventory_id")
FROM "film" f
LEFT JOIN "inventory" i ON f."film_id" = i."film_id"
GROUP BY f."film_id";

/* 30.Obtener los actores y el número de películas en las que ha actuado.*/
SELECT concat("first_name",' ',"last_name") , COUNT("film_id")
FROM "film_actor" fa
RIGHT JOIN "actor" a ON fa."actor_id" = a."actor_id" 
GROUP BY a."actor_id";

/* 31.Obtener todas las películas y mostrar los actores que han actuado en 
ellas, incluso si algunas películas no tienen actores asociados.*/
SELECT "title", concat("first_name",' ',"last_name") 
FROM "film" f	
LEFT JOIN "film_actor" fa ON f."film_id" = fa."film_id"
LEFT JOIN "actor" a ON fa."actor_id" = a."actor_id";

/* 32.Obtener todos los actores y mostrar las películas en las que han 
actuado, incluso si algunos actores no han actuado en ninguna película.*/
SELECT concat("first_name",' ',"last_name"), "title"
FROM "actor" a 
LEFT JOIN "film_actor" fa ON a."actor_id" = fa."actor_id" 
LEFT JOIN "film" f ON fa."film_id" = f."film_id";

/* 33.Obtener todas las películas que tenemos y todos los registros de 
alquiler.*/
SELECT "title", r.* 
FROM "film" f 
LEFT JOIN "inventory" i ON f."film_id" = i."film_id" /*Mostramos todas las películas independientemente de su inventario*/
RIGHT JOIN "rental" r ON i."inventory_id" = r."inventory_id" /*Mostramos todos los alquileres independientemente de su inventario*/;

/* 34.Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.*/
SELECT concat("first_name",' ',"last_name"), sum("amount") as Total_Gastado
FROM "customer" c 
JOIN "payment" p ON c."customer_id" = p."customer_id"
GROUP BY c."customer_id" 
ORDER BY sum("amount") DESC  
LIMIT 5;

/* 35.Selecciona todos los actores cuyo primer nombre es 'Johnny'.*/
SELECT "first_name", "last_name" 
FROM "actor" a 
WHERE a."first_name" ~*'Johnny';

/* 36.Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como 
Apellido.*/
SELECT "first_name" as "Nombre", "last_name" as "Apellido"
FROM "actor" a;

/* 37.Encuentra el ID del actor más bajo y más alto en la tabla actor.*/
SELECT max("actor_id"), min("actor_id") 
FROM "actor" a;

/* 38.Cuenta cuántos actores hay en la tabla “actorˮ.*/
SELECT count("actor_id") 
FROM "actor" a;

/* 39.Selecciona todos los actores y ordénalos por apellido en orden 
ascendente.*/
SELECT "last_name" 
FROM "actor" a 
ORDER BY "last_name" ASC;

/* 40.Selecciona las primeras 5 películas de la tabla “filmˮ.*/
SELECT "title"
FROM "film" f  
limit 5;

/* 41.Agrupa los actores por su nombre y cuenta cuántos actores tienen el 
mismo nombre. ¿Cuál es el nombre más repetido?*/
SELECT "first_name", count( "actor_id") 
FROM "actor" a 
GROUP BY "first_name" 
ORDER BY count("first_name") DESC /* Los nombres más repetidos son "Kenneth", "Penelope" y "Julia";*/
 
/* 42. Encuentra todos los alquileres y los nombres de los clientes que los 
realizaron.*/
SELECT "rental_id", concat("first_name", ' ', "last_name") 
FROM "rental" r 
LEFT JOIN "customer" c ON r."customer_id" = c."customer_id";
 
/* 43.Muestra todos los clientes y sus alquileres si existen, incluyendo 
aquellos que no tienen alquileres.*/
SELECT concat("first_name",' ',"last_name") , "rental_id"
FROM "customer" c 
LEFT JOIN "rental" r ON c."customer_id" = r."customer_id";

/* 44.Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor 
esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/
SELECT f."film_id", f."title", c."category_id", c.name AS category_name
FROM "film" f
CROSS JOIN "category" c;
/* No tiene sentido emparejar cada película con las 10 diferentes categorías pues sólo pertenecen a una de ellas*/ 

/* 45.Encuentra los actores que han participado en películas de la categoría 
'Action'.*/
SELECT DISTINCT a."actor_id", concat( a."first_name",' ', a."last_name"), c."name" 
FROM "actor" a
JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
JOIN "film" f ON fa."film_id" = f."film_id"
JOIN "film_category" fc ON f."film_id" = fc."film_id"
JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Action';

/* 46.Encuentra todos los actores que no han participado en películas.*/
SELECT a."actor_id", concat("first_name",' ',"last_name")
FROM "actor" a 
LEFT JOIN "film_actor" fa ON a."actor_id" =fa."actor_id"
WHERE fa."film_id" is NULL;

/* 47.Selecciona el nombre de los actores y la cantidad de películas en las 
que han participado.*/
SELECT concat("first_name",' ',"last_name") , count("film_id")
FROM "film_actor" fa
JOIN "actor" a ON fa."actor_id" = a."actor_id" 
GROUP BY concat("first_name",' ',"last_name");

/* 48.Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres 
de los actores y el número de películas en las que han participado.*/
CREATE VIEW actor_num_peliculas AS
SELECT 
    a."first_name",
    a."last_name",
    COUNT(fa."film_id") AS num_peliculas
FROM "actor" a
LEFT JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
GROUP BY a."actor_id", a."first_name", a."last_name";

/* 49.Calcula el número total de alquileres realizados por cada cliente.*/
SELECT "customer_id", count("rental_id")
FROM "rental" r 
GROUP BY "customer_id";

/* 50.Calcula la duración total de las películas en la categoría 'Action'.*/
SELECT sum("length") 
FROM "film" f 
LEFT JOIN "film_category" fc ON f."film_id" = fc."film_id" 
LEFT JOIN "category" c ON fc."category_id" =c."category_id" 
WHERE C."name" ~* 'Action';

/* 51.Crea una tabla temporal llamada “cliente_rentas_temporalˮ para 
almacenar el total de alquileres por cliente.*/
SELECT 
    c."customer_id", 
    c."first_name", 
    c."last_name", 
    COUNT(r."rental_id") AS total_rentas
FROM "customer" c
JOIN "rental" r ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name";

/* 52.Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las 
películas que han sido alquiladas al menos 10 veces.*/
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT 
    f."film_id", 
    f."title", 
    COUNT(r."rental_id") AS total_rentals
FROM "film" f
JOIN "inventory" i ON f."film_id" = i."film_id"
JOIN "rental" r ON i."inventory_id" = r."inventory_id"
GROUP BY f."film_id", f."title"
HAVING COUNT(r."rental_id") >= 10;

/* 53.Encuentra el título de las películas que han sido alquiladas por el cliente 
con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena 
los resultados alfabéticamente por título de película.*/
SELECT f."title"
FROM "rental" r
JOIN "inventory" i ON r."inventory_id" = i."inventory_id"
JOIN "film" f ON i."film_id" = f."film_id"
WHERE r."customer_id" = (
    SELECT "customer_id" 
    FROM "customer" 
    WHERE "first_name" ~* 'Tammy' AND "last_name" ~* 'Sanders'
)
AND r."return_date" IS NULL
ORDER BY f."title";

/* 54.Encuentra los nombres de los actores que han actuado en al menos una 
película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados 
alfabéticamente por apellido.*/
SELECT DISTINCT "first_name", "last_name"
FROM "actor"
WHERE" actor_id" IN (
    SELECT fa."actor_id"
    FROM "film_actor" fa
    JOIN "film_category" fc ON fa."film_id" = fc."film_id"
    JOIN "category" c ON fc."category_id" = c."category_id"
    WHERE c."name" = 'Sci-Fi'
)
ORDER BY "last_name", "first_name";

/* 55.Encuentra el nombre y apellido de los actores que han actuado en 
películas que se alquilaron después de que la película ‘Spartacus 
Cheaperʼ se alquilara por primera vez. Ordena los resultados 
alfabéticamente por apellido.*/

SELECT DISTINCT a."first_name", a."last_name"
FROM "actor" a
JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
JOIN "film" f ON fa."film_id" = f."film_id"
JOIN "inventory" i ON f."film_id" = i."film_id"
JOIN "rental" r ON i."inventory_id" = r."inventory_id"
WHERE r."rental_date" >(
	SELECT min("rental_date") 
	FROM "film" f 
	LEFT JOIN "inventory" i ON f."film_id" = i."film_id"
	LEFT JOIN "rental" r ON i."inventory_id" = r."inventory_id" 
	WHERE "title" ~* 'Spartacus Cheaper')
ORDER BY a."last_name", a."first_name";

/* 56.Encuentra el nombre y apellido de los actores que no han actuado en 
ninguna película de la categoría ‘Musicʼ.*/
SELECT DISTINCT "first_name", "last_name"
FROM "actor"
WHERE "actor_id" NOT IN (SELECT fa."actor_id"
	FROM "film_actor" fa
	JOIN "film_category" fc ON fa."film_id" = fc."film_id"
	JOIN "category" c ON fc."category_id" = c."category_id"
	WHERE c."name" = 'Music');

/* 57.Encuentra el título de todas las películas que fueron alquiladas por más 
de 8 días.*/
SELECT DISTINCT f."title"
FROM "rental" r
JOIN "inventory" i ON r."inventory_id" = i."inventory_id"
JOIN "film" f ON i."film_id" = f."film_id"
WHERE EXTRACT(DAY FROM (r."return_date" - r."rental_date")) > 8
ORDER BY f."title";

/* 58.Encuentra el título de todas las películas que son de la misma categoría 
que ‘Animationʼ.*/
SELECT DISTINCT f."title"
FROM "film" f
JOIN "film_category" fc ON f."film_id" = fc."film_id"
JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."category_id" = (
    SELECT "category_id" 
    FROM "category" 
    WHERE "name" = 'Animation'
)
ORDER BY f."title";

/* 59.Encuentra los nombres de las películas que tienen la misma duración 
que la película con el título ‘Dancing Feverʼ. Ordena los resultados 
alfabéticamente por título de película.*/
SELECT "title", "length" 
FROM "film" f 
WHERE "length" = (
    SELECT "Length"
    FROM "film"f 
    WHERE "title" ~* 'Dancing fever')
ORDER BY "title" ASC;

/* 60.Encuentra los nombres de los clientes que han alquilado al menos 7 
películas distintas. Ordena los resultados alfabéticamente por apellido.*/
SELECT c."first_name", c."last_name", "renta.total_peliculas_distintas"
FROM ( SELECT r."customer_id", COUNT(DISTINCT i."film_id") AS total_peliculas_distintas
    FROM "rental" r 
    LEFT JOIN "inventory" i ON r."inventory_id" = i."inventory_id" 
    GROUP BY r."customer_id" 
    HAVING COUNT(DISTINCT i."film_id") >= 7
) renta
JOIN customer c ON renta."customer_id" = c."customer_id"
ORDER BY c."last_name" ASC;

/* 61.Encuentra la cantidad total de películas alquiladas por categoría y 
muestra el nombre de la categoría junto con el recuento de alquileres.*/
SELECT c."name" AS category_name, COUNT(r."rental_id") AS total_rentals
FROM "rental" r
JOIN "inventory" i ON r."inventory_id" = i."inventory_id"
JOIN "film" f ON i."film_id" = f."film_id"
JOIN "film_category" fc ON f."film_id" = fc."film_id"
JOIN "category" c ON fc."category_id" = c."category_id"
GROUP BY c."name"
ORDER BY "total_rentals" DESC;

/* 62.Encuentra el número de películas por categoría estrenadas en 2006.*/
SELECT count("release_year"), "name" 
FROM "film" f 
LEFT JOIN "film_category" fc ON f."film_id" = fc."film_id" 
LEFT JOIN "category" c ON fc."category_id" = c."category_id" 
WHERE f."release_year" = 2006
GROUP BY "name";

/* 63.Obtén todas las combinaciones posibles de trabajadores con las tiendas 
que tenemos.*/
SELECT s."store_id", s2."staff_id"
FROM "store" s 
CROSS JOIN "staff" s2

/* 64.Encuentra la cantidad total de películas alquiladas por cada cliente y 
muestra el ID del cliente, su nombre y apellido junto con la cantidad de 
películas alquiladas*/
SELECT 
    c."customer_id", c."first_name", c."last_name", t."total_rentals"
FROM ( SELECT "customer_id", COUNT("rental_id") AS total_rentals
    FROM "rental" 
    GROUP BY "customer_id"
) AS t
LEFT JOIN "customer" c ON t."customer_id" = c."customer_id";

