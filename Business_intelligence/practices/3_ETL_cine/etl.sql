-- Elimina el esquema "etl" si ya existe, incluyendo todas las tablas y objetos relacionados.
DROP SCHEMA IF EXISTS etl CASCADE;

-- Crea un nuevo esquema llamado "etl" para organizar los objetos de la base de datos.
CREATE SCHEMA etl;

-- Crea una tabla llamada "pelicula_productora" en el esquema "etl" para almacenar información sobre películas y productoras.
CREATE TABLE etl.pelicula_productora (
  -- Identificador de la película, no puede ser nulo.
  pelicula INT NOT NULL,
  
  -- Fecha de emisión de la película, no puede ser nula.
  fecha_emision DATE NOT NULL,
  
  -- Identificador de la productora, no puede ser nulo.
  id_productora INT NOT NULL,
  
  -- Identificador de director de texto.
  text_id_director VARCHAR,
  
  -- Identificador de productor de texto.
  text_id_productor VARCHAR,
  
  -- Clave primaria que consta de las columnas "pelicula" e "id_productora" para garantizar la unicidad.
  PRIMARY KEY (pelicula, id_productora)
);

-- Crea un índice en la columna "pelicula" de la tabla "pelicula_productora" para mejorar el rendimiento de las consultas.
CREATE INDEX ON etl.pelicula_productora(pelicula);
