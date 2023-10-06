# cambiamos el directorio de trabajo si es necesario
setwd("~/Desktop/Master_de_big_data_USC/Statistical_learning/practices")
#Construir la ruta al archivo CSV
ruta_archivo <-  "./2_Convex_optimization/Advertising.csv"

# Cargar el archivo CSV separado por punto y coma de las ventas

Advertising <- read.csv(file = ruta_archivo ,sep = ",")
Advertising

# Input : TV
# Modelo de aprendizaje (lineal)
# Y = beta0 + beta1*X + error
mod <- lm(Advertising$Sales~Advertising$TV)
mod
# Coefficients:
# (Intercept)  Advertising$TV  
# 7.03259         0.04754  
#
plot(Advertising$TV,Advertising$Sales)
abline(mod,col="red")
# Ventas se modelan 7.03 + 0.48*TV


# Intervalo de confianzaa para los parámetros
confint(mod)

#Error tipico (Bo^ -2ET, Bo^ + 2ET)
summary(mod)$coefficients
# 2 deberia  qt(0.975,length(Advertising$Sales)-2)
dos<-qt(0.975,length(Advertising$Sales)-2)
summary(mod)$coefficients[,1]-2*summary(mod)$coefficients[,2]
confint(mod)
summary(mod)$coefficients[,1]-dos*summary(mod)$coefficients[,2]


# Contrastar si TV influye en sales 
# Ho : beta1=0
# H1: beta1 != 0
summary(mod)
summary(mod)$coefficients
# para beta1, el p-valor es 1.46739e-42

# r² no se conforma con  0.6119 pero 
# viendo que tiene cierta curbatura
summary(mod)

#output: sales
# modlo lineal multiple 
mod2 <- lm(Advertising$Sales~Advertising$TV+Advertising$Radio+Advertising$New)
mod2

plot(Advertising$New,Advertising$Sales)
summary(mod2)
# F-statstic (.....) p-value: 2.2e-16
# Como p-valor < 0.05 hay algún medio que influye en sales 
# intervalos de confianzaa al 95 %
confint(mod2)

# contrastes para cada beta ..j 
summary(mod2)

# error tipico 0.311908
# <2e-16 que el nivel que yo imponco
# 

#Coefficients:
#  Estimate             Std.     Error      t     value Pr(>|t|)    
#(Intercept)        2.938889   0.311908   9.422   <2e-16 ***
#  Advertising$TV     0.045765   0.001395  32.809   <2e-16 ***
#  Advertising$Radio  0.188530   0.008611  21.893   <2e-16 ***
#  Advertising$New   -0.001037   0.005871  -0.177     0.86    

# yo me puedo desprender de los periodicos y acabo teniendo un modelo mejor lo que me dice es que se
# pueda elimine Advertising$New   -0.001037   0.005871  -0.177     0.86 
# lo que puedo determinar es que b0 b1 y b2 son distintos de 0
# 
# mejor Advertising$New   -0.001037   0.005871  -0.177     0.86 


mod3 <- lm(Advertising$Sales~Advertising$TV+Advertising$Radio)
mod3
summary(mod3)

# el R cuadrado ajustado penaliza que cuantos mas parametros cojo reduce el r2 para penalizar escojer 
# en este casso se quedaria con el modelo que tien 3 parametros 
summary(mod3)$r.squared
summary(mod2)$r.squared
# lo que indica que la publicidad en periodicos no esta influllendo realmente en las ventas
summary(mod3)$adj.r.squared
summary(mod2)$adj.r.squared
# internamente r 

# Predincción

attach(Advertising) # soltamos el advertaising liberando en el dato
mod4=lm(Sales~Radio+Newspaper)
nueva=data.frame(TV=100,Radio=20,Newspaper=0)
predict(mod4,newdata=nueva)

# intervalo de confianza al 95%
# para solo una empresa
# Para solo una empresa mas error mucho mas alejado de  si quiero 
# hablar un intervalo mas grande ya que  solo 1 
# da valores mas lejanos  a la media
predict(mod4,newdata=nueva,interval="prediction")
# en media si tengo muchas empresas mucha 
predict(mod4,newdata=nueva,interval="confidence")
