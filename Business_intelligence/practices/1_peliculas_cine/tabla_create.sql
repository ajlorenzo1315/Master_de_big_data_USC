CREATE TABLE tiempo (
    id SERIAL NOT NULL,
    ano INT NOT NULL,
    mes INT NOT NULL,
    mes_texto VARCHAR(16) NOT NULL,
    CONSTRAINT tiempo_pk PRIMARY KEY (id)
);

CREATE TABLE director (
    id SERIAL NOT NULL,
    text_id VARCHAR(1000) NOT NULL,
    nombre VARCHAR(1000) NOT NULL,
    CONSTRAINT director_pk PRIMARY KEY (id)
);

CREATE TABLE productor (
    id SERIAL NOT NULL,
    text_id VARCHAR(1000) NOT NULL,
    nombre VARCHAR(1000) NOT NULL,
    CONSTRAINT productor_pk PRIMARY KEY (id)
);

CREATE TABLE productora (
    id SERIAL NOT NULL,
    text_id VARCHAR(1000) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT productora_pk PRIMARY KEY (id)
);