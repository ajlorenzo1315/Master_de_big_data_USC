Do we need the statictics in real time?
Depende de la vacunación por ejemplo en momnetos en los que se usa para un control es importante saber a que hora exacta se inyecto la vacuna para saber en caso de que haga reacción alergica o de que un lote este contaminado en este caso se recomenda hacerlo por horas no es del todo tiempo 
real pero permite tener una aproximación del momento de la vacuna. 

kimball approacj: define business requirements indtifi business processer , the level od details opde the data enseure data quality confirmed dimesión and fact, ETL , user needa

Enfoque de Kimball: definir los requisitos comerciales, identificar el procesador comercial, el nivel de detalles de los datos, garantizar la calidad de los datos, la dimensión y los hechos confirmados, ETL, las necesidades del usuario.

Requisitos comerciales:

- Seguimiento de Enfermedades: Identificar y analizar tendencias de enfermedades infecciosas.
- Gestión de Vacunaciones: Monitorear la distribución y efectividad de las vacunas.
- Evaluación de Servicios de Salud: Evaluar la capacidad y respuesta de los hospitales y centros de salud.
- Investigación y Prevención: Apoyar la investigación epidemiológica y las iniciativas de prevención.

Identificar Procesos Empresariales

- Registro y Monitoreo de Enfermedades: Incluye diagnóstico, tratamiento y seguimiento de enfermedades.
- Programas de Vacunación: Administración y seguimiento de vacunas.
- Gestión Hospitalaria: Operaciones diarias en hospitales y clínicas.
- Investigación Epidemiológica: Estudios y análisis para entender la propagación y prevención de enfermedades.

Granularidad

- Como se comento en el tiempo es recomendable almenos llegar a horas pero se podria usar tambien minutos (en muchos casos es muy importante seber el conociminto de tiempo exacto para saber la expasión de una infeción o control)

- la Persona tiene que tener una grananularidad de individuo puesto que cada persona puede reaciónar de manera distinta a las enfermedades y vacunas

- el lugar deveria se por calle ya que permite detectar la localización o concentración de contagiados

- enfermded cada variante de la mismas por que aunque tengan sisntomas similares hay muchas veces que en casos que puede darse la situación que aunque procedan de la misma basteria o virus  tengan comportamientos distintos 

- vacuna  por cada lote de vacuna deveria indicarse la farmaceutica, tipo  y el lote que se uso .

define basic requrements that make sense 


supongamos que los echos podrian ser dos

vacunación 

infección


las dimensiones pueden ser

tiempo (horas)

lugar (calle)

enfermedad ( variante de cada tipo de enfermedad)

vacuna (por  lote de vacuna id)

paciente (por persona )


todo esto puede ayudar a tener un mayor control sobre futuras epidemias asi como el control sobre las actuales. En este caso al tener dimensiones temporales con una granuladidad de hora o podria ser que el dat ware house trabaje con desfase o no todos los centros proporcionen dicha informcaión a la misma vez  por otro lado tambiens e pude tener problemas con el estudio real de la infeción por que dependiendo a la velocidad que se propagué es complicado  rastrear a todos los infectados.

Necesidades de los Usuarios

- Informes y Dashboards: Herramientas de informes para visualizar tendencias y patrones.
- Acceso a Datos en Tiempo Real: Para monitoreo inmediato de eventos de salud críticos.
- Análisis Predictivo y Descriptivo: Para apoyar la toma de decisiones y la planificación estratégica.


Recopilación de datos 

- Hospitales  públicos como privados, se podria pedir a los hospitales mantener un registro de las vacunas  que se han inyectadi asi como la pacientens ingresados por  una enfermedad infecionsa 

- centros de salud  públicos como privados, se podria pedir a los hospitales mantener un registro de las vacunas  que se han inyectadi asi como la pacientens ingresados por  una enfermedad infecionsa 

- Personal llame a un numero cuando se encuentre enfermo debido a una infección similar a como se actuo en el covid  concienciar a las personas para que reporten en caso de estar infectados 

- pedir el historia de traslado de personas en caso de que esten infectadas para conocer la procedencia de la mismas

- pedir reportes al   INE (instituto nacional de estadistica)

- usar el conocimiento del censo para obtener información sobre la residencia de un paciente
