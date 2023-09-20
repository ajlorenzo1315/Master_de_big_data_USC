#Operaciones basicas
3+3
3-3i
#multiplicación
3*3
#potencia
3^3
3**3

#Funciones basicas
log(3)
sqrt(3)

#cargar librerias
#instalar librerias
#install.packages(c("usdata", "ggplot2", "readr", "rmarkdown", "tibble"))
install.packages("openintro")
#cargar libreras
library(openintro)

head(email)
# optengo los datos asociados a la columna spam
email$spam
# Tamaño del vector
length(email$spam)
# Para optner ayda sobre algo
?email
help((email))
# tabal de frecuencia absoluta
table(email$spam)
# tabla de fecuencia relativa spam 
table(email$spam)/length(email$spam)

# tabla de fecuencia relativa formato (es la tabla que sale a )
table(email$spam)/length(email$spam)

# Gráfico de barras
 barplot(table(email$spam))
 # Gráfico de tartas /sectores
 pie(table(email$spam))
 
 #histograma agrupa directamente me crea las categorias entre 0-20 
 # mi te da una idea de la forma
 #no tiene una forma simetrica 
 hist(email$num_char)
 
 # diagrama de cajas
 boxplot(email$num_char)
 boxplot(email$num_char,ylim=c(0,50))
 
 # media
 mean(email$num_char)
 #mediana
 # el 50 % de los email tiene menos de 5.856 * 10³
 median(email$num_char)
 
 # medir dispersión si da valores pequeños todos los valores cerca de la media
 # varianza
 var(email$num_char)
 # desviación tipica  es la raiz cuadrada de la varianza tiene la misma magnitud
 sqrt( var(email$num_char))
 sd(email$num_char)
 
 # asimetria
 install.packages("moments")
 library(moments)
 skewness(email$num_char)
 
 #cuantiles
 # siempre ordena de mas pequeño a mas grande
 quantile(email$num_char,0.25)
 # Diagrama de disoersión
 plot(email$num_char,email$line_breaks)
 # Regrasión lineal
 reglin=lm(email$line_breaks-email$num_char)
 abline(reglin,col=2,lwd=2)
 
 #Guardar un elemento
 elem=3
 # forma formal de guerda un elemento
 elem<-3
 # R distingue entre mayusculas y minusculas
 Elem= 4
 elem= 4
 
 # Crear vectores
 vect<-c(3,2,4)
 # R hacce operaciones elemento a elemento
 3*vect
 # Si queremos acceder a un elemneto del vector 
 vect[2]
 vect[c(1,3)]
 #Eliminar objetos
 rm(elem)
 elem

 #secuentcias de números
 # seciemcoa valor minimo 1 maximo 5 que va de uno a uno de longitud 5
 seq(1,10,len=5)
 # seciemcoa valor minimo 1 maximo 5 que va de dos en dos
 seq(1,10,by=2)
 
 # Matrices  
 # Rellena hacia abajo 
 mat=matriz(c(1,3,5,7),nrow=2,ncol=2)
 matriz(c(1,3,5,7),nrow=2,ncol=2,birow=TRUE)
 # acceder a elementos
 mat[2,2]
 mat[2,]
 mat[,2]
 dim(mat)
 #los numeros negativos eleimina
 mat[,-2]
 # r empieza a nuerar en el 1
 vect<-c(1,2,3)
 vect[0] # esto deberia dar un erro 
 vect[1]
 
 # buccles
 for (i in  1:3){
   mat[i,1]=mat[i,1]+1
   
 }
 
# si quiero sumar los elementos de mi vector
 
 sum(vect)
 # Elememto a elemento
 mat*mat
 # si quiero el producto matricial
 mat%%mat
 #
 vect2=c('si','no')
# valores regilla
 1:3
 vec=c(1:10)
 
 # Un data frame es una matriz en la que cada una de las columnas dejas que tenga  
 #distintas variabbles como pudese caracteres y numeros 
 # sin que los numeros pasesn a ser caracteres se crean similar a la matriz
 # solo que si data.frame
 