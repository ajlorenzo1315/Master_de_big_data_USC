install.packages("faraway")
library("faraway")
data(meatspec)

head(meatspec)
dim(meatspec)

#training dataset (172 obs)
train <- meatspec[1:172,]

#training dataset (215-172 obs)
test<-meatspec[173:215,]

#regresion lineal clasica
ajuste.lm<-lm(fat~.,data=train)
summary(ajuste.lm)

#suma de residuos al cuadrado (training dataset)
sum(ajuste.lm$residuals^2)
#error cuadratico medio
mean(ajuste.lm$residuals^2)

#Predicccion realiza mi modelo
predtest<-predict(ajuste.lm, newdata=test)

#suma de residuos al cuadrado (test dataset)
sum((predtest-test$fat)^2)
#error cuadratico medio (test dataset)
mean((predtest-test$fat)^2)

#componentes principales sobre predictores
trainx<-train[,1:100]
pcax<-princomp(trainx)
summary(pcax)

pcax$scores[1,] #componentes principales del 1er ndividui

#regresion PCA
k<-3
trainpca<-as.data.frame(cbind(pcax$scores[,1:k], train$fat))
names(trainpca)[k+1]="fat"
ajuste.lmpca<-lm(fat~.,data=trainpca)
summary(ajuste.lmpca)

#suma de residuos al cuadrado (training dataset)
sum(ajuste.lmpca$residuals^2)
#error cuadratico medio
mean(ajuste.lmpca$residuals^2)

#cuanto valen las componentes principales para el test
testx<-test[,1:100]
testpca<-predict(pcax, newdata=testx)
testpca<-testpca[,1:k]
testpca<-as.data.frame(testpca)

#cuanto predice mi modelo que vale fat
predtest.pca<-predict(ajuste.lm , newdata = testpca)
predtest.pca
#realidad
test$fat

#suma de residuos al cuadrado (test dataset)
sum((predtest.pca-test$fat)^2)
#error cuadratico medio (test dataset)
mean((predtest.pca-test$fat)^2)






