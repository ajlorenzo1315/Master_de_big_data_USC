#x = seq(-10,10, length=30)
#y=x
#ghama=0.5

x <- seq(-10, 10, length = 30)
y <- x
ghama <- 0.5

# # si solo tengo una funcion es decir un calculo solo devuelve la linea
f <- function(x, y, ghama) {
  1/2 * (x^2 +ghama * y^2)
}

# genera una matriz de valores regilla de 20x20
#z=outer(x,y,ghama,f)
# Genera una matriz de valores usando outer
z <- outer(x, y, FUN = Vectorize(function(x, y) f(x, y, ghama)))
# deja ver graficos en perspectiva 3d 
persp(x,y,z,col=4)
# si quieres hacer un grafico mas chulo r old school o plotlib
# otro tipo de grafico es el de contorno 
contour(x,y,z)
image(x,y,z)
contour(x,y,z,add=T)
# como aqui hay dos lineas hay que indicar return para que sepa cual devolver
f=funtion(x,y,ghama){
  val0=(x^2+ghama*y^2)
  val1=ghama
  return(val1)
}


##### DESCENSO DEL GRADIENTE#####################
# Función a minimizar
f <- function(x, y, ghama) {
  1/2 * (x^2 + ghama * y^2)
}

# Gradiente de la función
grad_f <- function(x, y, ghama) {
  # funcion 1/2 * (x² + ghama * y²) 
  # Derivada parcial con respecto a x
  # regla de la cadena -> 2x/2+1/2*0 = 2x/2 = x
  grad_x <- x
  
  # Derivada parcial con respecto a y
  # regla de la cadena -> 0/2+ghama*2y/2 = ghama*y
  grad_y <- ghama * y
  
  # Devolver el gradiente como una lista de componentes el vector gradiente
  list(grad_x = grad_x, grad_y = grad_y)
  
}


# Parámetros iniciales
#set.seed(123)  # Para reproducibilidad usar una semilla en este caso no
# Dado un punto inicial x pertenecientte dom(f)
x0 <- runif(1, -10, 10)
y0 <- runif(1, -10, 10)
ghama <- 0.5
learning_rate <- 0.1
max_iterations <- 1000
tolerance <- 1e-6

# Inicialización
x <- x0
y <- y0

# repite

for (iteration in 1:max_iterations) {
  # obtengo el gradiente 
  gradient <- grad_f(x, y, ghama)
  grad_x <- gradient$grad_x
  grad_y <- gradient$grad_y
  
  # Actualizar los parámetros usando el descenso de gradiente
  # - learning_rate * grad_x devido a gard_x es igual - gradiente  por eso 
  # el mos 
  x_new <- x - learning_rate * grad_x
  y_new <- y - learning_rate * grad_y
  
  # Calcular el cambio en los parámetros calculamos el modulo
  delta <- sqrt((x_new - x)^2 + (y_new - y)^2)
  
  # Actualizar los parámetros
  x <- x_new
  y <- y_new
  
  # Comprobar la condición de parada
  if (delta < tolerance) {
    break
  }
}

# Imprimir los resultados
cat("Iteraciones:", iteration, "\n")
cat("Valor mínimo:", f(x, y, ghama), "\n")
cat("Coordenadas del mínimo (x, y):", x, y, "\n")


##### Profesor #####

# Punto inicial
tk=c(2,1)
# paso
t=0.2

# -gradeinte de f
deltax=function(x,y){-c(x,0.5*y)}

# Iterando 

#dir=deltax(tk[1],tk[2])
#tk=tk+t*dir

# ahora hacemos un bucle con iteraciones
max_iterations <-1000
for (iteration in 1:max_iterations) {
  dir=deltax(tk[1],tk[2])
  tk=tk+t*dir
  }
tk
# ahora anexamos el punto de parada 
# norma de tk  es decir ||tk|| < 10⁻⁶
# Punto inicial
tk=c(2,1)
# paso
t=0.2

tol=10^-6
max_iterations <-1000
for (iteration in 1:max_iterations) {
  dir=deltax(tk[1],tk[2])
  tk=tk+t*dir
  # criterio de parada
  if (sum(dir^2)<tol){break}
  }
tk

# para minizaar
# t= argmin (x+sx)
# este caso 
#t=argmin(1/2*((x-def_x)^2+ghama*(y-3/2y)^2))
t =( x^2 + 0.5^2*y^2)/(x^2+0.5^3*y^2)# usar 

# usar el blacktraking 
# Punto inicial
tk=c(2,1)
# paso
t=0.2

tol=10^-6
max_iterations <-1000
for (iteration in 1:max_iterations) {
  dir=deltax(tk[1],tk[2])
  tk=tk+t*dir
  # candidato par ser el siguiente punto
  fi=f(tk[1]+t*dir[1],tk[2]+t*dir[2])
  while(f1>(f0+0.5*t*(-sum(dir^2)))){t=0.5*t}
  
  # criterio de parada
  #if (sum(dir^2)<tol){break}
}
tk
###########################################



# Función a modelar
f <- function(x, beta0, beta1) {
  return(beta0 + beta1 * x)
}
# RSE (Residual Standard Error)
rse <- function(reales, prediccion) {
  n <- length(reales)
  rss <- sum((prediccion - reales)^2)
  rse <- sqrt((rss / (n - 2)))
  return(rse)
}
# Función de coste
coste <- function(x, y, beta0, beta1) {
  prediccion <- f(x, beta0, beta1)
  rse <- rse(y, prediccion)
  return(rse)
}

# Función del descenso de gradiente
desc_grad <- function(x, y, t, threshold, max_iter) {
    # Inicializamos los coeficientes a 0
    beta0 <- 0
    beta1 <- 0
    converged = FALSE
    iterations = 0
    while (converged == FALSE) {
      # Obtenemos la prediccion
      prediccion <- f(x, beta0, beta1)
      # Calculamos el gradiente de f(x)
      grad_beta0 = sum(y - prediccion)
      grad_beta1 = sum(x * (y - prediccion))
      # Actualizamos los valores de los parámetros beta0 y beta1
      beta0 <- beta0 + t * grad_beta0
      beta1 <- beta1 + t * grad_beta1
      # Calculamos el rse cometido con la función de coste
      coste <- coste(x, y, beta0, beta1)
      # Obtenemos el criterio de parada
      stopping_criterion = grad_beta0^2 + grad_beta1^2
      # Comprobamos si se cumple el criterio de parada
      if (stopping_criterion <= threshold) {
        converged = T
        print(paste("Optimal beta0: ",beta0))
        print(paste("Optimal beta1: ",beta1))
        print(paste("RSE: ", coste))
        print(paste("Converged in", iterations, "iterations"))
      }
      # Comprobamos si se han ejecutado el número máximo de iteraciones
      iterations = iterations + 1
      if (iterations > max_iter) {
        converged = TRUE
        print(paste("Optimal beta0: ",beta0))
        print(paste("Optimal beta1: ",beta1))
        print(paste("RSE: ", coste))
        print(paste("Not Converged"))
      }
  }
return(list(beta0, beta1, coste))
}
            

# Calculamos y
n <- 100
# x_i: n puntos aleatorios en el itervalo [min,max]
x <- runif(n, min = 0, max = 5)
# Parámetro beta0 del modelo
beta0 <- 2
# Parámetro beta1 del modelo
beta1 <- 5
# Error (con desviación típica sd=1)
epsilon <- rnorm(n, sd = 1)
# Calculamos y
y <- beta0 + beta1 * x + epsilon

result <- desc_grad(x, y, t = 0.001, threshold = 0.0001, max_iter = 1000)