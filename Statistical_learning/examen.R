# Ejercio 2
# Punto inicial
tk=c(2,1)
# paso
t=0.1

# -gradeinte de f
deltax=function(x,y){-c(2*x,2*y)}

# Iterando 

#dir=deltax(tk[1],tk[2])
#tk=tk+t*dir

# ahora hacemos un bucle con iteraciones
max_iterations <-1
for (iteration in 1:max_iterations) {
  dir=deltax(tk[1],tk[2])
  tk=tk+t*dir
}
tk
# Ejercicio 3
install.packages("ISLR")
library(ISLR)
library(ggplot2)
data("mtcars")
# Visualizamos los datos para entender la relación entre mpg (millas por galón) y wt (peso del coche)
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point() + geom_smooth(method="lm", se=FALSE)
mtcart_2 <- na.omit(mtcars)
#selecionamos las columnas
mtcart_3 <-mtcart_2[, c("mpg","disp", "hp", "drat", "wt","qsec")]
summary(mtcars)
x <- mtcart_3[,c("disp", "hp", "drat", "wt","qsec")] # Variables predictoras
y <- mtcart_3$mpg # Variable de respuesta
rr_glmnet <- glmnet(x, y, alpha = 0, lambda = lam) # Ajustar modelo Ridge con glmnet

# Estimación Lasso
library(glmnet) # Biblioteca para glmnet
# Lasso es similar a Ridge, pero puede reducir algunos coeficientes a cero, lo que implica selección de variables.
lam <- seq(0, 10, by = 0.01) # Secuencia de valores lambda para la penalización
lasso <- glmnet(x, y, alpha = 1, lambda = lam) # Ajustar modelo Lasso
coef(lasso) # Mostrar coeficientes
plot(lasso, xvar = "lambda")
# como podemos observar con un lambda igual a 0 podemos eliminar todas las varibles menos 2 
summary(lasso)

lasso <- glmnet(x, y, alpha = 1, lambda = 3) # Ajustar modelo Lasso
coef(lasso) # Mostrar coeficientes
# por lo que se puden descarte drat y qsec
lasso <- glmnet(x, y, alpha = 1, lambda = 1) # Ajustar modelo Lasso
coef(lasso) # Mostrar coeficientes
# por lo que se puden descarte drat y qsec

lasso <- glmnet(x, y, alpha = 1, lambda = 4) # Ajustar modelo Lasso
coef(lasso) # Mostrar coeficientes

# Ejercicio 4
mtcart_2 <- na.omit(mtcars)
mtcart_reduce <-mtcart_2[, c("mpg","drat", "wt", "vs")]


library(MASS)
lda.fit <- lda(mtcart_reduce$vs ~ ., data = mtcart_reduce)

# se calcula con proporciones muestrales
lda.fit$prior
table(mtcart_reduce$mpg)/length(mtcart_reduce$mpg)

# Dentro de cada subgrupo se ajusta una normal de medias 
lda.fit$means

# Predicci�n en observaciones originales
lda.pred2 <- predict(lda.fit)
mtcart_reduce$vs
# Comparamos con la realidad
table(lda.pred2$class, mtcart_reduce$vs)
# Vemos que el porcentaje mal clasificado clasificados es
mean(lda.pred2$class!= mtcart_reduce$vs)
# clasifica bien la clase 0 17/18
# clasifica mal la clase 1 5/14

# Utilizando An�lisis Cuadr�tico Discriminante
qda.fit <- qda(mtcart_reduce$vs ~ ., data = mtcart_reduce)

# Predicci�n para los valores observados
qda.pred <- predict(qda.fit)

# Comparamos con la realidad
table(qda.pred$class, mtcart_reduce$vs)
# clasifica bien la clase 0 17/18
# clasifica mal la clase 1 4/14

# En este caso en an�lisis predictivo es mejor
# tasa mal clasificada
mean(qda.pred$class!= mtcart_reduce$vs)

# b 
mtcart_reduce_2 <-mtcart_2[, c("mpg","disp", "hp", "vs")]
lda.fit <- lda(mtcart_reduce_2$vs ~ ., data = mtcart_reduce_2)

# se calcula con proporciones muestrales
lda.fit$prior
table(mtcart_reduce_2$vs)/length(mtcart_reduce_2$vs)

# Dentro de cada subgrupo se ajusta una normal de medias 
lda.fit$means

# Predicci�n en observaciones originales
lda.pred2 <- predict(lda.fit)

# Comparamos con la realidad
table(lda.pred2$class, mtcart_reduce_2$vs)
# Vemos que el porcentaje de bien clasificados es
mean(lda.pred2$class== mtcart_reduce_2$vs)


# En este caso tiene un mejor comportamiento usar qsec y drat ya que 
# en laso comprobamos que se explicaban menos la variable mpg
mtcart_reduce_3 <-mtcart_2[, c("mpg","qsec", "drat", "vs")]
lda.fit <- lda(mtcart_reduce_3$vs ~ ., data = mtcart_reduce_3)

# se calcula con proporciones muestrales
lda.fit$prior
table(mtcart_reduce_3$vs)/length(mtcart_reduce_3$vs)

# Dentro de cada subgrupo se ajusta una normal de medias 
lda.fit$means

# Predicci�n en observaciones originales
lda.pred2 <- predict(lda.fit)

# Comparamos con la realidad
table(lda.pred2$class, mtcart_reduce_3$vs)
# Vemos que el porcentaje de bien clasificados es
mean(lda.pred2$class== mtcart_reduce_3$vs)
