#!/usr/bin/env python
# coding: utf-8

# # Practica 1 Alicia Jiajun Lorenzo Lourido
# 
# ### Extrayendo y analizando web data sobre adicción al juego
# 
# **Se recomienda no ejecuatar este notebook ya que puede tardar mucho en ejecutarse por completo**
# 
# La web (ya sea una red social o una página web) representa una importante fuente de
# acceso a contenidos. En esta práctica, nos centraremos en scrapear contenido de
# páginas web o redes sociales relacionado con gambling problems (adicción al juego, en
# español). Este trabajo está orientado a familiarizarse con técnicas básicas de creación de
# corpus textuales, así como en una primera exploración del contenido de los textos
# mediante la extracción de términos centrales o importantes.

# ### 1) Extraer datos de la web acerca detrastornos del juego.
# 
# En concreto, se trata de extraer publicaciones realizadas por
# personas que potencialmente sufren este tipo de trastorno. Esta parte es libre y podéis
# extraer documentos tanto de páginas web como de redes sociales abiertas como
# Reddit. La única limitación es que la información tiene que estar en castellano. El
# resultado debe ser un corpus normalizado consistente en una colección de
# publicaciones (por ejemplo, posts en Reddit o entradas escritas en foros).
# A continuación, se os sugiere una lista de recursos relevantes:
# - Ludopatia.org. Por la rehabilitación de jugadores patológicos y otras adicciones. Foro de discusión.
# https://www.ludopatia.org/forum/default.asp
# - Ludopatía. Foro de discusión. https://www.forolinternas.com/viewtopic.php?f=16&t=17505
# -Ludopatía/adicción al juego. Grupo público de Facebook.
# https://www.facebook.com/groups/253782884636115
# -Ludopatía, adicción y problemas con el juego. Foro de discusión
# http://foroapuestas.forobet.com/ludopatia-adiccion-y-problemas-con-el-juego/
# - Subcomunidades de Reddit relevantes a la adicción con el juego
# El objetivo es crear un dataset de, por lo menos, varios miles de entradas. Para la
# recuperación web podéis usar librerías como Beautiful Soup o Scrapy y para recuperar
# de Reddit existe Praw: https://praw.readthedocs.io/en/stable/.
# En el notebook a entregar debe aparecer todo el código asociado a la extracción de
# contenidos y parseado para la creación del corpus. No sería válido obtener una
# colección de terceros y usarla para las partes posteriores del proyecto. Es necesario
# que cada alumno/a trabaje en la extracción de los datos a partir de al menos una fuente
# web.

# #### Scrapy 
# Usaremos la libreria Scrapy para obtener los datos necesarios para esta practica de la web 
# 'https://www.ludopatia.org/forum/default.asp'

# **NOTA**: Se pude intentar hacer scrapy desde notebook 
# 
# A continuación se muestra la lectura de una de las paginas del foro (de un post en concreto), esta es una manera simple en la que se usa scrapy la configuración final se hace mas abajo en el apartado 3:

# In[1]:


import scrapy
from scrapy.crawler import CrawlerRunner
from crochet import setup, wait_for

setup()

class QuotesToCsv(scrapy.Spider):
    name = "MJKQuotesToCsv"
    start_urls = ['https://www.ludopatia.org/forum/default.asp']

    custom_settings = {
        'FEEDS': {
            'quotes.json': {
                'format': 'json',
                'overwrite': True
            }
        }
    }

    def start_requests(self):
        url = "https://www.ludopatia.org/forum/forum_posts.asp?TID=9680&PN=1&get=last"
        self.root_url = 'https://www.ludopatia.org/forum/'
        yield scrapy.Request(url, self.parse)

    def parse(self, response):

        # Extraer el título del foro
        titulo_foro = response.xpath('//td[@class="heading"]/text()').get()

        # Extraer el asunto del tema
        asunto_tema = response.xpath('//span[@class="lgText"]/text()').get()

        mensajes = response.xpath('//td[@class="text" and @valign="top"]')
        autores = response.xpath('//span[@class="bold"]/text()').getall()

        for ind, mensaje in enumerate(mensajes):
            autor = autores[ind]
            fecha = mensaje.xpath('.//td[@class="smText"]/text()').get()
            texto = mensaje.xpath('.//text()').getall()
            editado = mensaje.xpath('.//span[@class="smText"]/text()').get()
            # Filtrar y limpiar el texto de partes no deseadas
            texto_limpio = [t.strip() for t in texto if t.strip()]
            texto_final = " ".join(texto_limpio)

            if autor and fecha and texto_final:
                yield{
                        'autor': autor,
                        'fecha': fecha.strip(),
                        'Editado': editado,
                        'texto': texto_final,
                        'titulo_foro': titulo_foro,
                        'asunto_tema': asunto_tema,}
            
                print(autor)
                print("-",texto_final)
            
@wait_for(10)
def run_spider():
    crawler = CrawlerRunner()
    d = crawler.crawl(QuotesToCsv)
    return d


# Ejecutamos la nuestra red para obtener cada post y mostrar su contenido

# In[2]:


run_spider()


