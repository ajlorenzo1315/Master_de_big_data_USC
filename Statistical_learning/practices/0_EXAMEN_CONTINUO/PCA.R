# 25 alumnos aspirantes a entrar en el m�ster
dat <- read.table("aspirantes.txt", header = TRUE)
# evaluaci�n de los 6 primeros
head(dat)

# An�lisis de Componentes Principales
test.pca <- princomp(dat)
test.pca

# Proporci�n de varianza explicada
summary(test.pca)

# Alternativa v�a autovalores
av <- test.pca$sdev^2
av[1]/sum(av)
sum(av[1:2])/sum(av)


## �C�mo escoger el n�mero de componentes?

# Podemos fijar su n�mero: solo quiero dos componentes (son f�ciles de representar)
# Las dos primeras componentes explican un 90% de la variabilidad
sum(av[1:2])/sum(av)
# Gr�fico de sedimentaci�n (screeplot)
# Buscar 'codo' en el gr�fico, entendiendo por codo un punto a partir del cual los valores propios son claramente m�s peque�os que los anteriores, y muy similares entre s�.
screeplot(test.pca, type = "lines")

# Autovalores (nos dice las combinaciones lineales de las variables originales)
test.pca$loadings

# Representaci�n
barplot(loadings(test.pca), beside = TRUE)

# �Cu�les ser�an los resultados de los 6 primeros alumonos si se aplica la transformaci�n obtenida por PCA?
head(test.pca$scores)


## Alternativa (haci�ndolo a mano)
n <- nrow(dat)
# Estimamos la matriz de varianzas-covarianzas
S <- cov(dat) * (n - 1)/n
auto <- eigen(S)
lambda <- auto$values
# Autovalores
lambda
# Autovectores
v <- auto$vectors
v


## Biplot: Representaci�n de scores y PCA
biplot(test.pca)




##########################

## Regresi�n con PCA
library(faraway)
data(meatspec)
# Contenido en grasa en funci�n de otras 100 variables
head(meatspec)
dim(meatspec)

# Partimos la muestra 
# Training data (172 obs)
train= meatspec[1:172,]
# Test data (43 obs)
test= meatspec[173:215,]

# Linear regression (with p=100 predictors)
fit.lm <- lm(fat ~ ., data = train)
summary(fit.lm)
# Suma de Residuos al Cudrado
sum(fit.lm$residuals^2)
# MSE
mean(fit.lm$residuals^2)

# �Qu� ocurre con los test data?
# Predicci�n
predy <- predict(fit.lm,newdata=test)
# Residuos
restest <- test$fat-predy
# Suma de Residuos al Cudrado
sum(restest^2)
# MSE
mean(restest^2)




## PCA en los predictores
p <- 100
trainx <- train[, 1:p]
pca <- princomp(trainx)
summary(pca)
screeplot(pca, type = "lines")

# Usando las 4 primeras componentes principales
k <- 4
pcax <- as.data.frame(cbind(pca$scores[, 1:k],train$fat))
names(pcax)[k+1] <- "fat"
fit.pcr <- lm(fat ~ ., data=pcax )

# MSE
mean(fit.pcr$residuals^2)

# MSE (test data)
# Al test data le aplicamos la transformaci�n que da PCA
testPCA <- predict(pca,newdata=test[,1:p])
testPCA <- testPCA[,1:k]
# Predicci�n
predy <- predict(fit.pcr,newdata=as.data.frame(testPCA))
# Residuos
restest <- test$fat-predy
# MSE
mean(restest^2)
