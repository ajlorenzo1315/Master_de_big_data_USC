

#Para realizar los métodos de clasificación con el conjunto de datos Iris en R, utilizaremos tres técnicas: 
#k-vecinos más próximos (k-NN), Análisis Lineal Discriminante (LDA) y Análisis Cuadrático Discriminante (QDA). 
#Cada uno de estos métodos tiene sus particularidades y fortalezas. 
#El conjunto de datos Iris es ideal para este tipo de análisis, 
#ya que contiene mediciones de longitud y anchura del sépalo y del pétalo de tres especies de iris diferentes.


#1. k-Vecinos Más Próximos (k-NN)


# Cargar la librería necesaria
library(class)

# Cargar el conjunto de datos Iris
data(iris)

# Dividir los datos en conjunto de entrenamiento y prueba
set.seed(123) # Para reproducibilidad
indices <- sample(1:nrow(iris), nrow(iris) * 0.7)
train_data <- iris[indices, ]
test_data <- iris[-indices, ]

# k-NN
knn_pred <- knn(train = train_data[, 1:4], test = test_data[, 1:4], cl = train_data[, 5], k = 3)

# Evaluar el rendimiento
table(knn_pred, test_data[, 5])

# Justificación: k-NN es un método simple y efectivo para clasificación. 
# Seleccionamos k = 3 como un punto de partida común. 
# Este método es particularmente útil cuando la relación entre las variables predictoras y la clase es compleja y no lineal.

#2. Análisis Lineal Discriminante (LDA)



# Cargar la librería necesaria
library(MASS)

# LDA
lda_fit <- lda(Species ~ ., data = train_data)

# Predicción y evaluación
lda_pred <- predict(lda_fit, test_data)
table(lda_pred$class, test_data[, 5])

#Justificación: LDA asume que las variables predictoras tienen distribuciones normales y covarianzas iguales en cada clase. 
#Es útil cuando esta suposición se aproxima a la realidad, lo cual es razonable para el conjunto de datos Iris.

#3. Análisis Cuadrático Discriminante (QDA)


# QDA
qda_fit <- qda(Species ~ ., data = train_data)

# Predicción y evaluación
qda_pred <- predict(qda_fit, test_data)
table(qda_pred$class, test_data[, 5])

#Justificación: QDA es similar a LDA pero no asume covarianzas iguales en cada clase. Esto lo hace más flexible que LDA, 
# especialmente cuando esta suposición de igualdad de covarianzas no se sostiene.

# Cargar la librería necesaria
library(klaR)

# Visualizar las fronteras de decisión para k-NN
partimat(Species ~ Petal.Length + Petal.Width, data = iris, method = "knn", k = 3)

# Visualizar las fronteras de decisión para LDA
partimat(Species ~ Petal.Length + Petal.Width, data = iris, method = "lda")

# Visualizar las fronteras de decisión para QDA
partimat(Species ~ Petal.Length + Petal.Width, data = iris, method = "qda")
