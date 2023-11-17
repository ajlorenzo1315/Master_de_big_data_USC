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
