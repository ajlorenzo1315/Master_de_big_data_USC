## Configuración Inicial --------------------------------------------

# Carga de las bibliotecas necesarias para análisis y visualización de datos
library(tidyverse)
library(patchwork)
library(scales)

# Configuración de temas para gráficos: tamaño de fuente por defecto
theme_set(theme_linedraw(base_size = 25))

# Configuración de opciones para la visualización de números en R
options(digits = 4) # Número de decimales a mostrar
# Opciones para manejar la visualización y errores en la consola Emacs
options(pillar.subtle = FALSE)
options(rlang_backtrace_on_error = "none")
options(crayon.enabled = FALSE)

# Temas personalizados para ggplot
sin_lineas <- theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) # Elimina líneas de la cuadrícula
color.itam  <- c("#00362b","#004a3b", "#00503f", "#006953", "#008367", "#009c7b", "#00b68f", NA) # Paleta de colores personalizada
sin_leyenda <- theme(legend.position = "none") # Elimina la leyenda
sin_ejes <- theme(axis.ticks = element_blank(), axis.text = element_blank()) # Elimina ejes

## Carga de Datos de Marketing ---------------------------------
data <- read_csv("https://www.statlearning.com/s/Advertising.csv", col_select = 2:5) # Carga datos de un CSV en línea
data |> colnames() # Muestra los nombres de las columnas
data |> print(n = 5) # Imprime las primeras 5 filas de los datos

# Creación de gráficos para visualizar la relación entre gastos en diferentes medios y las ventas
g1 <- ggplot(data, aes(TV, sales)) + geom_point(color = 'red') + geom_smooth(method = "lm", se = FALSE) + sin_lineas
g2 <- ggplot(data, aes(radio, sales)) + geom_point(color = 'red') + geom_smooth(method = "lm", se = FALSE) + sin_lineas
g3 <- ggplot(data, aes(newspaper, sales)) + geom_point(color = 'red') + geom_smooth(method = "lm", se = FALSE) + sin_lineas
g1 + g2 + g3 # Muestra los tres gráficos juntos

## Modelo Lineal Simple --------------------------------

model <- lm(sales ~ TV, data) # Ajuste de un modelo lineal simple con TV como variable independiente

data |>
  mutate(fitted = fitted(model)) |> # Agrega valores ajustados al dataframe
  ggplot(aes(TV, sales)) + # Gráfico de dispersión con línea de ajuste y barras de error
  geom_smooth(method = "lm", se = FALSE) +
  geom_errorbar(aes(ymin = fitted, ymax = sales),
                lty = 1, color = "gray") +
  geom_point(color = 'red') + sin_lineas

### Resúmenes de Modelos --------------------------

model |> summary() # Muestra un resumen estadístico del modelo
model |> broom::tidy() # Convierte el resumen del modelo en un formato 'tidy'

### Simulación de Variabilidad ----------------------------

genera_datos <- function(id){
  a <- 1; b <- 0; n <- 100
  tibble(x = runif(n, -1, 1),
         y = a * x + b + rnorm(n, sd = 1))
}
ajusta_modelo <- function(datos){
  modelo <- lm(y ~ x, datos)
  modelo
}

simulacion <-  tibble(id = seq(1, 10)) |>
  mutate(datos  = map(id, genera_datos),
         modelo = map(datos, ajusta_modelo),
         ajuste = map(modelo, broom::tidy))

params <- simulacion |>
  select(id, ajuste) |>
  unnest(ajuste) |>
  group_by(term) |>
  summarise(estimate = mean(estimate)) |>
  pull(estimate)

simulacion |>
  select(id, ajuste) |>
  unnest(ajuste) |>
  pivot_wider(names_from = term, values_from = estimate, id_cols = id) |>
  ggplot() +
  geom_abline(aes(intercept = `(Intercept)`,
                  slope = x), alpha = .7) +
  geom_abline(intercept = 0, slope = 1, color = 'red', size
              