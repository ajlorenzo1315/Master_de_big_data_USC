

#Entendido, puedo ayudarte a preparar algunos scripts de R básicos y bien comentados para que puedas entender 
#lo que se está haciendo y por qué. Dado que el examen abarcará temas como métodos lineales para regresión, 
#regularización, métodos para clasificación y reducción de la dimensión, me centraré en estos aspectos. 
#Empezaré con un ejemplo de regresión lineal y luego pasaré a otros temas.

#Regresión Lineal en R:
#  Este script muestra cómo realizar una regresión lineal simple en R. La regresión lineal se utiliza para entender la relación entre dos variables.


# Cargamos el paquete necesario
library(ggplot2)

# Ejemplo sencillo de Regresión Lineal con el dataset mtcars
# mtcars es un dataset integrado en R que contiene datos de distintos modelos de coches

# Visualizamos los datos para entender la relación entre mpg (millas por galón) y wt (peso del coche)
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point() + geom_smooth(method="lm", se=FALSE)

# Realizamos la regresión lineal
modelo <- lm(mpg ~ wt, data=mtcars)

# Mostramos el resumen del modelo
summary(modelo)

# Este resumen nos da información sobre la relación entre el peso del coche (wt) y su consumo (mpg).

#Regularización - Ridge y Lasso:
#  La regularización es un método para evitar el sobreajuste en modelos de regresión. Ridge y Lasso son dos tipos comunes de regularización.

R

# Cargamos las librerías necesarias
library(glmnet)

# Preparamos los datos
# Aquí estamos usando datos simulados para el ejemplo
x <- matrix(rnorm(100*20), 100, 20)
y <- rnorm(100)

# Ridge regression
fit.ridge <- glmnet(x, y, alpha=0)
# El parámetro alpha=0 indica Ridge regression

# Lasso regression
fit.lasso <- glmnet(x, y, alpha=1)
# El parámetro alpha=1 indica Lasso regression

# Estos modelos nos ayudan a prevenir el sobreajuste ajustando los coeficientes de las variables.

#Clasificación - Regresión Logística:
#  La regresión logística se utiliza para problemas de clasificación.


# Cargamos la librería necesaria
library(glmnet)

# Datos de ejemplo para clasificación binaria
x <- matrix(rnorm(100*20), 100, 20)
y <- sample(c(0,1), 100, replace=TRUE)

# Modelo de regresión logística
fit.logistic <- glmnet(x, y, family="binomial")

# Este modelo nos permite clasificar entre dos categorías basadas en las variables predictoras.

#Reducción de la Dimensión - Análisis de Componentes Principales (PCA):
#  PCA es una técnica para reducir la dimensionalidad de los datos.



# Cargamos la librería necesaria
library(prcomp)

# Usamos el dataset mtcars como ejemplo
datos <- mtcars[, c("mpg", "disp", "hp", "drat", "wt")]

# Aplicamos PCA
resultado.pca <- prcomp(datos, center=TRUE, scale.=TRUE)

# Ver el resumen de los resultados
summary(resultado.pca)

# Este resumen muestra la varianza explicada por cada componente principal.
