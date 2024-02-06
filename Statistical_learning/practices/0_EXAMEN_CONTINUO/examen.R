#La base de datos de Hitters de la librería ISLR, contiene el sario (en miles de dólares) 322 jugadores de béibol en 1987(Salary).
# Ademas  se han medido otras caracteristicas de cada jugadr help(Hitters). Utiñizando todsas las covariables numericas y asumiendo commo continues ,
#es decir , tosdas menos 14 league, la  15 division y la 20 newleague , 
# ajusta los siguientesa modelos que permiten predecir el salaru en funcion de las otras cavriables
# lieneal múltiple, Ridge y Lasso. En los dos ultimos casos mencione que valor de penalización lamda  has empleado e indica si los modelo te permitne eliminar 
# alguna covarible

#primero elimia todas las obsevacionen con algun NAN y llyego utiliza como conjunto de entranmiento las 200 primeras
# restos de observacicones como conjunto de test
# para ver que modelo proporcione en ete caso el mejor ajuste en terminos de la suma de residuos al cuadrado


install.packages("ISLR")
library(ISLR)
data("Hitters")
Hitters2<-Hitters[,-c(14,15,20)]
# eliminamos los nan
Hitters2_2 <- na.omit(Hitters2)
help(Hitters)
Hitters2_2_train<Hitters2_2[1:200,]
Hitters2_2_test<-Hitters2_2[200:length(x),]
# Regresión Lineal Múltiple
# Se ajusta un modelo lineal para explicar la variable 'salary' usando todas las otras variables como predictoras.

model <- lm(Hitters2_2$Salary ~ ., data =  Hitters2_2) # Ajustar modelo
summary(model)

# Regresión Ridge
# Ridge es una técnica de regularización que añade un término de penalización a la suma de los cuadrados de los coeficientes.
# Esto ayuda a prevenir el sobreajuste, especialmente cuando las variables predictoras están correlacionadas.
library(MASS) # Biblioteca para regresión Ridge
lam <- seq(0, 100, by = 0.01) # Secuencia de valores lambda para la penalización
rr <- lm.ridge(Hitters2_2$Salary ~ ., lambda = lam,data = Hitters2_2)
coef(rr) # Coeficientes para diferentes lambdas
plot(rr, xvar = "lambda")
# Regresión Ridge con glmnet
# glmnet es otra biblioteca que ofrece una implementación eficiente de regresión Ridge y Lasso.
library(glmnet) # Biblioteca para glmnet
x <- Hitters2_2_train[1, ] # Variables predictoras
y <- Hitters2_2_train$Salary # Variable de respuesta
rr_glmnet <- glmnet(x, y, alpha = 0, lambda = lam) # Ajustar modelo Ridge con glmnet
coef(rr_glmnet) # Mostrar coeficientes
plot(rr_glmnet, xvar = "lambda")
# Estimación Lasso
# Lasso es similar a Ridge, pero puede reducir algunos coeficientes a cero, lo que implica selección de variables.
lam <- seq(0, 1000, by = 0.01) # Secuencia de valores lambda para la penalización
lasso <- glmnet(x, y, alpha = 1, lambda = lam) # Ajustar modelo Lasso
coef(lasso) # Mostrar coeficientes
plot(lasso, xvar = "lambda")

lasso <- glmnet(x, y, alpha = 1, lambda = lam) # Ajustar modelo Lasso
coef(lasso) # Mostrar coeficientes
plot(lasso, xvar = "lambda")
# Selección del parámetro de penalización mediante validación cruzada
# La validación cruzada se usa para seleccionar el mejor valor de lambda que minimiza el error de predicción.
cvout <- cv.glmnet(as.matrix(x), y, alpha = 0, lambda = lam) # Validación cruzada para Ridge
coef(cvout, s = "lambda.min") # Coeficientes para el lambda óptimo en Ridge

cvout2 <- cv.glmnet(as.matrix(x), y, alpha = 1, lambda = lam) # Validación cruzada para Lasso
coef(cvout2, s = "lambda.min") # Coeficientes para el lambda óptimo en Lasso

# Predicción con Lasso
# Ejemplo de cómo hacer predicciones para las primeras 5 observaciones con un valor específico de lambda.
testx<-Hitters2_2_test[, -1]
predict(lasso, newx = as.matrix(x[200:length(x), ]), type = "response", s = 0.5)

# segun lasso para una lambda 6 somos capaz de eliminar una variable por lo que podria ser interesante 
predict(lasso, newx = as.matrix(x[200:length(x), ]), type = "response", s = 6)
predict(rr_glmnet, newx = as.matrix(x[200:length(x), ]), type = "response", s = 0.5)


p <- 100
trainx <- Hitters2_2_train[, 1:p]
pca <- princomp(trainx)
summary(pca)
screeplot(pca, type = "lines")


#--------
# chat gpt

# Instalar y cargar la librería "ISLR" si aún no está instalada
if (!require(ISLR)) {
  install.packages("ISLR")
  library(ISLR)
}

