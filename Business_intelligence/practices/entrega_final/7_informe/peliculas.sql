select p.nombre as productora, t.mes_texto as mes, sum(f.ingresos) as ingresos, sum(f.coste) as coste, 
       sum(f.ingresos - f.coste) as beneficios
from finanzas f, productora p ,tiempo t 
where f.productora = p.id and t.id = f.tiempo 
  and t.ano = 2016
group by p.nombre, t.mes, t.mes_texto 
order by productora, t.mes



select

    d.nombre as director,
    EXTRACT(year from to_date(t.ano || '-01-01', 'YYYY-MM-DD')) as ano,
    sum(f.ingresos) as ingresos_totales,
    sum(f.coste) as coste_total,
    sum(f.ingresos - f.coste) as beneficio_total,
    sum(s.satisfaccion) as satisfaccion_media

from 
    finanzas f, tiempo t , director d , satisfaccion_usuarios s
    
where f.tiempo = t.id and f.director = d.id and f.tiempo = s.tiempo and f.director = s.director and   t.ano > 2005
group by d.nombre, t.mes, t.mes_texto 
group by beneficio_total DESC;


select d.nombre as director,
    t.mes_texto as mes,
    t.ano as ano,
    sum(f.ingresos) as ingresos_totales,
    sum(f.coste) as coste_total,
    sum(f.ingresos - f.coste) as beneficio_total,
    avg(s.satisfaccion) as satisfaccion_media

from finanzas f, tiempo t , director d , satisfaccion_usuarios s
    
where f.tiempo = t.id and f.director = d.id and f.tiempo = s.tiempo_votacion and f.director = s.director and   t.ano > 2005
group by d.nombre, t.mes, t.mes_texto,t.ano 
order by beneficio_total desc;
