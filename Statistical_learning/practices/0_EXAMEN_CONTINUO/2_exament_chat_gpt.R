# Pregunta 1: Realizar una regresión lineal utilizando el conjunto de datos 'mtcars' en R.
# ¿Cuál es la relación entre la potencia del motor (hp) y el rendimiento de la gasolina (mpg)?

# Cargar el conjunto de datos 'mtcars'
data(mtcars)

# Ajustar el modelo de regresión lineal
lm_fit <- lm(mpg ~ hp, data = mtcars) # mpg es la variable dependiente y hp es la independiente

# Resumen del modelo para ver la relación
summary(lm_fit) # Muestra la relación entre 'hp' y 'mpg'. Un coeficiente negativo indica que a mayor 'hp', menor 'mpg'.

# Pregunta 2: Implementar un modelo de regresión logística en el conjunto de datos 'iris'.
# ¿Cuál es la probabilidad de que una flor de iris sea de la especie 'setosa' basándose en su longitud de pétalo?

# Transformar la variable de respuesta a formato binario
iris$IsSetosa <- ifelse(iris$Species == 'setosa', 1, 0)

# Ajustar el modelo de regresión logística
log_fit <- glm(IsSetosa ~ Petal.Length, data = iris, family = 'binomial')

# Probabilidad para una longitud de pétalo de 1.5 cm
prob_setosa <- predict(log_fit, newdata = data.frame(Petal.Length = 1.5), type = 'response')
prob_setosa # Muestra la probabilidad de que una flor con longitud de pétalo de 1.5 cm sea de la especie 'setosa'.

# Pregunta 3: Realizar un análisis de componentes principales (PCA) en el conjunto de datos 'mtcars'.
# ¿Qué porcentaje de la varianza se explica con los dos primeros componentes principales?

# Realizar PCA
pca_result <- prcomp(mtcars[, c("mpg", "hp", "wt")], center = TRUE, scale. = TRUE)

# Calcular la varianza explicada
var_exp <- summary(pca_result)$importance[2, 1:2]
var_exp # Muestra el porcentaje de varianza explicado por los dos primeros componentes principales.

# Pregunta 4: Utilizar el método k Vecinos Más Próximos para clasificar las especies en el conjunto de datos 'iris' basándose en 'Petal.Length' y 'Petal.Width'.
# ¿Cómo se clasifica una flor con longitud de pétalo de 4 cm y anchura de pétalo de 1.2 cm?

library(class) # Cargar la biblioteca class para kNN
features <- cbind(iris$Petal.Length, iris$Petal.Width)

# kNN con k=3
knn_result <- knn(train = features, test = matrix(c(4, 1.2), nrow = 1), cl = iris$Species, k = 3)
knn_result # Muestra la clasificación de una flor con longitud de pétalo de 4 cm y anchura de 1.2 cm.


# Pregunta 1: ¿Cómo afecta el número de vecinos (k) en un modelo kNN al clasificar las especies en el dataset 'iris'?
# Utiliza 'Petal.Length' y 'Petal.Width' para la clasificación. Prueba con diferentes valores de k y discute cómo cambia el rendimiento del modelo.

library(class)
features <- cbind(iris$Petal.Length, iris$Petal.Width)
species <- iris$Species

# Probar con diferentes valores de k
for (k in c(1, 5, 10, 15, 20)) {
  set.seed(123) # Para reproducibilidad
  knn_pred <- knn(train = features, test = features, cl = species, k = k)
  cat("k =", k, " - Accuracy:", mean(knn_pred == species), "\n")
  # Comentario: Un k más pequeño puede captar mejor las diferencias locales, pero es más sensible al ruido.
  # Un k más grande suaviza las fronteras de decisión, lo que puede ser útil para datos más dispersos o con ruido.
}

# Pregunta 2: En el conjunto de datos 'mtcars', ¿cómo influyen diferentes combinaciones de variables en un modelo de regresión lineal al predecir 'mpg'?
# Prueba al menos tres combinaciones diferentes de variables y analiza sus efectos en el rendimiento del modelo.

