# Cargar bibliotecas necesarias
library(ISLR) # Para el dataset
library(ggplot2) # Para visualización
library(dplyr) # Para manipulación de datos
library(MASS) # Para LDA

# Regresión Logística
# Se utiliza para predecir la probabilidad de una categoría o evento binario.
# Por ejemplo, predecir si un cliente incumplirá o no el pago de su tarjeta de crédito.

# Cargar y explorar el dataset Default
data(Default)
head(Default)

# Visualización de la relación entre balance y default
ggplot(Default, aes(x = balance, color = default)) +
  geom_density() +
  labs(title = "Densidad de Balance para cada Categoría de Default")

# Ajuste del modelo de regresión logística
glm_fit <- glm(default ~ balance, data = Default, family = "binomial")

# Resumen del modelo
summary(glm_fit)

# Análisis Discriminante Lineal (LDA)
# LDA se utiliza cuando las variables predictoras son cuantitativas y se asume que estas
# siguen una distribución normal. También se asume que las varianzas son iguales en los grupos.

# Ajuste del modelo LDA
lda_fit <- lda(default ~ balance, data = Default)

# Resumen del modelo LDA
lda_fit

# Comparación de los métodos
# Tanto la regresión logística como LDA se utilizan para clasificar observaciones en categorías.
# La elección entre estos métodos depende de las características del conjunto de datos.
# La regresión logística no asume distribución normal de los predictores, mientras que LDA sí.

# Evaluación de los modelos
# Para evaluar la eficacia de estos modelos, se pueden utilizar métricas como la tasa de error de clasificación,
# la matriz de confusión, la curva ROC, entre otras.

# Tasa de error de clasificación para LDA
lda_pred <- predict(lda_fit, Default)
table(lda_pred$class, Default$default)

# Tasa de error de clasificación para regresión logística
glm_pred <- predict(glm_fit, newdata = Default, type = "response")
glm_class_pred <- ifelse(glm_pred > 0.5, "Yes", "No")
table(glm_class_pred, Default$default)


# Cargar el paquete y los datos
library(ISLR) # Carga el paquete ISLR que contiene el conjunto de datos Default
data(Default) # Carga el conjunto de datos Default
head(Default) # Muestra las primeras filas del conjunto de datos para una vista previa

# Transformar la variable de respuesta a formato numérico
default01 <- ifelse(Default$default == "Yes", 1, 0)

# Problema de aplicar regresión lineal en datos binarios
# Una regresión lineal clásica no es adecuada para una variable dependiente binaria
# porque puede producir predicciones fuera del intervalo [0,1]
reglin <- lm(default01 ~ Default$balance) # Ajusta un modelo lineal
plot(Default$balance, default01, main = "Ajuste lineal", xlab = "Saldo", ylab = "Impago")
abline(reglin) # Añade la línea de regresión al gráfico

# Ajuste de un modelo de regresión logística
# La regresión logística es más adecuada para la variable de respuesta binaria
# porque modela la probabilidad de que ocurra un evento (por ejemplo, impago)
reglog1 <- glm(default ~ balance, data = Default, family = "binomial") # Ajusta un modelo logístico
summary(reglog1) # Muestra un resumen del modelo

# Interpretación de los coeficientes y cálculo de odds
# Los coeficientes en un modelo logístico representan el cambio en el logaritmo de odds
odds <- exp(reglog1$coefficients[1]) # Calcula las odds para un saldo medio de cero
odds / (1 + odds) # Convierte las odds a una probabilidad

# Efecto del saldo en las odds de impago
# Por cada unidad monetaria que aumenta el saldo, las odds de impago se multiplican por exp(beta1)
odds1 <- exp(reglog1$coefficients[2]) # Factor de cambio en las odds por cada unidad monetaria
saldo <- 1000
odds1000 <- odds * odds1 ^ saldo # Calcula las odds para un saldo de 1000
odds1000 / (1 + odds1000) # Convierte las odds a una probabilidad

