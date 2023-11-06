--tablas de referencia
SELECT create_reference_table('colecciones');
SELECT create_reference_table('generos');
SELECT create_reference_table('idiomas');
SELECT create_reference_table('paises');
SELECT create_reference_table('personas');
SELECT create_reference_table('productoras');
--tablas distribuídas
SELECT create_distributed_table('peliculas', 'id');
SELECT create_distributed_table('pelicula_genero', 'pelicula', colocate_with => 'peliculas');
SELECT create_distributed_table('pelicula_idioma_hablado', 'pelicula', colocate_with => 'peliculas');
SELECT create_distributed_table('pelicula_pais', 'pelicula', colocate_with => 'peliculas');
SELECT create_distributed_table('pelicula_personal', 'pelicula', colocate_with => 'peliculas');
SELECT create_distributed_table('pelicula_productora', 'pelicula', colocate_with => 'peliculas');
SELECT create_distributed_table('pelicula_reparto', 'pelicula', colocate_with => 'peliculas');