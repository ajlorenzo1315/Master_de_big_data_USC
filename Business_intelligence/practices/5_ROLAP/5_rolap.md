What is the difference with previous ROLLUP query??

Población Total por País y Subtotales Anuales:
Esta consulta calcula la población total de cada país por año y también proporciona subtotales por cada año. La función ROLLUP se usa para generar subtotales junto con los totales principales, lo cual es útil para un resumen jerárquico de los datos.

Población Total con CUBE:
Esta consulta es similar a la anterior, pero utiliza CUBE en lugar de ROLLUP. CUBE genera subtotales para todas las combinaciones posibles de las columnas agrupadas (en este caso, país y año), así como un total general. La función COALESCE se usa para reemplazar los valores nulos con una etiqueta significativa. Esta consulta es más completa en términos de resumen en comparación con la consulta ROLLUP.

Diferencia Entre ROLLUP y CUBE:
La principal diferencia entre los dos está en el nivel de detalle en el resumen. ROLLUP crea una jerarquía de subtotales desde el más detallado al menos, mientras que CUBE proporciona subtotales para todas las combinaciones posibles de las columnas agrupadas.

Exercises
E1- Choose and apply an alternative method to insert the CSV file into PostgreSQL dimension
and fact tables.

ETL

### E2- Add another fact and propose a couple of analytical queries. Show the results.


Paso 1: Crear la Nueva Tabla de Hechos para el PIB

Supongamos que tienes un archivo CSV con datos del PIB. La tabla podría llamarse Fact_GDP y tendría una estructura similar a la siguiente:

- gdp_id (ID único para cada registro)
- country_id (ID del país, enlazado con la tabla Dim_Country)
- time_id (ID del tiempo, enlazado con la tabla Dim_Time)
- gdp_value (valor del PIB)

``` sql

CREATE TABLE Fact_GDP (
    gdp_id SERIAL PRIMARY KEY,
    country_id INT,
    time_id INT,
    gdp_value DECIMAL
);
```

Paso 2: Insertar Datos en la Tabla de Hechos del PIB

Puedes insertar datos en esta tabla desde tu archivo CSV usando un método adecuado, como un script de Python con pandas y psycopg2, o utilizando herramientas de importación de datos de PostgreSQL.
Paso 3: Consultas Analíticas

Una vez que tengas los datos del PIB en tu base de datos, puedes realizar varias consultas analíticas. Aquí hay dos ejemplos:

    Comparación de PIB y Población:
    Esta consulta comparará el PIB y la población para ver si hay una correlación entre ambos.

    sql

SELECT 
    dc."Country Name", 
    dt.year, 
    fp.population AS population, 
    fg.gdp_value AS gdp
FROM Fact_Population AS fp
JOIN Fact_GDP AS fg ON fp.country_id = fg.country_id AND fp.time_id = fg.time_id
JOIN Dim_Country AS dc ON fp.country_id = dc.country_id
JOIN Dim_Time AS dt ON fp.time_id = dt.time_id
ORDER BY dc."Country Name", dt.year;

Crecimiento del PIB a lo Largo del Tiempo:
Esta consulta analizará el crecimiento del PIB a lo largo del tiempo para cada país.

sql

SELECT 
    dc."Country Name", 
    dt.year, 
    LAG(fg.gdp_value, 1) OVER (PARTITION BY fg.country_id ORDER BY dt.year) AS previous_year_gdp,
    fg.gdp_value AS current_year_gdp
FROM Fact_GDP AS fg
JOIN Dim_Country AS dc ON fg.country_id = dc.country_id
JOIN Dim_Time AS dt ON fg.time_id = dt.time_id
ORDER BY dc."Country Name", dt.year;


### E3- We are only interested in data from real countries. What would you change to make it possible?

1. Filtrado en las Consultas SQL

Puedes incluir condiciones en tus consultas SQL para excluir datos que no pertenezcan a países reales. Esto se puede hacer verificando el nombre del país o utilizando un identificador específico que distinga a los países reales de otros tipos de entidades (como regiones o agrupaciones económicas).

Ejemplo de Consulta SQL con Filtrado:

```sql

SELECT * FROM Fact_Population AS fp
JOIN Dim_Country AS dc ON fp.country_id = dc.country_id
WHERE dc."Country Name" NOT IN ('Mundo', 'Unión Europea', 'África', etc.);
```

**NOTA** Se puede manténe una lista actualizada de países reconocidos internacionalmente (por ejemplo, los miembros de la ONU) y úsala para filtrar tus datos. Esto puede implicar la creación de una tabla adicional en tu base de datos que contenga solo los nombres o códigos de los países reconocidos. Y Si es posible, integra tu base de datos con fuentes de datos externas confiables que ya tengan esta distinción hecha. Por ejemplo, podrías utilizar APIs o bases de datos públicas que proporcionen información actualizada y verificada sobre países.


2. Limpieza y Preparación de Datos

Antes de cargar los datos en tu base de datos, realiza una limpieza y preparación de los mismos. Esto puede incluir la eliminación o marcado de registros que no correspondan a países reales.

3. Estructura de la Base de Datos

Modifica la estructura de tu base de datos para incluir un campo que indique si un registro pertenece a un país real o no. Por ejemplo, puedes agregar una columna is_real_country en tu tabla Dim_Country.

Ejemplo de Modificación de la Tabla:

```sql

ALTER TABLE Dim_Country
ADD COLUMN is_real_country BOOLEAN DEFAULT TRUE;
```

Luego, actualiza esta columna según corresponda y utiliza este campo en tus consultas para filtrar los datos.

### E4- I want the annual population by continent. How would you do it?


Paso 1: Modificar la Estructura de la Base de Datos

Debes asegurarte de que tu base de datos pueda relacionar cada país con su continente correspondiente. Esto se puede hacer de dos maneras:

    Agregar una Columna de Continente en Dim_Country:
    Añade una nueva columna en tu tabla Dim_Country que indique el continente de cada país.

```sql

ALTER TABLE Dim_Country
ADD COLUMN continent VARCHAR(255);
```
Después de añadir esta columna, tendrás que actualizar cada fila con el continente correspondiente.

Crear una Nueva Tabla de Dimensiones para Continentes:
Otra opción es crear una nueva tabla de dimensiones, como Dim_Continent, que relacione cada país con su continente. Esta tabla podría tener columnas para el ID del continente, el nombre del continente, y el ID del país.

```sql

    CREATE TABLE Dim_Continent (
        continent_id SERIAL PRIMARY KEY,
        continent_name VARCHAR(255),
        country_id INT
    );
```
Paso 2: Consultas SQL para la Población por Continente

Una vez que tengas la relación entre países y continentes, puedes escribir consultas SQL para obtener la población anual por continente. Aquí hay un ejemplo de cómo podrías hacerlo:

```sql

SELECT 
    dt.year,
    dc.continent,
    SUM(fp.population) AS total_population
FROM Fact_Population AS fp
JOIN Dim_Country AS dc ON fp.country_id = dc.country_id
JOIN Dim_Time AS dt ON fp.time_id = dt.time_id
GROUP BY dt.year, dc.continent
ORDER BY dt.year, dc.continent;
```
Esta consulta suma la población de todos los países por continente y año, agrupando los datos primero por año y luego por continente.

Si usas una tabla de dimensiones separada para los continentes (Dim_Continent), tu consulta se vería ligeramente diferente, ya que tendrías que hacer un JOIN adicional con esta tabla.
