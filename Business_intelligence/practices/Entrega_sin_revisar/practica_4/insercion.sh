psql -U alumnogreibd -d bi2 -c "\copy public.tiempo from ./tiempo.csv csv"
psql -U alumnogreibd -d bi2 -c "\copy public.directores from ./directores.csv csv"
psql -U alumnogreibd -d bi2 -c "\copy public.productores from ./productores.csv csv"
psql -U alumnogreibd -d bi2 -c "\copy public.productoras from ./productoras.csv csv"
psql -U alumnogreibd -d bi2 -c "\copy public.finanzas from ./finanzas.csv csv"
psql -U alumnogreibd -d bi2 -c "\copy public.satisfaccion_usuarios from ./satisfaccion_usuarios.csv csv"
# comando  psql como ususario alumnogreibd en la base de datos inpeliculas lo cambie a (bi2) # copiar en el esquema dw tabla desde el *.csv
