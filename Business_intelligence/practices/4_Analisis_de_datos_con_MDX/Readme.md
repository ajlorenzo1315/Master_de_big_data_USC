Sesión 4: Análisis de datos con MDX

En esta sesión vamos a utlizar la interfaz gráfica de SAIKU Analytics para resolver consultas. Para cada consulta nos fijaremes en el código MDX generado.

En la siguiente página tenéis algo de documentación sobre Saiku (algunas de las opciones pertenecen a la opción Enterprise, que no está instalada): https://saiku-documentation.readthedocs.io/en/latest/.

Solo Filas

1.- Obtener el beneficio generado por cada productora. Ordena el resultado por beneficio de forma descendente.

**MOTIVACIÓN**

- Evaluación de Satisfacción Media: La consulta MDX permite a una productora determinar el beneficio medio de sus películas. Esto es crucial para comprender cómo sus la rentabilidad de las mismas. 

- Comparación con Otras Productoras: La consulta no solo calcula los beneficios media para una productora en particular, sino que también permite comparar estos resultados con los de otras productoras. Esto es esencial para situar a la productora en un contexto más amplio y comprender cómo se compara en términos de beneficios con respecto a sus competidores. Esta comparación proporciona información valiosa sobre la posición relativa de la productora en el mercado.


**MDX:**
```MDX

WITH
SET [~ROWS] AS
    Order({[productora].[nombre].Members},[Measures].[satisfacion],DESC)
SELECT
NON EMPTY {[Measures].[satisfacion]} ON COLUMNS,
NON EMPTY [~ROWS] ON ROWS
FROM [satisfacion]


WITH
SET [~ROWS] AS
     Order({[productora].[nombre].Members},[Measures].[beneficios],DESC)
SELECT
NON EMPTY {[Measures].[beneficios]} ON COLUMNS,
NON EMPTY [~ROWS] ON ROWS
FROM [finanzas]

```

2.- Limita el resultado anterior a solo las 10 productoras que generan más beneficios

**MOTAVACIÓN**
- Limitar el resultado a las 10 productoras que generan más beneficios, se concentra en las productoras que tienen un impacto significativo en los ingresos. Esto permite una evaluación más enfocada de las productoras más exitosas en lugar de examinar todas las productoras, lo que puede ser abrumador.

```MDX
WITH
SET [~TOP10Productoras] AS
    TopCount(
        [productora].[nombre].Members,
        10, [Measures].[beneficios]
    )
SELECT
NON EMPTY {[Measures].[beneficios]} ON COLUMNS,
NON EMPTY [~TOP10Productoras] ON ROWS
FROM [finanzas]
```

3.- Muestra la misma información pero solo para las productoras 'Walt Disney Pictures', 'Columbia Pictures'

```MDX
WITH
SET [~ProductorasFiltradas] AS
    {[productora].[nombre].&[Walt Disney Pictures], [productora].[nombre].&[Columbia Pictures]}
SELECT
NON EMPTY {[Measures].[beneficios]} ON COLUMNS,
NON EMPTY [~ProductorasFiltradas] ON ROWS
FROM [finanzas]


WITH
SET [~ROWS_productora_productora.productora] AS
    {[productora].[nombre].&[Walt Disney Pictures], [productora].[nombre].&[Columbia Pictures]}
SET [~ROWS_tiempo_tiempo.ano] AS
    {[tiempo.ano].[ano].Members}
SELECT
NON EMPTY {[Measures].[beneficios]} ON COLUMNS,
NON EMPTY NonEmptyCrossJoin([~ROWS_productora_productora.productora], [~ROWS_tiempo_tiempo.ano]) ON ROWS
FROM [finanzas]

```

4.- Muestra también el total.

```
WITH
SET [~TOP20Combinaciones] AS
    TopCount(
        CrossJoin([productora].[nombre].Members, [director].[nombre].Members),
        20, [Measures].[beneficios]
    )
SET [~TotalBeneficios] AS
    Sum([~TOP20Combinaciones], [Measures].[beneficios])
SELECT
NON EMPTY {[Measures].[beneficios], [~TotalBeneficios]} ON COLUMNS,
NON EMPTY [~TOP20Combinaciones] ON ROWS
FROM [finanzas]
```