# Cargar los datos de Hitters
data("Hitters")

# Eliminar observaciones con NaN
Hitters <- na.omit(Hitters)

# Separar las covariables numéricas y la variable objetivo "Salary"
X <- Hitters[, -c(14, 15, 20)]  # Excluye las columnas league, division y newleague
y <- Hitters$Salary

# Dividir los datos en conjunto de entrenamiento (200 primeras observaciones) y conjunto de prueba (restantes)
set.seed(42)  # Semilla para reproducibilidad
train_idx <- sample(1:nrow(X), 200)
X_train <- X[train_idx, ]
y_train <- y[train_idx]
X_test <- X[-train_idx, ]
y_test <- y[-train_idx]

# Ajustar modelo de regresión lineal múltiple
linear_model <- lm(Salary ~ ., data = data.frame(Salary = y_train, X_train))

# Ajustar modelo Ridge con un valor de penalización lambda (alpha) específico
library(glmnet)
alpha_ridge <- 1.0  # Puedes ajustar el valor de alpha según lo desees
ridge_model <- glmnet(X_train, y_train, alpha = alpha_ridge)

# Ajustar modelo Lasso con un valor de penalización lambda (alpha) específico
alpha_lasso <- 1.0  # Puedes ajustar el valor de alpha según lo desees
lasso_model <- glmnet(X_train, y_train, alpha = alpha_lasso)

# Evaluar los modelos en términos de RSS en el conjunto de prueba
linear_predictions <- predict(linear_model, newdata = data.frame(X_test))
ridge_predictions <- predict(ridge_model, newx = as.matrix(X_test))
lasso_predictions <- predict(lasso_model, newx = as.matrix(X_test))

# Calcular RSS para cada modelo
RSS_linear <- sum((y_test - linear_predictions)^2)
RSS_ridge <- sum((y_test - ridge_predictions)^2)
RSS_lasso <- sum((y_test - lasso_predictions)^2)

# Imprimir los RSS de cada modelo
cat("RSS del modelo lineal:", RSS_linear, "\n")
cat("RSS del modelo Ridge:", RSS_ridge, "\n")
cat("RSS del modelo Lasso:", RSS_lasso, "\n")


Para realizar la reducción dimensional en R utilizando PCA (Análisis de Componentes Principales) y otros métodos como LDA (Análisis Discriminante Lineal), puedes seguir estos pasos:

Primero, asegúrate de tener las librerías necesarias instaladas. Utilizaré las librerías caret, e1071, y MASS para PCA y LDA:

R

if (!require(caret)) {
  install.packages("caret")
  library(caret)
}

if (!require(e1071)) {
  install.packages("e1071")
  library(e1071)
}

if (!require(MASS)) {
  install.packages("MASS")
  library(MASS)
}

Ahora, puedes realizar la reducción dimensional con PCA y LDA:

PCA (Análisis de Componentes Principales):

R

# Estandarizar las covariables antes de aplicar PCA
scaled_X_train <- scale(X_train)

# Realizar PCA
pca_model <- prcomp(scaled_X_train, center = TRUE, scale. = TRUE)

# Verificar la proporción de varianza explicada por cada componente
prop_var <- pca_model$sdev^2 / sum(pca_model$sdev^2)

# Graficar la proporción de varianza explicada acumulativa
cumulative_prop_var <- cumsum(prop_var)
plot(cumulative_prop_var, type = "b", xlab = "Número de Componentes", ylab = "Proporción de Varianza Explicada Acumulativa")

# Seleccionar el número de componentes principales deseado
num_components <- 5  # Puedes ajustar este valor según tus necesidades

# Reducir dimensionalidad con PCA
reduced_X_train_pca <- predict(pca_model, newdata = scaled_X_train)[, 1:num_components]

# Aplicar la misma reducción a los datos de prueba
scaled_X_test <- scale(X_test)
reduced_X_test_pca <- predict(pca_model, newdata = scaled_X_test)[, 1:num_components]

LDA (Análisis Discriminante Lineal):

R

# Ajustar modelo LDA
lda_model <- lda(Salary ~ ., data = data.frame(Salary = y_train, reduced_X_train_pca))

# Reducir dimensionalidad con LDA
reduced_X_train_lda <- predict(lda_model, newdata = data.frame(Salary = y_train, reduced_X_train_pca))$x

# Aplicar la misma reducción a los datos de prueba
reduced_X_test_lda <- predict(lda_model, newdata = data.frame(Salary = y_train, reduced_X_test_pca))$x

#Ahora tienes reducciones dimensionales de los datos utilizando PCA y LDA.
#puedes utilizar estos conjuntos de datos reducidos en lugar de las covariables 
#originales para ajustar y evaluar modelos de regresión o cualquier otro análisis
#posterior que desees realizar. Asegúrate de ajustar tus modelos y r
#realizar evaluaciones utilizando estos conjuntos de datos reducidos en lugar de las covariables originales.