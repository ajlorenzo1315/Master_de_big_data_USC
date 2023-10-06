# instalamos el paquete para generar el PDF
install.packages("xml2")
install.packages("rvest")
install.packages("svglite")

install.packages("kableExtra")

# cambiamos el directorio de trabajo si es necesario
setwd("~/Desktop/Master_de_big_data_USC/Statistical_learning/practices")
#Construir la ruta al archivo CSV
ruta_archivo <-  "./1_Descriptive_analysis_of_data_set/estadisticas_trabajo.csv"

# Cargar el archivo CSV separado por punto y coma
datos <- read.csv2(file = ruta_archivo, sep = ";")

# list.files()# Ver las primeras filas de los datos
head(datos)
colnames(datos)
# 2 - Trata de obtener un subconjunto de tus datos que cumplan una cierta condición (si no eres
# capaz, coge el conjunto entero). ¿Cuantos datos tienes? ¿Cuál es el número de variables que
# tienes?
# Para saber que datos hay en la tabla 
# Obtener los posibles valores únicos de cada  columnaexcepto el salario
# Puesto que es el valor que queremos estudiar
valores_unicos <- unique(datos$Sectores.de.actividad.económica)
valores_unicos
valores_unicos <- unique(datos$Sexo.Brecha.de.género)
valores_unicos
valores_unicos <- unique(datos$Periodo)
valores_unicos
# Crear una subtabla para el sector "Educación"
subtabla_educacion <- datos[datos$Sectores.de.actividad.económica == "P Educación", ]
# Mostrar la subtabla
head(subtabla_educacion)
# Obtener el número de filas en el subconjunto
num_filas <- nrow(subtabla_educacion)

# Obtener el número de columnas en el subconjunto
num_columnas <- ncol(subtabla_educacion)

# Mostrar el número de filas y columnas
cat("Número de filas en el subconjunto:", num_filas, "\n")
cat("Número de columnas en el subconjunto:", num_columnas, "\n")

# Remover comas como separadores de miles y convertir la columna "Total" a numérico
datos$Total <- as.numeric(gsub(",", "", datos$Total))
# Crear un subconjunto de datos excluyendo las filas con "Cociente mujeres respecto a hombres" en la columna "Sexo.Brecha.de.género"
datos_sin_cociente <- subset(datos, !grepl("Cociente mujeres respecto a hombres", Sexo.Brecha.de.género))

# Calcular la diferencia salarial entre hombres y mujeres por año
diferencia_salarial <- aggregate(Total ~ Periodo + Sexo.Brecha.de.género, data = datos_sin_cociente, sum)

# Filtrar los datos para obtener solo la diferencia salarial entre hombres y mujeres
#diferencia_salarial <- subset(diferencia_salarial, Sexo.Brecha.de.género == "Hombres")


# Ordenar por año si es necesario
diferencia_salarial <- diferencia_salarial[order(diferencia_salarial$Periodo), ]

# Calcular la diferencia salarial
diferencia_salarial$Diferencia_Salarial <- c(NA, diff(diferencia_salarial$Total))

# Mostrar el resultado
print(diferencia_salarial)


# Cargar la librería ggplot2 si no está cargada
if (!require(ggplot2)) {
  install.packages("ggplot2")
  library(ggplot2)
}

# Convertir la columna "Total" a numérico y eliminar comas como separadores de miles
datos$Total <- as.numeric(gsub(",", "", datos$Total))

# Crear un gráfico de líneas
grafico_lineas <- ggplot(data = datos, aes(x = Periodo)) +
  geom_line(aes(y = Total, color = "Total"), size = 1) +
  geom_line(aes(y = Total[Sexo.Brecha.de.género == "Mujeres"], color = "Mujeres"), size = 1) +
  geom_line(aes(y = Total[Sexo.Brecha.de.género == "Hombres"], color = "Hombres"), size = 1) +
  labs(title = "Evolución del Total de Hombres, Mujeres y Diferencia Salarial",
       x = "Año",
       y = "Total") +
  scale_color_manual(values = c("Total" = "blue", "Mujeres" = "red", "Hombres" = "green")) +
  theme_minimal()

# Mostrar el gráfico
print(grafico_lineas)