# ##### Usando una red creada en nuestro entorno 
# 
# En este caso crearemos una red fuera del jupyter notebook ya que con el jupyter notebook por alguna razon rompe la busqueda puede ser que por que supere los recursos asignados a jupyter
# 
# 1. Creamos un  project 
#     ```bash
#     scrapy startproject ludopatia
#     ```
# 2. Creamos una araña (o red)
#     
#      ```bash
#     scrapy genspider ludopatia_spider ludopatia.org
#     ```
#  3. Configurar la araña para extraer información  del foro:
# 
# Abre el archivo ludopatia_spider.py en un editor de texto y modifícalo para que pueda raspar el foro "https://www.ludopatia.org/forum/default.asp". Tendrás que analizar la estructura HTML del sitio web y definir cómo planeas extraer los datos que necesitas.
# 

# In[1]:


get_ipython().system('scrapy startproject ludopatia')


# In[2]:


get_ipython().system('cd ludopatia && scrapy genspider ludopatia_spider ludopatia.org')


# 3. Configurar la araña para raspar el foro:
# 
# Se abre el archivo ludopatia_spider.py en un editor de texto y se modifircó para que pueda extraer la información  del foro "https://www.ludopatia.org/forum/default.asp". Se  analiza la estructura HTML del sitio web y definir cómo planeas extraer los datos que necesitas.
# 
# Esta es nuestra configuración para la extración :
# 
# ```python
# import scrapy
# 
# class LudopatiaSpider(scrapy.Spider):
#     name = 'ludopatia'
#     start_urls = ['https://www.ludopatia.org/forum/default.asp']
# 
#     custom_settings = {
#         'FEEDS': {
#             'ludopatia_forum.json': {
#                 'format': 'json',
#                 'overwrite': True
#             }
#         },
#     }
# 
#     def start_requests(self):
#         url = "https://www.ludopatia.org/forum/default.asp"
#         self.root_url = 'https://www.ludopatia.org/forum/'
#         yield scrapy.Request(url, self.parse)
# 
#     def parse(self, response):
#         print("URL de la página actual:", response.url)
# 
#         for forum in response.css('a[href^="forum_topics.asp"]'):
#             forum_url = forum.css('a::attr(href)').get()
#             forum_name = forum.css('a::text').get()
#             forum_full_url = self.root_url + forum_url
#             print(forum_name)
# 
#             yield response.follow(forum_full_url, callback=self.parse_forum)
# 
#     def parse_forum(self, response):
#         print("URL de la página actual forum:", response.url)
# 
#         for forum in response.css('a[href^="forum_posts.asp"]'):
#             forum_url = forum.css('a::attr(href)').get()
#             forum_name = forum.css('a::text').get()
#             forum_full_url = self.root_url + forum_url
# 
#             yield response.follow(forum_full_url, callback=self.parse_subforum)
# 
#         # Buscar el enlace "Siguiente" y seguirlo 
#         next_page = response.xpath('//a[contains(text(), "Siguiente")]/@href').extract_first()
#         if next_page:
#             # Construir la URL completa
#             yield response.follow(next_page, callback=self.parse_forum)
# 
#     def parse_subforum(self, response):
# 
#         # Extraer el título del foro
#         titulo_foro = response.xpath('//td[@class="heading"]/text()').get()
# 
#         # Extraer el asunto del tema
#         asunto_tema = response.xpath('//span[@class="lgText"]/text()').get()
# 
#         mensajes = response.xpath('//td[@class="text" and @valign="top"]')
#         autores = response.xpath('//span[@class="bold"]/text()').getall()
# 
#         for ind, mensaje in enumerate(mensajes):
#             autor = autores[ind]
#             fecha = mensaje.xpath('.//td[@class="smText"]/text()').get()
#             texto = mensaje.xpath('.//text()').getall()
#             editado = mensaje.xpath('.//span[@class="smText"]/text()').get()
#             # Filtrar y limpiar el texto de partes no deseadas
#             texto_limpio = [t.strip() for t in texto if t.strip()]
#             texto_final = " ".join(texto_limpio)
# 
#             if autor and fecha and texto_final:
#                    yield{
#                         'autor': autor,
#                         'fecha': fecha.strip(),
#                         'Editado': editado,
#                         'texto': texto_final,
#                         'titulo_foro': titulo_foro,
#                         'asunto_tema': asunto_tema,}
# ```
# 
# Edit setting.py
# 
# 
# ```python
# # Obey robots.txt rules
# ROBOTSTXT_OBEY = True
# 
# # Configure maximum concurrent requests performed by Scrapy (default: 16)
# CONCURRENT_REQUESTS = 32
# 
# # Configure a delay for requests for the same website (default: 0)
# # See https://docs.scrapy.org/en/latest/topics/settings.html#download-delay
# # See also autothrottle settings and docs
# #DOWNLOAD_DELAY = 3
# DOWNLOAD_DELAY = 0.5
# # The download delay setting will honor only one of:
# CONCURRENT_REQUESTS_PER_DOMAIN = 16
# CONCURRENT_REQUESTS_PER_IP = 16
# 
# ```

# 4. Se lanza la red para que pueda extraer la informcaión

# In[7]:


get_ipython().system('cd ludopatia && scrapy crawl ludopatia_spider')


