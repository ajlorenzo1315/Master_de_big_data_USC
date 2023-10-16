
select p.id, t.ano, p.nombre , p2.nombre ,d.nombre 
from finanzas f , tiempo t, director d , productor p , productora p2 
where f.tiempo=t.id  and f.director= d.id and f.productor= p.id 
	and f.productora = p2.id


select p.id, t.ano, p.nombre , p2.nombre ,d.nombre ,su.satisfaccion ,su.votos
from finanzas f , tiempo t, director d , productor p , productora p2 ,satisfaccion_usuarios su
where f.tiempo=t.id  and f.director= d.id and f.productor= p.id 
	and f.productora = p2.id and su.tiempo=t.id  and su.director= d.id and su.productor= p.id 
	and su.productora = p2.id 

order by t.ano,t.mes

parece estar todo correcto