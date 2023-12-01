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



awk -F, 'NR==1 {
    for (i=5; i<=NF; i++) {
        year[i-4] = gensub("\"", "", "g", $i);  # Almacenar los años en un arreglo, quitando las comillas
    }
}
NR>1 {
    country = gensub("\"", "", "g", $1);  # Quitar comillas del nombre del país
    code = gensub("\"", "", "g", $2);  # Quitar comillas del código del país
    for (i=5; i<=NF; i++) {
        if ($i != "" && $i != "\"\"") {
            value = gensub("\"", "", "g", $i);  # Quitar comillas del valor
            printf "\"%s\",\"%s\",%s,%s\n", country, code, year[i-4], value;
        }
    }
}' API_SL.TLF.TOTL.IN_DS2_en_csv_v2_5996631.csv > output_4.csv
