
Descripción del Conjunto de [Datos](https://www.ine.es/jaxiT3/Tabla.htm?t=10911&L=0):
El conjunto de datos contine  información del salario medio diferenciando por  género y  sectores de actividad económica. A continuación, se describe cada columna del conjunto de datos:

- "Sectores.de.actividad.económica": Esta columna indica los diferentes sectores económicos o áreas de actividad, como industria, agricultura, servicios, etc. Cada fila representa un sector económico específico.

- "Sexo.Brecha.de.género": Esta columna contien información sobre  género en cada sector. 

- "Periodo": Esta columna indica el período de tiempo al que se refieren los datos,en años, 

- "Total": Esta columna indica el salario medio anual por sectores de actividad económica y periodo. Unidades: €, %

Objetivos del Estudio de Salario por Sector y Desigualdad:
El estudio propuesto tiene como objetivo analizar la relación entre el salario y la desigualdad de género en los diferentes sectores de actividad económica. A continuación, se explica cómo se podría llevar a cabo este estudio:

    Análisis de Salario por Sector: Se podría realizar un análisis de los salarios promedio o medianos en cada uno de los sectores económicos mencionados en la columna "Sectores.de.actividad.económica". Esto permitiría identificar sectores donde los salarios son más altos o más bajos.

    Evaluación de la Desigualdad de Género en Salarios: Luego, se podría analizar la desigualdad de género en cada sector. Esto implica comparar los salarios de hombres y mujeres en cada sector y determinar si existen brechas salariales significativas.

    Comparación de Sectores: Se podría comparar la desigualdad de género en los diferentes sectores para identificar aquellos donde la brecha de género es más pronunciada o donde las mujeres tienen una representación menor.

    Alo largo del tiempo


valores unicos por sector

    [1] "B_S Secciones B-S: Industria, construcción y servicios (excepto actividades de los hogares como empleadores y organizaciones extraterritoriales)"
    [2] "F Construcción"                                                                                                                                  
    [3] "B Industrias extractivas"                                                                                                                        
    [4] "H Transporte y almacenamiento"                                                                                                                   
    [5] "P Educación"                                                                                                                                     
    [6] "O Administración Pública y defensa, Seguridad Social obligatoria"                                                                                
    [7] "E Suministro de agua, actividades de saneamiento, gestión de residuos y descontaminación"                                                        
    [8] "D Suministro de energía eléctrica, gas, vapor y aire acondicionado"                                                                              
    [9] "I Hostelería"                                                                                                                                    
    [10] "J Información y comunicaciones"                                                                                                                  
    [11] "C Industria manufacturera"                                                                                                                       
    [12] "R Actividades artísticas, recreativas y de entretenimiento"                                                                                      
    [13] "K Actividades financieras y de seguros"                                                                                                          
    [14] "L Actividades inmobiliarias"                                                                                                                     
    [15] "G Comercio al por mayor y al por menor, reparación de vehículos de motor y motocicletas"                                                         
    [16] "Q Actividades sanitarias y de servicios sociales"                                                                                                
    [17] "M Actividades profesionales, científicas y técnicas"                                                                                             
    [18] "N Actividades administrativas y servicios auxiliares"                                                                                            
    [19] "S Otros servicios"   

> valores_unicos <- unique(datos$Sexo.Brecha.de.género)
> valores_unicos
    [1] "Mujeres"                             "Hombres"                            
    [3] "Cociente mujeres respecto a hombres"

> valores_unicos <- unique(datos$Periodo)
> valores_unicos
 [1] 2020 2019 2018 2017 2016 2015 2014 2013 2012 2011 2010 2009



 > head(subtabla_educacion)
    Sectores.de.actividad.económica Sexo.Brecha.de.género Periodo    Total
145                     P Educación               Mujeres    2020 26.349,5
146                     P Educación               Mujeres    2019   25.221
147                     P Educación               Mujeres    2018 23.225,8
148                     P Educación               Mujeres    2017   22.784
149                     P Educación               Mujeres    2016 21.622,5
150                     P Educación               Mujeres    2015 20.981,6

> cat("Número de filas en el subconjunto:", num_filas, "\n")
Número de filas en el subconjunto: 36 
> cat("Número de columnas en el subconjunto:", num_columnas, "\n")
Número de columnas en el subconjunto: 4 



    Las filas representan observaciones o casos individuales. Cada fila suele corresponder a un registro único o una instancia específica en el conjunto de datos. Por ejemplo, si estás trabajando con datos de personas, cada fila podría representar a una persona individual con sus características.

    Las columnas representan variables o atributos. Cada columna contiene información específica sobre una característica o propiedad de los casos en las filas. Por ejemplo, si estás trabajando con datos de personas, las columnas podrían incluir variables como  Sexo.Brecha.de.género Periodo    Total. Cada columna contiene los valores correspondientes para cada caso u observación.


¿Cómo son las variables que estás estudiando? Cuantitativas (discretas o continuas), cuali-
tativas (nominales u ordinales).

son todas discretas 
