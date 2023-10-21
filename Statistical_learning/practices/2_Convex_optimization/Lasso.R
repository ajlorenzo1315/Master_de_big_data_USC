install.packages("Brq")
library(Brq)
# datos para detectar cancer de protat 
# lpsa es un buen indicador  ()
data("Prostate")
summary(Prostate)
# vamos a intentar con unos input 
# sacar unos outputs
# queremos entrenar un 

# ajustamos lienal

# el . es que indica que depende de todos las demas variables

mod=lm(lpsa ~.,data =Prostate)

coef(mod)
# si queremos evitar los problemas de de colarenidad 
# como sospecho que dos de las variables 
# estan relacionados

# Usamos el metodo Ridge

# la libreria deberia estar precargada
library(MASS)
modr<-lm.ridge(lpsa~.,data=Prostate,lambda = 0)
# esto no va a devolver los conficientes si no esta 
# normalizada las medidas por lo que primero que hace 
# es estanderizar y luego obtiene los coeficientes de beta
modr$coef # aqui estan estanderizados
# por que si se comara los valores no va a devolverslo corriente
# si quieres los coesficientes correctos sin
# estandarizar
coefficients((modr))

 # lo que devulesbe es la media muestras si se usa una penalizaación muy alta
modr2<-lm.ridge(lpsa~.,data=Prostate,lambda = 1000000000)
coefficients((modr2))
# si se unas algo intermedio los betas van a ir bajando 
modr3<-lm.ridge(lpsa~.,data=Prostate,lambda = 10)
coefficients((modr3))

install.packages("glmnet")
library(glmnet)

# no es la misma extructura
# primero hay que pasar input enteros y luego otra variable con todos los outputs
y=Prostate$lpsa
# en x almaceno todas las columnas - la 9 que es lpsa
x=Prostate[,-9]

modr4=glmnet(x,y,alpha=0,lambda=0)
coefficients((modr4))
# glmenet internamente hace lamda/2 no resulve exactamente el mimo problema pero en cualquier caso el
# efecto es el mismo pero no devielve el mismo resultado que con la otra libreria

modr4=glmnet(x,y,alpha=0,lambda=10)
coefficients((modr4))

lam=seq(0,10,by=0.01)
modr6=glmnet(x,y,alpha=0,lambda=lam)

plot(modr6,xvar="lambda")

# para obtener los coeficientes de la regilla de valores
# para un lambda expecifico
coef(modr6,s=9.91)

# Regulación LASSO
# glmet(alpah=1) -> LASSO

modl=glmnet(x,y,alpha=1,lambda=0)
coef=modl

modl2=glmnet(x,y,alpha=1,lambda=1000)
coef=modl2

# se muestra para distionto valores de 
# segun aumneta lambda va eliminando variables
# como se ve en la grafica las 3 contribulleun indice 
# postratico mayor
lam=seq(0,10,by=0.01)
modl3=glmnet(x,y,alpha=1,lambda=lam)
plot(modl3,xvar="lambda")

# el train y test para probar nuestro modelo 
# se escoge de manera aleatoria 
# Rideg
cvout=cv.glmnet(as.matrix(x),y,lambda = lam,alpha=0)
cvout$lambda.min

# los creadoes pueda variar entre 0 y 1 lo que hace esa gente podais penalizar de igual
# manera de los beta 2 y puede pernalizar absoluta
# se parecea a tener rideg y lasso a ala vez
# teniendo una mezcla de los dos con mayor o menor medida
# ridge mandar coeficientes a cero  ridef
# laso coge el probelema de alta dimención 
# en función de alfa  quiero penalizar mas muchas variables
# o el de linealidad