Filtros

5.- Mostrar los datos de beneficio de cada productora, pero solo para el año 2012 (para los últimos 5 años)

Filas y columnas

```MDX
WITH
SET [~ULTIMOS5Anos] AS
    Tail(
        [tiempo.ano].[ano].Members,
        5
    )
SELECT
NON EMPTY {[Measures].[beneficios]} ON COLUMNS,
NON EMPTY [~ULTIMOS5Anios] ON ROWS
FROM [finanzas]

WITH
SET [~ROWS_tiempo_tiempo.ano] AS
    {[tiempo.ano].[ano].&[2012]}
NON EMPTY {[Measures].[satisfacion]} ON COLUMNS,
NON EMPTY NonEmptyCrossJoin([~ROWS_productora_productora.productora], [~ROWS_tiempo_tiempo.ano]) ON ROWS
FROM [finanzas]

WITH
SET [~ROWS_productora_productora.productora] AS
    {[productora].[nombre].&[Walt Disney Pictures], [productora].[nombre].&[Columbia Pictures]}
SET [~ROWS_tiempo_tiempo.ano] AS
    {[tiempo.ano].[ano].&[2012]}
SELECT
NON EMPTY {[Measures].[beneficios]} ON COLUMNS,
NON EMPTY NonEmptyCrossJoin([~ROWS_productora_productora.productora], [~ROWS_tiempo_tiempo.ano]) ON ROWS
FROM [finanzas]



WITH
SET [~ROWS_productora_productora.productora] AS
    {[productora].[nombre].Members}
SET [~ROWS_tiempo_tiempo.ano] AS
    {[tiempo.ano].[ano].&[2012]}
SELECT
NON EMPTY {[Measures].[beneficios]} ON COLUMNS,
NON EMPTY NonEmptyCrossJoin([~ROWS_productora_productora.productora], [~ROWS_tiempo_tiempo.ano]) ON ROWS
FROM [finanzas]


WITH
SET [~ROWS_productora_productora.productora] AS
    {[productora].[nombre].Members}
SET [~ROWS_tiempo_tiempo.ano] AS
    {[tiempo.ano].[ano].&[2012]}
SELECT
NON EMPTY {[Measures].[beneficios]} ON COLUMNS,
NON EMPTY NonEmptyCrossJoin([~ROWS_productora_productora.productora], 
                            [~ROWS_tiempo_tiempo.ano].Lag(5):[~ROWS_tiempo_tiempo.ano]) ON ROWS
FROM [finanzas]

WITH
SET [~ROWS_productora_productora.productora] AS
    {[productora].[nombre].Members}
SET [~ROWS_tiempo_tiempo.ano] AS
    [tiempo.ano].[ano].&[2016]:[tiempo.ano].[ano].&[2012]
SELECT
NON EMPTY {[Measures].[beneficios]} ON COLUMNS,
NON EMPTY NonEmptyCrossJoin([~ROWS_productora_productora.productora], [~ROWS_tiempo_tiempo.ano]) ON ROWS
FROM [finanzas]


```

6.- Mostrar datos de beneficio para combinaciones de productoras y directores (los 20 con más beneficio).

```MDX
WITH
SET [~TOP20Combinaciones] AS
    TopCount(
        CrossJoin([productora].[nombre].Members, [director].[nombre].Members),
        20, [Measures].[beneficios]
    )
SELECT
NON EMPTY {[Measures].[beneficios]} ON COLUMNS,
NON EMPTY [~TOP20Combinaciones] ON ROWS
FROM [finanzas]

```

ENTREGA INDIVIDUAL: Propón 5 consultas más con datos de finanzas o de satisfacción de usuarios. Describe la consulta y por qué puede ser interesante para una productora. Entrega el enunciado, la descripción y el código MDX. 