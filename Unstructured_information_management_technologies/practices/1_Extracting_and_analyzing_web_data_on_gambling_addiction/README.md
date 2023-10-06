Creamos un entorno de conda con la versión de pyzon que dijo el profesor

    conda create --name TGINE python=3.7
    conda actvate TGINE    O source activate TGINE                
    
- Nota si no encuentra conda 

    export PATH="/home/alourido/anaconda3/bin:$PATH"



La elección entre Beautiful Soup y Scrapy depende de tus necesidades y del tipo de proyecto que estés abordando. Ambas herramientas son útiles para extraer datos de páginas web, pero tienen enfoques y capacidades ligeramente diferentes.

- Beautiful Soup:
    - Beautiful Soup es una biblioteca de Python diseñada específicamente para analizar y extraer datos de documentos HTML y XML.
    - Es ideal cuando solo necesitas analizar una página web o un conjunto limitado de páginas y extraer información de ellas.
    - Proporciona una forma sencilla de navegar por el DOM (Document Object Model) de una página web y buscar elementos específicos utilizando selectores CSS o expresiones regulares.
    - Es flexible y fácil de usar para proyectos pequeños y tareas de extracción de datos simples.

- Scrapy:
    - Scrapy es un framework de Python diseñado para la extracción de datos web a gran escala y la creación de arañas web (web spiders).
    - Es más poderoso y adecuado cuando necesitas extraer datos de múltiples páginas web o de un sitio web completo.
    - Scrapy proporciona un flujo de trabajo estructurado para crear arañas web que pueden navegar automáticamente por sitios web, seguir enlaces, y extraer datos de manera eficiente.
    - Es escalable y se puede utilizar para proyectos de raspado web más complejos y extensos.

En resumen, si solo necesitas extraer datos de unas pocas páginas web simples, Beautiful Soup podría ser suficiente y más fácil de implementar. Sin embargo, si estás abordando un proyecto más grande que involucra la extracción de datos de múltiples páginas web o sitios web completos, Scrapy sería una elección más apropiada debido a su capacidad para automatizar el proceso y su escalabilidad.

