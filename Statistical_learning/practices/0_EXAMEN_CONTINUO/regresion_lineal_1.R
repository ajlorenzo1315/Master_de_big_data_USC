### Multicolinealidad

# La multicolinealidad es un problema en la regresión cuando dos o más variables predictoras están correlacionadas,
# lo que significa que una puede predecirse linealmente a partir de las otras.

# Tamaño de la muestra
n <- 1000

# Modelo teórico Y = f(X) + eps, donde f(x) = beta0 + beta1*x1 + beta2*x2
beta0 <- 0 
beta1 <- 1
beta2 <- 1

# Desviación estándar del término de error
sigma <- 1

# Número de muestras para la simulación
B <- 1000 

# Valores de correlación para la simulación
rhos <- c(0.1, 0.5, 0.9)

# Matriz para almacenar los coeficientes estimados
cc <- array(dim = c(B, 3, length(rhos))) 

# Matriz para almacenar la correlación estimada
corv <- matrix(nrow = B, ncol = 3)

# Bucle para cada valor de correlación
for(j in 1:length(rhos)){
  rho <- rhos[j] # Correlación actual
  
  # Bucle para cada muestra
  for (i in 1:B){ 
    eps <- rnorm(n, 0, sigma) # Error sigue una distribución normal con media 0
    x1 <- rnorm(n)   # Valores x1 siguen una distribución normal
    xs <- rnorm(n)   # Valores x* siguen una distribución normal
    x2 <- rho*x1 + sqrt(1 - rho^2)*xs # x2 correlacionado con x1
    y <- beta0 + beta1*x1 + beta2*x2 + eps # y = f(x) + eps
    z <- lm(y ~ x1 + x2)  # Modelo lineal 
    cc[i, , j] <- coef(z) # Almacena coeficientes estimados
    
    corv[i, j] <- cor(x1, x2) # Almacena correlación estimada
  }
}

# Valor esperado de beta0, beta1, beta2
apply(cc, c(2, 3), mean)
# Varianza de beta0, beta1, beta2 cambia con la correlación
apply(cc, c(2, 3), var)

# Correlación de la muestra cercana a la teórica
colMeans(corv)

# Densidad de los coeficientes estimados para diferentes valores de rho
# Para beta0
j <- 1
plot(density(cc[, j, 1])) # rho=0.1 (negro)
lines(density(cc[, j, 2]), col = 2) # rho=0.5 (rojo)
lines(density(cc[, j, 3]), col = 3) # rho=0.9 (verde)

# Similar para beta1 y beta2

##########################################################

### Más características que observaciones
# Cuando el número de características (p) es igual o mayor al número de observaciones (n),
# los enfoques clásicos como la regresión lineal por mínimos cuadrados no son apropiados.

# Modelo teórico Y = f(X) + eps, donde f(x) = beta0 + beta1*x
beta0 <- 0
beta1 <- 1

# Desviación estándar del término de error
sigma <- 1

# Configuración de múltiples gráficos
par(mfrow = c(1, 2)) 

# Bucle para diferentes tamaños de muestra
for(n in c(50, 2)){
  eps <- rnorm(n, 0, sigma) # Error sigue una distribución normal con media 0
  x <- runif(n)   # Valores x siguen una distribución uniforme
  y <- beta0 + beta1*x + eps # y = f(x) + eps
  z <- lm(y ~ x)  # Modelo lineal
  plot(x, y)
  abline(z)
}

# Tamaño de la muestra
n <- 100

# Dimensiones grandes
ps <- c(90, 40, 10)

# Número de muestras para la simulación
B <- 1000 

# Matriz para almacenar coeficientes estimados (beta1 y beta2)
cc <- array(dim = c(B, 2, length(ps))) 

# Bucle para diferentes dimensiones
for(j in 1:length(ps)){
  p = ps[j]
  for (i in 1:B){ 
    eps <- rnorm(n, 0, sigma) # Error sigue una distribución normal con media 0
    xmat <- matrix(runif(n*p), nrow = n, ncol = p) # Matriz de valores x_j uniformes
    y <- rowSums(xmat) + eps # y = f(x) + eps, donde f(x) = suma de x1 a xp
    df <- data.frame(y, xmat)
    
    z <- lm(y ~ ., data = df)  # Modelo lineal 
    cc[i, , j] <- coef(z)[2:3] # Almacena coeficientes estimados para beta1 y beta2
  }
}


# For beta1
j=1
plot(density(cc[,j,1]),ylim=c(0,1.1)) # p=90 (black)
lines(density(cc[,j,2]),col=2) # p=40 (red)
lines(density(cc[,j,3]),col=3) # p=10 (green)

# For beta2
j=2
plot(density(cc[,j,1]),ylim=c(0,1.1)) # p=90 (black)
lines(density(cc[,j,2]),col=2) # p=40 (red)
lines(density(cc[,j,3]),col=3) # p=10 (green)


