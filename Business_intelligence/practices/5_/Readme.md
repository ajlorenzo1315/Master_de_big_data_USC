Dimensiones
- Pais
    (clave)
    - id
    - nombre
    - código
- Tiempo
    - id
    - nombre
    - año

- Población
    - id
    - población
    - clave foranea(KF) tiempo 
    - clave foranea(KF) pais 


Pasos

[datos](https://data.worldbank.org/indicator/SP.POP.TOTL?view=map)

creamos una nueva base de datos y la llamamos rolap 

creamos las tablas

tratamos el input

**instalamos el paquete necesario**

```bash 
sudo apt-get install gawk

gawk -F ',' -vFPAT='([^,]*)|("[^"]+")' -vOFS=, '{print $1,$2}' API_SP.POP.TOTL_DS2_en_csv_v2_6011311.csv > input.csv
```