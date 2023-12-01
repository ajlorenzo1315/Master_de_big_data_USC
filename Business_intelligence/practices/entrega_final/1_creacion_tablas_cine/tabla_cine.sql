-- Tabla tiempo: Almacena informacion temporal como ano y mes.
CREATE TABLE tiempo (
    id SERIAL PRIMARY KEY,          
    ano INT NOT NULL,               -- Ano del registro
    mes INT NOT NULL,               -- mes formato numerico
    mes_texto VARCHAR(16) NOT NULL  -- mes formato texto
);

-- Tabla director: Almacena informacion sobre los directores de cine. Cada director tiene un identificador unico.
CREATE TABLE director (
    id SERIAL PRIMARY KEY,          
    text_id VARCHAR(1000) NOT NULL, -- Identificador de texto, 
    nombre VARCHAR(1000) NOT NULL   -- Nombre completo del director
);

-- Tabla productor: Similar a la tabla director, pero para productores de peliculas.
CREATE TABLE productor (
    id SERIAL PRIMARY KEY,          
    text_id VARCHAR(1000) NOT NULL, -- Identificador de texto, 
    nombre VARCHAR(1000) NOT NULL   -- Nombre completo del productor
);

-- Tabla productora: Almacena información sobre las compañías productoras.
CREATE TABLE productora (
    id SERIAL PRIMARY KEY,      
    text_id INT NOT NULL,       -- Identificador numerico, para usarla como  una fuente externa
    nombre VARCHAR(100) NOT NULL -- Nombre de la compañía productora
);

-- Tabla finanzas: Diseñada para el seguimiento y analisis de datos financieros relacionados con la produccion de peliculas.
CREATE TABLE finanzas (
    tiempo INT,                           -- Referencia al tiempo (clave foranea)
    director INT,                         -- Referencia al director (clave foranea)
    productor INT,                        -- Referencia al productor (clave foranea)
    productora INT,                       -- Referencia a la productora (clave foranea)
    coste INT DEFAULT 0,                  -- Coste de la produccion
    ingresos INT DEFAULT 0,               -- Ingresos generados por la produccion
    PRIMARY KEY (tiempo, director, productor, productora), -- Clave primaria compuesta
    FOREIGN KEY (tiempo) REFERENCES tiempo(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (director) REFERENCES director(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (productor) REFERENCES productor(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (productora) REFERENCES productora(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla satisfaccion_usuarios: Almacena información sobre la satisfaccion de los usuarios con respecto a las películas.
CREATE TABLE satisfaccion_usuarios (
    tiempo_votacion INT,                                      -- Tiempo de votacion (clave foranea)
    tiempo_emision INT,                                       -- Tiempo de emision (clave foranea)
    director INT,                                             -- Director (clave foranea)
    productor INT,                                            -- Productor (clave foranea)
    productora INT,                                           -- Productora (clave foranea)
    votos INT DEFAULT 0,                                      -- Número total de votos
    satisfaccion DECIMAL(2, 1),                               -- Nivel de satisfaccion (escala 0.0 a 10.0)
    PRIMARY KEY (tiempo_votacion, tiempo_emision, director, productor, productora), -- Clave primaria compuesta
    FOREIGN KEY (tiempo_votacion) REFERENCES tiempo(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (tiempo_emision) REFERENCES tiempo(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (director) REFERENCES director(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (productor) REFERENCES productor(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (productora) REFERENCES productora(id) ON DELETE CASCADE ON UPDATE CASCADE
);