# 2) El corpus que obtengáis en el paso anterior debe ser almacenado en disco en un formato adecuado. 
# 
# Para ello, definid un esquema JSON o XML que permita almacenar toda la información disponible (guardando al menos título y contenido de cada publicación; se recomienda incorporar campos para todos los datos disponibles, por ejemplo no sólo título y contenido del texto sino también guardando el/la usuario/a que hace el escrito, subcomunidad o foro donde se publicó, fecha, etc.). Guardad toda la colección en un único fichero. Estos archivos deben ser legibles desde código Pythonutilizando, por ejemplo, la API ElementTree XML (para XML) o una biblioteca análoga para el procesamiento de JSON:
# https://docs.python.org/2.7/library/xml.etree.elementtree.html
# 
# Este apartdo se realiaza junto con el anterior ya que scrapy permite almacenar los datos en un json 
# que devuelve:
# 
# {[contenido_del_scrapy]}
# 
# por lo que haremos una edición para que puda ejecutarse de tal manera que luego se pudea leer:
# 
# {"texto":[contenido_del_scrapy]}

# 3) Realizad un sencillo tratamiento inicial del corpus anterior para vectorizar la colección y mostrar los términos más ponderados por tf/idf. Para ello:

# 1. instalad y familiarizaos con scikit-learn (http://scikit-learn.org/stable/) y, en particular, con sus posibilidades de extraer características del texto (sección 6.2.3 en la página https://scikit-learn.org/stable/modules/feature_extraction.html#text-feature-extraction) y
# con el vectorizador TfIdf: https://scikit-
# learn.org/stable/modules/generated/sklearn.feature_extraction.text.TfidfVectorizer.html#sklearn.feature_extraction.text.TfidfVectorizer

# In[8]:


# Instalamos las librerias necesarias
get_ipython().system('pip3 install scikit-learn')


# In[6]:


# Importa las bibliotecas necesarias:
import json
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import ENGLISH_STOP_WORDS
from sklearn.feature_extraction.text import CountVectorizer
from collections import Counter
import numpy as np


# ## Para entender la libreria empezaremos ejecutando un ejemplo basico de la [guia de usuario](https://scikit-learn.org/stable/modules/feature_extraction.html#text-feature-extraction) 
# 
# ### Extración de caracteristicas de un texto
# 
# 1. Tokenización de cadenas y asignación de un identificador entero a cada posible token, por ejemplo, utilizando espacios en blanco y signos de puntuación como separadores de tokens.
# 
# 2. Contar las ocurrencias de tokens en cada documento.
# 
# 3. Normalización y ponderación con disminución de importancia de los tokens que ocurren en la mayoría de las muestras o documentos.
# 
# En este esquema, las características y las muestras se definen de la siguiente manera:
# 
# - Cada frecuencia de ocurrencia de un token individual (normalizada o no) se trata como una característica.
# 
# - El vector de todas las frecuencias de tokens para un documento dado se considera una muestra multivariada.
# 
# 
# #### Esparsidad
# 
# En la mayoría de los documentos utilizan solo un pequeño conjunto de palabras del corpus, la matriz resultante tiene la mayoría de sus valores como ceros. Por ejemplo, en una colección de 10,000 documentos cortos, cada uno con un vocabulario de 100 a 1000 palabras, la mayoría de las palabras no se utilizan. Para gestionar eficientemente esta matriz, se emplea una representación dispersa, como la que ofrece el paquete scipy.sparse.
# 

# #### Uso común del vectorizador
# 
# CountVectorizer(): Es un vectorizador que convierte documentos de texto en una representación de bolsa de palabras (BoW). En esta representación, cada documento se representa como un vector de números que cuentan la frecuencia de las palabras en el documento.Este modelo tiene muchos parámetros, sin embargo, los valores predeterminados son bastante razonables

# In[7]:


# Este modelo tiene muchos parámetros, sin embargo, los valores predeterminados son bastante razonables
vectorizer = CountVectorizer()
vectorizer


# Ahora haremos una inferencia sobre un corpus minimalista para poder entender como se comporta
# 
# **Ajuste (Fit):** 
# Durante la fase de ajuste, el vectorizador (o cualquier otro modelo) aprende las características o propiedades del conjunto de datos de entrenamiento. En el contexto de CountVectorizer, el ajuste implica aprender el vocabulario del corpus, es decir, qué palabras únicas se encuentran en los documentos de texto del corpus y cómo se numeran. Esto significa que el vectorizador construirá un mapeo de palabras únicas a índices numéricos.
# 
# **Transformación (Transform):**
# Después de aprender el vocabulario durante la fase de ajuste, el método fit_transform se utiliza para convertir los documentos de texto en una representación numérica basada en ese vocabulario. En el caso de CountVectorizer, se cuentan las frecuencias de las palabras en cada documento y se genera una matriz numérica donde cada fila representa un documento y cada columna representa una palabra del vocabulario, y los valores en las celdas son las frecuencias de las palabras en los documentos.

# In[8]:


# Corpus minimalista
corpus = [
    'Este es el primer documento.',
    'Este es el segundo segundo documento.',
    'Y el tercero.',
    '¿Es este el primer documento?',
]
#X: matriz  numérica  de frecuencia de palabras.donde
#cada fila corresponde a un documento del corpus
#cada columna corresponde a una palabra única en el conjunto de documentos.

X = vectorizer.fit_transform(corpus)
# Imprimimos la matriz del documento
print("matriz: \n",X)
# la comvertimos array para verla en formato matricial
print("matriz: \n",X.toarray())


# **NOTA**: La configuración predeterminada tokeniza la cadena extrayendo palabras de al menos 2 letras. La función específica que realiza este paso puede solicitarse explícitamente. 

# In[9]:


analyze = vectorizer.build_analyzer()
_=analyze("Este es el primer documento a analizar") == (
    ['este', 'es', 'el', 'primer', 'documento','analizar'])

