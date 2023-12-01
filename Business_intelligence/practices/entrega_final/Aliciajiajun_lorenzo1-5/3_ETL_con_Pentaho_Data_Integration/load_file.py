import os
import xml.etree.ElementTree as ET
import csv
import argparse
import psycopg2

def tabla_vacia(cursor,nombre_tabla):
    cursor.execute(f"SELECT COUNT(*) FROM {nombre_tabla};")
    count = cursor.fetchone()[0]
    return count == 0

def insert_data_into_tiempo(cursor,ano,mes,mes_texto):
    
        cursor.execute("INSERT INTO tiempo (ano, mes, mes_texto) VALUES (%s, %s, %s) RETURNING id", (ano, mes, mes_texto,))
        # cursor.connection.commit()  # Confirma la transacción
        # Recupera la ID generada inmediatamente después de la inserción
        return cursor.fetchone()[0]

def insert_data_into_director(cursor, director_id, director_name):
    
        cursor.execute("INSERT INTO director (text_id, nombre) VALUES (%s, %s) RETURNING id",
                   (director_id, director_name,))
        # cursor.connection.commit()  # Confirma la transacció
        return cursor.fetchone()[0]

def insert_data_into_productor(cursor, productor_id, productor_name):

        cursor.execute("INSERT INTO productor (text_id, nombre) VALUES (%s, %s)  RETURNING id",
                   (productor_id, productor_name,))
        # cursor.connection.commit()  # Confirma la transacció
        return cursor.fetchone()[0]

def insert_data_into_productora(cursor, productora_id, productora_name):
  
        cursor.execute("INSERT INTO productora (text_id, nombre) VALUES (%s, %s)  RETURNING id",
                   (productora_id, productora_name,))
        #cursor.connection.commit()  # Confirma la transacció
        return cursor.fetchone()[0]

def insert_data_into_finanzas(cursor, tiempo_id, director_id, productor_id, productora_id, coste, ingresos):
    
    cursor.execute("INSERT INTO finanzas (tiempo, director, productor, productora, coste, ingresos) VALUES (%s, %s, %s, %s, %s, %s)",
                   (tiempo_id, director_id, productor_id, productora_id, coste, ingresos,))
        
def insert_data_into_satisfaccion_usuarios(cursor, tiempo_votacion, director_id, productor_id, productora_id, votos, satisfaccion):
    cursor.execute("INSERT INTO satisfaccion_usuarios (tiempo, director, productor, productora, votos, satisfaccion) VALUES (%s, %s, %s, %s, %s, %s)",
                   (tiempo_votacion, director_id, productor_id, productora_id, votos, satisfaccion))


def get_item(pelicula,objest):
    names=[]
    ids=[]
    for obj in pelicula.findall(objest):
        ids.append(obj.get('id'))
        names.append(obj.get('nombre'))
    names=','.join(names)
    ids='-'.join(ids)
    return names,ids


