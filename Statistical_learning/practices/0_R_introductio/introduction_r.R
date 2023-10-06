# Cambiar datos

#Cambiar directiro de trabajo a donde estan los datos
setwd("/home/alourido/Escritorio/Master_de_big_data_USC/Statistical_learning/practices/1_R_introductio")

#Cargar datos de advertising.cvs
datos=read.csv("Advertising.csv")
hist(datos$Sales)

#resad.csv read.table

# Media de toda la población = 2

# distribución normal con una media  igual a 2 y desviación tipica igual a 1
# la media depensde de cada muestra
datos=rnorm(20, mean=2, sd=1)

# otra manera de hacesrlo 
# creamos un vector vacio numerico
meanv=numeric()
# generamos un bucle que guarda la media de los datos genereados para generar mil medias
for (i in 1:1000){
  datos=rnorm(20, mean=2, sd=1)
  meanv[i]=mean(datos)
}
# el teoriema del central del limite estas muestrales se van a comportar como una campana de gauss
# tambien con cuanta dispersión 

quantile(meanv)
hist(meanv)

# si aunemeto n estare mas cerca del 2 pasamos de 20 a 200
# creamos un vector vacio numerico
meanv=numeric()
# generamos un bucle que guarda la media de los datos genereados para generar mil medias
for (i in 1:1000){
  datos=rnorm(200, mean=2, sd=1)
  meanv[i]=mean(datos)
}
# el teoriema del central del limite estas muestrales se van a comportar como una campana de gauss
# tambien con cuanta dispersión 

quantile(meanv)

# si aunemeto n estare mas cerca del 2 pasamos de 20 a 20000
# creamos un vector vacio numerico
meanv=numeric()
# generamos un bucle que guarda la media de los datos genereados para generar mil medias
for (i in 1:1000){
  datos=rnorm(20000, mean=2, sd=1)
  meanv[i]=mean(datos)
}
# el teoriema del central del limite estas muestrales se van a comportar como una campana de gauss
# tambien con cuanta dispersión 

quantile(meanv)
hist(meanv)


# para generar intervalos de confianza es 
tt=numeric()
for (i in 1:1000){
  datos=rnorm(20000, mean=2, sd=1)
  ttt=t.test(datos)
  # para saber si 2 esta dentro del intervalo de confiaza delos datos generados como sabemos que la medias 2 dos 
  # vemos cuantas veces 2 esta dentro del intervalo de congianza
  tt[i]=(ttt$conf.int[1]<2)&(2<ttt$conf.int[2])
}
table(tt)

# Hipotesis

# quiero saner si p>0.5
# en nuestro caso 13 con cebolla de un total de 20
# H0: p=0.5 o p<_0.5
# H1: p>0.-5
# hay que meter numero de exito y tamaño muestral
prop.test(13,20)
# quiero confirmar si h1 es cierto de decir si H1:p0.5 
prop.test(13,20,alternative="greater")
# solo si esta por debajo de mi erro
# p- valor< alpha
# alpha error que asimimos en la hipotesis en la que H0 sea cierta escogemos H1
# p-value = 0.1318 >0.05 
# En este caso no podemos admitir el error 
# con datos del cis seisa 
prop.test(3195,4538,alternative="greater")
# en este caso  p-value < 2.2e-16 por lo cual podemos considerar que segun el cis 
# puedo decir que la mayoria preferie con cebolla
# alternative hypothesis: true p is not equal to 0.5 esto solo indica la hipotesis 
# alternativa no si es verdadera ya que solo es verdadera dependiendo
# del error que se este dispuesto a cometer
prop.test(3195,4538)

# que significa que p-valor < 0.05
# suponcamos que
# h0= mean =2
# h1: mean distinto 2

# para generar intervalos de confianza es 
pvv=numeric()
for (i in 1:1000){
  datos=rnorm(200, mean=2, sd=1)
  # contras te si la verdadera media es distinto de 2
  ttt=t.test(datos,mu=2)
  pvv[i]=ttt$p.value
}

summary(pvv)
# quiere decir que 95% mean 2 y 5% mean es distinto de 2
table(pvv<0.05)
# lo unico que yo se es que le puedo dar una resticción lineal