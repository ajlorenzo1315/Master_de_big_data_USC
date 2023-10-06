CREATE TABLE tormentas (
	ano int,
	mes int,
	pais varchar,
	region varchar,
	viento_max real,
	viento_medio real,
	tormentas int,
	primary key (ano, mes, pais, region)
);

copy tormentas from '/home/alumnogreibd/public/tormentas.csv' with csv;

select * from tormentas