print("Este == Este",analyze("Este") == (['Este']))
print("Este == este",analyze("Este") == (['este']))
print("Este es el primer documento a analizar == 'este', 'es', 'el', 'primer', 'documento','analizar' ",_)


# Cada término encontrado por el analizador durante el ajuste se le asigna un índice entero único que corresponde a una columna en la matriz resultante. Esta interpretación de las columnas se puede recuperar de la siguiente manera

# In[10]:


vectorizer.get_feature_names_out()


# Podemos generar otro formato de visualización en el que nos permita ver que palabra corresponde a cada columna, para esto podemos usar la librerias de pandas y generar un dataframe
# 

# In[11]:


get_ipython().system('pip3 install pandas')


# In[12]:


import pandas as pd
X_df = pd.DataFrame(X.toarray(), columns = vectorizer.get_feature_names_out())
display(X_df)


# **Nota**: el primer y el último documento tienen exactamente las mismas palabras, por lo tanto, se codifican en vectores iguales. Perdiendo  la información de que el último documento es una forma interrogativa. Para preservar parte de la información de orden local, podemos extraer n-gramas de palabras de 2 palabras además de los 1-gramas (palabras individuales)

# In[13]:


bigram_vectorizer = CountVectorizer(ngram_range=(1, 2),
                                    token_pattern=r'\b\w+\b', min_df=1)
X_2 = bigram_vectorizer.fit_transform(corpus).toarray()
X_df_2 = pd.DataFrame(X_2, columns = bigram_vectorizer.get_feature_names_out())
display(X_df_2)


# 1. Tambien se pude hacer mapeo inverso usando vocabulary_
# 2. las palabras que no se observaron en el corpus de entrenamiento serán completamente ignoradas en las futuras llamadas al método 'transform'

# In[14]:


#mapeo inverso
print(vectorizer.vocabulary_.get('el'))
#nuevas palabras
print(vectorizer.transform(['algo nuevo']).toarray())


# #### Stop words
# 
# Las Stop words, como 'y', 'el', 'él', se presumen como no informativas en la representación del contenido de un texto y pueden eliminarse para evitar que se interpreten como señales para la predicción. Sin embargo, en ocasiones, palabras similares son útiles para la predicción, como en la clasificación del estilo de escritura o la personalidad.
# 
# hay que tener cuidado al elegir una lista de palabras de paro. Las listas populares de palabras de paro pueden incluir palabras que son altamente informativas para algunas tareas, como 'computadora'.
# 
# También asegúrase de que la lista de palabras de paro haya tenido el mismo procesamiento y tokenización aplicados que los utilizados en el vectorizador. La palabra 'we've' se divide en 'we' y 've' por el tokenizador predeterminado de CountVectorizer, por lo que si 'we've' está en 'stop_words', pero 've' no lo está, 've' se retendrá de 'we've' en el texto transformado. Nuestros vectorizadores intentarán identificar y advertir sobre ciertos tipos de inconsistencias.
# 
# Referencia
# 
# [NQY18]
# 
# J. Nothman, H. Qin and R. Yurchak (2018). [“Stop Word Lists in Free Open-source Software Packages”](https://aclanthology.org/W18-2502/). In Proc. Workshop for NLP Open Source Software.
# 

# Para esta demo podemos usar la libreria de [NLTK](https://www.nltk.org/) para obtener las stop words aunque sklearn.feature_extraction.text tiene sus propias palabras 'ENGLISH_STOP_WORDS' solo que en ingles y en nuestro caso estamos trabajando con textos en español.
# Tambien podemos crear nuestra propia lista de stop word dependiendo en que ambito nos estamos moviendo con un txt y usar y procesarlo para que se compatible con sklearn

# In[15]:


get_ipython().system('pip3 install nltk')


# In[16]:


# importamos y descargamos stopwords
import nltk
nltk.download('stopwords')


# In[17]:


from nltk.corpus import stopwords
stops_words = set(stopwords.words('spanish'))


# In[18]:


vectorizer_stop_words = CountVectorizer(ngram_range=(1, 2),
                                    token_pattern=r'\b\w+\b', min_df=1,
                                    stop_words = stops_words)

X = vectorizer_stop_words.fit_transform(corpus)

X_df = pd.DataFrame(X.toarray(), columns = vectorizer_stop_words.get_feature_names_out())
display(X_df)



# In[19]:


with open('./ludopatia/spanish_stop_word.txt', 'r', encoding='utf-8') as file:
    spanish_stop_words = set(file.read().splitlines())
    
vectorizer_stop_words = CountVectorizer(ngram_range=(1, 2),
                                    token_pattern=r'\b\w+\b', min_df=1,
                                    stop_words = spanish_stop_words)

X = vectorizer_stop_words.fit_transform(corpus)

X_df = pd.DataFrame(X.toarray(), columns = vectorizer_stop_words.get_feature_names_out())
display(X_df)


# #### Ponderación de términos Tf-idf
# El tf-idf (frecuencia del término por frecuencia inversa del documento) es una técnica de procesamiento de texto que ajusta la importancia de las palabras en un documento basándose en cuán frecuentes son en el conjunto de documentos. Esto se hace para evitar que las palabras muy comunes, como "el" o "un", dominen la representación.
# 
# En el tf-idf, se calcula la frecuencia del término en un documento y se multiplica por un factor idf que refleja cuán rara es la palabra en el conjunto de documentos. Esto se hace para dar más peso a las palabras que son distintivas en un documento en particular.
# 
# La fórmula del factor idf tiene en cuenta el número total de documentos y cuántos de ellos contienen el término en cuestión. Los vectores resultantes se normalizan para asegurar que tengan una longitud constante.