data(mtcars)
combinations <- list(c("wt", "hp"), c("cyl", "disp"), c("hp", "drat", "wt"))

# Probar diferentes combinaciones de variables
for (vars in combinations) {
  formula <- as.formula(paste("mpg ~", paste(vars, collapse = " + ")))
  lm_model <- lm(formula, data = mtcars)
  print(summary(lm_model))
  # Comentario: Cada combinación de variables puede capturar diferentes aspectos de la relación con 'mpg'.
  # Es importante considerar la relevancia de las variables y su posible colinealidad.
}

# Pregunta 3: Utilizando el conjunto de datos 'mtcars', ¿cómo afecta el parámetro de regularización en la regresión Ridge y Lasso al predecir 'mpg'?
# Ajusta modelos Ridge y Lasso con diferentes valores de lambda y compara sus resultados.

library(glmnet)
x_matrix <- as.matrix(mtcars[, -1])
y_vector <- mtcars$mpg

# Probar diferentes valores de lambda
lambdas <- 10 ^ seq(-4, -1, length = 5)
for (lambda in lambdas) {
  ridge_model <- glmnet(x_matrix, y_vector, alpha = 0, lambda = lambda)
  lasso_model <- glmnet(x_matrix, y_vector, alpha = 1, lambda = lambda)
  cat("Lambda:", lambda, " - Ridge:", mean(predict(ridge_model, x_matrix) - y_vector)^2,
      " - Lasso:", mean(predict(lasso_model, x_matrix) - y_vector)^2, "\n")
  # Comentario: Un lambda mayor impone una penalización más fuerte, lo que puede ayudar a prevenir el sobreajuste.
  # Sin embargo, también puede resultar en un modelo demasiado simplificado, perdiendo información relevante.
}

# Pregunta 4: En el conjunto de datos 'iris', realiza un Análisis de Componentes Principales (PCA) 
# y determina cuántos componentes son necesarios para explicar al menos el 90% de la varianza total.

library(stats)
# Realizar PCA en iris (sin la columna de especies)
iris_pca <- prcomp(iris[, 1:4], scale. = TRUE)
summary(iris_pca)
# Comentario: El resumen del PCA mostrará la proporción de la varianza explicada por cada componente.
# Seleccionar el número mínimo de componentes que sumen al menos el 90% de la varianza.

# Pregunta 5: Utilizando el conjunto de datos 'Boston' de la biblioteca MASS, ajusta un modelo de regresión lineal
# para predecir 'medv' (valor medio de viviendas ocupadas por sus propietarios en $1000) 
# utilizando 'rm' (número promedio de habitaciones por vivienda) y 'lstat' (porcentaje de población de estatus bajo).

library(MASS)
data(Boston)
lm_boston <- lm(medv ~ rm + lstat, data = Boston)
summary(lm_boston)

# Comentario: Este modelo nos permite entender cómo el número de habitaciones y el estatus socioeconómico
# afectan el valor medio de las viviendas.

# Pregunta 6: Utiliza el método de Análisis Discriminante Lineal (LDA) para clasificar las especies en el conjunto de datos 'iris'.
# Compara el desempeño del modelo LDA con un modelo kNN.

library(MASS)
lda_iris <- lda(Species ~ ., data = iris)
lda_pred <- predict(lda_iris)
table(lda_pred$class, iris$Species)

# Comparación con kNN
library(class)
knn_pred <- knn(train = iris[, 1:4], test = iris[, 1:4], cl = iris$Species, k = 3)
table(knn_pred, iris$Species)
# Comentario: Comparar las matrices de confusión de LDA y kNN para evaluar su rendimiento.
# LDA asume una distribución normal de los predictores, mientras que kNN no tiene tal suposición.

# Pregunta 7: En el conjunto de datos 'mtcars', realiza una regresión logística para predecir si un coche tiene una transmisión automática o manual.
# Usa las variables 'mpg', 'hp' y 'wt' como predictores.

