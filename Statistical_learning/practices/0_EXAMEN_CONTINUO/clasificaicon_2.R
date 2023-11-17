# Clasificaci�n de especies en funci�n de
# longitud y anchura de p�talo

data(iris)
plot(iris$Petal.Length, iris$Petal.Width, col = iris$Species)
legend("bottomright", levels(iris$Species), pch = 1, col = 1:3)

# k vecinos m�s pr�ximos

library(class)
matexp <- cbind(iris$Petal.Length, iris$Petal.Width)
vecres <- iris$Species

# Vamos a hacer predicci�n sobre los propios datos (test=training)
# k=1 (1 vecino)

knn.pred <- knn(train=matexp,test=matexp,cl=vecres,k=1)

# Comparamos predicci�n con realidad
table(knn.pred,vecres)
# La predicci�n deber�a ser perfecta
which(knn.pred!=vecres)
# No lo es porque tenemos dos plantas clasificadas distintas
# con las mismas explicativas (en el training)
which((matexp[,1]==4.8)&(matexp[,2]==1.8))
vecres[which((matexp[,1]==4.8)&(matexp[,2]==1.8))]

# Si queremos ver la probabilidad asociada
knn.predb <- knn(matexp,matexp,cl=vecres,k=1,prob=T)
attr(knn.predb, "prob")

# k=10 (10 vecinos)
set.seed (1)
knn.pred2 <- knn(matexp,matexp,cl=vecres,k=10)
table(knn.pred2,vecres)

# Vamos a representar la frontera de decisi�n
seqx <- seq(0.9,7,len=100)
seqy <- seq(0,2.6,len=100)
rejbid <- expand.grid(x=seqx,y=seqy)
knn.pred3 <- knn(matexp,rejbid,cl=vecres,k=10)
image(seqx,seqy,matrix(as.double(knn.pred3),nrow=100),col=1:3)
points(iris$Petal.Length, iris$Petal.Width, bg = iris$Species,col=4,pch=21)


# An�lisis lineal discriminante

library(MASS)
lda.fit <- lda(Species ~ Petal.Length + Petal.Width, data = iris)

# Las probabilidades a priori de que una observaci�n provenga de la clase k
# se calcula con proporciones muestrales
lda.fit$prior
table(iris$Species)/length(iris$Species)

# Dentro de cada subgrupo se ajusta una normal de medias 
lda.fit$means

# La predicci�n se hace con el comando predict
# Nuevas observaciones
newd <- data.frame(Petal.Length=c(1.26905,5),Petal.Width=c(2.19,2))
lda.pred <- predict(lda.fit,newdata=newd)

# Probabilidad de pertenecer a cada clase
lda.pred$posterior

# Clase en la que clasifican a estas nuevas observaciones
lda.pred$class

# Si solo quisi�semos dar clasificaci�n de aquellas que excedan una 
# probabilidad de 0.5, ver�amos que la segunda la clasificamos
# como virg�nica, pero la primera queda sin clasificar
lda.pred$posterior>0.5

# Predicci�n en observaciones originales
lda.pred2 <- predict(lda.fit)

# Comparamos con la realidad
table(lda.pred2$class, iris$Species)


# Vemos que el porcentaje de mal clasificados es
(4+2)/150
mean(lda.pred2$class!= iris$Species)



# Si utilizasemos como criterio que la prob a posteriori
# sea mayor que 0.9, se clasifican 138
sum(lda.pred2$posterior>0.9)

# Las observaciones que se clasifican son
obsclas <- rowSums(lda.pred2$posterior>0.9)

# Comparamos con la realidad
table(lda.pred2$class[obsclas==1], iris$Species[obsclas==1])
# aqu� la clasificaci�n es perfecta



# Utilizando An�lisis Cuadr�tico Discriminante
qda.fit <- qda(Species ~ Petal.Length + Petal.Width, data = iris)

# Predicci�n para los valores observados
qda.pred <- predict(qda.fit)

# Comparamos con la realidad
table(qda.pred$class, iris$Species)

# En este caso en an�lisis predictivo es mejor
mean(qda.pred$class!= iris$Species)

# Una alternativa para visualizar los resultados es la librer�a klaR
# install.packages("klaR")

library(klaR)
partimat(Species ~ Petal.Length + Petal.Width, data = iris, method = "lda")
partimat(Species ~ Petal.Length + Petal.Width, data = iris, method = "qda")