# In[20]:


from sklearn.feature_extraction.text import TfidfVectorizer
# Convierte el corpus a una matriz TF-IDF
vectorizer_idf = TfidfVectorizer(
    use_idf=True
)
print("con Tf-idf")
X = vectorizer_idf.fit_transform(corpus)
X_df = pd.DataFrame(X.toarray(), columns = vectorizer_idf.get_feature_names_out())
display(X_df)
print("sin Tf-idf")
X = vectorizer.fit_transform(corpus)
X_df = pd.DataFrame(X.toarray(), columns = vectorizer_idf.get_feature_names_out())
display(X_df)


# 
# 2. dado el corpus obtenido de la web, y considerando cada entrada o post como un documento individual, utilizad el vectorizador TfIdf (filtrando las stopwords y todas aquellas palabras que aparezcan en menos de 10 docs) para vectorizar la colección y luego mostrar los 50 términos más "centrales" de la colección. Entendiendo como más centrales aquellos cuya suma acumulada de tf/idf sobre todos los documentos es mayor. Además, mostrar también los 100 términos más repetidos de la colección (suma de su tf o term frequency en los documentos)

# In[21]:


# Como se almacenaron los textos sin tratar generamos una funcion para procesarlo a la hora de cargarlo
def tratar_cadenas(texto,fecha,editado):
    
    texto_trato=texto.replace(fecha, "")
    if editado:
        texto_trato=texto_trato.replace(editado, "")
    texto_trato=texto_trato.replace("_", "")
    texto_trato=texto_trato.lower()
    return texto_trato


# In[65]:


# lista para almacenar los textos de cada objeto JSON
corpus = []

# Abrimos el archivo JSON y procesamos cada linea como un objeto JSON
with open('./ludopatia/ludopatia_forum_4.json', 'r', encoding='utf-8') as file:
    data = json.load(file)
    corpus = [tratar_cadenas(dato['texto'],dato['fecha'],dato['Editado']) \
              for dato in data['texto'] \
              if dato['autor']!="administrator" and dato['titulo_foro']!= "Soporte General. Ayuda Técnica.Tratamiento Ludopatia"]


# In[66]:


# comprobamos que se ha tratado correctamente por 
print(corpus[0])


# **50 términos más "centrales" de la colección** :
# Para ello sumamos el valor TF-IDF de cada una de las palabras para todos los documentos presentes en el corpus:

# In[68]:


stops_words = set(stopwords.words('spanish'))

tfidf_vectorizer = TfidfVectorizer(stop_words=stops_words,  min_df=1,
    use_idf=True
)
tfidf_matrix = tfidf_vectorizer.fit_transform(corpus)
# Definimos el número de palabras más repetidas que queremos consultar
n_words_to_retrieve = 100

terms = tfidf_vectorizer.get_feature_names_out()
term_tfidf_scores = list(zip(terms, term_tfidf_sum))
term_tfidf_scores = sorted(term_tfidf_scores, key=lambda x: x[1], reverse=True)[:50]


print("50 términos más ponderados por tf/idf, 50 términos más 'centrales' de la colección:")
print([i for i,_ in term_tfidf_scores])


# In[71]:


stops_words = set(stopwords.words('spanish'))

tfidf_vectorizer = TfidfVectorizer(stop_words=stops_words,  min_df=5,
    use_idf=True
)
tfidf_matrix = tfidf_vectorizer.fit_transform(corpus)
# Definimos el número de palabras más repetidas que queremos consultar
n_words_to_retrieve = 100

terms = tfidf_vectorizer.get_feature_names_out()
term_tfidf_scores = list(zip(terms, term_tfidf_sum))
term_tfidf_scores = sorted(term_tfidf_scores, key=lambda x: x[1], reverse=True)[:50]


print("50 términos más ponderados por tf/idf, 50 términos más 'centrales' de la colección:")
print([i for i,_ in term_tfidf_scores])


# **100 términos más repetidos en la colección** 
# Para ello sumamos sus valores TF para todos los documentos sea mayor:

# In[69]:


# Sumamos el valor TF de cada palabra
# Obtén los términos más repetidos en los documentos
count_vectorizer = CountVectorizer(stop_words=stops_words)
count_matrix = count_vectorizer.fit_transform(corpus)
frecuencias_terminos = np.array(count_matrix.sum(axis=0)).flatten()
id_most_common_terms=(-frecuencias_terminos).argsort()[:n_words_to_retrieve]

terminos_100 = np.take(tfidf_vectorizer.get_feature_names(), id_most_common_terms)
print("\n100 términos más repetidos en la colección:")
print(terminos_100)


# In[70]:


count_vectorizer = TfidfVectorizer(stop_words=stops_words,  min_df=1,
    use_idf=False
)
count_matrix = count_vectorizer.fit_transform(corpus)
frecuencias_terminos = np.array(count_matrix.sum(axis=0)).flatten()
id_most_common_terms=(-frecuencias_terminos).argsort()[:n_words_to_retrieve]

terminos_100 = np.take(tfidf_vectorizer.get_feature_names(), id_most_common_terms)
print("\n100 términos más repetidos en la colección:")
print(terminos_100)


# In[73]:


