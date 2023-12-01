Sesión 7: Implementación de informes
En esta sesión vamos a probar la funcionalidad de construcción de informes que proporciona Pentaho de forma nativa (Report Designer). Vamos a crear el informe descrito en la memoria del proyecto de Producción de Cine.

Arrancamos la herramienta con el siguiente comando

./pentaho/report-designer/report-designer.sh
Seguimos los pasos del wizard para generar nuestro informe. La consulta que utilizaremos para generar los datos es la siguiente.

select p.nombre as productora, t.mes_texto as mes, sum(f.ingresos) as ingresos, sum(f.coste) as coste, 
       sum(f.ingresos - f.coste) as beneficios
from dw.finanzas f, dw.productoras p , dw.tiempo t 
where f.productora = p.id and t.id = f.tiempo 
  and t.ano = 2016
group by p.nombre, t.mes, t.mes_texto 
order by productora, t.mes
ENTREGA INDIVIDUAL 7: Genera un nuevo informe que resulte de interés para la productora de cine. 

Genera otro reporte en el que, usando los datos de población, muestre los países con un mayor crecimiento relativo desde el año 2000.

Entrega los archivos resultantes a través del campus virtual.

Última modificación: mércores, 22 de novembro de 2023, 14:48