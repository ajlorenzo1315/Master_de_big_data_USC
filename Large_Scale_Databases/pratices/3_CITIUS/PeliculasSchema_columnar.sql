CREATE TABLE colecciones (
	id int4 not null,
	nombre text,
	PRIMARY KEY (id)
);

CREATE TABLE generos (
	id int4 not null,
	nombre text,
	PRIMARY KEY (id)
);

CREATE TABLE idiomas (
	id text NOT NULL,
	nombre text,
	PRIMARY KEY (id)
);

CREATE TABLE paises (
	id text NOT NULL,
	nombre text,
	PRIMARY KEY (id)
);


CREATE TABLE peliculas (
    id int4 NOT NULL,
    titulo text ,
    -- coleccion int4 references colecciones(id),
    coleccion int4 ,
    para_adultos bool ,
    presupuesto int4 ,
    -- idioma_original text references idiomas(id),
    idioma_original text ,
    titulo_original text ,
    sinopsis text ,
    popularidad float8 ,
    fecha_emision date ,
    ingresos int8 ,
    duracion float8 ,
    lema text ,
) USING columnar;



CREATE TABLE personas (
	id int4 NOT NULL,
	nombre text ,
	PRIMARY KEY (id)
);

CREATE TABLE productoras (
	id int4 NOT NULL,
	nombre text,
	PRIMARY KEY (id)
);


CREATE TABLE pelicula_genero (
	--pelicula int4 NOT NULL references peliculas(id),
	--genero int4 NOT NULL references generos(id),
	pelicula int4 NOT NULL ,
	genero int4 NOT NULL ,
	PRIMARY KEY (pelicula, genero)
);

CREATE TABLE pelicula_idioma_hablado (
	--pelicula int4 NOT NULL references peliculas(id),
	--idioma text NOT NULL references idiomas(id),
	pelicula int4 NOT NULL ,
	idioma text NOT NULL ,
	PRIMARY KEY (pelicula, idioma)
);

CREATE TABLE pelicula_pais (
	--pelicula int4 NOT NULL references peliculas(id),
	--pais text NOT NULL references paises(id),
	pelicula int4 NOT NULL ,
	pais text NOT NULL ,
	PRIMARY KEY (pelicula, pais)
);

CREATE TABLE pelicula_personal (
	--pelicula int4 NOT NULL references peliculas(id),
	--persona int4 NOT NULL references personas(id),
	pelicula int4 NOT NULL ,
	persona int4 NOT NULL ,
	departamento text,
	trabajo text NOT NULL,
	PRIMARY KEY (pelicula, persona, trabajo)
);

CREATE TABLE pelicula_productora (
	--pelicula int4 NOT NULL references peliculas(id),
	--productora int4 NOT NULL references productoras(id),
	pelicula int4 NOT NULL ,
	productora int4 NOT NULL ,

	PRIMARY KEY (pelicula, productora)
);

CREATE TABLE pelicula_reparto (
	--pelicula int4 NOT NULL references peliculas(id),
	--persona int4 NOT NULL references personas(id),
	
	pelicula int4 NOT NULL ,
	persona int4 NOT NULL ,
	orden int4 NOT NULL,
	personaje text NOT NULL,
	PRIMARY KEY (pelicula, persona, personaje, orden)
);


