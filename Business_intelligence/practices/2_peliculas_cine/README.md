## Sesión 2: Creación de cubos de datos 

Schema Workbench nos permite diseñar cubos multidimensionales a partir de modelos de datos en estrella almacenados en nuestra base de datos. Empezamos por generar un ejemplo de modelo simple en estrella a partir de nuestra tabla de tormentas.



Utilizamos ahora Schema Workbench para crear un cubo y publicarlo en Pentaho. Para evitar confusiones, vamos primero a borrar la fuente de datos generada en la sesión anterior. Schema Workbench se ejecuta como sigue.


# Creación de los cubos de datos

Utilizando como base las estructuras de datos relacionales descritas en la subsección anterior,
se crea un esquema multidimensional con dos cubos. Dado que las dimensiones se comparten
entre los dos cubos, se definen primero a nivel de esquema y después se reutilizan a nivel de cubo.

## Esquema: ProduccionCine

- Dimensión: director. Dimensión de tipo estándar.
  - Jerarquía: jerarquiadirector. Definida por el atributo id.
  - Nivel: niveldirector. Nivel de tipo regular definido por el atributo nombre.
  - Tabla: directores

- Dimensión: productor. Dimensión de tipo estándar.
  - Jerarquía: jerarquiaproductor. Definida por el atributo id.
  - Nivel: niveldirector. Nivel de tipo regular definido por el atributo nombre.
  - Tabla: productores.

- Dimensión: productora. Dimensión de tipo estándar.
  - Jerarquía: jerarquiaproductora. Definida por el atributo id.
  - Nivel: nivelproductora. Nivel de tipo regular definido por el atributo nombre.
  - Tabla: productores.

- Dimensión: tiempo. Dimensión de tipo temporal.
  - Jerarquía: jerarquiatiempo. Definida por el atributo id.
  - Nivel: anno. Nivel de tipo TimeYears definido por el atributo ano.
  - Nivel: mes. Nivel de tipo TimeMonths definido por el atributo mes. Se utiliza el atributo mes_texto para nombrar a los elementos de este nivel.
  - Tabla: tiempo.

## Cubo: satisfaccion

- Tabla: satisfaccion_usuarios
- Dimensiones
  - Dimensión usada: director. Se referencia la dimensión director. Se utiliza el atributo director como clave foránea.
  - Dimensión usada: productor. Se referencia la dimensión productor. Se utiliza el atributo productor como clave foránea.
  - Dimensión usada: productora. Se referencia la dimensión productora. Se utiliza el atributo productora como clave foránea.
  - Dimensión usada: tiempoemision. Se referencia la dimensión tiempo. Se utiliza el atributo tiempo_emision como clave foránea.
  - Dimensión usada: tiempovotacion. Se referencia la dimensión tiempo. Se utiliza el atributo tiempo_votacion como clave foránea.
- Medidas
  - Medida: votos. Se agrega el atributo votos usando la función SUM.
  - Medida: satisfaccion. Se agrega el atributo satisfacción usando la función AVG.

## Cubo: finanzas

- Tabla: finanzas
- Dimensiones
  - Dimensión usada: director. Se referencia la dimensión director. Se utiliza el atributo director como clave foránea.
  - Dimensión usada: productor. Se referencia la dimensión productor. Se utiliza el atributo productor como clave foránea.
  - Dimensión usada: productora. Se referencia la dimensión productora. Se utiliza el atributo productora como clave foránea.
  - Dimensión usada: tiempoemision. Se referencia la dimensión tiempo. Se utiliza el atributo tiempo como clave foránea.
- Medidas
  - Medida: coste. Se agrega el atributo coste usando la función SUM.
  - Medida: ingresos. Se agrega el atributo ingresos usando la función SUM.
  - Medida calculada: beneficio. Se genera un nuevo valor para la dimensión Measures usando la expresión MDX "[Measures].[ingresos]-[Measures].[coste]"
