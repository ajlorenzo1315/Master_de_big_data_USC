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


# Una de las cosas que se hace que es ver que los residuos fincione bien
# para ello hacemos un plot del modelo
lm <- lm(Advertising$Sales~Advertising$TV)

# se pude ver si son normales para poder ajustar (solo ajustando en media solo si sigue una distrivución nomal)
# se ve si los residuos se aproximana a una recta 
# asumir que la dispersión se alejan lo mimo de la recata si se la recta de regresión primero estan muy cerca y luego 
# muy lejos luego veo que el mo

# cuando pesidual vs lecerage signifia cque un punto tira demasiado 

# Comprobamos que todos los puntos se situan sobre la recta 

#-------------------------------------------------------------------------------------
# 11 -10-2023
#--------------------------------------------------------------------------------------
# otros problemas mas comunes son los problemas de collinerity
# que pasaa los que mas invierten en televisión asume que los inputs no tienen relación entre si  entre los dos inputs
# si se usa de los modelos de regresión 

# tengo un problema que es minimizar Y1-B0-B1X11 - B2 X21)² +.....+
#^B=(X^t*X)⁻¹ * X^t*Y
#hay algo peor si las cariantes son muy dependientes los B se van a volver nulos dado que los inputs deberian ser independientres entre si

# generando un escerario ideal par ala regresion al
# ser las betas independientes 
n<<-100
beta<- c(3,5) # verdaderos  parametros 
# genero 100 datos para x1 y x2 (supongamos que son radio y televisión)
x1<-rnorm(n)
x2<-rnorm(n)
#y<-beta[1]*x1+beta[2]*x2+error
y<-beta[1]*x1+beta[2]*x2+rnorm(n)
mod <- lm(y~x1+x2)

# ahora lo que haremos que los puntos de x2 este relacionado con x1

n<<-100
beta<- c(3,5) # verdaderos  parametros 
# genero 100 datos para x1 y x2 (supongamos que son radio y televisión)
x1<-rnorm(n)
# lo que hacemos que los datos de x2 se generen dependiendo de x1 con cierto error
x2<-rnorm(n,mean=x1,sd=0.01)
#y<-beta[1]*x1+beta[2]*x2+error
y<-beta[1]*x1+beta[2]*x2+rnorm(n)
# cuando se ajuste el modeloahora lo hace orrible lo que le
# dice que Betha1=3 partiendo de mi training datase siendo el modelo
# perfecto lo que estoy hacinedo estimando  -11(puede cambiar segun la ejecucion)
# lo que esta pasando aqui es un ejecución de compesacion por lo cual
# indica que al estar relacionadas una de las dos no seria necesario e intenta
# que si una sube mucho la otra lo baje puede se r que en una de las
# ejecuciones de similar al modelo real por azar .
mod <- lm(y~x1+x2)
# Al conseguir muchos datos de los clientes estan muy relacionados nuestro modelo 
# se vuelve loco por lo cual el modelo no esta biem ajustado


# ahora los modelos esstaran efecto modelo multicolinealidad controlando la correlaicón
# primero genero 2 inpust independientes

# datos aleatorios de una normal que al generar primero 1 y luego otro no van a tener relación
x1=rnorm(100,mean = 0,sd=1)
x1s=rnorm(100,mean = 0,sd=1)

# ahora indicamos cuanta correlación queremos tener
cor=0.5
# ahora generamos x2 con cierta correlación x1s es x^*
# basaandonos en una formula que tien el documento en LAB CV
x2=cor*x1+sqrt(1-cor^2)*x1s

# declaramos un error para el modelo con una 
# deviación menor
 eps=rnorm(1000,0,std=0.1)
 # Ahora generamos el modelo
 y=x1+x2+eps
 mod<-lm(y~x1+x2)
 coef(mod)
 
 beta0v=numeric()
 beta1v=numeric()
 beta2v=numeric()
 cor=1
 for (i in 1:1000){

   # datos aleatorios de una normal que al generar primero 1 y luego otro no van a tener relación
   x1=rnorm(1000,mean = 0,sd=1)
   x1s=rnorm(1000,mean = 0,sd=1)
   
   # ahora indicamos cuanta correlación queremos tener

   # ahora generamos x2 con cierta correlación x1s es x^*
   # basaandonos en una formula que tien el documento en LAB CV
   x2=cor*x1+sqrt(1-cor^2)*x1s
   
   # declaramos un error para el modelo con una 
   # deviación menor
   eps=rnorm(1000,0,sd=0.1)
   # Ahora generamos el modelo
   y=x1+x2+eps
   mod=lm(y~x1+x2)
   beta0v[i]=coef(mod)[1]
   beta1v[i]=coef(mod)[2]
   beta2v[i]=coef(mod)[3]
 }
 
 # los si esta bien centrado en el valor esta bien 
 # histograma de lso beta estimado beta^
 hist(beta0v)
 summary(beta0v)
 
 hist(beta1v)
 summary(beta1v)
 # si se aumenta la correlación va seguir teniendo una forma campaneada pero se van a lejar los valores 
 # al tener correlaciones mas fuertes el modelo empieza a funcionar mal
 
 #---------------------------------------------------------------------------
 