count_vectorizer = TfidfVectorizer(stop_words=stops_words,  min_df=5,
    use_idf=False
)
count_matrix = count_vectorizer.fit_transform(corpus)
frecuencias_terminos = np.array(count_matrix.sum(axis=0)).flatten()
id_most_common_terms=(-frecuencias_terminos).argsort()[:n_words_to_retrieve]

terminos_100 = np.take(tfidf_vectorizer.get_feature_names(), id_most_common_terms)
print("\n100 términos más repetidos en la colección:")
print(terminos_100)


# **NOTA** Como se pude observar en los textos se repite  bastante hola y foro por lo que podriamos añadirlos al stop words ya que estas palabras no aportan información real sino que son formalistmos a la hora de escribir post en un foro que seria saludar e indicar donde estas escribiendo

# 3) En este paso, se os pide volver a sacar los términos más relevantes de la colección.
# 
# Ahora utilizaremos una técnica neuronal con embeddings de un modelo avanzado
# denominado BERT. Esta técnica representa los documentos y términos en un espacio
# vectorial y computa sus similaridades coseno. Para ello, debéis utilizar la librería Python
# KeyBERT: https://github.com/MaartenGr/KeyBERT. En este caso, se entiende como más
# centrales aquellos cuya suma acumulada de similaridades documento-término sobre
# todos los documentos es mayor.
# Nota: Internamente esta librería utiliza las funciones previas de scikit-learn para generar
# la lista de palabras candidatas. También se le podría inyectar una lista de palabras
# candidatas con el parámetro candidates.
# Tip: Para un correcto funcionamiento, deberéis usar un modelo que soporte varios
# idiomas. Por defecto solo soporta el inglés. Aquí podéis encontrar la lista de modelos
# multilingües:
# https://www.sbert.net/docs/pretrained_models.html#multi-lingual-models.

# In[24]:


get_ipython().system('pip install keybert')
get_ipython().system('pip install transformers')


# Demo para varios textos análoga a la de sklearn

# In[25]:


from keybert import KeyBERT

corpus = [
    'Este es el primer documento.',
    'Este es el segundo segundo documento.',
    'Y el tercero.',
    '¿Es este el primer documento?',
]

# Carga el modelo BERT multilingüe
model_name = 'bert-base-multilingual-cased'  # Puedes usar otro modelo si lo prefieres
kw_model = KeyBERT(model=model_name) ### Inicialización del modelo, recomendado su uso en GPU

doc_embeddings, word_embeddings = kw_model.extract_embeddings(corpus) ### No genera embeddings para todas las palabras

print(doc_embeddings.shape)
print(word_embeddings.shape)

keywords = kw_model.extract_keywords(corpus)
print(keywords)



# comparando con sklearn

# In[26]:


def plot_keybert(keywords):
    # para mostrar los keywords como un dataframe para visualizar el valor de cada palabra
    # por cada documento
    # Crearamos un diccionario para almacenar los valores 
    keywords_dict = {}

    for i, doc in enumerate(keywords):
        keywords_dict[i] = dict(doc)
    # Crearamos el DataFrame
    df = pd.DataFrame.from_dict(keywords_dict, orient='index')
    df = df.reindex(list(range(len(keywords))))
    return(df)


# In[27]:


from sklearn.feature_extraction.text import TfidfVectorizer
# Conviertimos el corpus a una matriz TF-IDF
vectorizer_idf = TfidfVectorizer(
    use_idf=True
)
print("con Tf-idf")
X = vectorizer_idf.fit_transform(corpus)
X_df = pd.DataFrame(X.toarray(), columns = vectorizer_idf.get_feature_names_out())
display(X_df)
print("con keybert")
display(plot_keybert(keywords))


# Recargamos el corpus de del JSON

# In[34]:


#lista para almacenar los textos de cada objeto JSON
corpus = []

# Abrimos el archivo JSON y procesamos cada línea como un objeto JSON
with open('./ludopatia/ludopatia_forum_4.json', 'r', encoding='utf-8') as file:
    data = json.load(file)
    corpus = [tratar_cadenas(dato['texto'],dato['fecha'],dato['Editado']) \
              for dato in data['texto'] \
              if dato['autor']!="administrator" and dato['titulo_foro']!= "Soporte General. Ayuda Técnica.Tratamiento Ludopatia"]


# In[35]:


# comprobamos que se ha tratado correctamente 
print(corpus[0])


# In[36]:


print(len(corpus))
# para keybert son muchos datos por los que vamos a pasarle un subconjunto de los datos 
num_datos=10000
corpus_sub=corpus[:num_datos]


# In[38]:


# comprobamos si se esta ejecutando en la GPU entonces utilizamos el corputs entero

import torch

# Comprueba si CUDA (GPU) está disponible
if torch.cuda.is_available():
    # Obtiene el índice de la GPU actual
    current_device = torch.cuda.current_device()
    # Obtiene el nombre de la GPU actual
    current_device_name = torch.cuda.get_device_name(current_device)
    print(f"Se está utilizando la GPU {current_device}: {current_device_name}")
    corpus_sub=corpus
else:
    print("No se está utilizando la GPU. La ejecución se realiza en la CPU.")

print("cantidad de datos",len(corpus_sub))


