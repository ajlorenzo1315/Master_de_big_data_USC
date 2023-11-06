data(meas)



mean(ajuste.lm$residuals^2)
# pediciión realiza mi modelo  par aver cuanto vale los residuos
#@ sobtre el conkunto si yo tnego las observaciones de x1 a xp 
# cuanto vale el doelo
predtest<-predic(ajuste.lm,newdata=test)

# cuanto valia en relaidad 
terst$fat

# cuanto vale los residuos al cuadrado 
# lo que predice - la realidad 

sum((predtest-test$fat)^2)

# eror cuadtaico medio es 
mean((predtest-test$fat)^2)
# cuanto este mas acercado a cero mejor ahora voy a proyextar

# lo que me va a decir es el valor de los 100 predictores
trainx<-train[,1:100] # quiero entrenar sobre el train
# proyectamos sobre el train
# compon entes principales estoy proyectando las dimensiones
pcax<-princomp(trainx)
# ya con la primera dimensión explicar la mayoria del comportamiente 
# toas estan medidas en la primera magnitud seguramente todas
# las variables sean super relacionadas 

# entonces vamos a hacer regresión sobre dos 
# nos vamos a quedar una matriz de las pca que queramos (componente principaes) y los valores

# nops dice cuanto vale  sobre el primer componente
pcax$scores[1,]

# nos querenmos quedar con las k componentes principales
k<-3
#trainpca<-pcax$scores[,1:k]
# las 3 primeras columnas son las proyecciónes y la ultima es los valores de Y que ya teniamos
trainpca<-cbind(pcax$scores[,1:k],train$fat)
# como necesita que el data sea un date frame por que si no da un error
# combertimos la matriz en un data frame 
trainpca<-as.data.frame(trainpca)
# para que funciones esto hay que indicar que la ultima columna de train  far para que luego 
# podamos referenciarlas
name(trainpca)[k+1]='fat'
ajuste.lmpca<-lm(fat~,data=trainpca)
summary(ajuste.lmpca)
# para el train se va ha hacer peor