# Determinar la frontera para clasificación
# La frontera entre clasificar como default o no se encuentra donde la probabilidad es 0.5
front <- -reglog1$coefficients[1] / reglog1$coefficients[2]
oddsfront <- odds * odds1 ^ front
oddsfront / (1 + oddsfront) # Probabilidad en la frontera

# Representación gráfica del ajuste logístico
plot(Default$balance, default01, main = "Ajuste logístico", xlab = "Saldo", ylab = "Impago")
seqx <- seq(-10, 2800, len = 10000)
seqy <- predict(reglog1, list(balance = seqx), type = "response")
lines(seqx, seqy, col = 2, lwd = 2) # Añade la curva de regresión logística

# Clasificación y matriz de confusión
# Clasificar a los clientes según la probabilidad predicha de impago
probdef <- predict(reglog1, type = "response") # Probabilidad de impago
clasif1 <- probdef > 0.5 # Clasificar como impago si la probabilidad es mayor que 0.5
table(Default$default, clasif1) # Matriz de confusión para umbral de 0.5

# Clasificación alternativa con un umbral más bajo
clasif2 <- probdef > 0.2 # Clasificar como impago si la probabilidad es mayor que 0.2
table(Default$default, clasif2) # Matriz de confusión para umbral de 0.2

# Cargar el conjunto de datos iris y visualizar la relación entre longitud y anchura de pétalo
data(iris)
plot(iris$Petal.Length, iris$Petal.Width, col = iris$Species)
legend("bottomright", levels(iris$Species), pch = 1, col = 1:3)

# k Vecinos Más Próximos (kNN)
# kNN es un método no paramétrico que clasifica una observación basándose en las clases de sus k vecinos más cercanos.
# No asume una forma particular para la distribución de los datos, lo que lo hace flexible, pero puede ser menos eficiente en grandes dimensiones.
# Ejemplo de uso: Clasificación en sistemas de recomendación o en escenarios donde la relación entre las variables no es bien entendida.

library(class) # Cargar la biblioteca class para kNN
matexp <- cbind(iris$Petal.Length, iris$Petal.Width) # Crear matriz de características
vecres <- iris$Species # Vector de respuesta

# Realizar kNN con k=1
knn.pred <- knn(train = matexp, test = matexp, cl = vecres, k = 1)
table(knn.pred, vecres) # Comparar la clasificación con la realidad

# Análisis Lineal Discriminante (LDA)
# LDA asume que las variables predictoras para cada clase siguen una distribución normal con igual varianza y covarianza.
# Es un método paramétrico que puede ser más eficiente que kNN en grandes dimensiones y cuando las asunciones se cumplen.
# Ejemplo de uso: Clasificación en el ámbito médico para diagnosticar enfermedades basadas en medidas biométricas.

library(MASS) # Cargar la biblioteca MASS para LDA
lda.fit <- lda(Species ~ Petal.Length + Petal.Width, data = iris) # Ajustar LDA
lda.pred <- predict(lda.fit) # Realizar predicciones con LDA
table(lda.pred$class, iris$Species) # Comparar las predicciones con la realidad

# Análisis Cuadrático Discriminante (QDA)
# QDA es similar a LDA pero permite que cada clase tenga su propia matriz de varianza y covarianza.
# Esto hace a QDA más flexible que LDA, pero puede ser menos eficiente si el tamaño de la muestra no es suficientemente grande.
# Ejemplo de uso: Clasificación en el campo de las finanzas, como la identificación de perfiles de riesgo crediticio, 
# donde cada grupo puede tener una varianza distinta.

qda.fit <- qda(Species ~ Petal.Length + Petal.Width, data = iris) # Ajustar QDA
qda.pred <- predict(qda.fit) # Realizar predicciones con QDA
table(qda.pred$class, iris$Species) # Comparar las predicciones con la realidad

# Visualización de las fronteras de decisión usando klaR
library(klaR) # Cargar klaR para visualización
partimat(Species ~ Petal.Length + Petal.Width, data = iris, method = "lda") # Frontera LDA
partimat(Species ~ Petal.Length + Petal.Width, data = iris, method = "qda") # Frontera QDA