# seleción de modelo multilengua en base a 
# | Model Name                               | Performance Sentence Embeddings (14 Datasets) | Performance Semantic Search (6 Datasets) | Avg. Performance | Speed | Model Size |
# | ---------------------------------------- | ---------------------------------------------- | --------------------------------------- | --------------- | ----- | ---------- |
# | all-mpnet-base-v2                        | 69.57                                        | 57.02                                   | 63.30           | 2800  | 420 MB     |
# | multi-qa-mpnet-base-dot-v1               | 66.76                                        | 57.60                                   | 62.18           | 2800  | 420 MB     |
# | all-distilroberta-v1                     | 68.73                                        | 50.94                                   | 59.84           | 4000  | 290 MB     |
# | all-MiniLM-L12-v2                        | 68.70                                        | 50.82                                   | 59.76           | 7500  | 120 MB     |
# | multi-qa-distilbert-cos-v1               | 65.98                                        | 52.83                                   | 59.41           | 4000  | 250 MB     |
# | all-MiniLM-L6-v2                         | 68.06                                        | 49.54                                   | 58.80           | 14200 | 80 MB      |
# | multi-qa-MiniLM-L6-cos-v1                | 64.33                                        | 51.83                                   | 58.08           | 14200 | 80 MB      |
# | paraphrase-multilingual-mpnet-base-v2    | 65.83                                        | 41.68                                   | 53.75           | 2500  | 970 MB     |
# | paraphrase-albert-small-v2               | 64.46                                        | 40.04                                   | 52.25           | 5000  | 43 MB     |
# | paraphrase-multilingual-MiniLM-L12-v2    | 64.25                                        | 39.19                                   | 51.72           | 7500  | 420 MB     |
# | paraphrase-MiniLM-L3-v2                  | 62.29                                        | 39.19                                   | 50.74           | 19000 | 61 MB      |
# | distiluse-base-multilingual-cased-v1     | 61.30                                        | 29.87                                   | 45.59           | 4000  | 480 MB     |
# | distiluse-base-multilingual-cased-v2     | 60.18                                        | 27.35                                   | 43.77           | 4000  | 480 MB     |
# 
# Modelos Multilingües
# 
# Estos modelos encuentran oraciones semánticamente similares dentro de un solo idioma o entre diferentes idiomas:
# 
#    - distiluse-base-multilingual-cased-v1: Versión multilingüe destilada de Universal Sentence Encoder multilingüe. Admite 15 idiomas: árabe, chino, neerlandés, inglés, francés, alemán, italiano, coreano, polaco, portugués, ruso, español, turco.
# 
#    - distiluse-base-multilingual-cased-v2: Versión multilingüe destilada de Universal Sentence Encoder multilingüe. Esta versión admite 50+ idiomas, pero tiene un rendimiento ligeramente inferior al modelo v1.
# 
#    - paraphrase-multilingual-MiniLM-L12-v2: Versión multilingüe de paraphrase-MiniLM-L12-v2, entrenada en datos paralelos para 50+ idiomas.
# 
#    - paraphrase-multilingual-mpnet-base-v2: Versión multilingüe de paraphrase-mpnet-base-v2, entrenada en datos paralelos para 50+ idiomas.

# In[40]:


from keybert import KeyBERT
# Carga el modelo BERT multilingüe
model_name = 'distiluse-base-multilingual-cased-v1'  # Puedes usar otro modelo si lo prefieres
kw_model = KeyBERT(model=model_name) ### Inicialización del modelo, recomendado su uso en GPU

doc_embeddings, word_embeddings = kw_model.extract_embeddings(corpus) ### No genera embeddings para todas las palabras

print(doc_embeddings.shape)
print(word_embeddings.shape)

keywords = kw_model.extract_keywords(corpus)


# In[42]:


import numpy as np
from collections import Counter


# diccionarios para almacenar la suma acumulada de similar TF/IDF y la frecuencia de términos
tfidf_sum_dict = {}
term_freq_dict = {}

# Iterar sobre las keywords
for document in keywords:
    # Cada keyword es una tupla (palabra, valor similar TF/IDF)
    for keyword in document:
        word, tfidf_value = keyword

        # Actualizar la suma acumulada similar TF/IDF
        tfidf_sum_dict[word] = tfidf_sum_dict.get(word, 0) + tfidf_value

        # Contar la frecuencia de terminos
        term_freq_dict[word] = term_freq_dict.get(word, 0) + 1

# Obtener los 50 terminos mas "centrales" (mayor suma acumulada similar TF/IDF)
top_50_tfidf = sorted(tfidf_sum_dict.items(), key=lambda x: x[1], reverse=True)[:50]

# Obtener los 100 terminos mas repetidos (mayor frecuencia de terminos)
top_100_term_freq = sorted(term_freq_dict.items(), key=lambda x: x[1], reverse=True)[:100]

# Mostrar los resultados
print("50 términos más centrales:")
for term, tfidf_sum in top_50_tfidf:
    print(f"{term}: {tfidf_sum}")

print("\n100 términos más repetidos:")
for term, term_freq in top_100_term_freq:
    print(f"{term}: {term_freq}")


# In[49]:


term_frequencies = Counter(" ".join(corpus).split())
most_common_terms = top_50_tfidf
num_columns = len(top_50_tfidf)
table = [most_common_terms[i:i + num_columns] for i in range(0, len(most_common_terms), num_columns)]

print("50 términos más centrales:")
for row in table:
    print([a for a,_ in row])


# In[50]:


term_frequencies = Counter(" ".join(corpus).split())
most_common_terms = top_100_term_freq
num_columns = len(top_100_term_freq)
table = [most_common_terms[i:i + num_columns] for i in range(0, len(most_common_terms), num_columns)]

