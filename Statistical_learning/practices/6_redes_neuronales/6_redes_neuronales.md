# Boletin 1 

### 1. Se tiene una red neuronal con una capa oculta, sl={2, 3, 1}, W(1)= (-2, 1; 1, -1; 3, -1), W(2)= (2, 3, 1), b(1)= (0; -1; 1), y b(2)= (0). La red utiliza la función de activación sigmoide en todas las neuronas salvo la de salida, cuya función de activación es la identidad. Además, la función de coste es el error cuadrático. Dado el ejemplo (1, 1, 1):
   
    
Los pesos y los bias iniciales son:

$$ W^{(1)} = \begin{pmatrix} -2 & 1 \\ -1 & -1 \\ -1 & 3 \end{pmatrix} $$

$$ W^{(2)} = \begin{pmatrix} 2 & 3 & 1\end{pmatrix}$$

$$b^{(1)} = \begin{pmatrix}0 \\-1 \\1\end{pmatrix}$$

$$ b^{(2)} = \begin{pmatrix} 0\end{pmatrix} $$


#### a) Calcula zi(l) y ai(l) para todas las neuronas.

![Alt text](image.png)

**Nota:** este ejercicio debe hacerse sin utilizar ninguna función de scikit-learn.


Los resultados obtenidos son:

Para la primera capa oculta (3 neuronas):

$$z^{(1)}= \begin{pmatrix}-2*1+1*1+0 \\1*1-1*1-1 \\-1*1+3*1+1\end{pmatrix} = \begin{pmatrix}-1 \\-1 \\3\end{pmatrix} $$
$$
a^{(1)} = \begin{pmatrix}
\sigma(-1) \\
\sigma(-1) \\
\sigma(3)  
\end{pmatrix} \approx \begin{pmatrix}
0.269 \\
0.269 \\
0.953
\end{pmatrix}
$$

Para la capa de salida (1 neurona):

$$z^{(2)}= \begin{pmatrix}2*0.269+3*0.269+1*0.953 + 0\end{pmatrix} = \begin{pmatrix} 2.297 \end{pmatrix} $$ 

**Dado que la función de activación es la identidad**


$$ a_1^{(2)} = z_1^{(2)} =\begin{pmatrix} 2.297 \end{pmatrix}  $$ 

#### b) Usando el algoritmo de retro-propagación del error, calcula δi(l) para todas las neuronas.

derivada de la sigmoide

$$\sigma'(z) = \sigma(z) \cdot (1 - \sigma(z))$$

$$
\delta^{(1)}  = (W^{(2)})^T \cdot \delta^{(2)} \cdot \sigma'(z^{(1)}) = \begin{pmatrix}
0.510 \\
0.765 \\
0.059
\end{pmatrix}
$$

$$
\delta^{(2)} = a^{(2)} - y = \begin{pmatrix}
2.297
\end{pmatrix} - \begin{pmatrix}
1
\end{pmatrix} \begin{pmatrix}
1.297
\end{pmatrix}
$$

#### c) Usando el algoritmo de retro-propagación del error, determina los valores finales de cada peso (Wij(l)) y bias (bi(l)) de la red neuronal tras finalizar la primera iteración del algoritmo, asumiendo un valor de λ=1, y una tasa de aprendizaje α=0,5.

![Alt text](image-1.png)

$$W_{new}^{(l)} = W^{(l)} - \alpha \cdot \delta W^{(l)} $$

$$b_{new}^{(l)} = b^{(l)} - \alpha \cdot \delta b^{(l)}$$

$$W_{new}^{(1)T} = \begin{pmatrix}
-2.255 & 0.745 \\
0.617 & -1.383 \\
2.971 & -1.029
\end{pmatrix}
$$

$$b_{new}^{(1)} = \begin{pmatrix}
-0.255 \\
-1.383 \\
0.971
\end{pmatrix}
$$

$$W_{new}^{(2)T} = \begin{pmatrix}
1.826 \\
2.826 \\
0.382
\end{pmatrix}$$


$$
b_{new}^{(2)} = \begin{pmatrix}
-0.649
\end{pmatrix}

