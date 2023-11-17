# Instalación del paquete 'faraway' que contiene funciones y conjuntos de datos para análisis estadístico
install.packages("faraway")

# Cargar el paquete 'faraway'
library("faraway")

# Cargar el conjunto de datos 'meatspec' del paquete 'faraway'
data(meatspec)

# Mostrar las primeras filas del conjunto de datos 'meatspec' para obtener una visión general
head(meatspec)

# Mostrar las dimensiones del conjunto de datos 'meatspec' (número de filas y columnas)
dim(meatspec)

# Crear un conjunto de entrenamiento con las primeras 172 observaciones
train <- meatspec[1:172,]

# Crear un conjunto de prueba con las observaciones restantes
test <- meatspec[173:215,]

# Realizar una regresión lineal utilizando 'fat' como variable dependiente y todas las demás como independientes en el conjunto de entrenamiento
ajuste.lm <- lm(fat ~ ., data = train)

# Mostrar un resumen del modelo de regresión lineal para evaluar coeficientes y estadísticas significativas
summary(ajuste.lm)

# Calcular la suma de los residuos al cuadrado del modelo en el conjunto de entrenamiento
sum(ajuste.lm$residuals^2)

# Calcular el error cuadrático medio del modelo en el conjunto de entrenamiento
mean(ajuste.lm$residuals^2)

# Hacer predicciones en el conjunto de prueba utilizando el modelo ajustado
predtest <- predict(ajuste.lm, newdata = test)

# Calcular la suma de los residuos al cuadrado en el conjunto de prueba
sum((predtest - test$fat)^2)

# Calcular el error cuadrático medio en el conjunto de prueba
mean((predtest - test$fat)^2)

# Realizar un análisis de componentes principales (PCA) en los predictores del conjunto de entrenamiento
trainx <- train[, 1:100]
pcax <- princomp(trainx)

# Mostrar un resumen del PCA para evaluar la varianza explicada por cada componente principal
summary(pcax)

# Mostrar los valores de las componentes principales para la primera observación
pcax$scores[1,]

# Seleccionar un número de componentes principales para usar en la regresión
k <- 3

# Crear un nuevo conjunto de entrenamiento con las primeras 'k' componentes principales y la variable 'fat'
trainpca <- as.data.frame(cbind(pcax$scores[, 1:k], train$fat))
names(trainpca)[k + 1] = "fat"

# Realizar una regresión lineal con las componentes principales seleccionadas
ajuste.lmpca <- lm(fat ~ ., data = trainpca)

# Mostrar un resumen del modelo de regresión PCA
summary(ajuste.lmpca)

# Calcular la suma de los residuos al cuadrado para el modelo PCA en el conjunto de entrenamiento
sum(ajuste.lmpca$residuals^2)

# Calcular el error cuadrático medio para el modelo PCA en el conjunto de entrenamiento
mean(ajuste.lmpca$residuals^2)

# Preparar los datos de prueba para la predicción con PCA
testx <- test[, 1:100]
testpca <- predict(pcax, newdata = testx)
testpca <- testpca[, 1:k]
testpca <- as.data.frame(testpca)

# Realizar predicciones en el conjunto de prueba utilizando el modelo de regresión PCA
predtest.pca <- predict(ajuste.lmpca, newdata = testpca)

# Mostrar las predicciones del modelo PCA
predtest.pca

# Mostrar los valores reales de 'fat' en el conjunto de prueba
test$fat

# Calcular la suma de los residuos al cuadrado para el modelo PCA en el conjunto de prueba
sum((predtest.pca - test$fat)^2)

# Calcular el error cuadrático medio para el modelo PCA en el conjunto de prueba
mean((predtest.pca - test$fat)^2)
