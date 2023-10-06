-- Definición de la tabla de tiempo para almacenar información de tiempo
CREATE TABLE tiempo (
    id SERIAL PRIMARY KEY,
    ano INT NOT NULL,
    mes INT NOT NULL,
    mes_texto VARCHAR(16) NOT NULL
);

-- Definición de la tabla de directores con su identificación única (text_id)
CREATE TABLE director (
    id SERIAL PRIMARY KEY,
    text_id VARCHAR(1000) NOT NULL,
    nombre VARCHAR(1000) NOT NULL
);

-- Definición de la tabla de productores con su identificación única (text_id)
CREATE TABLE productor (
    id SERIAL PRIMARY KEY,
    text_id VARCHAR(1000) NOT NULL,
    nombre VARCHAR(1000) NOT NULL
);

-- Definición de la tabla de productoras con identificación única (text_id)
CREATE TABLE productora (
    id SERIAL PRIMARY KEY,
    text_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

-- Definición de la tabla de finanzas para el seguimiento de los datos financieros
CREATE TABLE finanzas (
    tiempo INT,
    director INT,
    productor INT,
    productora INT,
    coste INT DEFAULT 0,
    ingresos INT DEFAULT 0,
    PRIMARY KEY (tiempo, director, productor, productora),
    FOREIGN KEY (tiempo) REFERENCES tiempo(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (director) REFERENCES director(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (productor) REFERENCES productor(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (productora) REFERENCES productora(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Definición de la tabla de satisfacción de usuarios
CREATE TABLE satisfaccion_usuarios (
    tiempo_votacion INT,
    tiempo_emision INT,
    director INT,
    productor INT,
    productora INT,
    votos INT DEFAULT 0,
    satisfaccion DECIMAL(2, 1),
    PRIMARY KEY (tiempo_votacion, tiempo_emision, director, productor, productora),
    FOREIGN KEY (tiempo_votacion) REFERENCES tiempo(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (tiempo_emision) REFERENCES tiempo(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (director) REFERENCES director(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (productor) REFERENCES productor(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (productora) REFERENCES productora(id) ON DELETE CASCADE ON UPDATE CASCADE
);