print("\n100 términos más repetidos en la colección:")
for row in table:
    print([a for a,_ in row])


# 
# 50 términos más ponderados por tf/idf, 50 términos más 'centrales' de la colección:
# 
# ['si', 'jugar', 'mas', 'juego', 'dinero', 'gracias', 'vida', 'solo', 'bien', 'hola', 'foro', 'dia', 'creo', 'siempre', 'ayuda', 'tiempo', 'ser', 'hacer', 'puede', 'ahora', 'vez', 'hace', 'hoy', 'mejor', 'día', 'enfermedad', 'problema', 'nunca', 'mismo', 'abrazo', 'años', 'cosas', 'verdad', 'saludo', 'voy', 'pues', 'dias', 'bueno', 'quiero', 'cada', 'va', 'asi', 'puedo', 'hecho', 'aunque', 'salir', 'vivir', 'puedes', 'animo', 'espero']
# 
# 
# 100 términos más repetidos en la colección:
# 
# ['si' 'jugar' 'juego' 'mas' 'dinero' 'vida' 'solo' 'bien' 'ser' 'foro'
#  'tiempo' 'vez' 'siempre' 'hacer' 'ahora' 'creo' 'hola' 'puede' 'hace'
#  'gracias' 'dia' 'mismo' 'enfermedad' 'problema' 'años' 'ayuda' 'cosas'
#  'hoy' 'mejor' 'nunca' 'pues' 'cada' 'día' 'aunque' 'verdad' 'voy'
#  'quiero' 'va' 'puedo' 'bueno' 'ir' 'cuenta' 'asi' 'ver' 'hecho' 'veces'
#  'tener' 'decir' 'salir' 'dejar' 'menos' 'abrazo' 'familia' 'así'
#  'persona' 'saludo' 'dias' 'muchas' 'tambien' 'tan' 'mal' 'vivir' 'dos'
#  'caso' 'momento' 'puedes' 'espero' 'seguir' 'gente' 'meses' 'siento'
#  'casa' 'camino' 'nadie' 'poder' 'horas' 'personas' 'ludopatia' 'claro'
#  'ludopata' 'perdido' 'todas' 'amigo' 'alguien' 'sino' 'animo' 'pasado'
#  'jugando' 'problemas' 'fin' 'aqui' 'llevo' 'parte' 'paso' 'saber'
#  'quiere' 'digo' 'trabajo' '24' 'dice']
# 

# **NOTA** Como se pude observar hay una pequeña variación en las palabras importantes pero cabe desctacar que sige siendo importante jugar , juego y el resto de paralabras es bastante similar tf/idf en algunos caso cambaindo el orden

# ### 5) (optativo) Utilizad la librería WordCloud de Python o similares para generar una
# nube de palabras del corpus. El objetivo de este apartado es obtener una
# representación visual de los términos más relevantes del corpus extraído.

# In[51]:


#Instala la libreria WordCloud.
get_ipython().system('pip install wordcloud')


# In[52]:


#Importa las bibliotecas necesarias:

from wordcloud import WordCloud
import matplotlib.pyplot as plt


# Primero ejecutamos una demo para entender como funciona

# In[56]:


# para un documento

corpus = "Este es el primer documento."

# nube de palabras con WordCloud:

wordcloud = WordCloud(width=800, height=400, background_color='white').generate(corpus)

# ploteo de la nube de palabras:

plt.figure(figsize=(10, 5))
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis('off')
plt.show()


# In[59]:


# para varios documnetos
corpus = [
    'Este es el primer documento.',
    'Este es el segundo segundo documento.',
    'Y el tercero.',
    '¿Es este el primer documento?',
]

# union de todos los documentos en un solo corpus
corpus = " ".join(corpus)

# Configuración de WordCloud
wordcloud_config = {
    'width': 800,
    'height': 400,
    'background_color': 'white',
}

# Generacion la nube de palabras para el corpus completo
wordcloud = WordCloud(**wordcloud_config).generate(corpus)

# Muestra de la nube de palabras para el corpus completo
plt.figure(figsize=(10, 5))
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis('off')
plt.title('Nube de palabras para el Corpus Completo')


# Hacemos la nube  para nuestro corpus

# In[61]:


# lista para almacenar los textos de cada objeto JSON
corpus = []

# Abrimos el archivo JSON y procesamos cada línea como un objeto JSON
with open('./ludopatia/ludopatia_forum_4.json', 'r', encoding='utf-8') as file:
    data = json.load(file)
    corpus = [tratar_cadenas(dato['texto'],dato['fecha'],dato['Editado']) \
              for dato in data['texto'] \
              if dato['autor']!="administrator" and dato['titulo_foro']!= "Soporte General. Ayuda Técnica.Tratamiento Ludopatia"]

# union de todos los documentos en un solo corpus
corpus = " ".join(corpus)

# Configuración de WordCloud
wordcloud_config = {
    'width': 800,
    'height': 400,
    'background_color': 'white',
}

# usamos stop word
stopwords = set(stopwords.words('spanish')) 

# Generacion la nube de palabras para el corpus completo
wordcloud = WordCloud(stopwords=stopwords,**wordcloud_config).generate(corpus)

# Muestra de la nube de palabras para el corpus completo
plt.figure(figsize=(10, 5))
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis('off')
plt.title('Nube de palabras para el Corpus Completo')


# Como se puede observar la nuve de palarabras es bastante similar  a los resultados que se obtuvieron con el sklearn

# In[ ]:




