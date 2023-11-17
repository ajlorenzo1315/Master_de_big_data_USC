# Cargar las bibliotecas necesarias
library(MASS) # Para análisis de componentes principales y funciones estadísticas
library(tidyverse) # Para manipulación de datos y gráficos

# Introducción al Análisis de Componentes Principales (PCA)
# PCA es un método de reducción de dimensionalidad que transforma las variables originales
# en un nuevo conjunto de variables (los componentes principales) que son linealmente independientes
# y capturan la mayor cantidad posible de variabilidad en los datos.

# Ejemplo: Uso de PCA en un conjunto de datos
data(iris) # Cargar el dataset iris
head(iris)

# Aplicar PCA al dataset
iris_pca <- prcomp(iris[,1:4], center = TRUE, scale. = TRUE) # Centrar y escalar las variables antes de aplicar PCA

# Ver los resultados de PCA
summary(iris_pca)
plot(iris_pca)

# Los resultados de PCA incluyen:
# 1. Los valores propios (eigenvalues), que indican la cantidad de varianza explicada por cada componente principal.
# 2. Los vectores propios (eigenvectors), que indican la dirección de los componentes principales en el espacio original.

# Análisis de Componentes Principales (PCA) como técnica de reducción de dimensionalidad
# En el contexto de un gran número de variables, PCA permite reducir la dimensionalidad de los datos
# al mantener solo aquellos componentes principales que explican una parte significativa de la varianza.

# Ejemplo: Reducción de dimensionalidad con PCA
# Supongamos que decidimos mantener solo los primeros dos componentes principales
iris_pca_reducido <- iris_pca$x[,1:2]

# Los datos ahora están en un espacio de menor dimensión pero aún capturan la mayoría de la variabilidad de los datos originales.

# Regresión de Componentes Principales (PCR)
# PCR es un enfoque que utiliza PCA en el contexto de la regresión lineal.
# En PCR, primero se reduce la dimensionalidad de los predictores mediante PCA y luego se utiliza
# la regresión lineal en los componentes principales resultantes.

# Ejemplo: Uso de PCR para predecir una variable de respuesta
# Supongamos que queremos predecir la variable Sepal.Length en el dataset iris
# Primero aplicamos PCA a las variables predictoras
predictores_pca <- prcomp(iris[,2:4], center = TRUE, scale. = TRUE)

# Luego ajustamos un modelo de regresión lineal utilizando los componentes principales como predictores
model_pcr <- lm(iris$Sepal.Length ~ predictores_pca$x[,1] + predictores_pca$x[,2])

# Resumen del modelo PCR
summary(model_pcr)

# PCR es útil especialmente cuando hay una alta multicolinealidad entre los predictores o cuando
# el número de predictores es alto en comparación con el número de observaciones.


# Cargar datos de aspirantes
dat <- read.table("aspirantes.txt", header = TRUE) # Carga el conjunto de datos desde un archivo
head(dat) # Muestra las primeras filas para obtener una vista preliminar

# Análisis de Componentes Principales (PCA)
# PCA se utiliza para reducir la dimensionalidad de los datos, manteniendo la mayor cantidad de información.
test.pca <- princomp(dat) # Realiza PCA en los datos
summary(test.pca) # Muestra un resumen del resultado de PCA, incluyendo la varianza explicada

# Cálculo de la proporción de varianza explicada
# Esto ayuda a entender qué porcentaje de la información total se conserva en cada componente principal.
av <- test.pca$sdev^2 # Calcula los autovalores
av[1] / sum(av) # Proporción de varianza explicada por el primer componente
sum(av[1:2]) / sum(av) # Proporción acumulada de varianza explicada por los dos primeros componentes

# Cómo escoger el número de componentes
# El gráfico de sedimentación (screeplot) ayuda a determinar un número adecuado de componentes principales a conservar.
screeplot(test.pca, type = "lines") # Crea un screeplot para visualizar la importancia relativa de cada componente

# Cargar la biblioteca faraway y utilizar el conjunto de datos meatspec
library(faraway) # Cargar la biblioteca faraway
data(meatspec) # Cargar el conjunto de datos meatspec
head(meatspec) # Muestra las primeras filas del conjunto de datos
dim(meatspec) # Muestra las dimensiones del conjunto de datos

# División de los datos en entrenamiento y prueba
train <- meatspec[1:172,] # Datos de entrenamiento
test <- meatspec[173:215,] # Datos de prueba

# Regresión Lineal con p=100 predictores
fit.lm <- lm(fat ~ ., data = train) # Ajustar un modelo de regresión lineal
summary(fit.lm) # Muestra un resumen del modelo
mean(fit.lm$residuals^2) # Calcula el error cuadrático medio (MSE) en los datos de entrenamiento

# Predicción y cálculo de MSE en los datos de prueba
predy <- predict(fit.lm, newdata = test) # Realizar predicciones en los datos de prueba
restest <- test$fat - predy # Calcular los residuos
mean(restest^2) # Calcular el MSE en los datos de prueba

# PCA en los predictores y Regresión usando PCA
pca <- princomp(train[, 1:100]) # Realizar PCA en los predictores
summary(pca) # Muestra un resumen del resultado de PCA
screeplot(pca, type = "lines") # Crea un screeplot para visualizar la importancia relativa de cada componente

# Utilizar las primeras 4 componentes principales para la regresión
k <- 4
pcax <- as.data.frame(cbind(pca$scores[, 1:k], train$fat))
fit.pcr <- lm(fat ~ ., data = pcax) # Ajustar un modelo de regresión usando las componentes principales
mean(fit.pcr$residuals^2) # Calcular el MSE en los datos de entrenamiento usando PCA

# Predicción y cálculo de MSE en los datos de prueba usando PCA
testPCA <- predict(pca, newdata = test[, 1:100])
testPCA <- testPCA[, 1:k]
predy <- predict(fit.pcr, newdata = as.data.frame(testPCA))
restest <- test$fat - predy
mean(restest^2) # MSE en los datos de prueba usando PCA