# vamos a intentar solucionar el problema

 #------------------------------------------------------------------------------
 
 # Cuando el numero de caracteristicas de una persona es mayor que n 
 # si p (num de caracteristicas estoy estudiando) si > n o aprox a n 
 # se va a tener probemas poe que la matriz no se va a poder invertir 
 #
 
 # Y=bo+b1*X
 # si yo tengo solo dos obserbaciones tengo una recta que psa perfectamente
 # por los dos puntos y entonces sobre ajusta  lo que pasa es que si se aumenta 
 # ajuste perfecto un plano que pase por todos los puntos 
 # un hiper plano es lo que pasa cuando las caracteristicas se acercan mucho a 
 # los individuos que tenemos 

 # ------------------------------------------------------------------
 # si tengo demasiadas caracteristicas 
 # 3 opciones 
 # 1 en vez coger todas coger menos podemos usar el r² ajustado 
 #    para saber cuales son mas significativas
 #     anadir caracteristicas hasta que no mejores el modelo
 #    este no lo va hablar 
 # 2 Metodos de regularización lo que se va hacer es empujarlos hacia cero 
 # para que se elimine la caracteristica
 # 3 reducir l a dimensión en ver considerar las p caracteristicas lo que se 
 # hace es proyectarlas pierdo información 
 
 #-----------------------------------------------------------------------
 # METODOS DE REGULARIZACIÓN 
 # TENGO EL MODELO GENERAL QUE ES 
 # Y= B0+ B1*X1 -......+Bp*Xp
 # voy a reducir los coficiente para que se limite elo que se esta haciendo el metodo de regularización es conseguir que tenga 
 # menos varanza solucionando 
 
 # metosod por exelencia para el profesor
 # metodo ridge
 # basicamente 
 # yo tengo mi problema de minimizar B (Betha) 
 # min sum( Yi-B0*X1-......-Bp*Xp)²
 # lo que habla ridge es de imponer una restricción 
 # de que la suma de los coeficiental cuadrado no puede valer mas 
 # de un valor 
 # suma(betha²)<=s
 # de forma en el caso que tengas betha1²+betha²
 # (seguiria algo similar a la función de una circunferencia de tal manera que s es el radio)
 # este pude ser que no obtenga la mejor solución
 # por lo que nos quedaremos con el primer criterio de error que este dentro 
 # del circulo que se declaran con la ecuación de 
 # de esta manera evitamos que los valores sean muy altos
 # se puede rescivier 
 #  min betha (sum (Yi-B0-B1*X1-...-Bp*Xp)+landa*sum(B²))
 #  cuando landa es igual son los betas al cuadrado (calasica)
 # los bethas qyue se cogen son los de toda la vida 
 # si landa es muy grande los vertas se van a cero a nada que B(algo)
 # valga 1 se va hacer muy grande la unica solución es que B² sea cero
 # para que el criterio de error sea lo mas bajo posible
 # con el landa sera con lo que se juegue para que penalizce betha
 # s esta muy relacionado con landan se esta hablando del mismo
 # problema en este caso s inversamente equivalente a landa
 # de tal manera s=0 es igual landa= infinito
 # esto permite que escojas entre fiarte de la 
 # regresion clasica o la penalización 
 # evitando problemas como el que teniamos a la hora 
 # de usar inputs relacionados 
 # es obligatorio que landa>=0 es decir siempre positivo
 # hay que se cuidadosos con la penalizaaciónm
 # suponmgamos que Y es el peso  y X la altura
 # Y=-100+1.1 Altura
 # enfunción de como se mida los 
 # coeficientes bethas cambian por lo que 
 # hay que ajustar landa a la unidad medida
 # por lo cual al cambiar las unidades 
 # hay que ajustar segun la diferencia entre unidades medida
 # para evitar esto hay que estandarizar las bariables 
 # escalando las mismas unidades de medidas
 # los coficientes empiezan siendo muy grandes
 # pero va empujando todos a la vez 
 # se va desde sesgo varianza para escoger landa hay que tener
 # encuenta no dejar que se tenga mucha varianza pero tapoco dejar 
 # que nos alejemos de la solución real 
 # de tal manera que escoger el landa que minimice las dos
 # se pude usar el error cuadratico medio
 
 #------------
 # lasso (profe mas fan de lasso que de redge pordejar coficientes a cero)
 # lo que hace es 
 # sum(abs(bj))<=s
 # es decir se parece mucho a redge
 # lo que hace que nuestra función de seleción de parametros sean rombos 
 # diamantes en vez de circulos lo interesante es que al alejarnos
 # de la solución obtimo aveces la primera vez que toca el rombo 
 # permite que una de las bethas sea 0 lo que significa 
 # que hacemos que un ceficiente desaparezca
 # se usa con  la intención de eliminar variables
 # aunque sea mas computacionalmene mas costoso
 
 # ninguna de las dos tecnicas se superpone a la otra es decir que 
 # no se pude decir que una sea mejor que la otra
 #----------------------------------------------------------------------------------------------
 # se pude selocionser landa si me quiero quedar con dos variables 
 # criterios de a ojo 
 # metodoso validación cruzada
 
 #......................................................................................................
 # Notas  en la clase anterior 
 # h0* B1=0
 # h1* Bj!=0 
 # lasoo no sistutulle a un test formal
 # que laso diga que hay coeficientes 
 # seguramente me dirá cuales son cero
 # si que hay cierta relación en el 
 # contraste que da 0 por lo que laso 
 # lo suele hacer bien ya que tiende a eliminar primero
 # las que van a ser cero por contraste pero
 # como se pude forzar eso no significa que sean cero
 #....................................................................................................
 # R² si se sobre ajusta da 1 no todas las metricas 
 # son buenas ya que si se sobre ajusta 