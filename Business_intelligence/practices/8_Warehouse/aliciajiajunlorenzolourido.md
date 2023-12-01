### Enfoque de Kimball para el Diseño de un Almacén de Datos en el Servicio de Epidemiología de Galicia
##### Requisitos Comerciales

- Seguimiento de Enfermedades: Identificar y analizar tendencias de enfermedades infecciosas.
- Gestión de Vacunaciones: Monitorear la distribución y efectividad de las vacunas.
- Evaluación de Servicios de Salud: Evaluar la capacidad y respuesta de los hospitales y centros de salud.
- Investigación y Prevención: Apoyar la investigación epidemiológica y las iniciativas de prevención.

##### Procesos Empresariales

- Registro y Monitoreo de Enfermedades: Diagnóstico, tratamiento y seguimiento de enfermedades.
- Programas de Vacunación: Administración y seguimiento de vacunas.
- Gestión Hospitalaria: Operaciones diarias en hospitales y clínicas.
- Investigación Epidemiológica: Estudios y análisis para entender la propagación y prevención de enfermedades.

##### Granularidad de los Datos

- Tiempo: Al menos a nivel de horas para rastrear eventos críticos.
- Pacientes: Individualmente para comprender reacciones y efectos variados.
- l: Por calle, para identificar focos de contagio.
- Enfermedades: Cada variante para diferenciar comportamientos.
- Vacunas: Por lote, incluyendo detalles de farmacéutica y tipo.

##### Hechos y Dimensiones

- Hechos:

    - Vacunación
    - Infección

- Dimensiones:

    - Tiempo (horas)
    - l (calle)
    - Enfermedad (variante)
    - Vacuna (por lote)
    - Paciente (individual)

##### Necesidades de los Usuarios

- Informes y Dashboards: Herramientas para visualizar tendencias y patrones.
- Acceso a Datos en Tiempo Real: Monitoreo inmediato de eventos de salud críticos.
- Análisis Predictivo y Descriptivo: Apoyo a la toma de decisiones y planificación estratégica.

##### Recopilación de Datos

- Hospitales y Centros de Salud: Registros de vacunaciones y pacientes con enfermedades infecciosas.
- Reportes de Personas Enfermas: Incentivar a que las personas informen sobre infecciones.
- Historial de Traslados: Para rastrear la propagación de infecciones.
- Reportes del INE y Censo: Información estadística y residencial.
- Apoyarce en otras organizaciones que tengan datos sobre el tema:  ONS 
- Red Nacional de Vigilancia Epidemiológica (RENAVE) 

##### Consideraciones Adicionales

- Importancia de la calidad y la organización de los datos.
- Granularidad y detalle son cruciales para un análisis eficaz, este pude variar dependiendo de la fuemte de datos por lo que hay que  solucionar la posibilidad de incopatibilidad con el data warehouse.
- Posible desfase en la recopilación de datos debido a la variedad de fuentes.


#### Query 

Podemos saber cuantas infeciones por enfermedad hubo indicandonos el lugar

```sql
select i.nombre, l.nombre ,count(*) 
from infeccion i , lugar l , tiempo t 
where t.ano = 2023 and i.lugar_id = l.id and i.tiempo_id = t.id 
group by i.nombre;
-- se podria indicar que agupase por lugar y enfermdad lo que nos permite saber por lugar que
-- enfermedad es mas comun 
select l.nombre, i.nombre, count(*) as num_Casos
from infeccion i , lugar l , tiempo t 
where i.lugar_id = l.id and i.tiempo_id = t.id and  t.ano = 2023
group by l.nombre, Enfermedad.nombre
order by l.nombre, count(*) desc;
 
```

Consulta para evaluar la efectividad de diferentes lotes de vacunas.

```sql
select v.nombre, count(distinct p.id) as num_pacientes, sum(case when i.id IS NULL then 1 else 0 end) as sin_infeccion 
from vacuna v, infeccion i , lugar l , tiempo t , paciente p 
where t.ano = 2023 and i.lugar_id = l.id and i.tiempo_id = t.id and
p.vac_id=v.id and p.inf_id=i.id 
group by v.nombre

```

Distribución de vacunación por  edades de Pacientes 

```sql

select v.nombre, p.edad, COUNT(distinct p.id) AS num_Casos
from vacuna v, paciente p 
where  v.id = p.vac_id
group by v.nombre, p.edad
order by p.edad;

```