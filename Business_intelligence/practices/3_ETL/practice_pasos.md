
1. en ela maquina virtual 

en un shell

pentaho/data-integration/spoon.sh

2. buscar donde tiener los archivos  que nod dio el profesor de cv y llevarlos a 

3. crear variable doble click en el board 

4. en el  xml que cargamos en del dashboard editar file para añadir nuestros datos

    file/directorio ${data_load}
    wildcard tormentas-[0-9][0-9][0-9][0-9].xml

5. ahora vamos a content  
    y en getpath y selecionaos el path que queremos

    /tomerntas

6. en fields le damos a get fields

7. en nuestro caso revisamos los datos y cambiamos los que necesiten 

    EN estes caso usamos por ejempo mean vientos 
    tambien indormar las cosa que ncesitas
    como la coma que por defecto usa el punto

    nota eliminar espacuoiane  blaco 
    en este caso ponemos en decimales , para vientos medios
    y cambiamos el inter a numeric y luego quitamos los espacios

8. añadimos copy result y lo numos  y lo unimos
xml -> copy rows

9. añadimos unique rows Hash (creo)
dentro clicamos en donde se pude y ponemos 1 ano y 2 mes

10. añadimos elñ  maepo  y lo unimos 

    en el que generamos texto_mes

    y rellenamos con los meses del año

11. insert/update crear vuestra conexión 

    le das a new presupones base de datos de dwtormentas le llama igual
    escoge posstgres jdvc local hos 

    nos conectamos a nuestra base de datos
    en esta la parte de arriba donde solo este ano y mes es para 
    saber si acualizar o insetar

    abajo ponemos como esta en la imagen

13. hacemos algo similar para pais región

    **NOTA** HACER UN SELECT DE LOS DATOS con strem loockup 

14. Run para comprobar que todo este bien 

------------------------------------------------------------------

15. nos falta una tranformación



------

16. creando un trabajo

- star
- trabajo
- sucefull

- si no va el ok al cargar la ruta del trabajo copiarla a mano