$$

**Ecuación**

ecuación de entropia:

$$ H(X) = -\sum_{i=1}^{n} P(x_i) \log_2 P(x_i) $$

- H(X) representa la entropía del nodo.

- P(xi​) es la probabilidad de cada clase ii, y la sumatoria se realiza sobre todas las clases nn en el conjunto de datos.

Para saber cual es la mejor división se usa esta ecuación

$$ H(X) = entropia_{right} \times numitems_{right} + numitems_{left} \times entropia_{left} $$

- H(X) representa la entropía del de la división- H(X) representa la entropía del árbol.

Arbol sin scikit-learn

![Alt text](image.png)


Arbol de scikit-learn

![Alt text](image-2.png)


**Nota:** este ejercicio debe hacerse sin utilizar ninguna función de scikit-learn. No es necesario

### 2.Dado el problema de clasificación Blood Transfusion Service Center:

#### a) La clase que implementa el Perceptrón multicapa (MLP) en problemas de clasificación enscikit-learn es sklearn.neural_network.MLPClassifier. Revisa los parámetros y métodos que tiene.

La clase [`sklearn.neural_network.MLPClassifier`](https://scikit-learn.org/stable/modules/generated/sklearn.neural_network.MLPClassifier.html) en scikit-learn implementa un clasificador de perceptrón multicapa para problemas de clasificación.

Parámetros:

- `hidden_layer_sizes`: Tupla que representa el número de neuronas en las capas ocultas.
- `activation`: Función de activación para las capas ocultas ("identity", "logistic", "tanh", "relu").
- `solver`: Algoritmo para la optimización del peso ("lbfgs", "sgd", "adam").
- `alpha`: Parámetro de regularización L2.
- `batch_size`: Tamaño del minibatch para el optimizador estocástico.
- `learning_rate`: Tasa de aprendizaje para el entrenamiento ("constant", "invscaling", "adaptive").
- `max_iter`: Número máximo de iteraciones.
- `random_state`: Semilla del generador pseudoaleatorio para la mezcla de datos.
- `tol`: Tolerancia para la optimización.
- `early_stopping`: Detener el entrenamiento cuando la puntuación de validación no mejore.

Métodos:

- `fit`: Entrenar el modelo con datos `X` y etiquetas `y`.
- `predict`: Predecir las etiquetas para muestras en `X`.
- `score`: Devolver la precisión media en las etiquetas de prueba y predicciones para `X`.
- `get_params`: Obtener parámetros para este estimador.
- `set_params`: Establecer parámetros para este estimador.


##### datos

**Tabla entera (748 rows × 5 columns)**

|   | Reciente | Frecuencia | Cantidad_Sangre | Tiempo | Donacion_marzo |
|---|:--------:|:----------:|:---------------:|:------:|:--------------:|
| 0 |    0     |     2      |        50       | 12500  |       1        |
| 1 |    1     |     0      |        13       | 3250   |       1        |
| 2 |    2     |     1      |        16       | 4000   |       1        |
|...|   ...    |    ...     |       ...       |  ...   |      ...       |
| 745 |  23    |     3      |        750      |  62    |       0        |
| 746 |  39    |     1      |        250      |  39    |       0        |
| 747 |  72    |     1      |        250      |  72    |       0        |


**Tipo del dato de cada columna:**

| Columna          | Tipo de Dato |
|------------------|--------------|
| Reciente         | int64        |
| Frecuencia       | int64        |
| Cantidad_Sangre  | int64        |
| Tiempo           | int64        |
| Donacion_marzo   | int64        |


**Cantidad de valores NaN en cada columna:**

| Columna          | Cantidad de NaN |
|------------------|-----------------|
| Reciente         | 0               |
| Frecuencia       | 0               |
| Cantidad_Sangre  | 0               |
| Tiempo           | 0               |
| Donacion_marzo   | 0               |


##### Histograma por cada clase y variable

![Alt text](images/image-2.png)


##### Relación entre variable por clase

![Alt text](images/image-3.png)


#### b) Divide los datos en entrenamiento (80%) y test (20%).

#### c) Realiza la experimentación con  (MLPClassifier) usando como hiper-parámetrousando los valores por defecto de los parámetros, excepto para activation=’tanh y solver=’lbfgs’, y max_iter=2000. Además, utiliza los siguientes hiper-parámetros: hidden_layer_sizes y alpha:
 
Muestra la gráfica del error de entrenamiento con validación cruzada (5-CV) frente al valor
del hiper-parámetro. 

- Odenador personal:

    ![Alt text](image-2.png)
    ![Alt text](image-3.png)
    ![Alt text](image-4.png)
    ![Alt text](image-5.png)
    ![Alt text](image-6.png)

- Odenador cesga:

    ![Alt text](image-7.png)
    

**¿Cuál es el menor error de validación cruzada, su desviación estándar y el valor del hiper-parámetro para el que se consigue?**

El error viene descrito por 1-mean_test_score

- Odenador personal:


    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | error_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:---------------:|:---------------:|
    |            (3,)          |    0.33     |     0.811036    |    0.023973    |  0.188964         |       1        |



- Odenador cesga:

    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | error_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:---------------:|:---------------:|
    |            (3,)          |    0.53     |     0.809365    |    0.026690    |        0.190635        |        1        |



  
**En caso de que haya varios modelos con error mínimo, debe seleccionarse siempre el más simple.**

Muestra la gráfica del error de test frente al valor del hiper-parámetro, y valora si la gráfica del error de entrenamiento con validación cruzada ha hecho una buena estimación delAprendizaje Estadístico Máster en Big Data. Universidad de Santiago de Compostela error de test. 

- Odenador personal:

    ![Alt text](image-8.png)
    ![Alt text](image-9.png)
    ![Alt text](image-10.png)
    
- Odenador cesga:

    ![Alt text](image-11.png)

**¿Cuál es el error de test para el valor del hiper-parámetro seleccionado por la validación cruzada?**

- Mejores ordenador personal test:

    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | error_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:----------------:|:---------------:|
    |            (5,)          |     0.5     |     0.813333    |       0.0      |      0.186667    |        1        |
    |          (4, 4)          |    0.03     |     0.813333    |       0.0      |      0.186667    |        1        |


- Odenador personal:

    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | error_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:----------------:|:---------------:|
    |            (3,)          |     0.3     |       0.8       |       0.0      |       0.2        |       12        |
    |            (3,)          |     0.5     |       0.8       |       0.0      |       0.2        |       11        |
    |            (3,)          |     0.33    |       0.8       |       0.0      |       0.2        |       --        |


	
- Mejores ordenador cesga test:

    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | error_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:----------------:|:---------------:|
    |            (5,)          |     0.5     |     0.813333    |       0.0      |      0.186667    |        1        |
    |          (4, 4)          |    0.03     |     0.813333    |       0.0      |      0.186667    |        1        |



- Odenador cesga:

    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | error_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:----------------:|:---------------:|
    |            (3,)          |     0.3     |       0.8       |       0.0      |       0.2        |       12        |
    |            (3,)          |     0.5     |       0.8       |       0.0      |       0.2        |       11        |
    |            (3,)          |     0.53 	 |       0.8       |       0.0      |       0.2        |       --        |




### 3. Repite el ejercicio 2 pero para el problema de regresión Energy Efficiency con la variable de salida cooling load. Al ser un problema de regresión deberás utilizar KNeighborsRegressor, y como medida de error de entrenamiento y test el MSE.

**Nota.** Al ser un problema de regresión, para estimar tanto el error de entrenamiento como el de test (MSE) es necesario desestandarizar los errores calculados. Para desestandarizar el campo `mean_test_score`, únicamente será necesario multiplicar cada valor por la varianza (cuadrado de la desviación estándar) de las observaciones de Y del conjunto de entrenamiento. No se debe restar la media, ya que los campos `splitX_test_score` se calculan como la diferencia entre el valor de groundtruth y la predicción para cada dato de test, por lo que todas las operaciones de adición o substracción ya se han tenido en cuenta. De forma similar, para desestandarizar el campo `std_test_score`, únicamente será necesario multiplicar cada valor por la varianza de las
observaciones de Y del conjunto de entrenamiento.

#### a) Analiza las características del conjunto de datos: número y tipo de variables de entrada y salida, número de instancias, número de clases y distribución de las mismas, correlación entre las variables, valores perdidos, etc.

**Tabla entera (768 rows × 9 columns)**

|    |  X1  |   X2  |   X3  |   X4   |  X5  | X6 |  X7  | X8 |   Y2   |
|----|------|-------|-------|--------|------|----|------|----|--------|
| 0  | 0.98 | 514.5 | 294.0 | 110.25 | 7.0  |  2 | 0.0  |  0 | 21.33  |
| 1  | 0.98 | 514.5 | 294.0 | 110.25 | 7.0  |  3 | 0.0  |  0 | 21.33  |
| 2  | 0.98 | 514.5 | 294.0 | 110.25 | 7.0  |  4 | 0.0  |  0 | 21.33  |
|... | ...  | ...   | ...   | ...    | ...  |... | ...  |... | ...    |
| 765| 0.62 | 808.5 | 367.5 | 220.50 | 3.5  |  3 | 0.4  |  5 | 17.11  |
| 766| 0.62 | 808.5 | 367.5 | 220.50 | 3.5  |  4 | 0.4  |  5 | 16.61  |
| 767| 0.62 | 808.5 | 367.5 | 220.50 | 3.5  |  5 | 0.4  |  5 | 16.03  |


**Tipo del dato de cada columna:**



| Columna | Tipo de Dato |
|---------|--------------|
| X1      | float64      |
| X2      | float64      |
| X3      | float64      |
| X4      | float64      |
| X5      | float64      |
| X6      | int64        |
| X7      | float64      |
| X8      | int64        |
| Y1      | float64      |
| Y2      | float64      |


**Cantidad de valores NaN en cada columna:**

| Columna | Cantidad de NaN |
|---------|-----------------|
| X1      | 0               |
| X2      | 0               |
| X3      | 0               |
| X4      | 0               |
| X5      | 0               |
| X6      | 0               |
| X7      | 0               |
| X8      | 0               |
| Y1      | 0               |
| Y2      | 0               |



##### Histograma por cada clase y variable

![Alt text](images/image-11.png)

##### Relación entre variable por clase

![Alt text](images/image-10.png)




#### a) La clase que implementa el Perceptrón multicapa (MLP) en problemas scikit-learn regresion es sklearn.neural_network.MLPRegressor. Revisa los parámetros y métodos que tiene.

La clase [`sklearn.neural_network.MLPRegressor`](https://scikit-learn.org/stable/modules/generated/sklearn.neural_network.MLPRegressor.html) en scikit-learn implementa un regresor de perceptrón multicapa para problemas de regresión.

Parámetros:

- `hidden_layer_sizes`: Tupla que representa el número de neuronas en las capas ocultas.
- `activation`: Función de activación para las capas ocultas ("identity", "logistic", "tanh", "relu").
- `solver`: Algoritmo para la optimización del peso ("lbfgs", "sgd", "adam").
- `alpha`: Parámetro de regularización L2.
- `batch_size`: Tamaño del minibatch para el optimizador estocástico.
- `learning_rate`: Tasa de aprendizaje para el entrenamiento ("constant", "invscaling", "adaptive").
- `learning_rate_init`: La tasa de aprendizaje inicial para el entrenamiento.
- `power_t`: El exponente de la tasa de aprendizaje escalonada inversa.
- `max_iter`: Número máximo de iteraciones.
- `shuffle`: Si se deben mezclar las muestras en cada iteración.
- `random_state`: Semilla del generador pseudoaleatorio para la mezcla de datos.
- `tol`: Tolerancia para la optimización.
- `verbose`: Si imprimir mensajes de progreso en stdout.
- `warm_start`: Si usar la solución de llamadas anteriores para ajustar el modelo.
- `momentum`: Momentum para la actualización de gradiente.
- `nesterovs_momentum`: Si usar o no el momentum de Nesterov.
- `early_stopping`: Detener el entrenamiento cuando la puntuación de validación no mejore.
- `validation_fraction`: La proporción del conjunto de entrenamiento a utilizar como conjunto de validación.
- `beta_1`, `beta_2`, `epsilon`: Parámetros para el optimizador 'adam'.

Métodos:

- `fit`: Entrenar el modelo con datos `X` y valores objetivo `y`.
- `predict`: Predecir los valores objetivo para las muestras en `X`.
- `score`: Devolver el coeficiente de determinación \(R^2\) de la predicción.
- `get_params`: Obtener parámetros para este estimador.
- `set_params`: Establecer parámetros para este estimador.
- `partial_fit`: Entrenamiento incremental sobre un lote de muestras.




#### b) Divide los datos en entrenamiento (80%) y test (20%).


#### c) Realiza la experimentación con DecisionTreeRegressor usando como hiper-parámetro el número mínimo de muestras necesarias para dividir un nodo.


**¿Cuál es el menor error de validación cruzada, su desviación estándar y el valor del hiper-parámetro para el que se consigue?**


Muestra la gráfica del error de entrenamiento con validación cruzada (5-CV) frente al valor
del hiper-parámetro. 

- Odenador personal:

    
    ![Alt text](image-12.png)
    ![Alt text](image-13.png)

- Odenador cesga:

    ![Alt text](image-14.png)

- Odenador personal:

   
    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | destandardized_mean_test_score | destandardized_std_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:------------------------------:|:-----------------------------:|:---------------:|
    |        (32, 32, 32)      |     0.1     |     -0.005461   |    0.001346    |            0.488051            |           0.120275            |        1        |
    |        (19, 19, 19)      |     0.08    |     -0.005212   |    0.000951    |            0.465767            |           0.084974            |        1        |

- Odenador cesga:

    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | destandardized_mean_test_score | destandardized_std_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:------------------------------:|:-----------------------------:|:---------------:|
    |        (19, 19, 19)      |     0.1     |     -0.00524    |    0.000469    |            0.468284            |           0.041888            |        1        |

    

**En caso de que haya varios modelos con error mínimo, debe seleccionarse siempre el más simple.**

Muestra la gráfica del error de test frente al valor del hiper-parámetro, y valora si la gráfica del error de entrenamiento con validación cruzada ha hecho una buena estimación del Aprendizaje Estadístico Máster en Big Data. Universidad de Santiago de Compostela error de test. 


**¿Cuál es el error de test para el valor del hiper-parámetro seleccionado por la validación cruzada?**


- Mejores ordenador personal test:
    
    ![Alt text](image-15.png)

    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | destandardized_mean_test_score | destandardized_std_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:------------------------------:|:-----------------------------:|:---------------:|
    |        (55, 55, 55)      |     0.05    |     -0.004212   |       0.0      |            0.376357            |               0.0             |        1        |




- Odenador personal:

    
    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | destandardized_mean_test_score | destandardized_std_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:------------------------------:|:-----------------------------:|:---------------:|
    |        (32, 32, 32)      |     0.1     |     -0.005028   |       0.0      |            0.449284            |               0.0            
    |        (19, 19, 19)      |     0.08    |     -0.005228   |       0.0      |            0.467154            |               0.0             |       176       |






- Mejores ordenador cesga test:

    ![Alt text](image-16.png)

    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | destandardized_mean_test_score | destandardized_std_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:------------------------------:|:-----------------------------:|:---------------:|
    |        (30, 30, 30)      |     0.01    |     -0.004235   |       0.0      |            0.378415            |               0.0             |        1        |


- Odenador cesga:

    | param_hidden_layer_sizes | param_alpha | mean_test_score | std_test_score | destandardized_mean_test_score | destandardized_std_test_score | rank_test_score |
    |:------------------------:|:-----------:|:---------------:|:--------------:|:------------------------------:|:-----------------------------:|:---------------:|
    |        (25, 25, 25)      |     0.05    |     -0.0066     |       0.0      |            0.589777            |               0.0             |       594       |
    |        (19, 19, 19)      |     0.1     |     -0.005689   |       0.0      |            0.508426            |               0.0             |       78        |




