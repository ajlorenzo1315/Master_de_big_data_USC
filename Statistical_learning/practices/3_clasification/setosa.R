# datos sobre plantas
data(iris)

#plot()

library(class)
# k vecinos mas proximos

?knn
# cojo mi conjunto de entrenamiento que estan clasificación supervisada
# para 50 plantas 

# conjunto de entrenaminto (input)
# matriz  de columna de longitud de petalo y anchura de petalo
tmat=cbind(iris$Petal.Length,iris$Petal.Width)
# conjunto de entramiento de (outpout)
# como estamos en clasificación supervisada yo ya se el output
clt=iris$Species

# k vecinos mas proximos (k=1)
# deberiria tener un problema de over fiting por
# escogerse a si mismo al usar el k vecino 
# con ide que 3 plantas tiene la misma anchura 
# hay 3 plangtas que coincide las clasifica como la mayoria
# en este caso deberia hacerlo perfecto
knniris=knn(tmat,tmat,clt,k=1)

# Devuelve clasificación para lo que yo le ponga en terst (tmat)
knniris[1]
# voy a comparar la clasificación que hace el modelo con la realidad

# hay un problema de over fitin g deberia  aparecer 
iris[iris$Petal.Length==4.8 && iris$Petal.Width==1.8]
# cual esta clasificando mal
which(knniris!=iris$Species)
# luego miramos las caracteristocas de esta clasificaión que esta mal
iris$Petal.Length[71]
iris$Petal.Width[71]

# si cogeis un vecino mas proxiumo tendrias que tener una 
# Una clasificación perfecta sobre el train 
# pero si se usa el eval daria problemas de over fiting
set.seed(2023)

knniris10=knn(tmat,tmat,clt,k=10)
table(knniris10,iris$Species)

################################

# ANALISIS LINEAL DISCRIMINANDTE

################################

library(MASS)
lda.fit=lda(Species~iris$Petal.Length+iris$Petal.Width,data=iris)
