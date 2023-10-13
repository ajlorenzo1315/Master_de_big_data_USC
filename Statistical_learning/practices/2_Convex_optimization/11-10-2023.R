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
 
 