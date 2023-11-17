# Cargar bibliotecas necesarias para el análisis
library(tidyverse)
library(broom)

# Regresión lineal múltiple
# Supongamos que observamos una respuesta cuantitativa Y y variables predictoras X1, X2, ..., Xp
# El modelo lineal múltiple se escribe como Y = β0 + β1X1 + β2X2 + ... + βpXp + ε

# Ejemplo: Regresión lineal múltiple con variables no correlacionadas
n <- 100 # Tamaño de la muestra
beta <- c(3, 5) # Parámetros verdaderos (intercepto = 0)
x1 <- rnorm(n) # Generar valores aleatorios para X1
x2 <- rnorm(n) # Generar valores aleatorios para X2
y <- beta[1] * x1 + beta[2] * x2 + rnorm(n) # Respuesta Y generada a partir del modelo
mod <- lm(y ~ x1 + x2) # Ajustar el modelo lineal
coef(mod) # Mostrar los coeficientes estimados

# Ejemplo: Regresión lineal múltiple con variables altamente correlacionadas
x2 <- rnorm(n, mean = x1, sd = 0.01) # Generar X2 correlacionado con X1
y <- beta[1] * x1 + beta[2] * x2 + rnorm(n) # Respuesta Y
mod <- lm(y ~ x1 + x2) # Ajustar modelo con variables correlacionadas
coef(mod) # Mostrar coeficientes estimados

# Análisis de multicolinealidad
# Multicolinealidad se refiere a un problema en la regresión donde dos o más variables predictoras están correlacionadas.
# Esto puede hacer que la interpretación de los coeficientes del modelo sea problemática y puede inflar la varianza de los coeficientes estimados.

# Ridge regression (regresión de crestas)
# Es una técnica para analizar datos multicolineales. Ajusta un modelo lineal donde los coeficientes son penalizados, 
# reduciendo así su magnitud hacia cero. Esto ayuda a reducir la varianza de los estimadores a costa de introducir sesgo.

# Ejemplo de regresión ridge
# Supongamos que tenemos un conjunto de datos con predictores y queremos aplicar la regresión ridge.
# Utilizaremos la función `lm.ridge` del paquete `MASS`.
library(MASS)
# Ajuste del modelo ridge. lambda es el parámetro de penalización.
# Debe ser elegido cuidadosamente, a menudo mediante validación cruzada.
ridge_mod <- lm.ridge(y ~ x1 + x2, lambda = 1)
print(ridge_mod)

# Lasso regression (regresión Lasso)
# Similar a la regresión ridge, pero puede reducir algunos coeficientes exactamente a cero, lo que implica selección de variables.
# Utilizaremos la función `glmnet` del paquete `glmnet`.
library(glmnet)
x_matrix <- model.matrix(y ~ x1 + x2)[, -1] # Crear matriz de diseño
lasso_mod <- glmnet(x_matrix, y, alpha = 1) # alpha = 1 para Lasso
print(lasso_mod)

# La elección de los parámetros de penalización en ridge y lasso es crítica y suele hacerse mediante validación cruzada.



# La multicolinealidad es un problema en modelos de regresión donde dos o más variables predictoras están fuertemente correlacionadas.
# Esto puede hacer que la interpretación de los coeficientes del modelo sea problemática.

# Definición del tamaño de la muestra y del modelo teórico
n <- 1000 # Tamaño de la muestra
beta0 <- 0 # Coeficiente para el término de intercepción
beta1 <- 1 # Coeficiente para x1
beta2 <- 1 # Coeficiente para x2
sigma <- 1 # Desviación estándar del término de error

# Número de repeticiones para la simulación
B <- 1000 

# Diferentes valores de correlación para explorar
rhos <- c(0.1, 0.5, 0.9)

# Arrays para almacenar los coeficientes estimados y las correlaciones estimadas
cc <- array(dim = c(B, 3, length(rhos)))
corv <- matrix(nrow = B, ncol = 3)

# Bucle para simular datos y ajustar modelos con diferentes grados de correlación
for(j in 1:length(rhos)){
  rho <- rhos[j]
  for (i in 1:B){ 
    eps <- rnorm(n, 0, sigma)
    x1 <- rnorm(n)
    xs <- rnorm(n)
    x2 <- rho * x1 + sqrt(1 - rho^2) * xs
    y <- beta0 + beta1 * x1 + beta2 * x2 + eps
    z <- lm(y ~ x1 + x2)
    cc[i, , j] <- coef(z)
    corv[i, j] <- cor(x1, x2)
  }
}

# Análisis de los coeficientes estimados y la correlación
apply(cc, c(2, 3), mean)
apply(cc, c(2, 3), var)
colMeans(corv)

