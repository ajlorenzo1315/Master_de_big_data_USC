data 
https://ourworldindata.org/grapher/who-regions
https://data.humdata.org/dataset/coronavirus-covid-19-cases-and-deaths/resource/2ac6c3c0-76fa-4486-9ad0-9aa9e253b78d
https://ourworldindata.org/covid-vaccinations
https://covid19.who.int/data


pentaho/data-integration/spoon.sh

Para cargar datos de un archivo CSV a las tablas pais, tiempo, y cifras_covid usando Pentaho Data Integration (también conocido como Spoon), deberás seguir estos pasos:
Paso 1: Preparar Pentaho Data Integration

Asegúrate de tener instalado Pentaho Data Integration. Si no lo tienes, puedes descargarlo desde el sitio web oficial de Pentaho.
Paso 2: Crear una Nueva Transformación

    Abre Pentaho Data Integration y crea una nueva transformación.
    Dentro de la transformación, necesitarás añadir y configurar varios pasos para leer, transformar y cargar tus datos.

Paso 3: Leer el Archivo CSV

    Añade un paso de entrada de texto (Input → Text file input).
    Configura este paso para leer tu archivo CSV, asegurándote de definir correctamente los campos según tu archivo CSV.

Paso 4: Transformar los Datos para la Tabla pais

    Utiliza el paso "Select/Rename values" para seleccionar y renombrar los campos necesarios para la tabla pais (Country_code, Country, WHO_region).
    Añade un paso "Unique rows" para eliminar duplicados.

Paso 5: Transformar los Datos para la Tabla tiempo

    Utiliza un paso de "Modified Java Script Value" para extraer y transformar la fecha en año, mes, día y nombre del mes.
    Usa funciones de JavaScript para dividir el campo de fecha y crear los campos correspondientes.

Paso 6: Transformar los Datos para la Tabla cifras_covid

    Utiliza otro paso de "Select/Rename values" para preparar los campos necesarios para la tabla cifras_covid (id_pais, id_tiempo, confirmados, muertes).

Paso 7: Cargar Datos en las Tablas

    Para cada tabla (pais, tiempo, y cifras_covid), utiliza un paso de "Table Output" para cargar los datos transformados en tu base de datos.
    Configura cada "Table Output" con los detalles de conexión a tu base de datos y mapea los campos de entrada a las columnas de la tabla correspondiente.

Paso 8: Ejecutar la Transformación

    Una vez configurados todos los pasos, ejecuta la transformación para cargar los datos en tus tablas.
    Verifica en tu base de datos que los datos se hayan cargado correctamente.