mtcars$am <- factor(mtcars$am, labels = c("Automatic", "Manual"))
logit_model <- glm(am ~ mpg + hp + wt, data = mtcars, family = "binomial")
summary(logit_model)
# Comentario: Este modelo nos ayuda a entender cómo las características del coche influyen en el tipo de transmisión.
# La regresión logística es adecuada para una respuesta binaria como la transmisión del coche.

# Pregunta 8: Realiza una regresión Ridge y una regresión Lasso en el conjunto de datos 'Boston' para predecir 'medv'.
# Usa todas las variables excepto 'medv' como predictores. Determina los mejores parámetros lambda para ambos modelos.

library(glmnet)
x_matrix <- model.matrix(medv ~ ., Boston)[, -1]
y_vector <- Boston$medv

# Regresión Ridge
cv_ridge <- cv.glmnet(x_matrix, y_vector, alpha = 0)
best_lambda_ridge <- cv_ridge$lambda.min

# Regresión Lasso
cv_lasso <- cv.glmnet(x_matrix, y_vector, alpha = 1)
best_lambda_lasso <- cv_lasso$lambda.min
# Comentario: Estos modelos nos permiten evaluar la importancia de las variables en la predicción de 'medv',
# con la regularización ayudando a prevenir el sobreajuste.

# Pregunta Avanzada 1: Implementación de Validación Cruzada Personalizada para Regresión Lineal
# Utiliza el conjunto de datos 'mtcars'. Implementa una validación cruzada de 5 pliegues desde cero para evaluar el rendimiento de un modelo de regresión lineal que predice 'mpg' usando todas las variables excepto 'name'.

# Solución:
set.seed(123)
folds <- cut(seq(1, nrow(mtcars)), breaks = 5, labels = FALSE)
res_cv <- data.frame(obs = rep(NA, 5), pred = rep(NA, 5))

for(i in 1:5){
  train_data <- mtcars[folds != i, ]
  test_data <- mtcars[folds == i, ]
  model_cv <- lm(mpg ~ ., data = train_data)
  res_cv$obs[i] <- mean((test_data$mpg - predict(model_cv, test_data))^2)
}
mean(res_cv$obs)
# Comentario: La validación cruzada personalizada proporciona una medida más robusta del rendimiento del modelo en diferentes subconjuntos del conjunto de datos.

# Pregunta Avanzada 2: Modelos Mixtos en Datos Agrupados
# En el conjunto de datos 'sleepstudy' del paquete 'lme4', ajusta un modelo mixto para evaluar cómo los días de privación de sueño afectan la reacción. Considera la variación aleatoria entre los sujetos.

# Solución:
library(lme4)
data(sleepstudy)
model_mm <- lmer(Reaction ~ Days + (1 | Subject), data = sleepstudy)
summary(model_mm)
# Comentario: Un modelo mixto es adecuado aquí para tener en cuenta tanto los efectos fijos (días de privación de sueño) como los efectos aleatorios (variaciones entre sujetos).

# Pregunta Avanzada 3: Análisis de Series Temporales y Pronóstico
# Utiliza el conjunto de datos 'AirPassengers'. Ajusta un modelo ARIMA y realiza un pronóstico para los próximos 12 meses. Discute tus hallazgos.

# Solución:
library(forecast)
AirPassengers_ts <- ts(AirPassengers, frequency = 12)
model_arima <- auto.arima(AirPassengers_ts)
forecast_arima <- forecast(model_arima, h = 12)
plot(forecast_arima)
# Comentario: El modelo ARIMA permite modelar y pronosticar datos de series temporales, teniendo en cuenta la estacionalidad y la tendencia en los datos de pasajeros aéreos.

# Pregunta Avanzada 4: Redes Neuronales en R
# Construye y entrena una red neuronal simple usando el conjunto de datos 'iris' para clasificar las especies. Utiliza el paquete 'neuralnet'.

# Solución:
library(neuralnet)
iris_nn <- iris
iris_nn$Species <- as.numeric(iris_nn$Species)
nn_model <- neuralnet(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = iris_nn, hidden = c(5), linear.output = FALSE)
plot(nn_model)
# Comentario: La red neuronal es un enfoque poderoso para modelar relaciones complejas en los datos, especialmente útil en clasificación y regresión no lineal.
