# Cargar las bibliotecas necesarias para análisis de datos y gráficos
library(tidyverse)
library(patchwork)
library(scales)

# Configuración de temas para gráficos: tamaño de fuente y otros ajustes visuales
theme_set(theme_linedraw(base_size = 25))
options(digits = 4)
options(pillar.subtle = FALSE)
options(rlang_backtrace_on_error = "none")
options(crayon.enabled = FALSE)

# Temas personalizados para ggplot (sin líneas de cuadrícula, sin leyenda, sin ejes)
sin_lineas <- theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
sin_leyenda <- theme(legend.position = "none")
sin_ejes <- theme(axis.ticks = element_blank(), axis.text = element_blank())

# Carga de datos de marketing desde un archivo CSV en línea
data <- read_csv("https://www.statlearning.com/s/Advertising.csv", col_select = 2:5)
data |> colnames()
data |> print(n = 5)

# Creación de gráficos para visualizar la relación entre gastos en diferentes medios y las ventas
g1 <- ggplot(data, aes(TV, sales)) + geom_point(color = 'red') + geom_smooth(method = "lm", se = FALSE) + sin_lineas
g2 <- ggplot(data, aes(radio, sales)) + geom_point(color = 'red') + geom_smooth(method = "lm", se = FALSE) + sin_lineas
g3 <- ggplot(data, aes(newspaper, sales)) + geom_point(color = 'red') + geom_smooth(method = "lm", se = FALSE) + sin_lineas

# Mostrar los tres gráficos juntos
g1 + g2 + g3

# Modelo Lineal Simple: Regresión lineal con TV como variable independiente
model <- lm(sales ~ TV, data)
data |> mutate(fitted = fitted(model)) |> ggplot(aes(TV, sales)) + geom_smooth(method = "lm", se = FALSE) + geom_errorbar(aes(ymin = fitted, ymax = sales), lty = 1, color = "gray") + geom_point(color = 'red') + sin_lineas

# Resumen estadístico del modelo
model |> summary()
model |> broom::tidy()

# Simulación de variabilidad para comprender la distribución de los estimadores
genera_datos <- function(id) { tibble(x = runif(100, -1, 1), y = x + rnorm(100)) }
ajusta_modelo <- function(datos) { lm(y ~ x, datos) }
simulacion <- tibble(id = 1:10) |> mutate(datos = map(id, genera_datos), modelo = map(datos, ajusta_modelo), ajuste = map(modelo, broom::tidy))

# Modelo Lineal Múltiple: Regresión lineal con TV, Radio y Newspaper
mod2 <- lm(sales ~ TV + radio + newspaper, data)
mod2 |> broom::tidy()

# Resumen estadístico para el modelo lineal múltiple
mod2 |> broom::glance() |> select(statistic, p.value, df, df.residual)
