#Cargar los datos: Asegúrate de que los datos estén en un formato que R pueda leer (como un archivo .csv). 
#Si los datos están en un archivo de texto (.txt), puedes usar read.table.

#Estandarizar los datos: Dado que las variables tienen diferentes escalas,
#es importante estandarizarlas antes de realizar el PCA.

#Realizar el PCA: Puedes usar la función prcomp para realizar el PCA. 
#Esta función permite elegir entre usar la matriz de covarianzas o la de correlaciones.

#Analizar los resultados: Observa los valores propios (varianza explicada) y 
#los vectores propios (cargas de las componentes) para interpretar las componentes principales.

# Crear un biplot: Esto te ayudará a visualizar tanto las cargas de las 
#variables como las puntuaciones de los casos en las componentes principales.

# Cargar las librerías necesarias
library(readr)
library(ggplot2)

# Cargar los datos
# Asegúrate de ajustar la ruta del archivo y el método de lectura según sea necesario
datos <- read.table("decatlon.txt", header = TRUE, sep = "\t")

# Estandarizar los datos
datos_estandarizados <- scale(datos)

# Realizar el PCA
pca_resultado <- prcomp(datos_estandarizados, scale = TRUE)

# Ver la varianza explicada
print(summary(pca_resultado))

# Crear un biplot
biplot(pca_resultado)

# También puedes explorar los resultados del PCA de forma más detallada
# Valores propios
valores_propios <- pca_resultado$sdev^2

# Porcentaje de varianza explicada por cada componente
porcentaje_varianza <- valores_propios / sum(valores_propios) * 100
print(porcentaje_varianza)

# Cargas de las componentes
cargas <- pca_resultado$rotation
print(cargas)