def load_file_tables(root,reader,cursor=None, meses_del_ano = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
    ]):
   
    # Accede a elementos y atributos
    # for element in root:
    #     print(element.tag, element.attrib)
    #     for subelement in element:
    #         print(subelement.tag, subelement.text)
    # Iterar a través de las etiquetas 'pelicula' dentro de 'peliculas'
    # print(root.iter('pelicula'))
    for pelicula in root.iter('pelicula'):
        #print(pelicula)
        id_pelicula = pelicula.get('id')
        emision = pelicula.get('emision')
        titulo = pelicula.find('titulo').text
        presupuesto = pelicula.find('presupuesto').text
        ingresos = pelicula.find('ingresos').text

        directores_name,directores_id = get_item(pelicula,".//director")
       
        productoras_name,productoras_id= get_item(pelicula,".//productora")
      
        productor_name,productor_ids=get_item(pelicula,".//productor")
        fecha=emision.split('-')
        ano=fecha[0]
        mes=fecha[1]
        mes_texto=meses_del_ano[int(mes)-1]
        #print("xml",ano)
        if cursor:
            tiempo_id = insert_data_into_tiempo(cursor,ano,mes,mes_texto)
           
            director_id = insert_data_into_director(cursor, directores_id, directores_name)
     
            productor_id = insert_data_into_productor(cursor, productor_ids, productor_name)
        
            productora_id = insert_data_into_productora(cursor, productoras_id, productoras_name)
           
            insert_data_into_finanzas(cursor,tiempo_id, director_id, productor_id, productora_id, presupuesto, ingresos)
            # Variables para almacenar los totales de votos y satisfacción
            total_votos = 0
            total_satisfaccion = 0

            # Iterar a través de las filas del archivo CSV
            for i,row in enumerate(reader):
                if i>0:
                    pelicula = row[0]
                    usuario = row[1]
                    instante = row[2]
                    voto = float(row[3]) # Asegúrate de convertir el voto a un número entero

                    # Realiza un seguimiento de las dimensiones relevantes (por ejemplo, película y productora)
                    # y calcula los totales de votos y satisfacción
                    # Puedes ajustar esto según tus necesidades específicas
                    total_votos += 1
                    total_satisfaccion += voto

            #echa=instante.split('-')
            #tiempo_votacion=ano
            # Calcula el nivel de satisfacción promedio
            if total_votos > 0:
                nivel_satisfaccion = total_satisfaccion / total_votos
            else:
                nivel_satisfaccion = 0

            # Inserta los resultados en la tabla de satisfacción de usuarios en la base de datos
            if cursor:
                insert_data_into_satisfaccion_usuarios(cursor, tiempo_id , director_id, productor_id, productora_id, total_votos, nivel_satisfaccion)
            else:
                print("CSV - Total de votos:", total_votos, "Nivel de satisfacción:", nivel_satisfaccion)
                
        else:
            print("xml",id_pelicula,emision,titulo,presupuesto,ingresos,directores_id,directores_name,
            productoras_id,productoras_name,productor_id,productor_name)
            print(ano,mes,mes_texto)

        

# Define una función para comprobar si una tabla existe
def tabla_existe(cursor,nombre_tabla):
    cursor.execute("SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = %s);", (nombre_tabla,))
    return cursor.fetchone()[0]

def generar_tabla(cursor):
    print("CREAMOS LAS TABLAS")
    # Lista de nombres de las tablas que deseas crear
    tablas = ["tiempo", "director", "productor", "productora","finanzas","satisfaccion_usuarios"]
    # Itera a través de la lista y crea las tablas si no existen
    for tabla in tablas:
        if not tabla_existe(cursor,tabla):
            if tabla == "tiempo":
                cursor.execute("""
                    CREATE TABLE tiempo (
                        id SERIAL NOT NULL,
                        ano INT NOT NULL,
                        mes INT NOT NULL,
                        mes_texto VARCHAR(16) NOT NULL,
                        CONSTRAINT tiempo_pk PRIMARY KEY (id)
                    );
                """)
            elif tabla == "director":
                cursor.execute("""
                    CREATE TABLE director (
                        id SERIAL NOT NULL,
                        text_id VARCHAR(1000) NOT NULL,
                        nombre VARCHAR(1000) NOT NULL,
                        CONSTRAINT director_pk PRIMARY KEY (id)
                    );
                """)
            elif tabla == "productor":
                cursor.execute("""
                    CREATE TABLE productor (
                        id SERIAL NOT NULL,
                        text_id VARCHAR(1000) NOT NULL,
                        nombre VARCHAR(1000) NOT NULL,
                        CONSTRAINT productor_pk PRIMARY KEY (id)
                    );
                """)
            elif tabla == "productora":
                cursor.execute("""
                    CREATE TABLE productora (
                        id SERIAL NOT NULL,
                        text_id VARCHAR(1000) NOT NULL,
                        nombre VARCHAR(100) NOT NULL,
                        CONSTRAINT productora_pk PRIMARY KEY (id)
                    );
                """)
            elif tabla =="finanzas":
                cursor.execute("""CREATE TABLE finanzas (
                    tiempo INT,
                    director INT,
                    productor INT,
                    productora INT,
                    coste bigint DEFAULT 0,
                    ingresos bigint DEFAULT 0,
                    CONSTRAINT finanzas_pk PRIMARY KEY (tiempo, director, productor, productora),
                    CONSTRAINT tiempo_finanzas_fk FOREIGN KEY (tiempo) REFERENCES tiempo(id) ON DELETE restrict ON UPDATE cascade,
                    CONSTRAINT director_finanzas_fk FOREIGN KEY (director) REFERENCES director(id) ON DELETE cascade ON UPDATE cascade,
                    CONSTRAINT productor_finanzas_fk FOREIGN KEY (productor) REFERENCES productor(id) ON DELETE cascade ON UPDATE cascade,
                    CONSTRAINT productora_finanzas_fk FOREIGN KEY (productora) REFERENCES productora(id) ON DELETE cascade ON UPDATE cascade
                );""")

            elif tabla =="satisfaccion_usuarios":
                cursor.execute("""CREATE TABLE satisfaccion_usuarios (
                    tiempo INT,
                    director INT,
                    productor INT,
                    productora INT,
                    votos INT DEFAULT 0,
                    satisfaccion DECIMAL(2, 1),
                    CONSTRAINT satisfaccion_usuarios_pk PRIMARY KEY (tiempo, director, productor, productora),
                    CONSTRAINT tiempo_votacion_satisfaccion_usuarios_fk FOREIGN KEY (tiempo) REFERENCES tiempo(id) ON DELETE restrict ON UPDATE cascade,
                    CONSTRAINT director_satisfaccion_usuarios_fk FOREIGN KEY (director) REFERENCES director(id) ON DELETE cascade ON UPDATE cascade,
                    CONSTRAINT productor_satisfaccion_usuarios_fk FOREIGN KEY (productor) REFERENCES productor(id) ON DELETE cascade ON UPDATE cascade,
                    CONSTRAINT productora_satisfaccion_usuarios_fk FOREIGN KEY (productora) REFERENCES productora(id) ON DELETE cascade ON UPDATE cascade
                );""")
    
