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



1. Evaluación del Coste Medio por Película por Productora



**MOTAVACIÓN**
Esta consulta permite a las productoras entender su estructura de costos y compararla con otras productoras. Es fundamental para lSET [~ROWS] ASa gestión financiera y la toma de decisiones estratégicas sobre la inversión en futuras producciones.

```MDX

WITH 
SET [~ROWS] AS
    [productora].[nombre].Members
SELECT
NON EMPTY {[Measures].[coste_medio]} ON COLUMNS,
NON EMPTY [~ROWS] ON ROWS
FROM [finanzas]

```

2. Análisis de la Tendencia de Satisfacción de Usuarios a lo Largo del Tiempo


**MOTAVACIÓN**
Esta consulta es útil para comprender cómo las decisiones creativas y de producción afectan la percepción del público. Permite a las productoras ajustar sus estrategias para mejorar la satisfacción del cliente.


```MDX

SELECT
NON EMPTY {[tiempo.ano].[ano].Members} ON COLUMNS,
NON EMPTY {[Measures].[satisfaccion]} ON ROWS
FROM [satisfacion]
WHERE ([productora].[nombre].[nombre productora específica])

```


3. Comparación de Ingresos y Costos por Director



**MOTAVACIÓN**
Esta consulta proporciona una visión clara del rendimiento financiero de las películas bajo la dirección de diferentes directores. Ayuda a identificar a los directores cuyas películas son más rentables.

```MDX


SELECT
NON EMPTY {[Measures].[coste], [Measures].[ingresos]} ON COLUMNS,
NON EMPTY {[director].[nombre].Members} ON ROWS
FROM [finanzas]

```

4. Comparación de Ingresos y Costos por Director entre un periodo de año s




Esta consulta  ofrece a las productoras de cine un análisis detallado del rendimiento financiero de sus películas a lo largo de un rango de años, enfocándose en los costes, ingresos y beneficios generados por todos los directores. Es crucial para evaluar la eficiencia y el impacto financiero de los directores, identificar tendencias en la rentabilidad a lo largo del tiempo, y ayudar en la toma de decisiones estratégicas. Al proporcionar una visión amplia de la salud financiera de las producciones, esta consulta permite a las productoras ajustar sus estrategias y colaboraciones para maximizar la rentabilidad y el éxito en el mercado


```MDX

WITH
SET [~FILTER] AS
    {[director.Jerarquiadirector].[nombre].Members}
SET [~ROWS] AS
    {[tiempo.ano].[ano].[${ano_inicio}]:[tiempo.ano].[ano].[${ano_fin}]}
SELECT
NON EMPTY {[Measures].[coste], [Measures].[ingresos], [Measures].[beneficios]} ON COLUMNS,
NON EMPTY [~ROWS] ON ROWS
FROM [finanzas]
WHERE [~FILTER]

```

5. Calcular la media de beneficios mensuales de las películas en los últimos años para identificar el mes más rentable para los lanzamientos.

**MOTAVACIÓN**

Esta consulta es fundamental para las productoras que buscan optimizar sus calendarios de lanzamiento. Al entender qué meses han generado históricamente mayores ingresos, pueden planificar estratégicamente sus estrenos para coincidir con estos períodos, maximizando así el potencial de ingresos de sus películas.

```MDX

WITH
SET [~Meses] AS
    [tiempo.ano].[mes].Members
SELECT
NON EMPTY {[Measures].[beneficios], [Measures].[coste]} ON COLUMNS,
NON EMPTY [~Meses] ON ROWS
FROM [finanzas]
WHERE ([director.Jerarquiadirector].[nombre].Members)


```
