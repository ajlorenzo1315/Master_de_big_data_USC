1-  comprobamos el estado y lo activamos en caso de que no este no dejamos que se arranque de manera automaticapara que no tenga problemas con los procesos que levantaremos luego

comprobamos si esta activado 

sudo systemctl is-active mongod

levantamos 

sudo systemctl start mongod

comprobamos otra vez

sudo systemctl status mongod

2- Ejecutamos el cliente

mongo

- la base de datos no se crea desde el , se crea cuando necesita almacenar una colección 

3- usamos nuestra base de datos

use bdge (esta no exite cuando se ejecuta asi hasta que se ejecute la coleción si haces un show no muestra nada)

3.1- Ejecutamos una coleción para insertar

db.empleados.insertOne(
 {nombre: "Miguel Angel Pintor",
  direccion: {calle: "Via del Corso",
              numero: "14",
              cp: "23452",
              localidad: "Roma"},
  paga_mensual: [23000, 23500, 23800, 23800, 23500, 22900, 23200, 46000, 23100, 23700, 23500, 46100],
  cursos: [
	{nombre: "Administración MongoDB", nota:8.9},
	{nombre: "Programación JavaScript", nota:7.2},
	]
 }
)

out

{
        "acknowledged" : true,
        "insertedId" : ObjectId("653a9944bb4ba221adc93d1a") # esto es un identificador que se le coloca a cada object 

}

**Nota** esto es atomic o se inserta o no se inserta no queda a medias

- mostramos db.empleados.find().pretty() # find para buscar y pretty para que lo muestre bonito 

**Nota** Si insertas muchos tendrias el primero el isetado si va bien y si falla en el 2 si insertaria el primero parecido a que es una lista de objetos y lo de quedar a medias es solo por objeto no por toda la lista

db.empleados.insertMany([
 {nombre: "Leonardo Ingenioso",
  direccion: {calle: "Leonardo Ingenioso",
              numero: "5",
                    cp: "24987",
                    localidad: "Roma"},
  paga_mensual: [12,24,18,12,143,56,34,34,64,456,34,756,34,14,23],
  cursos: [
	{nombre: "Administración MongoDB", nota:4.7}
	]
 },
 {nombre: "Donato di Niccolo di Betto Bardi",
  direccion: {calle: "Via dei Coronari",
              numero: "28",
                    cp: "23452",
                    localidad: "Roma"},
  paga_mensual: [23000, 23500, 23800, 23800, 23500, 22900, 23200, 46000, 23100, 23700, 23500, 46100],
  cursos: [
	{nombre: "Administración MongoDB", nota:5.3},
	{nombre: "Administración PostgreSQL", nota:9.3},
	{nombre: "Administración Neo4J", nota:5.6}
	]
 },
 {nombre: "Rafael Sanzio",
  direccion: {calle: "Via Margutta",
              numero: "34",
                    cp: "23456",
                    localidad: "Roma"},
  paga_mensual: [12,12,42,34,23,123,24,23,124,434,45,345],
  proyectos: [
	{titulo: "Procesamiento a gran escala de datos", presupuesto: 2343465.23},
	{titulo: "Construcción de soluciones eficientes de publicación", presupuesto: 323244.43}
	]
 }
])

out:

{
        "acknowledged" : true,
        "insertedIds" : [
                ObjectId("653a9a14bb4ba221adc93d1b"),
                ObjectId("653a9a14bb4ba221adc93d1c"),
                ObjectId("653a9a14bb4ba221adc93d1d")
        ]
}

4- Modifiación 

4.0- comprobamos los datos 
db.empleados.find({nombre:"Leonardo Ingenioso"}).pretty()

out

 db.empleados.find({nombre:"Leonardo Ingenioso"}).pretty()
{
        "_id" : ObjectId("653a9a14bb4ba221adc93d1b"),
        "nombre" : "Leonardo Ingenioso",
        "direccion" : {
                "calle" : "Leonardo Ingenioso",
                "numero" : "5",
                "cp" : 24900,
                "localidad" : "Roma"
        },
        "paga_mensual" : [
                12,
                24,
                18,
                12,
                143,
                56,
                34,
                34,
                64,
                456,
                34,
                756,
                34,
                14,
                23
        ],
        "cursos" : [
                {
                        "nombre" : "Administración MongoDB",
                        "nota" : 4.7
                }
        ]
}



**NOTA** si mi servicio web busca por nombre es interesatne indexar por nombre se pued  indexar por cualquiera tanto internos como externos 

- cambiamos el cp de leonardo

db.empleados.updateOne(
	{nombre: "Leonardo Ingenioso"},
	{
		$set: {"direccion.cp": 24900}
	}
)

out :

