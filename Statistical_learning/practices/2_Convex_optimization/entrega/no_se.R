# Representaci�n gr�fica

x <- seq(-10, 10, length = 30)
y <- x
f <- function(x, y) {0.5 * (x^2 + y^2)}
z <- outer(x, y, f)

# Gr�fico en 3d
persp(x, y, z,col=4,theta = 30, phi = 30)

# Gr�fico de contorno
contour(x, y, z)

# Con colores
image(x, y, z)
contour(x, y, z,add=T)


# Alternativas

# install.packages("lattice")
library(lattice)
g <- expand.grid(x = -10:10, y = -10:10)
g$z <- 0.5 * (g$x^2 + g$y^2)
wireframe(z ~ x * y, data = g, drape = TRUE)
levelplot(z ~ x * y, g, contour = TRUE)

install.packages("plotly")
library(plotly)
fig1 <- plot_ly(x = ~x,y = ~y,z = ~z)
fig1 <- fig1 %>% add_surface()
fig1

fig2 <- plot_ly(x = ~x,y = ~y,z = ~z, type = "contour")
fig2






#################################################################
#################################################################






# Vamos a ver c�mo funciona el algoritmo de descenso de gradiente
# El paso se lo damos al argumento gamma

# install.packages("animation")
library(animation)
oopt = ani.options(interval = 0.3, nmax = ifelse(interactive(), 50, 2))
xx = grad.desc(FUN = function(x, y) 0.5 * (x^2 + 2 * y^2), init = c(2, 1), gamma = 0.2)
xx$par # soluci�n
xx$persp(col = "lightblue", phi = 30) # Gr�fico de superf�cie









#################################################################
#################################################################







# Algoritmo de descenso de gradiente

# Funci�n objetivo
gammae=1
f <- function(x, y, gamma=gammae) {0.5 * (x^2 + gamma*y^2)}

# Punto inicial
pk <- c(gammae,1)

# Direcci�n
deltax=function(x, y, gamma=gammae) {-c(x, gamma*y)}

# Paso
t <- 0.2

# Criterio de parada
tol <- 10^(-5)

# Si queremos fijarle un n�mero m�ximo de pasos

dir <- deltax(pk[1],pk[2])

for (i in 1:1000){
  pk <- pk+t*dir
  dir <- deltax(pk[1],pk[2])
  if(sum(dir^2)<tol){break}
}

# Par� en el paso
i

# Punto donde se alcanza el m�nimo
pk
# Valor de la derivada en ese punto
-dir


# Ejemplo de cálculo del módulo de un vector unidimensional
vector_unidimensional <- c(3, 4, 5)
modulo_vector_unidimensional <- norm(vector_unidimensional)

cat("Módulo del vector unidimensional:", modulo_vector_unidimensional, "\n")







# Sin n�mero m�ximo de pasos podemos usar while o repeat
dir <- deltax(pk[1],pk[2])
while(sum(dir^2)>tol){
  pk <- pk+t*dir
  dir <- deltax(pk[1],pk[2])
}

dir <- deltax(pk[1],pk[2])
repeat{
  pk <- pk+t*dir
  dir <- deltax(pk[1],pk[2])
  if(sum(dir^2)<tol){break}
}











# Funci�n recreando el algoritmo para elecciones de usuario

graddec=function(gamma,t=0.2,puntoini=NULL,tol=10^(-5),nitermax=1000){
  
  if(is.null(puntoini)){
    pk=c(c(gamma,1))
  }else{
    pk=puntoini
  }
  
  dir <- deltax(pk[1],pk[2],gamma)
  
  for (i in 1:nitermax){
    pk <- pk+t*dir
    dir <- deltax(pk[1],pk[2],gamma)
    if(sum(dir^2)<tol){break}
  }
  
  if(i<nitermax){
    sol0=pk
  }else{
    sol0="No encontrada"
  }
  
  return(list(sol=sol0,niter=i,gradval=-dir))
  
}

# Cambiando el paso
graddec(1)
graddec(1,2)
graddec(1,0.01)

# Cambiando el valor de gamma (con paso fijo t=2)
graddec(0.1)
graddec(1)
graddec(10)







#################################################################
#################################################################




# exact line search

# f(x+s delta) = f(x - s grad(f))
# grad f = (x, gamma*y)
# f(x - s grad(f)) = 1/2*( (1-s)^2 x^2 + gamma*(1-gamma*s)^2*y^2)
# d/ds f(x - s grad(f)) = -(1-s)*x^2 - (1-gamma*s)*gamma^2*y^2
# d/ds f(x - s grad(f)) = 0 si s=(gamma^2*y^2 + x^2)/(gamma^3*y^2 + x^2) 


# El valor de t lo obtenemos por exact line search
tf=function(x,y,gamma) (gamma^2*y^2 + x^2)/(gamma^3*y^2 + x^2) 

# Repetimos la funci�n anterior pero con paso variable

graddec2=function(gamma,puntoini=NULL,tol=10^(-5),nitermax=1000){
  
  if(is.null(puntoini)){
    pk=c(c(gamma,1))
  }else{
    pk=puntoini
  }
  
  dir <- deltax(pk[1],pk[2],gamma)
  
  for (i in 1:nitermax){
    t <- tf(pk[1],pk[2],gamma)
    pk <- pk+t*dir
    dir <- deltax(pk[1],pk[2],gamma)
    if(sum(dir^2)<tol){break}
  }
  
  if(i<nitermax){
    sol0=pk
  }else{
    sol0="No encontrada"
  }
  
  return(list(sol=sol0,niter=i,gradval=-dir))
  
}

# Para distintos valores de gamma
graddec2(0.1)
graddec2(1)
graddec2(10)







#################################################################
#################################################################





# Backtracking line search

# Mientras que f(x+t*dir) > f(x)+alpha*t*grad(f(x))*dir
# Actualiza t=beta*t

graddec3=function(gamma,alpha=0.5,beta=0.5,t=1,puntoini=NULL,tol=10^(-5),nitermax=1000){
  
  if(is.null(puntoini)){
    pk=c(c(gamma,1))
  }else{
    pk=puntoini
  }
  
  dir <- deltax(pk[1],pk[2],gamma)
  
  for (i in 1:nitermax){
    
    f1 <- f(pk[1]+t*dir[1],pk[2]+t*dir[2])
    f0 <- f(pk[1],pk[2])
    
    while(f1 > (f0 - alpha*t*sum(dir^2)) ){
      t=beta*t
    }
    
    pk <- pk+t*dir
    dir <- deltax(pk[1],pk[2],gamma)
    if(sum(dir^2)<tol){break}
  }
  
  if(i<nitermax){
    sol0=pk
  }else{
    sol0="No encontrada"
  }
  
  return(list(sol=sol0,niter=i,gradval=-dir))
  
}


# Para distintos valores de gamma
graddec3(0.1)
graddec3(1)
graddec3(10)

# Para otros valores de alpha y beta
graddec3(10,alpha=10^(-4))
graddec3(10,beta=0.3)
graddec3(10,alpha=0.1,beta=0.3)