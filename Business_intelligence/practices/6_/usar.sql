WITH 
SET [~FILTER] AS 

    {
        [director.Jerarquiadirector].[nombre].[David Yates]
    }

SET [~ROWS] AS 
   
     {
        [tiempo_emision].[ano].[2006],
        [tiempo_emision].[ano].[2007],
        [tiempo_emision].[ano].[2008],
        [tiempo_emision].[ano].[2009],
        [tiempo_emision].[ano].[2010],
        [tiempo_emision].[ano].[2011],
        [tiempo_emision].[ano].[2012],
        [tiempo_emision].[ano].[2013],
        [tiempo_emision].[ano].[2014],
        [tiempo_emision].[ano].[2015],
        [tiempo_emision].[ano].[2016],
        [tiempo_emision].[ano].[2017],
        [tiempo_emision].[ano].[2018],
        [tiempo_emision].[ano].[2019]
    }

SELECT 
NON EMPTY {[Measures].[numero votos]} ON COLUMNS, 
NON EMPTY [~ROWS] ON ROWS 
FROM [satisfacion] 
WHERE [~FILTER]



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