{ "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 0 }

- ahora comprobamos que este bien la clave cambiada

db.empleados.find({nombre:"Leonardo Ingenioso"}).pretty()

out : 

db.empleados.find({nombre:"Leonardo Ingenioso"}).pretty()
{
        "_id" : ObjectId("653a9a14bb4ba221adc93d1b"),
        "nombre" : "Leonardo Ingenioso",
        "direccion" : {
                "calle" : "Leonardo Ingenioso",
                "numero" : "5",
                "cp" : 24900,
                "localidad" : "Roma"
        },
        "paga_mensual" : [
                12,
                24,
                18,
                12,
                143,
                56,
                34,
                34,
                64,
                456,
                34,
                756,
                34,
                14,
                23
        ],
        "cursos" : [
                {
                        "nombre" : "Administración MongoDB",
                        "nota" : 4.7
                }
        ]
}


- añadimos un curso nuevo

db.empleados.updateOne(
	{nombre: "Leonardo Ingenioso"},
	{
		$push: {cursos: {nombre: "Administración HBase", nota: 4.2}}
	}
)

out:

{ "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }


comprobamos 


db.empleados.find({nombre:"Leonardo Ingenioso"}).pretty()
{
        "_id" : ObjectId("653a9a14bb4ba221adc93d1b"),
        "nombre" : "Leonardo Ingenioso",
        "direccion" : {
                "calle" : "Leonardo Ingenioso",
                "numero" : "5",
                "cp" : 24900,
                "localidad" : "Roma"
        },
        "paga_mensual" : [
                12,
                24,
                18,
                12,
                143,
                56,
                34,
                34,
                64,
                456,
                34,
                756,
                34,
                14,
                23
        ],
        "cursos" : [
                {
                        "nombre" : "Administración MongoDB",
                        "nota" : 4.7
                },
                {
                        "nombre" : "Administración HBase",
                        "nota" : 4.2
                },
                {
                        "nombre" : "Administración HBase",
                        "nota" : 4.2
                }
        ]
}



db.empleados.find({nombre:"Miguel Angel Pintor"}).pretty()



 db.empleados.find({nombre:"Miguel Angel Pintor"}).pretty()
{
        "_id" : ObjectId("653a9944bb4ba221adc93d1a"),
        "nombre" : "Miguel Angel Pintor",
        "direccion" : {
                "calle" : "Via del Corso",
                "numero" : "14",
                "cp" : "23452",
                "localidad" : "Roma"
        },
        "paga_mensual" : [
                23000,
                23500,
                23800,
                23800,
                23500,
                22900,
                23200,
                46000,
                23100,
                23700,
                23500,
                46100
        ],
        "cursos" : [
                {
                        "nombre" : "Administración MongoDB",
                        "nota" : 8.9
                },
                {
                        "nombre" : "Programación JavaScript",
                        "nota" : 7.2
                }
        ]
}

**Nota** filtrammos el array de nombres en el que es igual(in) a Administración esto se hace para aumentar el curso emn 1

db.empleados.updateOne(
	{nombre: "Miguel Angel Pintor"},
	{$inc: {"cursos.$[curso].nota": 1 }},
	{arrayFilters: [{"curso.nombre": {$in: [/Administración/]}}]}
)

db.empleados.find({nombre:"Miguel Angel Pintor"}).pretty()
{
        "_id" : ObjectId("653a9944bb4ba221adc93d1a"),
        "nombre" : "Miguel Angel Pintor",
        "direccion" : {
                "calle" : "Via del Corso",
                "numero" : "14",
                "cp" : "23452",
                "localidad" : "Roma"
        },
        "paga_mensual" : [
                23000,
                23500,
                23800,
                23800,
                23500,
                22900,
                23200,
                46000,
                23100,
                23700,
                23500,
                46100
        ],
        "cursos" : [
                {
                        "nombre" : "Administración MongoDB",
                        "nota" : 9.9
                },
                {
                        "nombre" : "Programación JavaScript",
                        "nota" : 7.2
                }
        ]
}

todo se hace atomico de esta marena solo modifica un documento pero en este caso de 'updateMany' no es atomico por que pude fallar en medio de la lista y habria algunos modificados y otros no


db.empleados.updateMany(
{},
[{
        $set: {
            paga_mensual_media: {
                $trunc: [{
                        $avg: "$paga_mensual"
                    }, 0]
            },
            paga_anual: {
                $trunc: [{
                        $sum: "$paga_mensual"
                    }, 0]
            }
        }
    }, {
        $set: {
            tipo_empleado: {
                $trunc: [{
                        $divide: ["$paga_mensual_media", 10000]
                    }, 0]
            }
        }
    }
]
)

out 

{ "acknowledged" : true, "matchedCount" : 4, "modifiedCount" : 4 }



la hoja verde (compas) de la maquina virtual es grafico es expecifico  tambien se pude comprobar si dbeaver para esto 
compas esta pensado para consultas y agregados


vamos a tener en cada linea un json con cada pelicula en copncreata genera una unica columna json con csv

copy
(select json_build_object(
	'id', id,
	'titulo', titulo,
	'presupuesto', presupuesto,
	'generos', generos,
	'idioma', idioma_original,
	'titulo_original', titulo_original,
	'sinopsis', sinopsis,
	'fecha_emision', fecha_emision,
	'ingresos', ingresos,
	'duracion', duracion,
	'reparto', reparto,
	'personal', personal
	)
from peliculasjson)
to '/home/alumnogreibd/public/peliculas.json'
with csv quote E'\r'




mkdir servconf
--configsvr (indica que va a ser el servidor de configuración de un sarni)
nohup mongod --configsvr --replSet rsConfServer --port 27017 --bind_ip localhost  --dbpath /home/alumnogreibd/BGDE/servconf --bind_ip localhost > /dev/null &




nohup mongod --configsvr --replSet rsConfServer --port 27017 --bind_ip localhost --dbpath /home/alumnogreibd/BGDE/servconf --bind_ip localhost > /dev/null &