# Visualización de la densidad de los coeficientes estimados para diferentes grados de correlación
plot_density_coef <- function(j) {
  plot(density(cc[, j, 1]), ylim = c(0, 1.1)) # rho=0.1
  lines(density(cc[, j, 2]), col = 2) # rho=0.5
  lines(density(cc[, j, 3]), col = 3) # rho=0.9
}

plot_density_coef(1) # Para beta0
plot_density_coef(2) # Para beta1
plot_density_coef(3) # Para beta2

# La multicolinealidad infla la varianza de los coeficientes de regresión, lo que puede ser problemático para la interpretación.
# Problemas surgen cuando el número de características (p) es igual o mayor que el número de observaciones (n).
# Los métodos clásicos como la regresión lineal por mínimos cuadrados no son adecuados en este caso.

# Modelo teórico para diferentes tamaños de muestra
beta0 <- 0
beta1 <- 1
sigma <- 1

par(mfrow = c(1, 2)) # Configuración para mostrar múltiples gráficos
for(n in c(50, 2)){
  eps <- rnorm(n, 0, sigma)
  x <- runif(n)
  y <- beta0 + beta1 * x + eps
  z <- lm(y ~ x)
  plot(x, y)
  abline(z)
}

# Tamaño de la muestra y dimensiones para la simulación
n <- 100
ps <- c(90, 40, 10) # Diferentes números de predictores
B <- 1000 

# Array para almacenar coeficientes estimados
cc <- array(dim = c(B, 2, length(ps)))

# Bucle para simular datos y ajustar modelos con un gran número de predictores
for(j in 1:length(ps)){
  p = ps[j]
  for (i in 1:B){ 
    eps <- rnorm(n, 0, sigma)
    xmat <- matrix(runif(n * p), nrow = n, ncol = p)
    y <- rowSums(xmat) + eps
    
    

# Carga de datos y bibliotecas
library(Brq) # Biblioteca para el conjunto de datos de Prostate
data(Prostate) # Cargar datos de Prostate

# Visualizar dimensiones y primeras filas de los datos
dim(Prostate) # Muestra las dimensiones del dataset
head(Prostate) # Muestra las primeras filas

# Regresión Lineal Múltiple
# Se ajusta un modelo lineal para explicar la variable 'lpsa' usando todas las otras variables como predictoras.
# Esto es útil para entender la relación entre 'lpsa' y los marcadores clínicos.
lm_fit <- lm(lpsa ~ ., data = Prostate) # Ajustar modelo
summary(lm_fit) # Resumen del modelo

# Regresión Ridge
# Ridge es una técnica de regularización que añade un término de penalización a la suma de los cuadrados de los coeficientes.
# Esto ayuda a prevenir el sobreajuste, especialmente cuando las variables predictoras están correlacionadas.
library(MASS) # Biblioteca para regresión Ridge
lam <- seq(0, 10, by = 0.01) # Secuencia de valores lambda para la penalización
rr <- lm.ridge(lpsa ~ ., lambda = lam, data = Prostate) # Ajustar modelo Ridge para diferentes lambdas
coef(rr) # Coeficientes para diferentes lambdas

# Regresión Ridge con glmnet
# glmnet es otra biblioteca que ofrece una implementación eficiente de regresión Ridge y Lasso.
library(glmnet) # Biblioteca para glmnet
x <- Prostate[, -9] # Variables predictoras
y <- Prostate$lpsa # Variable de respuesta
rr_glmnet <- glmnet(x, y, alpha = 0, lambda = lam) # Ajustar modelo Ridge con glmnet
coef(rr_glmnet) # Mostrar coeficientes

# Estimación Lasso
# Lasso es similar a Ridge, pero puede reducir algunos coeficientes a cero, lo que implica selección de variables.
lasso <- glmnet(x, y, alpha = 1, lambda = lam) # Ajustar modelo Lasso
coef(lasso) # Mostrar coeficientes

# Selección del parámetro de penalización mediante validación cruzada
# La validación cruzada se usa para seleccionar el mejor valor de lambda que minimiza el error de predicción.
cvout <- cv.glmnet(as.matrix(x), y, alpha = 0, lambda = lam) # Validación cruzada para Ridge
coef(cvout, s = "lambda.min") # Coeficientes para el lambda óptimo en Ridge

cvout2 <- cv.glmnet(as.matrix(x), y, alpha = 1, lambda = lam) # Validación cruzada para Lasso
coef(cvout2, s = "lambda.min") # Coeficientes para el lambda óptimo en Lasso

# Predicción con Lasso
# Ejemplo de cómo hacer predicciones para las primeras 5 observaciones con un valor específico de lambda.
predict(lasso, newx = as.matrix(x[1:5, ]), type = "response", s = 0.5)

    