def load_file(host,database,user,password,root_dir,xml_directory,csv_directory):
    
    # Conectarse a la base de datos PostgreSQL
    conn = psycopg2.connect(
        host=host,
        database=database,
        user=user,
        password=password
    )
    conn.autocommit = True
    ## Crear un cursor
    cursor = conn.cursor()

    # Iterar a través de los archivos XML
    meses_del_ano=[
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"]
    
    generar_tabla(cursor)
    for xml_filename in os.listdir(root_dir+xml_directory):
        #print(xml_filename.split('.')[0])
        # Abre y analiza el archivo XML
        xml_file_path = os.path.join(root_dir, xml_directory, xml_filename)
        tree = ET.parse(xml_file_path)
        root = tree.getroot()

       
        # Insertar los datos en la tabla tiempo
        #cur.execute("INSERT INTO tiempo (ano, mes, mes_texto) VALUES (%s, %s, %s)", (ano, mes, mes_texto))
        
        #print_xml(root,cursor=cursor,meses_del_ano=meses_del_ano)

        # Imprime el nombre del archivo CSV sin la extensión
        csv_filename = "{}.csv".format(os.path.splitext(xml_filename)[0])
        aux=csv_filename.split('-')
        aux[0]=csv_directory[:-1]
        csv_filename ='-'.join(aux)
        
        # Ruta completa al archivo CSV
        csv_file_path = os.path.join(root_dir, csv_directory, csv_filename)
        with open(csv_file_path, newline="") as csvfile:
            reader = csv.reader(csvfile)
            load_file_tables(root,reader,cursor,meses_del_ano)

if __name__ == "__main__":
    #root_dir="/home/alourido/Desktop/Master_de_big_data_USC/Business_intelligence/practices/data/"
    # Directorios que contienen los archivos XML y CSV
    #xml_directory = "peliculas/"
    #csv_directory = "votos/"

    # Definir argumentos de línea de comandos
    parser = argparse.ArgumentParser(description="Insertar datos desde un archivo XML en una tabla de PostgreSQL")
    parser.add_argument("--host", help="Host de la base de datos PostgreSQL",
                        default="localhost")
    parser.add_argument("--database", help="Nombre de la base de datos PostgreSQL",
                        default="bi")
    parser.add_argument("--user", help="Usuario de PostgreSQL",
                        default="alumnogreibd")
    parser.add_argument("--password", help="Contraseña de PostgreSQL",
                        default="greibd2021")
    parser.add_argument("--root_dir", help="directorio raiz",
                        default="/home/alumnogreibd/IN/FuentesDatos/")
    parser.add_argument("--path_peliculas", help="directorio pelicuas",
                        default="peliculas/")
    parser.add_argument("--path_votos", help="directorio votos",
                        default="votos/")

    args = parser.parse_args()
    
    load_file(
        host=args.host,
        database=args.database,
        user=args.user,
        password=args.password,
        root_dir=args.root_dir,
        xml_directory=args.path_peliculas,
        csv_directory=args.path_votos

    )

