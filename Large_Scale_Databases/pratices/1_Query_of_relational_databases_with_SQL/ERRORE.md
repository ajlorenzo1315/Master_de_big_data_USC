codigo 

SELECT c.nombre ,
      MIN(p.ingresos - p.presupuesto) AS min_beneficio,
      MAX(p.ingresos - p.presupuesto) AS max_beneficio,
      AVG(p.ingresos - p.presupuesto) AS media_beneficio,
      CORR(p.presupuesto, p.ingresos) AS correlacion_presupuesto_ingresos,
      CORR(p.popularidad, p.presupuesto) AS correlacion_popularidad_presupuesto,
      CORR(p.popularidad, p.ingresos) AS correlacion_popularidad_ingresos
FROM peliculas p , colecciones c 
WHERE p.coleccion = c.id and c.nombre like '%Star Wars Collection%';

SQL Error [42803]: ERROR: la columna «c.nombre» debe aparecer en la cláusula GROUP BY o ser usada en una función de agregación

sol

El error que estás viendo se debe a que estás seleccionando la columna c.nombre en tu consulta sin incluirla en una cláusula GROUP BY o en una función de agregación, como MIN, MAX, o AVG. En SQL, cuando estás utilizando una cláusula GROUP BY, todas las columnas en la lista de selección deben estar incluidas en la cláusula GROUP BY o estar dentro de una función de agregación.

Si deseas obtener el nombre de la colección "Star Wars Collection" junto con las estadísticas de beneficio y correlación, puedes hacerlo utilizando una subconsulta o una consulta anidada. Aquí tienes una forma de hacerlo utilizando una subconsulta:


SELECT c.nombre,
       min_beneficio,
       max_beneficio,
       media_beneficio,
       correlacion_presupuesto_ingresos,
       correlacion_popularidad_presupuesto,
       correlacion_popularidad_ingresos
FROM colecciones c
INNER JOIN (
    SELECT coleccion, 
           MIN(ingresos - presupuesto) AS min_beneficio,
           MAX(ingresos - presupuesto) AS max_beneficio,
           AVG(ingresos - presupuesto) AS media_beneficio,
           CORR(presupuesto, ingresos) AS correlacion_presupuesto_ingresos,
           CORR(popularidad, presupuesto) AS correlacion_popularidad_presupuesto,
           CORR(popularidad, ingresos) AS correlacion_popularidad_ingresos
    FROM peliculas
    GROUP BY coleccion
) p_stats
ON c.id = p_stats.coleccion
WHERE c.nombre LIKE '%Star Wars Collection%';

En esta consulta, primero calculamos las estadísticas de beneficio y correlación en una subconsulta agrupando por la columna coleccion. Luego, unimos esta subconsulta con la tabla de colecciones para obtener el nombre de la colección "Star Wars Collection" junto con las estadísticas correspondientes. Esto evita el error que mencionabas y te proporciona el resultado deseado.

otra solución


SELECT 
      MIN(p.ingresos - p.presupuesto) AS min_beneficio,
      MAX(p.ingresos - p.presupuesto) AS max_beneficio,
      AVG(p.ingresos - p.presupuesto) AS media_beneficio,
      CORR(p.presupuesto, p.ingresos) AS correlacion_presupuesto_ingresos,
      CORR(p.popularidad, p.presupuesto) AS correlacion_popularidad_presupuesto,
      CORR(p.popularidad, p.ingresos) AS correlacion_popularidad_ingresos,
      
FROM peliculas p , colecciones c 
WHERE p.coleccion = c.id and c.nombre like '%Star Wars Collection%';